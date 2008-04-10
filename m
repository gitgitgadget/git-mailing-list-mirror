From: Sean Estabrooks <seanlkml@sympatico.ca>
Subject: Re: Creating a patch set with git-format-patch
Date: Thu, 10 Apr 2008 06:56:38 -0400
Message-ID: <BAYC1-PASMTP020D4804B5CBAC8A5BEBD5AEEC0@CEZ.ICE>
References: <d0383f90804100151s6ffde16al6035116c27c9cb3a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Ian Brown" <ianbrn@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 10 12:57:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JjuTL-0002y7-Vf
	for gcvg-git-2@gmane.org; Thu, 10 Apr 2008 12:57:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755028AbYDJK44 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Apr 2008 06:56:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755035AbYDJK44
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Apr 2008 06:56:56 -0400
Received: from bay0-omc2-s15.bay0.hotmail.com ([65.54.246.151]:38294 "EHLO
	bay0-omc2-s15.bay0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755019AbYDJK4z (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Apr 2008 06:56:55 -0400
Received: from BAYC1-PASMTP02 ([65.54.191.162]) by bay0-omc2-s15.bay0.hotmail.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 10 Apr 2008 03:56:53 -0700
X-Originating-IP: [70.54.4.86]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([70.54.4.86]) by BAYC1-PASMTP02.CEZ.ICE over TLS secured channel with Microsoft SMTPSVC(6.0.3790.2668);
	 Thu, 10 Apr 2008 03:56:53 -0700
Received: from bud.attic.local ([10.10.10.20])
	by linux1.attic.local with esmtp (Exim 4.43)
	id 1JjvOP-00040I-KE; Thu, 10 Apr 2008 07:56:37 -0400
In-Reply-To: <d0383f90804100151s6ffde16al6035116c27c9cb3a@mail.gmail.com>
X-Mailer: Sylpheed 2.4.5 (GTK+ 2.12.8; x86_64-pc-linux-gnu)
X-OriginalArrivalTime: 10 Apr 2008 10:56:53.0290 (UTC) FILETIME=[95EC88A0:01C89AF9]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79206>

On Thu, 10 Apr 2008 11:51:59 +0300
"Ian Brown" <ianbrn@gmail.com> wrote:

Hi Ian,

> I intend to  make a change in two files: net/ipv4/route.c and
> include/net/dst.h and send a patch set of two patches for review.
> Now I want to create this  patch set of two pathces correctly;
> First patch for net/ipv4/route.c and second for include/net/dst.h.
> 
> what should I do ?

The first step is to edit route.c and commit your change to Git with a complete
description[1].  Then edit the dst.h file and commit that to Git as a separate
change.  Afterward you can use git format-patch to prepare these commits to
be emailed:

$  git format-patch HEAD^^

This tells Git to create a	 text file in the current directory for each commit made
since the reference you pass.   You can then configure git send-email[2] to send
these text files out, or send them manually with your regular email client.  If you
do send them manually, make sure to include the text file inline in your email,
don't send it as an attachment.  You will find a subject line inside the file you can
cut-and-paste into place, and  a few other headers that you'll need to delete.

HTH,
Sean

[1]  Remember that each commit log entry should be made as a one-line overview,
followed by a blank line, followed by as much prose as it takes to fully explain the
change.

[2]  There is a small section about configuring git-send-email for use with gmail
using msmtp here:  http://git.or.cz/gitwiki/GitTips
