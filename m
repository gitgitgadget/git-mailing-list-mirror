From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [Administrivia] On ruby and contrib/
Date: Sat, 8 Jun 2013 09:17:40 +0700
Message-ID: <CACsJy8BMrxLZFGQfUN1YCG+qkAj-91aYkc54R5O4iqgXUNeQOw@mail.gmail.com>
References: <7vtxld30f2.fsf@alter.siamese.dyndns.org> <7va9n52zjc.fsf@alter.siamese.dyndns.org>
 <rmivc5rp9w2.fsf@fnord.ir.bbn.com> <alpine.DEB.1.00.1306061818191.28957@s15462909.onlinehome-server.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Greg Troxel <gdt@ir.bbn.com>, Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Thomas Rast <trast@inf.ethz.ch>,
	=?UTF-8?Q?Ren=C3=A9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Jun 08 04:18:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ul8jR-0003ZH-Jc
	for gcvg-git-2@plane.gmane.org; Sat, 08 Jun 2013 04:18:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751242Ab3FHCSN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Jun 2013 22:18:13 -0400
Received: from mail-la0-f49.google.com ([209.85.215.49]:41687 "EHLO
	mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751052Ab3FHCSM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jun 2013 22:18:12 -0400
Received: by mail-la0-f49.google.com with SMTP id ea20so730897lab.8
        for <git@vger.kernel.org>; Fri, 07 Jun 2013 19:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=1r+kwgScH1dxEqTYT4UtHPb+R5g7ThQy+TKeCIA3sq8=;
        b=fmTL+4kW5TxnRK/r4wJWIs8+1igRdaFw9E4BcMRjx5YADINRclaYxrg9Be4ttrm+qw
         Y53q1bLXeC2fBs5Ik+gdeNPHqt+IEFZonXvNbbhxb4c8r4MoY+ijJU0xh+LhgbuFf9sv
         pVsSeeLdfP7Pi1mG48B+9cX6xSv+6/E7dvX4pcgGF+s5duoewDSrqw/MFihTOwX8l3OK
         pb3cJEzR1lTMxkwRj9K6lN2GLAqZeQqhRLJFs4qziMzOwq03FR9Pk79SFRlehFvk4ZAl
         JbS0Vao6YBPh6KHuAIX2xridYr1b219mK4kxLzLMLGeHXqjE5XWqT6Vexc7GLOCOQFkx
         ANOg==
X-Received: by 10.112.156.5 with SMTP id wa5mr2320794lbb.63.1370657891162;
 Fri, 07 Jun 2013 19:18:11 -0700 (PDT)
Received: by 10.114.24.234 with HTTP; Fri, 7 Jun 2013 19:17:40 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.1306061818191.28957@s15462909.onlinehome-server.info>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226778>

On Thu, Jun 6, 2013 at 11:22 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi Greg,
>
> On Thu, 6 Jun 2013, Greg Troxel wrote:
>
>> As one of the people who helps maintain git packages in pkgsrc, my
>> initial reaction is negative to adding a ruby dependency.
>
> My initial reaction, too. It was hard enough to get Perl included with Git
> for Windows (because of that pesky Subversion dependency).
>
> As you can see from the commit history, I was the primary force behind
> trying to get everything "core" in Git away from requiring scripting
> languages (I think it is an awesome thing to provide APIs for as many
> languages as possible, but a not-so-cool thing to use more than one
> language in the core code). It does not seem that anybody picked up that
> task when I left, though.

Nobody seems to mention it yet. There's another reason behind the C
rewrite effort: fork is costly on Windows. The C rewrite allows us to
run with one process (most of the time). This applies for shell, perl
and even ruby scripts because libgit.a is never meant to be used
outside git.c context (unlike libgit2). In this regard, ruby is just
as bad as currently supported non-C languages.
--
Duy
