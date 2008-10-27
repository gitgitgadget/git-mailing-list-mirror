From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Add mksnpath and git_snpath which allow to specify the
	output buffer
Date: Mon, 27 Oct 2008 07:45:37 +0100
Message-ID: <20081027064537.GA4751@blimp.localdomain>
References: <20081026215913.GA18594@blimp.localdomain> <7v8wsak4mr.fsf@gitster.siamese.dyndns.org>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 27 07:46:56 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KuLsN-0008Ai-Os
	for gcvg-git-2@gmane.org; Mon, 27 Oct 2008 07:46:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751556AbYJ0Gpn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Oct 2008 02:45:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751591AbYJ0Gpm
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Oct 2008 02:45:42 -0400
Received: from mo-p05-ob.rzone.de ([81.169.146.182]:61861 "EHLO
	mo-p05-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751539AbYJ0Gpm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Oct 2008 02:45:42 -0400
X-RZG-CLASS-ID: mo05
X-RZG-AUTH: :Pm0FVUW6aauhRGJJc5OfA4AU8DM8ZlijdmJYxKn/UQvEQQx8AE81pE/a
Received: from tigra.home (Fab75.f.strato-dslnet.de [195.4.171.117])
	by post.webmailer.de (fruni mo13) (RZmta 17.14)
	with ESMTP id y001f0k9R6O1Ya ; Mon, 27 Oct 2008 07:45:38 +0100 (MET)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from blimp.localdomain (unknown [192.168.0.8])
	by tigra.home (Postfix) with ESMTP id CE21A277C8;
	Mon, 27 Oct 2008 07:45:37 +0100 (CET)
Received: by blimp.localdomain (Postfix, from userid 1000)
	id 6BF5536D27; Mon, 27 Oct 2008 07:45:37 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <7v8wsak4mr.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99209>

Junio C Hamano, Mon, Oct 27, 2008 06:07:24 +0100:
> Where is git_snpath() used?

Nowhere yet, but it should replace git_path in every call where the
result is not used immediately. Which, as the story with cygwin
porting shows, can be sometimes not quite trivial (who could suspect
lstat(2) will have application local side effects?).

Maybe I should resend the patches without it, following by patches
introducing git_snpath and replacing calls to git_path.

Maybe Linus should be sued for introducing the function in the first
place.
