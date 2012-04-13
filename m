From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] tests: add initial bash completion tests
Date: Fri, 13 Apr 2012 12:45:57 -0700
Message-ID: <7vaa2f2z62.fsf@alter.siamese.dyndns.org>
References: <1334181423-4391-1-git-send-email-felipe.contreras@gmail.com>
 <CAMP44s2Ug91_sQ-XR3ck2k+x+eQRt9PNRRBOUnkrnNRhY6fEpw@mail.gmail.com>
 <7vmx6g6e2i.fsf@alter.siamese.dyndns.org>
 <CAMP44s37znvnw+n3NsFj+ZVuxwPhrordJA0ko0LV9udPS+i3aQ@mail.gmail.com>
 <7vzkag3528.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>,
	Thomas Rast <trast@student.ethz.ch>, Jeff King <peff@peff.net>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 13 21:46:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SImRe-0003HY-04
	for gcvg-git-2@plane.gmane.org; Fri, 13 Apr 2012 21:46:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756035Ab2DMTqB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Apr 2012 15:46:01 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58008 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755277Ab2DMTqA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Apr 2012 15:46:00 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AE45D7F0B;
	Fri, 13 Apr 2012 15:45:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=c50AztGAiPlyQBCYgKZssrxvedk=; b=t7tbT0
	4oJSM+1UnqZW7UTj03+RFghbOF13vI5ZwK4+BDHRWZAXSgGeKpw3VrIIvlP2W3ru
	7oCe/ZaCE31rRcYadPmSRLY1l1O4vNiPpFAroEkHZZZyWwhDkV5cQeePz/5jAGcX
	rATSEjeW2ZTh+gjRI8NVWTJWR+F20zZefO3GM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=U7+mpJKxDOVgmo3aov+bq4M94+sW0PkW
	eON3wpw7Y+vqj4330P7F5zXAEre8ZLbkGw+CQoatU79T2B11eX5YxSHNGMy4u8dC
	xcTpzAis80luu7AGolzPo1Jih4tAQFMwcdeC6+OgNWDrC6e6SNzsSYc6YLVkHDhH
	w+VCFuIkTJ0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A4EF37F08;
	Fri, 13 Apr 2012 15:45:59 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2E79B7F00; Fri, 13 Apr 2012
 15:45:59 -0400 (EDT)
In-Reply-To: <7vzkag3528.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu, 12 Apr 2012 16:26:23 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4AFB1F4A-85A1-11E1-AE29-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195439>

Junio C Hamano <gitster@pobox.com> writes:

> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> Do I need to resend the patch?
>
> Not necessarily.  If you can eyeball what is queued on 'pu' and gave me an
> Ack (or send a replacement with "You stupid, you amended it wrong!") that
> should be sufficient.

Actually, can we have a follow-up patch to add in-code comment before the
_get_comp_words_by_ref shell function in t9902 to explain why the test
overrides this implementation detail?  The script being tested will need
to maintain _some_ invariants that is expected by this hack in order to
keep the test working (or this hack needs to be updated when the updates
to the completion script need to break the invariants), but without any
explanation on what the invariants are, it is making it hard to others to
update the completion script.

Thanks.
