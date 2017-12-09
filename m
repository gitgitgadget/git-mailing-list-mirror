Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB4601F404
	for <e@80x24.org>; Sat,  9 Dec 2017 03:04:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753498AbdLIDD7 (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Dec 2017 22:03:59 -0500
Received: from mail-wm0-f54.google.com ([74.125.82.54]:46243 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753157AbdLIDD6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Dec 2017 22:03:58 -0500
Received: by mail-wm0-f54.google.com with SMTP id r78so5995412wme.5
        for <git@vger.kernel.org>; Fri, 08 Dec 2017 19:03:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vfQm9Bpq2kpXlJEAcL7p735lFsHiVUCYqkXPwRiKDh4=;
        b=Zv0m7u7WxKUP5AJ8luYXVZSYep7tH5gt8nNg+HFwT0/sSStY1WjiZNuTVP2Kh5ONxk
         6AsLDVPMZ0a+V8KhkIOGNQnRxv2KLbNzsk2kGnFHG8Jv6sgq2iIYT8nV7glI4Vmo+8eB
         2JGQrlwsIIURurv/dvCoRqdp0TCJ5MNdR575N8y08RGbHoGox0IkvUU0CWxfUIVOuNTl
         MR0lMcl6yVmnrsIYAQQXDOHG87nWms6V5eBiI4CRJ8ktilUn1W2bxTaChNiFeIdmqAId
         3p2jYTB4rMy0lErU8zTUOnMSfK/NLa5pkieQOFvkKYuB22N5MZEv+fKYTUSBpG4V57hI
         ooBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vfQm9Bpq2kpXlJEAcL7p735lFsHiVUCYqkXPwRiKDh4=;
        b=Dy1R9+CVYueuednM/mhs8r1mY3Wgv5q+Zj2+pIsgU3GG+Ansrxcf5g5m3f1kuuoItM
         ffOivFo7BPUYXVrgN1jwe1TVo10hua+uJOhcRThsWmRUyK/H4SN5bYv/7yUWu6ywkRqr
         S7nBrOD2GBajIozAqK0zirAPa8WzdQ6bLGCuRYNkF3zfvokcnQEHTjLifsCJac2LfjhD
         v0foS+fS90x5HzSUSnVe08OTBI+nFg5fI4DwkHEkkOJkltS17aBILn2809w99o4xlGWi
         v7L/oyMPHyjOiJlw4uiopSUaQATXvks098n700iFvJMJB+Hr0+MB5YMBxFc2y2oqKWPW
         E6xg==
X-Gm-Message-State: AKGB3mLW5y1D0nR/006cAkt4vBrBjYQHU6Yvw5A+I1wCw3AVb2Bz98ve
        nDhvzKiXifGI77C3/g1Bw/N72XlHhBM=
X-Google-Smtp-Source: AGs4zMZPnxodMvjRB2/f4aOWsD/ShGQ8iXJYuzpIqrjwIFyy7wmAizBtFKyPlIpU05Cu5mQhaLNIYA==
X-Received: by 10.28.193.139 with SMTP id r133mr3434468wmf.39.1512788636940;
        Fri, 08 Dec 2017 19:03:56 -0800 (PST)
Received: from [192.168.5.102] (cable-24-135-61-30.dynamic.sbb.rs. [24.135.61.30])
        by smtp.gmail.com with ESMTPSA id l31sm13067059wrc.50.2017.12.08.19.03.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Dec 2017 19:03:56 -0800 (PST)
Subject: Re: [SCRIPT/RFC 0/3] git-commit --onto-parent (three-way merge, no
 working tree file changes)
To:     Alexei Lozovsky <a.lozovsky@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
        Git Mailing List <git@vger.kernel.org>,
        Nikolay Shustov <nikolay.shustov@gmail.com>,
        Johannes Schneider <mailings@cedarsoft.com>,
        Patrik Gornicz <patrik-git@mail.pgornicz.com>,
        Martin Waitz <tali@admingilde.org>,
        Shawn Pearce <spearce@spearce.org>,
        Sam Vilain <sam@vilain.net>, Jakub Narebski <jnareb@gmail.com>
References: <8998e832-f49f-4de4-eb8d-a7934fba97b5@gmail.com>
 <d5f243a5-6e35-f3fc-4daf-6e1376bef897@kdbg.org>
 <203a75c8-0c58-253c-2c18-05450f7ae49b@gmail.com>
 <ea156b8b-29d8-7501-b5a5-a29cfbd7d1d6@kdbg.org>
 <741dfedc-07f8-24fb-ebe2-940f8b2639d4@gmail.com>
 <33e97533-716b-e1cc-6aa0-bf8941225319@kdbg.org>
 <7ae3ffd5-147d-55d2-9630-da12c429d631@gmail.com>
 <39323748-282c-5881-2bfa-de622bb8b765@kdbg.org>
 <CAPc5daWupO6DMOMFGn=XjUCG-JMYc4eyo8+TmAsdWcAOHXzwWg@mail.gmail.com>
 <f9a94a62-9541-e019-8ab3-9fc9cfe2c43f@gmail.com>
 <xmqqo9n99ohc.fsf@gitster.mtv.corp.google.com>
 <a3510c14-23e9-d1d9-0847-b60451f8e15d@gmail.com>
 <D842B04A-9331-4F26-8F19-B61F6F13FC79@gmail.com>
From:   Igor Djordjevic <igor.d.djordjevic@gmail.com>
Message-ID: <92643df4-f54e-cd31-da4a-138ec314655a@gmail.com>
Date:   Sat, 9 Dec 2017 04:03:53 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <D842B04A-9331-4F26-8F19-B61F6F13FC79@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Alexei,

On 09/12/2017 03:18, Alexei Lozovsky wrote:
> 
> > Chris reported in this very topic[1] that sometimes, due to
> > conflicts with later commits, "checkout > commit > [checkout >]
> > rebase --onto" is "much easier to do", where "commit --fixup >
> > rebase -i" "breaks" (does not apply cleanly).
> 
> It was more of a rant about conflict resolution by rebase rather than
> a concern about modification time of files. While I'd prefer git to
> not touch the source tree unnecessarily, it's not really a big deal
> for me if it does and some parts of the project need to be rebuilt.

Nevertheless, I found it valuable in supporting the case where 
"commit --fixup > rebase -i" seems to require even more work than 
otherwise necessary :)

But thanks for clarifying, anyway, it does feel like `git rebase -i 
--autosquash` could be smarter in this regards, if `git rebase 
--onto` does it better...?

Even though your explanation seems clear, having a real, easily 
reproducible case would help as well, I guess.

> I kinda hoped that you may know this magic and incorporate it into 
> "commit --onto" which will allow to immediately get to the result of 
> the rebase:
> 
>   ---A---f!A---B'
> 
> without spelling it all manually.

If you mind enough to be bothered testing it out, might be even 
existing/initial state of originally proposed `git commit 
--onto-parent` script would work for you, as it does incorporate some 
trivial three-way merge resolution.

In your starting situation:

    ---A---B

... you would just do something like:

    git commit --onto-parent A

... hopefully ending up in the desired state (hopefully = conflicts 
automatically resolved):

    ---A---C---B'

You could even do this instead:

    git commit --onto-parent A --amend

... ending up with:

    ---A'---B'

... as that is basically what you wanted in the first place ;)

> (And yeah, I'm actually Alexei, not Chris. That was my MUA being
> dumb and using an old pseudonym than Google insists I'm called by.)

Ah, sorry for the confusion :)

Regards, Buga
