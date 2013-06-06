From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [Administrivia] On ruby and contrib/
Date: Fri, 7 Jun 2013 02:10:58 +0530
Message-ID: <CALkWK0n2VsEP31jMB2kZ4x=wa90o8QPkR=ZWETfm=H5RC1kKcg@mail.gmail.com>
References: <7vtxld30f2.fsf@alter.siamese.dyndns.org> <7va9n52zjc.fsf@alter.siamese.dyndns.org>
 <rmivc5rp9w2.fsf@fnord.ir.bbn.com> <alpine.DEB.1.00.1306061818191.28957@s15462909.onlinehome-server.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Greg Troxel <gdt@ir.bbn.com>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Thomas Rast <trast@inf.ethz.ch>,
	=?UTF-8?Q?Ren=C3=A9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	=?UTF-8?B?Tmd1ecKtbiBUaMOhaSBOZ8O3YyBEdXk=?= <pclouds@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jun 06 22:41:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ukh0E-0007AS-6N
	for gcvg-git-2@plane.gmane.org; Thu, 06 Jun 2013 22:41:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753197Ab3FFUll (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Jun 2013 16:41:41 -0400
Received: from mail-ie0-f175.google.com ([209.85.223.175]:34596 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752996Ab3FFUlk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Jun 2013 16:41:40 -0400
Received: by mail-ie0-f175.google.com with SMTP id a11so8363439iee.20
        for <git@vger.kernel.org>; Thu, 06 Jun 2013 13:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=LUPhyuO+hYa2oM9GEFfqIQqjB4JsiCRZxQ7PdSMV0PE=;
        b=g6vfSt6onwRxZJx5AKb3bZBjUGmPHaFdX5ow45zAe9tRTQLLohrBCf8DgLujDuMOgU
         Kc0BPTHBHfSmrYaPXR77OpUWn91j5jfgAQd3LR34Ytnmmu9TK1meWhL/iCJPUf9hUwUD
         F5/edAZvt5LkIoWsquF2mUigwURdrjfO1dE9nBXdSBH33K0PKTktjWcKCYjAL5PZV9Ig
         xf39mzmt2xdJtlOOZCCzPSz4WfqX3WiRytAY9bRa4htFoNJ3rkW5QB19ZeFb8gsNdydN
         Y8EiS4s69I2LNCybxgLCR6A3iX6stH/rwawt1m957wBKa+XyxoHhN/y8U0CohSrK1sW6
         Dsiw==
X-Received: by 10.50.107.6 with SMTP id gy6mr6443234igb.57.1370551300470; Thu,
 06 Jun 2013 13:41:40 -0700 (PDT)
Received: by 10.64.136.104 with HTTP; Thu, 6 Jun 2013 13:40:58 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.1306061818191.28957@s15462909.onlinehome-server.info>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226557>

Johannes Schindelin wrote:
> My initial reaction, too. It was hard enough to get Perl included with Git
> for Windows (because of that pesky Subversion dependency).

Nevertheless, we had to do it, and we did it.  We will do it again, if
we get enough important code written in Ruby.

> As you can see from the commit history, I was the primary force behind
> trying to get everything "core" in Git away from requiring scripting
> languages (I think it is an awesome thing to provide APIs for as many
> languages as possible, but a not-so-cool thing to use more than one
> language in the core code). It does not seem that anybody picked up that
> task when I left, though.

Rewriting everything in C?  Is anyone bored enough to pick up this
task?  Bourne shell is a great language for prototyping; git-rebase.sh
(and friends), git-stash.sh, git-pull.sh are doing just fine.  Sure,
it makes sense to do heavy-lifting in C, and this is happening as it
has always been happening (remember git-commit.sh?).  If you followed
the list emails, you'd know that Felipe is looking into delegating
large portions of the work done by git-rebase.sh to sequencer.c.

Anyway, all this talk about some hypothetical ideas just bores me.
What matters is what is currently happening.  And nobody is actively
rewriting the "core in Git" in C, so I don't see the point of
discussing anything but patches.
