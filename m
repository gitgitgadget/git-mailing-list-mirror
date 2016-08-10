Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7854F1FD99
	for <e@80x24.org>; Wed, 10 Aug 2016 19:04:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934834AbcHJTD5 (ORCPT <rfc822;e@80x24.org>);
	Wed, 10 Aug 2016 15:03:57 -0400
Received: from mail-it0-f53.google.com ([209.85.214.53]:36691 "EHLO
	mail-it0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933531AbcHJTDy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Aug 2016 15:03:54 -0400
Received: by mail-it0-f53.google.com with SMTP id x130so46379149ite.1
        for <git@vger.kernel.org>; Wed, 10 Aug 2016 12:03:54 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=/m/th5F7i166nwqI7/+iFkIWxEoSwmbwxexsKWl+BLM=;
        b=JzulT+gMMbJVKdmcwIFt33JFR3xsDjmwA02PH1ud5K/azYz3o5pT+Lx+z5rRtqQn/R
         0fBUQfN7y89+qu507YM4ijvGYMWW8ascLjwpgupnhopSB5PUIoQVuv4ZUbQ/zRMD4peo
         eKuLGY/oVJLOfHqauy4Mzu4YwPkc3r36EJSRTlcPUxanChLys/JhL+Xl05FDKgNuFDVJ
         IwU+g9xQhnpkrT4l4D/n9dLM5FVbpUatCkg5n+qYuz+b7pM3n1DIuMLwmCxH1IsGCuXP
         ZtMuT5UIk3Mr0qOCdxbxh4SHPf/uLQ1ALAaZQgyvnTrbR+HZ/qa5RrTHW25d8yH7tD2r
         tW+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=/m/th5F7i166nwqI7/+iFkIWxEoSwmbwxexsKWl+BLM=;
        b=HHq/35vUuc5yzVf/+WCdYs7jczu8tnc4+PrSVgBMDcWxbfmUbiDrdMl5otFPCw9CGg
         61Uh4t3FeQCqmQktkV9tfielbWEir87QpjdjkkWgXbobPRcRosTaOVndAZxuTwl7WQga
         vyaQd8T+T/A9IFDdhGhlAu1WBBdAJAe3LsQQQhEgdU9c/FSbTXAj8xCblbVG1V09INnB
         1N15+s76f24NWTr0TRNqDfNKiiMZa6aS7jnP4lBE2LreLdV9Lc6RYFiQmPaTc2Cj3kn+
         acc70kelyPsM36MqRLZgAG4NM/+PkwCUAGN7b8lbdD0cteV7nAyM5DbDkZrI3nwVRuaw
         hOLw==
X-Gm-Message-State: AEkoouuSw3rTdpUpo+AuR4CU10t1HNiaBe13DZZzw3owNNuoWydhyX3MA7i2fDZigE3n3+O4b8l2HrNHQGAdGoKl
X-Received: by 10.36.217.9 with SMTP id p9mr5421570itg.46.1470855833249; Wed,
 10 Aug 2016 12:03:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.128.66 with HTTP; Wed, 10 Aug 2016 12:03:52 -0700 (PDT)
In-Reply-To: <xmqq1t1w5vk6.fsf@gitster.mtv.corp.google.com>
References: <A6131C47-3230-4EC4-B3F6-B2507C937A22@gmail.com>
 <20160810175607.30826-1-sbeller@google.com> <xmqq1t1w5vk6.fsf@gitster.mtv.corp.google.com>
From:	Stefan Beller <sbeller@google.com>
Date:	Wed, 10 Aug 2016 12:03:52 -0700
Message-ID: <CAGZ79kb5Sy6rC1j8uLq+oCTfVVpan0tgat59yOJV20nFeRzSKQ@mail.gmail.com>
Subject: Re: [PATCH] t7406: fix breakage on OSX
To:	Junio C Hamano <gitster@pobox.com>
Cc:	"git@vger.kernel.org" <git@vger.kernel.org>,
	Lars Schneider <larsxschneider@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, Aug 10, 2016 at 11:27 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> On OSX `wc` prefixes the output of numbers with whitespace, such that
>> the `commit_count` would be "SP <NUMBER>". When using that in
>>
>>     git submodule update --init --depth=$commit_count
>>
>> the depth would be empty and the number is interpreted as the pathspec.
>> Fix this by not using `wc` and rather instruct rev-list to count.
>>
>> Another way to fix this is to remove the `=` sign after the `--depth`
>> argument as then we are allowed to have more than just one whitespace
>> between `--depth` and the actual number. Prefer the solution of rev-list
>> counting as that is expected to be slightly faster and more self-sustained
>> within Git.
>
> You meant self-contained, I would guess.

Yes. Mind to fix that locally, or waiting for a resend?

>
> There are a couple of "log --oneline | wc -l" remaining that are
> currently safe but they may be a time-bomb waiting to go off.

$ grep -r "log --oneline | wc -l"
t6050-replace.sh: test $(git log --oneline | wc -l) = 7 &&
t6050-replace.sh: test $(git log --oneline | wc -l) = 3 &&
t7406-submodule-update.sh: test 1 = $(git -C submodule log --oneline | wc -l)
t7406-submodule-update.sh: test 1 = $(git -C submodule log --oneline | wc -l)
t7400-submodule-basic.sh: test 1 = $(git log --oneline | wc -l)

All of the occurrences are not white space sensitive AFAICT,
they are just bad examples, which may inspire others to follow
that pattern.

Thanks,
Stefan
