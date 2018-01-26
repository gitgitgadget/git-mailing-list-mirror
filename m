Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 813531F404
	for <e@80x24.org>; Fri, 26 Jan 2018 18:52:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752578AbeAZSv7 (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Jan 2018 13:51:59 -0500
Received: from mail-ua0-f194.google.com ([209.85.217.194]:45673 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752516AbeAZSv5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jan 2018 13:51:57 -0500
Received: by mail-ua0-f194.google.com with SMTP id z3so910997uae.12
        for <git@vger.kernel.org>; Fri, 26 Jan 2018 10:51:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=uGUfBQopHBdn9r04y488/hnN8hfVzK+WI3Hfgpr2xbA=;
        b=e6U9KWG9ZByKaX3GiVtAe3SKJBNHVhZB6w1QTZ9My6jeRbvlSK23nPZb0S4pTLUQvo
         2xUCXb8LgEs8yQhv6WB1d9igeyb4aSrfq80nlqRkS/JpGIFpmvB11YOnJb7X5s25jOjt
         H0DDe+u4HIBcDKVn9KDL9+NL2EJTwoDaKblP5tPq1/FGNvFVNOboRo/EXyibFihTM8vg
         kB48igVe7Kc66Mzs01fGxOU8rPMR00s5IoAs0OpPjRMVjeeQelAJiIXCSEVIYefUOEdf
         hgoLpA52Mj5Aex3QbHwv+zIBGObb9uiCib8+GQUJibpQ12q3cU8BWNHUolIan+5IFH84
         Iy8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=uGUfBQopHBdn9r04y488/hnN8hfVzK+WI3Hfgpr2xbA=;
        b=qmpXsLw7VP5v41R34MhG0epuOlg7u7neBgEsBdmIZyqfQpapkcKvW48ew3TxRrDRyN
         KfWDxmiKMAoMZUK6Y9AoVKjp2BJbG96xsL37kPxVIHwU5tCj0KW9cjge+uPF7APpyQmY
         Dp/6qQLvQc+rO9qF6AYDl53cTV9mDMhlf/uzlnYAEH+jty6yeNu10hSgi3mmM1Odbu8k
         +fR8RcweAlnsWKc3CHrB+B8o0Ju0paeq7+gFu/Z95t7VXtowD1nEI9XNpNyViMwCavrU
         e9LJWvOqOXUqudD6HGFEXD7XW+9D/8TsnnQn+d5FXt9zuuQyk0tOY/V71o685BTabIim
         8mPA==
X-Gm-Message-State: AKwxytd2cBNle2Hs3fikl1G+fplpTXZIf+9ng6HUWp+gIpchO/4WKsAk
        QhfN/ssvO2XdrhZI6IZz1e17WQRMzTesapYwNN4=
X-Google-Smtp-Source: AH8x225048CoYEF5ZwTDD+iTKgWF1LlZ/lo7nT7e9dZ2/H4EnovXWnrbmgDlSrVAm+t97OHH/tu+hiDmWdw3101aWgw=
X-Received: by 10.176.25.67 with SMTP id u3mr11223153uag.44.1516992716775;
 Fri, 26 Jan 2018 10:51:56 -0800 (PST)
MIME-Version: 1.0
Received: by 10.176.32.12 with HTTP; Fri, 26 Jan 2018 10:51:56 -0800 (PST)
In-Reply-To: <xmqq1sic8omp.fsf@gitster.mtv.corp.google.com>
References: <20180126123708.21722-1-szeder.dev@gmail.com> <20180126123708.21722-9-szeder.dev@gmail.com>
 <xmqq1sic8omp.fsf@gitster.mtv.corp.google.com>
From:   =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Date:   Fri, 26 Jan 2018 19:51:56 +0100
Message-ID: <CAM0VKjn401p4fbF-mJrpaQrgOHGHZ1HtRNx9n+CV+jn4n2a1Uw@mail.gmail.com>
Subject: Re: [PATCH 08/10] t: forbid piping into 'test_i18ngrep'
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git mailing list <git@vger.kernel.org>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 26, 2018 at 7:24 PM, Junio C Hamano <gitster@pobox.com> wrote:
> SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:
>
>> See two of the previous patches for the only such cases we had in our
>> test suite.  However, reliably preventing this antipattern is arguably
>> more important than supporting these cases, which can be worked around
>> by only minor inconveniences.
>
> I am not sure if that inconveniences will be minor.  Is this too
> contrived an example, for example?
>
>   check () {
>         pattern=3D$1 file=3D$2 script=3D./runme
>
>         test_i18ngrep "$pattern" "$file" &&
>         write_script "$script" &&
>         test_expect_success "check $pattern" '
>                 "$script"
>         '
>   }
>
>   check foo file <<-EOF
>   ... test script comes here ...
>   EOF

With 'test_i18ngrep' outside the 'test_expect_success' block!?
Definitely too contrived. :)

OTOH, what about flipping the order of 'test_i18ngrep' and
'write_script'?  If we can't do that, then I wonder what the reason
might be that is not too contrived.


>>
>> Signed-off-by: SZEDER G=C3=A1bor <szeder.dev@gmail.com>
>> ---
>>  t/test-lib-functions.sh | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
>> index 92ed02937..e381d50d0 100644
>> --- a/t/test-lib-functions.sh
>> +++ b/t/test-lib-functions.sh
>> @@ -719,6 +719,10 @@ test_i18ncmp () {
>>  # under GETTEXT_POISON this pretends that the command produced expected
>>  # results.
>>  test_i18ngrep () {
>> +     ( read line ) &&
>> +     error "bug in the test script: data on test_i18ngrep's stdin;" \
>> +           "perhaps a git command's output is piped into it?"
>> +
>>       if test -n "$GETTEXT_POISON"
>>       then
>>           : # pretend success
