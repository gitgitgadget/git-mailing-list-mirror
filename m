From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Teach git log --check to return an appropriate error code
Date: Sat, 09 Aug 2008 11:58:50 -0700
Message-ID: <7vljz66mmt.fsf@gitster.siamese.dyndns.org>
References: <alpine.DEB.1.00.0808081315060.9611@pacific.mpi-cbg.de.mpi-cbg.de>
 <1218265054-19220-1-git-send-email-4ux6as402@sneakemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Peter Valdemar =?utf-8?Q?M=C3=B8rch?= <4ux6as402@sneakemail.com>
X-From: git-owner@vger.kernel.org Sat Aug 09 21:00:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KRtfW-00021y-Dk
	for gcvg-git-2@gmane.org; Sat, 09 Aug 2008 21:00:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751921AbYHIS66 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 9 Aug 2008 14:58:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751814AbYHIS66
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Aug 2008 14:58:58 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:46821 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751290AbYHIS66 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 9 Aug 2008 14:58:58 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 38B66523A7;
	Sat,  9 Aug 2008 14:58:57 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 95681523A6; Sat,  9 Aug 2008 14:58:54 -0400 (EDT)
In-Reply-To: <1218265054-19220-1-git-send-email-4ux6as402@sneakemail.com>
 (Peter Valdemar =?utf-8?Q?M=C3=B8rch's?= message of "Sat, 9 Aug 2008 08:57:34
 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 382CC442-6645-11DD-890D-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91774>

Peter Valdemar M=C3=B8rch  <4ux6as402@sneakemail.com> writes:

> 	The return value is a bitfield, with |=3D 1 if HAS_CHANGES
> 	(clearly log has changes "always" - except e.g. "git log
> 	HEAD..HEAD")...

Is it clear?  "git log HEAD~20..HEAD -- path" where path never changes
within the range would be !HAS_CHANGES, wouldn't it?

Perhaps "git log --exit-code --raw A..B -- path" should give the same e=
xit
status as '! test -z "$(git rev-list A..B -- path)"'?
