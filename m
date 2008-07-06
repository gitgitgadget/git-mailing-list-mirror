From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-mailinfo may corrupt patch headers on attached files
Date: Sun, 06 Jul 2008 15:13:20 -0700
Message-ID: <7vfxqmd5kv.fsf@gitster.siamese.dyndns.org>
References: <alpine.LFD.1.10.0807061036500.3016@woody.linux-foundation.org>
 <1215379261-10802-1-git-send-email-dzickus@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, torvalds@linux-foundation.org
To: Don Zickus <dzickus@redhat.com>
X-From: git-owner@vger.kernel.org Mon Jul 07 00:14:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KFcV2-0008Pp-H4
	for gcvg-git-2@gmane.org; Mon, 07 Jul 2008 00:14:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755598AbYGFWNa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jul 2008 18:13:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755889AbYGFWNa
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Jul 2008 18:13:30 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:60574 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755107AbYGFWNa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jul 2008 18:13:30 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id AABB120F04;
	Sun,  6 Jul 2008 18:13:27 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id E89D820F03; Sun,  6 Jul 2008 18:13:21 -0400 (EDT)
In-Reply-To: <1215379261-10802-1-git-send-email-dzickus@redhat.com> (Don
 Zickus's message of "Sun, 6 Jul 2008 17:21:01 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: C2447588-4BA8-11DD-8027-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87560>

Don Zickus <dzickus@redhat.com> writes:

> Boundary lines in emails are treated as a special case.  As a result of
> processing the boundary line a new line will be read into the buffer.
>
> The string length variable 'len' is evaluated before the boundary case, thus
> there is the possibility the length of the string does not match the new
> line read in (in the boundary line case).  This causes a partial output of
> the line to the patch file.
>
> The fix is trivial, evaluate the length of the string right before
> processing it.

Ah, I was about to bisect this to see where it needs to be fixed and if it
needs to be fixed in maint (or maint-1.5.5 and earlier).  Thanks for doing
this before I got around to it.
