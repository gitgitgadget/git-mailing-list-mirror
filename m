Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 326FD1F404
	for <e@80x24.org>; Tue, 14 Aug 2018 21:02:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728072AbeHNXvs (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Aug 2018 19:51:48 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:34186 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726648AbeHNXvs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Aug 2018 19:51:48 -0400
Received: by mail-ed1-f68.google.com with SMTP id h1-v6so10841184eds.1
        for <git@vger.kernel.org>; Tue, 14 Aug 2018 14:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=LmDReyckrEBareJW5iZV2yzYecOiSXB5RjEOwe7i6PM=;
        b=lahcDQOazYnlbcPiEDgMAJcOWeEWt7Wn0EhEQApPiv+/EzEmV0lFnpIqGXc6SElaX5
         8YvULO8n4LNUtE8T1/VXP9RCyxMEvx24oWsf/KqMlT5uEJ1aAiD8vEaIpeflzoGcE8RF
         YK4ju69vlkZ+KO+sWUkCo8He2b3x/1yYAU/YHFs+5YUNn4jMxiXmHqKodZoM5BTWGcVB
         U0P+cMeYM9Dzq2z9NOc+UU/XAXt7JGxi4A0bo+lQG5i/lXG7vPsndbgR9WLt/cAUcs0k
         pi91ufJsj+gCh8YjGWbYhvgoNr/CtlsVkd4thZb41hIRgpZ7FWMy2QAw9O5tPuTkgZ+N
         2J3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=LmDReyckrEBareJW5iZV2yzYecOiSXB5RjEOwe7i6PM=;
        b=Os5O+BPOthW8rHi9Df0q5RpaQAIMJusx9pMFoF+zRapTKOrzp9hga7dJghWDlRHq2c
         46qG5IXFF5qxcXOEDsXBX/4j6g4+/BrdDaYTvkoe4UilkBwnAg11qAMUACqg43uKtub5
         nnnd/8kdCIuw3xGziWXcvibITJ5LEnYlchntLzEuODAokpfPYnio55rlm596Ppy7rj2+
         C1H/Q+hOBWXe5PrRMQGZW++M+7aq0TwmN+fACOUvQ0lhR82AhSJRMOBJ6Q+V10Rm5g8u
         jA29vnkfKXD+7KBaMlACJAIN3UHMygqyIugSz34Ksf39ksyYfrQ6Io5eYQ0uoMREpntJ
         fkIA==
X-Gm-Message-State: AOUpUlHyulFJDWbFEehfJ45SIpM65SuPuFcHBIe7sennflFw/B6DTNVR
        XRDWvbl+dIYxfTNB1CpTx0U=
X-Google-Smtp-Source: AA+uWPxssXYFblGstq1MvHah8Z/RGlHEj+iJHRzABIHanADY6jV+eakn1hzan7fjfGINwWD6rEuQFg==
X-Received: by 2002:a50:fc0f:: with SMTP id i15-v6mr28401428edr.81.1534280566730;
        Tue, 14 Aug 2018 14:02:46 -0700 (PDT)
Received: from evledraar (h98111.upc-h.chello.nl. [62.194.98.111])
        by smtp.gmail.com with ESMTPSA id x13-v6sm33012695edx.17.2018.08.14.14.02.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 Aug 2018 14:02:45 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Eric Wong <e@80x24.org>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2] send-email: add an option to impose delay sent E-Mails
References: <20180325182803.30036-1-avarab@gmail.com> <20180814181534.21234-1-avarab@gmail.com> <20180814184509.GA16659@dcvr>
User-agent: Debian GNU/Linux testing (buster); Emacs 27.0.50; mu4e 1.1.0
In-reply-to: <20180814184509.GA16659@dcvr>
Date:   Tue, 14 Aug 2018 23:02:44 +0200
Message-ID: <87eff0hdaj.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Aug 14 2018, Eric Wong wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> wrote:
>> Add a --send-delay option with a corresponding sendemail.smtpSendDelay
>> configuration variable. When set to e.g. 2, this causes send-email to
>> sleep 2 seconds before sending the next E-Mail. We'll only sleep
>> between sends, not before the first send, or after the last.
>>
>> This option has two uses. Firstly, to be able to Ctrl+C a long send
>> with "all" if you have a change of heart. Secondly, as a hack in some
>> mail setups to, with a sufficiently high delay, force the receiving
>> client to sort the E-Mails correctly.
>>
>> Some popular E-Mail clients completely ignore the "Date" header, which
>> format-patch is careful to set such that the patches will be displayed
>> in order, and instead sort by the time the E-mail was received.
>>
>> Google's GMail is a good example of such a client. It ostensibly sorts
>> by some approximation of received time (although not by any "Received"
>> header). It's more usual than not to see patches showing out of order
>> in GMail. To take a few examples of orders seen on patches on the Git
>> mailing list:
>>
>>     1 -> 3 -> 4 -> 2 -> 8 -> 7 (completion by Nguy=E1=BB=85n Th=C3=A1i N=
g=E1=BB=8Dc Duy)
>>     2 -> 0 -> 1 -> 3 (pack search by Derrick Stolee)
>>     3 -> 2 -> 1 (fast-import by Jameson Miller)
>>     2 -> 3 -> 1 -> 5 -> 4 -> 6 (diff-highlight by Jeff King)
>>
>> The reason to add the new "X-Mailer-Send-Delay" header is to make it
>> easy to tell what the imposed delay was, if any. This allows for
>> gathering some data on how the transfer of E-Mails with & without this
>> option behaves. This may not be workable without really long delays,
>> see [1] and [2].
>
> Aside from the new header, I think this is better implemented
> using the existing $relogin_delay and $batch_size=3D1.
>
> Disconnecting during the delay might be more sympathetic to
> existing mail servers (which aren't C10K-optimized).

Yeah that's a good point, maybe we're being wasteful on remote resources
here.

> If the client sleeps, the server may disconnect the client anyways to
> save resources.

Seems like something we'd need to deal with anyway, do we?

>> @@ -1741,6 +1747,10 @@ sub process_file {
>>  		$message, $xfer_encoding, $target_xfer_encoding);
>>  	push @xh, "Content-Transfer-Encoding: $xfer_encoding";
>>  	unshift @xh, 'MIME-Version: 1.0' unless $has_mime_version;
>> +	if ($send_delay && $i > 0) {
>> +		push @xh, "X-Mailer-Send-Delay: $send_delay";
>> +		sleep $send_delay;
>> +	}
>
> We can add this header for relogin_delay + batch_size
>
> But maybe --send-delay can be a shortcut for
> --relogin-delay and --batch-size=3D1

I need to enter a password when sending a batch with my SMTP server now,
once. With relogin I'd need to enter this N times unless I use whatever
auth save facility there is in git-send-email (which I don't use now).

I don't think it makes sense to conflate these two modes.
