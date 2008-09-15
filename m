From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Optional shrinking of RCS keywords in git-p4
Date: Sun, 14 Sep 2008 23:17:19 -0700
Message-ID: <7v4p4iexw0.fsf@gitster.siamese.dyndns.org>
References: <1221458331-8804-1-git-send-email-dhruva@ymail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT SCM <git@vger.kernel.org>
To: Dhruva Krishnamurthy <dhruva@ymail.com>
X-From: git-owner@vger.kernel.org Mon Sep 15 08:20:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kf7Ru-0007o8-N4
	for gcvg-git-2@gmane.org; Mon, 15 Sep 2008 08:20:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751253AbYIOGRa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Sep 2008 02:17:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751187AbYIOGRa
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Sep 2008 02:17:30 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:50376 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750721AbYIOGR3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Sep 2008 02:17:29 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 754E961FF8;
	Mon, 15 Sep 2008 02:17:24 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id F0AC761FF6; Mon, 15 Sep 2008 02:17:21 -0400 (EDT)
In-Reply-To: <1221458331-8804-1-git-send-email-dhruva@ymail.com> (Dhruva
 Krishnamurthy's message of "Mon, 15 Sep 2008 11:28:51 +0530")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: F674888A-82ED-11DD-B2BB-D0CFFE4BC1C1-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95879>

Dhruva Krishnamurthy <dhruva@ymail.com> writes:

> Modifying RCS keywords prevents submitting to p4 from git due to missing hunks.

Hmm.  How are "missing hunks" caused?  Do you mean:

 - the substituted values from the expanded keywords are stripped out by
   default (with kwstrip=True) when you check out from p4;

 - when you submit your changes back, p4 side expects you to send the file
   with keywords just as it originally expanded;

and this causes the contents mismatch, leading p4 to reject your change?

The patch itself looks fine; I just wanted to make sure commit log
explains what was fixed.
