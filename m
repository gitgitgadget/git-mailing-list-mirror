From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 2/3] sequencer: add "--reset-hard" option to "git
 sequencer--helper"
Date: Tue, 4 Aug 2009 11:34:15 -0400 (EDT)
Message-ID: <alpine.LNX.2.00.0908041111550.2147@iabervon.org>
References: <20090803024023.3794.44226.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Jakub Narebski <jnareb@gmail.com>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Tue Aug 04 17:36:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYM3N-0003p4-8P
	for gcvg-git-2@gmane.org; Tue, 04 Aug 2009 17:35:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932948AbZHDPeU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Aug 2009 11:34:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932945AbZHDPeR
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Aug 2009 11:34:17 -0400
Received: from iabervon.org ([66.92.72.58]:47380 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932934AbZHDPeQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Aug 2009 11:34:16 -0400
Received: (qmail 2831 invoked by uid 1000); 4 Aug 2009 15:34:15 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 4 Aug 2009 15:34:15 -0000
In-Reply-To: <20090803024023.3794.44226.chriscool@tuxfamily.org>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124792>

On Mon, 3 Aug 2009, Christian Couder wrote:

> This new option uses the "reset_almost_hard()" function to perform
> a reset.

Shouldn't it make it possible to do an almost-hard reset (that is, keep a 
dirty working tree's changes while changing the index and HEAD to a 
different commit)? AFAICT, this series doesn't expose the interesting new
functionality it provides.

Also, I thought that we'd found that other built-ins could be simplified 
through the use of functions you're adding here. In particular, checkout 
wants to change the index and working tree while preserving dirty working 
tree changes. So it would probably be better for it to go in a library 
object, where sequencer--helper would just make it available to shell 
code.
	-Daniel
*This .sig left intentionally blank*
