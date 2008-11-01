From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] connect.c: add a way for git-daemon to pass an error
	back to client
Date: Sat, 1 Nov 2008 15:39:54 +0100
Message-ID: <20081101143954.GB7157@steel.home>
References: <b97024a40810311859t2e5a6102u31ad4480e7c75c03@mail.gmail.com> <alpine.DEB.1.00.0811010316340.22125@pacific.mpi-cbg.de.mpi-cbg.de> <alpine.LFD.2.00.0810312218300.13034@xanadu.home> <alpine.DEB.1.00.0811010334010.22125@pacific.mpi-cbg.de.mpi-cbg.de> <b97024a40810312035v5416b578v51b5bed528ca8d39@mail.gmail.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Nicolas Pitre <nico@cam.org>, git@vger.kernel.org,
	gitster@pobox.com
To: Tom Preston-Werner <tom@github.com>
X-From: git-owner@vger.kernel.org Sat Nov 01 15:41:38 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KwHfQ-0005lJ-FX
	for gcvg-git-2@gmane.org; Sat, 01 Nov 2008 15:41:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751530AbYKAOkF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Nov 2008 10:40:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751479AbYKAOkF
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Nov 2008 10:40:05 -0400
Received: from mo-p05-ob.rzone.de ([81.169.146.180]:41918 "EHLO
	mo-p05-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751493AbYKAOkE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Nov 2008 10:40:04 -0400
X-RZG-CLASS-ID: mo05
X-RZG-AUTH: :Pm0FVUW6aauhRGJJc5OfA4AU8DM8ZlijdmJYxKn/UQvEQQx9CE82pYs=
Received: from tigra.home (Fa914.f.strato-dslnet.de [195.4.169.20])
	by post.webmailer.de (fruni mo44) (RZmta 17.14)
	with ESMTP id j00268kA1ECtmP ; Sat, 1 Nov 2008 15:39:59 +0100 (MET)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id B6340277C8;
	Sat,  1 Nov 2008 16:39:58 +0100 (CET)
Received: by steel.home (Postfix, from userid 1000)
	id 85D5356D27; Sat,  1 Nov 2008 15:39:56 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <b97024a40810312035v5416b578v51b5bed528ca8d39@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99745>

Tom Preston-Werner, Sat, Nov 01, 2008 04:35:20 +0100:
> Maybe this is worth asking the question: does anybody use git-daemon
> for private code? If so, why are they not using SSH instead? And in
> that case, how are informative error messages a security risk?

Yes. I use both in my private network, with only ssh open to the
internet. git-daemon is smaller and faster (started from inetd). And
I'm absolutely sure wont ever accidentally push something in the
mirrored repos.

I never had the error reporting problem in this setup, though. It is a
fully controled environment and I can just look in syslog.

I support the original reason for not doing the errors, BTW. It cannot
be on by default.

Heh, try the patch for your private repos and private repos of your
employer, who can sack you for exposing confidential information, and
open them to internet. Than come back and tell us how safe you feel :)
