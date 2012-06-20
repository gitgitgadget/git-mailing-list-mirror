From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] submodule add + autocrlf + safecrlf
Date: Wed, 20 Jun 2012 12:24:04 -0700
Message-ID: <7vehp9vlbf.fsf@alter.siamese.dyndns.org>
References: <cover.1340202515.git.brad.king@kitware.com>
 <7vipelx49g.fsf@alter.siamese.dyndns.org> <4FE211C8.3080007@kitware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Brad King <brad.king@kitware.com>
X-From: git-owner@vger.kernel.org Wed Jun 20 21:24:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ShQVi-0003zt-60
	for gcvg-git-2@plane.gmane.org; Wed, 20 Jun 2012 21:24:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757515Ab2FTTYI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jun 2012 15:24:08 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57922 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752292Ab2FTTYH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jun 2012 15:24:07 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CC2C99887;
	Wed, 20 Jun 2012 15:24:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HparyHyjP+vhCbkEvuWVrmNtWGg=; b=xI09v7
	HZBR8f9ac4iFydnwgzxIIrPf5Wrtu3oLLz7VNJCc669CeeZzLoRf6m6Wtm1YDhV/
	GzymdflQlV9ANV9bN1A2Nk/4Rb2CTQhDbxuosc1l7aLHKFAn3Z6pld57MIAJBnsB
	xEc5qsOcyfrfkw1wYqsQ2zw/IQgW+2Rmhp+Lc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vEFS5qJR/X/9X/cs3Q3zwkPlh1cvsg/h
	gErtewSj1AHQ5QUVZBNf0gfSSagA7StwhFiPmRhZN00/iRoIOo7ck7H379l1aNT+
	KbG/TAc4B2ZtrrKii7M0bjM+9s8AKGRzyG47eASqPo92CWU/bAkZncxfTXgR2/kt
	wXM/vp8JJFc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 751D59885;
	Wed, 20 Jun 2012 15:24:06 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B01819884; Wed, 20 Jun 2012
 15:24:05 -0400 (EDT)
In-Reply-To: <4FE211C8.3080007@kitware.com> (Brad King's message of "Wed, 20
 Jun 2012 14:09:12 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 80316358-BB0D-11E1-AB3E-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200334>

Brad King <brad.king@kitware.com> writes:

> On 06/20/2012 01:49 PM, Junio C Hamano wrote:
>> I have a suspicion that "git config" should be taught about this
>> kind of thing instead.
>> 
>> Shoudn't your .git/config file that is outside the revision control
>> also end with CRLF if your platform and project prefer CRLF over LF?
>
> That would be reasonable, but is beyond the scope I'm willing to
> tackle myself.
>
> I don't actually have a project like this so I have no strong
> opinion on this issue.

If that is the case, my preference would be to wait until that "git
config" change happens (provided that it is a reasonably way
forward---it may turn out to be a bad idea) and do nothing to
clutter "git submodule" at all.  In the meantime, if there are real
projects that are hurt by this, we can tell them to explicitly
specify that .gitmodules is a LF text file in their .gitattributes.
