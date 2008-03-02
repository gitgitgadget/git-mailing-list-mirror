From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Make builtin-reset.c use parse_options.
Date: Sun, 2 Mar 2008 22:38:43 +0100
Message-ID: <20080302213843.GA13954@steel.home>
References: <47C98472.8000002@gmail.com> <20080302094031.GA2973@steel.home> <1b46aba20803020454v322f061bi4f34a737e9e2b7f3@mail.gmail.com> <20080302155541.GH2973@steel.home> <1b46aba20803021040ofec56b9q120a654a192eec09@mail.gmail.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Carlos Rica <jasampler@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 02 22:39:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVvu0-0002wA-1E
	for gcvg-git-2@gmane.org; Sun, 02 Mar 2008 22:39:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757168AbYCBVir (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Mar 2008 16:38:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757126AbYCBVir
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Mar 2008 16:38:47 -0500
Received: from mo-p07-ob.rzone.de ([81.169.146.188]:26018 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757092AbYCBViq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Mar 2008 16:38:46 -0500
X-RZG-CLASS-ID: mo07
X-RZG-AUTH: z4gQVF2k5XWuW3CculzzcFzzec4=
Received: from tigra.home (Fac78.f.strato-dslnet.de [195.4.172.120])
	by post.webmailer.de (mrclete mo2) (RZmta 16.8)
	with ESMTP id Z047bck22IiIbQ ; Sun, 2 Mar 2008 22:38:45 +0100 (MET)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id D16F2277BD;
	Sun,  2 Mar 2008 22:38:44 +0100 (CET)
Received: by steel.home (Postfix, from userid 1000)
	id 0442956D24; Sun,  2 Mar 2008 22:38:43 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1b46aba20803021040ofec56b9q120a654a192eec09@mail.gmail.com>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75846>

Carlos Rica, Sun, Mar 02, 2008 19:40:09 +0100:
> On Sun, Mar 2, 2008 at 4:55 PM, Alex Riesen <raa.lkml@gmail.com> wrote:
> >
> >  "static const struct option options[] = {"
> 
> The other files using parse_options have only "static", or nothing.

Well, they all miss something. Besides all nice things about static
syntax checking, the compiler (GCC) can optimize string constants to
use the same data (not that it is interesting in this particular
case).

> To make "options" static, then reset_type and quiet should be
> static too, otherwise it cannot compile (in my system).

Of course. Is it a problem for user-interface level code?

> I don't know benefits of making all of them "static".

It is initialized statically.

> Has this been discussed previously?

Yeah. Sometime around 1972.
