From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Possible bug in Git
Date: Thu, 15 Apr 2010 17:01:37 -0700
Message-ID: <7vr5mggt9a.fsf@alter.siamese.dyndns.org>
References: <4BC6EECE.6060408@gestiweb.com>
 <k2u32541b131004151645i78733507rc50724548036ef36@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David =?utf-8?Q?Mart=C3=ADnez_Mart=C3=AD?= 
	<desarrollo@gestiweb.com>, git@vger.kernel.org,
	deavidsedice@gmail.com
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 16 02:01:58 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O2Z0P-0007OK-4V
	for gcvg-git-2@lo.gmane.org; Fri, 16 Apr 2010 02:01:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758155Ab0DPABv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Apr 2010 20:01:51 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:64898 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758114Ab0DPABu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Apr 2010 20:01:50 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 54CD4AB90C;
	Thu, 15 Apr 2010 20:01:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=FjjT00BIXfBm8aol1+nI9++CcCk=; b=QPCIPS
	TLOAz3HQ6NbCsdmY8Syk2dZUrK8q79NG92ufJb3n1Fm5VNPFzq1llzc4s+EPbMrk
	AgXDknXAq1wT6kfYNpcHOzSnLveFDpQ3D5NJno9hirJZ8ITFMaq+ePy/VkrkXBYd
	PAa97FRTioqOP1kXHtzfvZFUw6eoQTI9N4akY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=h7g4QFJK2Oj3XkTOmObxbb3Yze/OzYon
	U0m5PrpwUdy3XLgAXdkucoJwyT+etcgNu8Td/5CjzFrb/ugaLZTGvus06o9fHNMy
	kj6mtOnb0t3NUR0RLjBi3gatPBrKEhnvSnc8yw2WDm3+LfnKXDou0OUiAs0qaxQA
	wxrhNqUPL/o=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 10ACFAB90A;
	Thu, 15 Apr 2010 20:01:44 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 45D0AAB906; Thu, 15 Apr
 2010 20:01:39 -0400 (EDT)
In-Reply-To: <k2u32541b131004151645i78733507rc50724548036ef36@mail.gmail.com>
 (Avery Pennarun's message of "Thu\, 15 Apr 2010 19\:45\:59 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 3E13932E-48EB-11DF-A0DE-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145036>

Avery Pennarun <apenwarr@gmail.com> writes:

> So what git tries to do is reduce the diff output of a merge commit
> down to just the "unexpected" parts: the parts that are different from
> what you'd get if you just merged in the individual changes in the
> obvious way.

This (and everything you said after this paragraph) is not quite correct.
What is shown is the pieces that do not match either of the parent.

So if you have a conflicted merge and resolve it by taking what one side
did literally (think: "merge -X ours"), that hunk becomes uninteresting
because the end result matches what one of the parents had.
