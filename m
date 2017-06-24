Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E4CCB20401
	for <e@80x24.org>; Sat, 24 Jun 2017 12:38:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751436AbdFXMic (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Jun 2017 08:38:32 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:33239 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750817AbdFXMic (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Jun 2017 08:38:32 -0400
Received: by mail-qk0-f196.google.com with SMTP id p21so9393630qke.0
        for <git@vger.kernel.org>; Sat, 24 Jun 2017 05:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=wsHZ54LEMXJGtVvyyzC7j42XH6WoQR/i/NLC1X6esRM=;
        b=uNzL0yAB+Qmt6We+jhAsyAD+XORMojVRm/y4LbHZZNjU3D3nV8wpos+4/iEms5Isy/
         mS9BZfiZQ1C3by1IuJgObAkCsQrdoSGJvCsF45tzc7hLZ4RRSdfGstF5CbpnPrLDPnNq
         4Q/sXRkEvvorqZkaSfQBfiLAzFARzfCK+1yI++objbormNZuuhOqcPk20vsT7slY4MeS
         VZojXwMH1f5LCrOu9kB6pzKgtBphnizKuIujkpra2Kk4Jcr2OZaZh6xQaFpwgwlQsA9B
         37oX9w8qFMQ3ZiS3l2RbtWpvN4tW60wedans2ckNEkbKG1ZCZDlfTLIHRPIMq1EV4Xz1
         G5lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=wsHZ54LEMXJGtVvyyzC7j42XH6WoQR/i/NLC1X6esRM=;
        b=Nq7hd4jy9eCk5T0atHPZGi7i6UUf3y3L1IhYUrxo6PspTXQcH2nW9PjksxoFKJmgdN
         jiGNIb3PIPuMgi8KvQjmMiwWsChcVZj9J/BKQN+MDEteK1yw0w0YjrrtwnFUbiHcPXBB
         50DUzFEBrbwhUzGXpwtJXL+wU30NbgGwZt49jhitxRJ7AfbXPUlvyaMNvI14+7z2mDLt
         1G9NtvNKlGjgv02wg3YVwCjRgweoxYagfcyLDzJmduMzQKNs8tIUatLi6K0kCsF/hVh3
         lKHKeEsidNiw2NEj/UXJXlcQO6T6UlvL2XzUZaXIa1PRHYi4alMq3EzbwHZPIM66zBuh
         GnNA==
X-Gm-Message-State: AKS2vOyq2Dxbj3XMCsqOrUswdxbU8FAfOTfco/VQLJh7huRLWYSKCQ1A
        fgBm9dA7I/+GapRi6im9N7Lh9dm1tg==
X-Received: by 10.55.207.140 with SMTP id v12mr13338873qkl.49.1498307911116;
 Sat, 24 Jun 2017 05:38:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.237.63.198 with HTTP; Sat, 24 Jun 2017 05:38:30 -0700 (PDT)
In-Reply-To: <CAE5ih78YFSjcn6RNGzdxsjvn6B7xvHMgKKRqirjW00=9hWpDYA@mail.gmail.com>
References: <1497961141-3144-1-git-send-email-miguel.torroja@gmail.com>
 <xmqq4lv8kjxo.fsf@gitster.mtv.corp.google.com> <CAE5ih78YFSjcn6RNGzdxsjvn6B7xvHMgKKRqirjW00=9hWpDYA@mail.gmail.com>
From:   miguel torroja <miguel.torroja@gmail.com>
Date:   Sat, 24 Jun 2017 14:38:30 +0200
X-Google-Sender-Auth: AoMRZfZLtD2rqc83CYY-0Adut6I
Message-ID: <CAKYtbVbMKgPASP-ib7DSbDONnV988woV_=zU=XPwaMpWE=TqGQ@mail.gmail.com>
Subject: Re: [PATCH] git-p4: changelist template with p4 -G change -o
To:     Luke Diamand <luke@diamand.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

You are right about the "# add"comment. I couldn't find any extra info
in the marshaled output that I can use to add the change action
comment after the path. That's one downside of that change.

On Sat, Jun 24, 2017 at 1:49 PM, Luke Diamand <luke@diamand.org> wrote:
> On 22 June 2017 at 18:32, Junio C Hamano <gitster@pobox.com> wrote:
>> Miguel Torroja <miguel.torroja@gmail.com> writes:
>>
>>> The option -G of p4 (python marshal output) gives more context about the
>>> data being output. That's useful when using the command "change -o" as
>>> we can distinguish between warning/error line and real change description.
>>>
>>> Some p4 plugin/hooks in the server side generates some warnings when
>>> executed. Unfortunately those messages are mixed with the output of
>>> "p4 change -o". Those extra warning lines are reported as {'code':'info'}
>>> in python marshal output (-G). The real change output is reported as
>>> {'code':'stat'}
>
> I think this seems like a reasonable thing to do if "p4 change -o" is
> jumbling up output.
>
> One thing I notice trying it out by hand is that we seem to have lost
> the annotation of the Perforce per-file modification type (is there a
> proper name for this?).
>
> For example, if I add a file called "baz", then the original version
> creates a template which looks like this:
>
>    //depot/baz    # add
>
> But the new one creates a template which looks like:
>
>    //depot/baz
>
> Luke
