Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9BA3B207DF
	for <e@80x24.org>; Mon, 12 Sep 2016 17:40:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755619AbcILRkJ (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Sep 2016 13:40:09 -0400
Received: from mail-wm0-f52.google.com ([74.125.82.52]:35129 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751936AbcILRkB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Sep 2016 13:40:01 -0400
Received: by mail-wm0-f52.google.com with SMTP id a6so66142072wmc.0
        for <git@vger.kernel.org>; Mon, 12 Sep 2016 10:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=GzK2OqVIbwJafmEt50Zc+VYOiRNGL83nH8AFNY185NA=;
        b=cU840Vqn2KxZJ1oe8+3ExSUd77QrEgbW8YzjL6F7PfyGlgSiaboCeF+ABvwuzFG8+y
         YyjhP6BDi4dLBj/X3pCi83Luiw6ZpjQzLeE2L2jzdP+TUn55qYt5i+aR7124WC/u8IUD
         aiXBmkAss73dtl/5nZh04eKjmO6GoITiyQP7/MD0FcMeUo4mlEtTJTqvtwSn1TM6uZ6A
         XHW7X5PPIRLspWukQci4wh3QVrfj8QX2ogg/eJZQTY9Vf5F5LCc1LQ5//xQOwJpw7dyz
         PHO99ah7CQ0oX1PHB9lRiEmLeq+3SyW82++tns8lxTytXT9Qh7TdRvA15lc/Xa6pQmYL
         BuDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=GzK2OqVIbwJafmEt50Zc+VYOiRNGL83nH8AFNY185NA=;
        b=anROxdW5h9Ho4bJ9T+z3abY3hXVu2mEz/e/5vRhR2dCbQE6pfVbUq8fB3z6AdX8jZW
         nyp/yAWKJjWsNx4pflRhfJecFLt1emuYKae9JGJOaFe51yl/QkjeksWczUVRmidD6qgG
         zislrAP61nPu+vWRvjUlUEC2Gi2Af/mUAO0rjiTFSgiadLymYPF6lW0xsPwpfHQoC1Jw
         4V4B5FnRySot48KSyynUVGQf+jzUhX77OfssratdAKWntmEk+lAg1K1O+5iove0JVP7N
         tSOCH3yNZXax4/zC5qomvtUd/OUApvTOJ1uzZWNiy9m0WoSGYsvlBnPCxWfA90BWWo71
         9p1g==
X-Gm-Message-State: AE9vXwNeYuehfHXZ7RK3osFqC3iJG3Ipznbz0NM3VijL5GF0RqMrsJwa9Ufg6K9YyDgzRtSKWwKAkcLysVe/FRta
X-Received: by 10.194.123.35 with SMTP id lx3mr18093202wjb.126.1473702000190;
 Mon, 12 Sep 2016 10:40:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.28.15.79 with HTTP; Mon, 12 Sep 2016 10:39:59 -0700 (PDT)
In-Reply-To: <CAKoko1oSEac_Nr1SkRB=dM_r3Jnew1Et2ZKj716iU3JLyHe2GQ@mail.gmail.com>
References: <1473458004-41460-1-git-send-email-bmwill@google.com>
 <xmqqh99o8ypm.fsf@gitster.mtv.corp.google.com> <CAGZ79kaWNykEAZcjZ2Y19j2_3TF+qcz+vb8zSi1U+me3k+06LA@mail.gmail.com>
 <xmqqmvje6qbe.fsf@gitster.mtv.corp.google.com> <20160912005106.fj7adhmtfklv4vir@sigill.intra.peff.net>
 <20160912005229.6njhgfq7h6cb34s4@sigill.intra.peff.net> <xmqqmvjd3y5l.fsf@gitster.mtv.corp.google.com>
 <CAKoko1oSEac_Nr1SkRB=dM_r3Jnew1Et2ZKj716iU3JLyHe2GQ@mail.gmail.com>
From:   Brandon Williams <bmwill@google.com>
Date:   Mon, 12 Sep 2016 10:39:59 -0700
Message-ID: <CAKoko1rNUaoC7pKH=aWQQP83AoeZjakFSNq_w-G2OL78ZKg+=w@mail.gmail.com>
Subject: Re: [RFC/PATCH] ls-files: adding support for submodules
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for all the comments.  What it sounds like is that using ls-files as
a means to power a recursive git-grep may not be like the best approach (I
assumed that would be the case but thought it a decent place to start).

I agree that not all operating modes would be useful for a recursive
ls-files, which is why I initially don't have support for them.  I guess
the question would be which modes would be worth supporting in a recursive
case?
