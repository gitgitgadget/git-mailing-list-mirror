From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Python scripts audited for minimum compatible version
 and checks added.
Date: Thu, 20 Dec 2012 19:38:42 -0800
Message-ID: <7vk3sc2hx9.fsf@alter.siamese.dyndns.org>
References: <20121220141855.05DAA44105@snark.thyrsus.com>
 <20121220144813.GA27211@sigill.intra.peff.net>
 <20121220150252.GA24387@thyrsus.com>
 <7vsj7060nj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: esr@thyrsus.com
X-From: git-owner@vger.kernel.org Fri Dec 21 04:39:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TltSK-0004o9-EK
	for gcvg-git-2@plane.gmane.org; Fri, 21 Dec 2012 04:39:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751706Ab2LUDir (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Dec 2012 22:38:47 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60888 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750875Ab2LUDiq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Dec 2012 22:38:46 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 28C4EAF1B;
	Thu, 20 Dec 2012 22:38:45 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qhX38AELTpLu3IDNx/o5aIbmp6M=; b=OurTwm
	3o3CT1BtVQRqBfJvu3tZ8bafDqqyvlktaXbw3E7TLeca/uWlCiy77NLpIdO6W0mj
	2B2yKbOs/6P1LD4RVXmsiHOT9smr+Q2MrffSVlkrqx69JWjydvn1Cygh9cNxlFLj
	FxGPbfCQ8milDO2cLo0JklxtTeqU2Vz2lQfeQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=J8pkjkF+hGb/2LR3Fol7l2tiF6sel9mH
	iDio3HDfvU4mgNYxVZOXsBDZUIDsQKT6IRh6DFzKSX1vD161cXm3Zs9Ya+3aJzeQ
	Q/uDOXfaB+Sx38HWCpAmFBcNoabm/RQPxToZ5CczdsCskCeiUcF7ZhF72vvnBBVv
	mmWUlrzb73E=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 15BC8AF1A;
	Thu, 20 Dec 2012 22:38:45 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 87CFAAF19; Thu, 20 Dec 2012
 22:38:44 -0500 (EST)
In-Reply-To: <7vsj7060nj.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu, 20 Dec 2012 10:25:52 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EBBCF46E-4B1F-11E2-8044-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211951>

I needed something like this on top of it to get it pass t5800.

diff --git a/git_remote_helpers/git/__init__.py b/git_remote_helpers/git/__init__.py
index 776e891..5047fd4 100644
--- a/git_remote_helpers/git/__init__.py
+++ b/git_remote_helpers/git/__init__.py
@@ -1,3 +1,5 @@
+import sys
+
 if sys.hexversion < 0x02040000:
     # The limiter is the subprocess module
     sys.stderr.write("git_remote_helpers: requires Python 2.4 or later.")
-- 
1.8.1.rc2.225.g0e05fff
