From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add mksnpath and git_snpath which allow to specify the
 output buffer
Date: Mon, 27 Oct 2008 20:35:04 -0700
Message-ID: <7vd4hlgzo7.fsf@gitster.siamese.dyndns.org>
References: <20081026215913.GA18594@blimp.localdomain>
 <7v8wsak4mr.fsf@gitster.siamese.dyndns.org>
 <20081027064537.GA4751@blimp.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 28 04:36:36 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KufNg-0006T7-Nv
	for gcvg-git-2@gmane.org; Tue, 28 Oct 2008 04:36:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751865AbYJ1DfT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Oct 2008 23:35:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752147AbYJ1DfT
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Oct 2008 23:35:19 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:35938 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751673AbYJ1DfR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Oct 2008 23:35:17 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id E7C637407D;
	Mon, 27 Oct 2008 23:35:16 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id C2A3674077; Mon, 27 Oct 2008 23:35:11 -0400 (EDT)
In-Reply-To: <20081027064537.GA4751@blimp.localdomain> (Alex Riesen's message
 of "Mon, 27 Oct 2008 07:45:37 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 702866C2-A4A1-11DD-AC3E-9CEDC82D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99274>

Alex Riesen <raa.lkml@gmail.com> writes:

> Junio C Hamano, Mon, Oct 27, 2008 06:07:24 +0100:
>> Where is git_snpath() used?
>
> Nowhere yet, but it should replace git_path in every call where the
> result is not used immediately. Which, as the story with cygwin
> porting shows, can be sometimes not quite trivial (who could suspect
> lstat(2) will have application local side effects?).
>
> Maybe I should resend the patches without it, following by patches
> introducing git_snpath and replacing calls to git_path.

I took the liberty of doing the first half of just that ;-)

I also think this series of fix is maint-worthy, and splitted the last one
into two so that maint and master can be fixed independently.
