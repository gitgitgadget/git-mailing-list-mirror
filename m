From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC v1 5/6] combine-diff.c: remove a call to fstat()
 inside show_patch_diff()
Date: Wed, 28 Jan 2009 17:16:30 -0800
Message-ID: <7vab9akj2p.fsf@gitster.siamese.dyndns.org>
References: <1233004637-15112-1-git-send-email-barvik@broadpark.no>
 <1233004637-15112-6-git-send-email-barvik@broadpark.no>
 <7v63jznp58.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Kjetil Barvik <barvik@broadpark.no>
X-From: git-owner@vger.kernel.org Thu Jan 29 02:18:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSLXh-0003t9-LI
	for gcvg-git-2@gmane.org; Thu, 29 Jan 2009 02:18:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752883AbZA2BQj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jan 2009 20:16:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751870AbZA2BQi
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Jan 2009 20:16:38 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:33829 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752335AbZA2BQi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jan 2009 20:16:38 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id A49301D838;
	Wed, 28 Jan 2009 20:16:36 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 082B11D830; Wed,
 28 Jan 2009 20:16:31 -0500 (EST)
In-Reply-To: <7v63jznp58.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed, 28 Jan 2009 12:37:07 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 794DD7EC-EDA2-11DD-91C2-0372113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107604>

Junio C Hamano <gitster@pobox.com> writes:

> Kjetil Barvik <barvik@broadpark.no> writes:
>
>> Currently inside show_patch_diff() we have and fstat() call after an
>> ok lstat() call.  Since we before the call to fstat() have already
>> test for the link case with S_ISLNK() the fstat() can be removed.
>
> Good eyes.  Thanks.

Heh, I noticed you will update the commit log message, so I'll dequeue
this and wait for an update.
