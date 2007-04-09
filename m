From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH 4/5] merge-recursive: handle D/F conflict case more carefully.
Date: Mon, 9 Apr 2007 20:58:09 +0200
Message-ID: <20070409185809.GA13212@steel.home>
References: <7v6488ckk0.fsf@assigned-by-dhcp.cox.net>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Daniel Barkalow <barkalow@iabervon.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Apr 10 01:00:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Haz4C-00016w-DH
	for gcvg-git@gmane.org; Mon, 09 Apr 2007 20:58:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932255AbXDIS6N (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Apr 2007 14:58:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932224AbXDIS6M
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Apr 2007 14:58:12 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:25911 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932255AbXDIS6L (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Apr 2007 14:58:11 -0400
Received: from tigra.home (Fc9f2.f.strato-dslnet.de [195.4.201.242])
	by post.webmailer.de (klopstock mo57) (RZmta 5.5)
	with ESMTP id I0739dj39HW2m9 ; Mon, 9 Apr 2007 20:58:08 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 52AD4277B6;
	Mon,  9 Apr 2007 20:58:08 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 4BCC9D150; Mon,  9 Apr 2007 20:58:09 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7v6488ckk0.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaFzAcjYko=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44076>

Junio C Hamano, Sat, Apr 07, 2007 16:42:55 +0200:
> +			if (unlink(path)) {
> +				if (errno == EISDIR) {
> +					/* something else exists */
> +					error(msg, path, ": perhaps a D/F conflict?");

isn't this one an F/D conflict?
