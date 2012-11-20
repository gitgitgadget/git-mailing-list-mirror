From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] config --get-all: it is an error not to see any value
Date: Mon, 19 Nov 2012 16:24:03 -0800
Message-ID: <7v7gphunoc.fsf_-_@alter.siamese.dyndns.org>
References: <50AABA9B.6090007@freescale.com>
 <7vd2z9uobn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Timur Tabi <timur@freescale.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 20 01:24:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TabdX-0001ij-3i
	for gcvg-git-2@plane.gmane.org; Tue, 20 Nov 2012 01:24:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753775Ab2KTAYI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Nov 2012 19:24:08 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43043 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753631Ab2KTAYG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Nov 2012 19:24:06 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B62CE77F4;
	Mon, 19 Nov 2012 19:24:05 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/g8W6kxeBBY2sxXLqlqcN8BbiyY=; b=HzCIA4
	z/pk+dFAnBNU+zdCH/soC3mJIrWf6rCyfjZU+eUUBU+kLnp7yc6g8eE46mAi6hN2
	tKuZvwNZtqHVTLBNO+5Hu5cVMZcpy+YFguvZiXcnDl7E+UnumoCEGRAcK0Z5MH0r
	Q3+mzF8BZkq4ydg/5ROWZd2YB+2vU7W0InJ38=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gmLTe+iXCqki7On2EKt717/e3YsvAKMC
	QVHwlspO6SMwnNjevOwI/FgbdPFStIG2CzIExU6D/gOILHN+eyYHW3jydt24GXhM
	IiuonUk7SD+t3MfGsClcCld/9o4KKEEHeNyZHw6kU2no7xnPFe26dFFwm0LrI2Hw
	AZ4GTWOTo0c=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9E27277F3;
	Mon, 19 Nov 2012 19:24:05 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C456977F0; Mon, 19 Nov 2012
 19:24:04 -0500 (EST)
In-Reply-To: <7vd2z9uobn.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon, 19 Nov 2012 16:10:04 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 97421548-32A8-11E2-AB31-C2612E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210069>

The wording "... is not exactly one." incorrectly hinted as if
having no value is not an error, but that was not what was
intended.  Clarify what similarity it wants to mention by
elaborating the "Like get" part of the description.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-config.txt | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git i/Documentation/git-config.txt w/Documentation/git-config.txt
index eaea079..273239d 100644
--- i/Documentation/git-config.txt
+++ w/Documentation/git-config.txt
@@ -85,8 +85,9 @@ OPTIONS
 	found and error code 2 if multiple key values were found.
 
 --get-all::
-	Like get, but does not fail if the number of values for the key
-	is not exactly one.
+	Like `--get`, shows the value(s) given to the key, and signals an
+	error if there is no such key.  Unlike `--get`, does not
+	fail if there are multiple values defined for the key.
 
 --get-regexp::
 	Like --get-all, but interprets the name as a regular expression and
