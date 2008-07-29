From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: Re: [PATCH] Modify mingw_main() workaround to avoid link errors
Date: Tue, 29 Jul 2008 10:33:46 +0200
Message-ID: <1217320426.488ed5ea47384@webmail.nextra.at>
References: <1217065304-27815-1-git-send-email-prohaska@zib.de> <1217104655.488b8b0f5ca48@webmail.nextra.at> <4CCD1862-48FB-412B-80B6-E1B822BF3A87@zib.de> <1217186640.488ccb50a934a@webmail.nextra.at> <B6158330-640B-4CA3-8589-310FA8EA6CC9@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Tue Jul 29 10:34:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNkfT-0006sT-Ov
	for gcvg-git-2@gmane.org; Tue, 29 Jul 2008 10:34:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753135AbYG2Idv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jul 2008 04:33:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753194AbYG2Idv
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jul 2008 04:33:51 -0400
Received: from smtp5.srv.eunet.at ([193.154.160.227]:35436 "EHLO
	smtp5.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753089AbYG2Idu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jul 2008 04:33:50 -0400
Received: from webmail01.si.eunet.at (webmail01.srv.eunet.at [193.154.180.195])
	by smtp5.srv.eunet.at (Postfix) with ESMTPS id F2C0A13A37E;
	Tue, 29 Jul 2008 10:33:48 +0200 (CEST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by webmail01.si.eunet.at (8.13.1/8.13.1) with ESMTP id m6T8XkvW027583;
	Tue, 29 Jul 2008 10:33:46 +0200
Received: from 77.118.250.127 ([77.118.250.127]) 
	by webmail.nextra.at (IMP) with HTTP 
	for <johsixt@mbox.eunet.at>; Tue, 29 Jul 2008 10:33:46 +0200
In-Reply-To: <B6158330-640B-4CA3-8589-310FA8EA6CC9@zib.de>
User-Agent: Internet Messaging Program (IMP) 3.2.8
X-Originating-IP: 77.118.250.127
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90599>

Zitat von Steffen Prohaska <prohaska@zib.de>:

>
> On Jul 27, 2008, at 9:24 PM, Johannes Sixt wrote:
>
> > Zitat von Steffen Prohaska <prohaska@zib.de>:
> >
> >>
> >> On Jul 26, 2008, at 10:37 PM, Johannes Sixt wrote:
> >>
> >>> Zitat von Steffen Prohaska <prohaska@zib.de>:
> >>>> With MinGW's
> >>>>
> >>>>  gcc.exe (GCC) 3.4.5 (mingw special)
> >>>>  GNU ld version 2.17.50 20060824
> >>>>
> >>>> the old define caused link errors:
> >>>>
> >>>>  git.o: In function `main':
> >>>>  C:/msysgit/git/git.c:500: undefined reference to `mingw_main'
> >>>>  collect2: ld returned 1 exit status
> >>>>
> >>>> The modified define works.
> >>>
> >>> I have the same tools, but not this error. ???
> >>
> >> I cleaned my work tree and built several times but did not
> >> find out what exactly is causing the error.  So I came up
> >> with the modified define, which declares the static
> >> mingw_main in global scope.  I have no clue why I see the
> >> error that you don't have.
> >
> > Neither do I. But a strange line number you have there. In 01d9b2d
> > (from
> > mingw.git) I have 'exit(1)' in line 500 of git.c.
>
> I have the same in line 500.  I am still wondering what this could
> mean.  But I do not yet now :-(

Can you try 'make -k' and see whether you have a similar problem with the
non-builtins that have their own main()?

-- Hannes
