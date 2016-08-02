Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 831461F858
	for <e@80x24.org>; Tue,  2 Aug 2016 07:59:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756166AbcHBH65 (ORCPT <rfc822;e@80x24.org>);
	Tue, 2 Aug 2016 03:58:57 -0400
Received: from mail-wm0-f46.google.com ([74.125.82.46]:38433 "EHLO
	mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756159AbcHBH6z convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Aug 2016 03:58:55 -0400
Received: by mail-wm0-f46.google.com with SMTP id o80so276921125wme.1
        for <git@vger.kernel.org>; Tue, 02 Aug 2016 00:58:54 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=w7XkRes6aW40mK9v4RqrnQA0A6PEIP0IoX0Vgj4Z3mk=;
        b=Nzpwy3io26UjZYmW5QzQ/60FCW+1V0vQSConAjB7YooUjfglVFoeTEA+KURBAjeEjf
         smDvlhIu1rVM+d2eqNLzyWbtVunUOBkCICIaGBdWXGBG5rqG8zsZ+Dv2x5OIce8mXt9X
         ugEhVgnKXYRaH2e/dNqhJ+NyhiBvTzDb1T0JG2jo2ZNECmhvfr277cjYJT4HXO0IPkdZ
         puPMfJSgJZ9xyz3II7XCGgaOGHtUkjsAT5uhYHLbo8yBexsWTsgHa4nlB4cf9DkKLFr2
         0vg+oxWVqDuMAlww2Md17hyVz7DuVJUK8bBmd9E19xuyaQ/3nzYUnM5cVL5nHdgqERny
         uGUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=w7XkRes6aW40mK9v4RqrnQA0A6PEIP0IoX0Vgj4Z3mk=;
        b=RJ9IYWvaZtxvDL9ErjsBHCeyeB9UsQhb+ZmI+itU3sTt6Ut6uZeBu3dYPfEor0Mxdv
         w0M2hixZiGW1w38sUZx5LQz0EXfBjBq2d5TzwM3KwaJtSfKJdHhynzhEC/l3kY9LmDGj
         reCwlDCnFcJ3GVkhP4MUrTXTuvQzka2K/xMYf6XpWQpAk7BqdniYGIslZDOUKgUJ6977
         NkBmLmp8r1qJZc8rbsOR58SeJC3hLcTMjM5bLJEWSzWWp/PcuMngW3oHKdWJzHZr9qKh
         1aFl4ao9feG2iToTeBmsJKQPkOUXhlIYZT1/YF8gz7dOHDptK3o1ouCHOa/9brhlZytV
         /67Q==
X-Gm-Message-State: AEkoouuNKl2HcrUcbNoQ/uOBh7+addyWH4za1nBm8S4xLN8vxDIu2XCTcgpbJlh1uBfeKA==
X-Received: by 10.28.185.202 with SMTP id j193mr18015898wmf.78.1470123672197;
        Tue, 02 Aug 2016 00:41:12 -0700 (PDT)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id m81sm20615290wmf.1.2016.08.02.00.41.10
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 02 Aug 2016 00:41:11 -0700 (PDT)
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v3 06/10] run-command: add clean_on_exit_handler
From:	Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <c2a8149b-8a61-81d8-f07b-31b80e565fda@kdbg.org>
Date:	Tue, 2 Aug 2016 09:41:11 +0200
Cc:	Git Mailing List <git@vger.kernel.org>, gitster@pobox.com,
	jnareb@gmail.com, tboegi@web.de, mlbright@gmail.com, e@80x24.org,
	peff@peff.net
Content-Transfer-Encoding: 8BIT
Message-Id: <1C660676-D19E-4F73-BDD9-5F18CC0245EA@gmail.com>
References: <20160727000605.49982-1-larsxschneider%40gmail.com/> <20160729233801.82844-1-larsxschneider@gmail.com> <20160729233801.82844-7-larsxschneider@gmail.com> <ef6c6152-a720-6bd5-22bb-6ebf375ca919@kdbg.org> <EBBE9E5E-1A39-4124-AB0D-D74EE01FA0DA@gmail.com> <c2a8149b-8a61-81d8-f07b-31b80e565fda@kdbg.org>
To:	Johannes Sixt <j6t@kdbg.org>
X-Mailer: Apple Mail (2.3124)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org


> On 02 Aug 2016, at 07:53, Johannes Sixt <j6t@kdbg.org> wrote:
> 
> Am 01.08.2016 um 13:14 schrieb Lars Schneider:
> >> On 30 Jul 2016, at 11:50, Johannes Sixt <j6t@kdbg.org> wrote:
> >> Am 30.07.2016 um 01:37 schrieb larsxschneider@gmail.com:
> >>> static struct child_to_clean *children_to_clean;
> >>> @@ -30,6 +31,8 @@ static void cleanup_children(int sig, int in_signal)
> >>> {
> >>> 	while (children_to_clean) {
> >>> 		struct child_to_clean *p = children_to_clean;
> >>> +		if (p->clean_on_exit_handler)
> >>> +			p->clean_on_exit_handler(p->pid);
> >>
> >> This summons demons. cleanup_children() is invoked from a signal
> >> handler. In this case, it can call only async-signal-safe functions.
> >> It does not look like the handler that you are going to install
> >> later will take note of this caveat!
> >>
> >>> 		children_to_clean = p->next;
> >>> 		kill(p->pid, sig);
> >>> 		if (!in_signal)
> >>
> >> The condition that we see here in the context protects free(p)
> >> (which is not async-signal-safe). Perhaps the invocation of the new
> >> callback should be skipped in the same manner when this is called
> >> from a signal handler? 507d7804 (pager: don't use unsafe functions
> >> in signal handlers) may be worth a look.
> >
> > Thanks a lot of pointing this out to me!
> >
> > Do I get it right that after the signal "SIGTERM" I can do a cleanup
> > and don't need to worry about any function calls but if I get any
> > other signal then I can only perform async-signal-safe calls?
> 
> No. SIGTERM is not special.
> 
> Perhaps you were misled by the SIGTERM mentioned in cleanup_children_on_exit()? This function is invoked on regular exit (not from a signal). SIGTERM is used in this case to terminate children that are still lingering around.

Yes, that was my source of confusion. Thanks for the clarification!

> 
> > If this is correct, then the following solution would work great:
> >
> > 		if (!in_signal && p->clean_on_exit_handler)
> > 			p->clean_on_exit_handler(p->pid);
> 
> This should work nevertheless because in_signal is set when the function is invoked from a signal handler (of any signal that is caught) via cleanup_children_on_signal().

Right. Thank you!

- Lars