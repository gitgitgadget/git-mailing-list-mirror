Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F7C0209AA
	for <e@80x24.org>; Sat, 15 Oct 2016 08:27:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753456AbcJOI1R (ORCPT <rfc822;e@80x24.org>);
        Sat, 15 Oct 2016 04:27:17 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:36033 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753343AbcJOI0p (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Oct 2016 04:26:45 -0400
Received: by mail-qk0-f195.google.com with SMTP id z190so10120373qkc.3
        for <git@vger.kernel.org>; Sat, 15 Oct 2016 01:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=nhF/kAgi7UwO6JC2YVTadNcKN5RX260mE0zRBqBm4NU=;
        b=ksLi8xhYlqOcVn3RxKjMaUGXzxrQ3GJp9dHyYEUtdDo0yoX3Ty5YLqTrV0ZNxCXVHy
         aEZMXUC832dYqHacednImoxgfPjd1s/8XV3nvIDHFH+YBfAGZzXaZttqXsZfgdQ3CqA6
         H4ZkwDfVX8fz6N42H1YKqRBe1u2tIH55EkZSgoZjPjyYf1fifDHL57hgj17756mm/ecC
         UPwGaSR8ZZKcNxuI+b2XkJERsXHZFKRjcukuRRzLfZE9SBGJcppme6idzL2mO5ECc93J
         Bs55ptQw+MeAKqUvv4ZQ34u+BY5ZRGSu0zJQHa49t8cGy0Ec84JQ9VZIm1CIsMQz0kSm
         Mf8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=nhF/kAgi7UwO6JC2YVTadNcKN5RX260mE0zRBqBm4NU=;
        b=HaCMsJFPHiJKP5DlpTfIpJq9CzKMR9/FC3Ayw4djKbhs6ZllqNEOapwXlqxkPgssxq
         WKW+Zn0UUpF+f8P5m889NECnuIWisM3hld9TPs9CGks3oSjLRUgbMbNy31Ce3LfR99aV
         qnS5rnOWzRIqJmuJrVafWoM3R3mnq5unD5slcfNVCt1+iW3R2fHIFFQpeCduAoQJF4nX
         EHNLTbkQ/TuDw2YpZTdILMTVfeFOuWYXX5CFHJFHzE5paYSBfbat8nunRmkYQt4lgIAb
         EQMWtBJtHln55VDbE3Y0BrJFbwaET3a7EyqrRCpn7bPKf9iCH75M0XGAdugfSM579TEf
         FnXA==
X-Gm-Message-State: AA6/9Rld36aDXZuxFgcz4ZopkB5oOlfcTCshXs/UIFH2CUdxvn1hVV4R5bGuOaNTgg/3WcX0QqNuy3x5pEMMYQ==
X-Received: by 10.233.222.71 with SMTP id s68mr17890211qkf.203.1476519111208;
 Sat, 15 Oct 2016 01:11:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.55.217.79 with HTTP; Sat, 15 Oct 2016 01:11:30 -0700 (PDT)
In-Reply-To: <xmqq37jyzsdk.fsf@gitster.mtv.corp.google.com>
References: <20161006091135.29590-1-avarab@gmail.com> <20161006091135.29590-3-avarab@gmail.com>
 <3fa9902f-3b01-5ec6-8129-34cff4c7cac9@gmail.com> <xmqq37jyzsdk.fsf@gitster.mtv.corp.google.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Sat, 15 Oct 2016 10:11:30 +0200
Message-ID: <CACBZZX4FK+zrVyBTpbJAbSAxQ9LuCTXcExeEqZE6D3nwHbNxZA@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] gitweb: Link to 7-char+ SHA1s, not only 8-char+
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 14, 2016 at 8:40 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Jakub Nar=C4=99bski <jnareb@gmail.com> writes:
>
>> s/SHA1/SHA-1/g in above paragraph (for correctness and consistency).
>>>
>>> I think it's fairly dubious to link to things matching [0-9a-fA-F]
>>> here as opposed to just [0-9a-f], that dates back to the initial
>>> version of gitweb from 161332a ("first working version",
>>> 2005-08-07). Git will accept all-caps SHA1s, but didn't ever produce
>>> them as far as I can tell.
>>
>> All right.  If we decide to be more strict in what we accept, we can
>> do it in a separate commit.
>>
>>>
>>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
>>
>> Acked-by: Jakub Nar=C4=99bski <jnareb@gmail.com>
>
> Thanks for a review.  As the topic is not yet in 'next', I'll squish
> in your Acked-by: to them.  I saw them only for 1 & 2/3; would
> another for 3/3 be coming soon?

As far as I can tell the only outstanding "change this" is your
s/SHA1/SHA-1/ in <xmqq37k9jm86.fsf@gitster.mtv.corp.google.com>, do
you want to fix that up or should I submit another series?

>>
>>> ---
>>>  gitweb/gitweb.perl | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
>>> index cba7405..92b5e91 100755
>>> --- a/gitweb/gitweb.perl
>>> +++ b/gitweb/gitweb.perl
>>> @@ -2036,7 +2036,7 @@ sub format_log_line_html {
>>>      my $line =3D shift;
>>>
>>>      $line =3D esc_html($line, -nbsp=3D>1);
>>> -    $line =3D~ s{\b([0-9a-fA-F]{8,40})\b}{
>>> +    $line =3D~ s{\b([0-9a-fA-F]{7,40})\b}{
>>
>> By the way, it is quite long commit message for one character change.
>> Not that it is a bad thing...
>>
>>>              $cgi->a({-href =3D> href(action=3D>"object", hash=3D>$1),
>>>                                      -class =3D> "text"}, $1);
>>>      }eg;
>>>
