From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] blame.c: Properly initialize strbuf after calling,
 textconv_object()
Date: Fri, 28 Oct 2011 09:00:36 -0700
Message-ID: <7vlis5t8bf.fsf@alter.siamese.dyndns.org>
References: <4EAACA1C.6020302@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, msysgit@googlegroups.com
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 28 18:00:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RJorM-0004gc-QC
	for gcvg-git-2@lo.gmane.org; Fri, 28 Oct 2011 18:00:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932212Ab1J1QAk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Oct 2011 12:00:40 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36625 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751313Ab1J1QAj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Oct 2011 12:00:39 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C4C0A5E23;
	Fri, 28 Oct 2011 12:00:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=aBA4h4AsR4/UciCtoNIx0JYTRww=; b=TRPlgB
	9uYcIY7j0XJpCKkFYj2he4NTsdW5j5Lw7ECtwVXYoqHNhFMXJcv2gaKO/Nv5KqoF
	oRwcthGjl0f/35x5kUpsyZtl576nsHbinNx2+D8bzGKF0CJBO+2ltmm9fko2Rgv2
	UIEoXoTvmnH47wtQydyl2CimdNl7j/jh6MPZs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ObIAg6aulQSUc9k5L53OSyq5ckNKDwsJ
	ZCxTwZBXfl0JmO0v+1POU21mUqWaxJRFlcDAtqZ93kIwU42gamC4o6xfHy670S6X
	VGG39rBSRLreHgSaIX7uLdst3ebmHTtMnG9DTCzHySXMJ9I/5IXlWlWympLJjHsN
	SL+7DWkryD0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BC1DC5E22;
	Fri, 28 Oct 2011 12:00:38 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4F8755E1F; Fri, 28 Oct 2011
 12:00:38 -0400 (EDT)
In-Reply-To: <4EAACA1C.6020302@gmail.com> (Sebastian Schuberth's message of
 "Fri, 28 Oct 2011 17:28:28 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FA84B1AE-017D-11E1-A4C9-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184415>

Thanks; do you have no addition to the test suite to demonstrate the
breakage?
