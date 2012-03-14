From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] http: try standard proxy env vars when http.proxy
 config option is not set
Date: Wed, 14 Mar 2012 13:41:30 -0700
Message-ID: <7v1uouq5j9.fsf@alter.siamese.dyndns.org>
References: <4F4CCE8A.4010800@seap.minhap.es>
 <m3pqcjt6s2.fsf@carbon.jhcloos.org> <7v4ntvx87v.fsf@alter.siamese.dyndns.org>
 <4F5F1FEA.8020103@seap.minhap.es> <7vhaxrsssm.fsf@alter.siamese.dyndns.org>
 <4F606AE9.70608@seap.minhap.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: James Cloos <cloos@jhcloos.com>, git@vger.kernel.org,
	peff@peff.net, sam.vilain@catalyst.net.nz, sam@vilain.net
To: Nelson Benitez Leon <nelsonjesus.benitez@seap.minhap.es>
X-From: git-owner@vger.kernel.org Wed Mar 14 21:41:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7v0s-0007v5-H1
	for gcvg-git-2@plane.gmane.org; Wed, 14 Mar 2012 21:41:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759677Ab2CNUld (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Mar 2012 16:41:33 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63539 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758619Ab2CNUlc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Mar 2012 16:41:32 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 47F6F7D03;
	Wed, 14 Mar 2012 16:41:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=luWrysiivo9JhNgr7V92kanLbt8=; b=fv52gV
	DiBEkDJNXQ7ecSb6huktJU57aMwCpPPaxjZAxIpwlJnFNoblMrCndroZcjG61AwR
	ezku+ufuYhaQfheISC2LVr2B1f9K63yRnZLVWaaxN5Umrao7G25mweCpWg/+jywH
	yBcccCMDqsSeSWyUmtEM47tJFMCp1i+SL/RjM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uUUAO1RI31pbec67xIl5WDxY58PWZC0e
	E2a8qPRykQEI8QpbjG67agI4s+1fDRuUl2y8sIAg+8WQ8qH5MsetZxvw5+iDnsCt
	XfAmGkV5E0F5HYHJlsv2lDDuQ5VuR+rLw6eWl52u2QVPgZeVMxh8a2APcwve423W
	+uXDf9uTAMA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3FB8C7D02;
	Wed, 14 Mar 2012 16:41:32 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CA0627D00; Wed, 14 Mar 2012
 16:41:31 -0400 (EDT)
In-Reply-To: <4F606AE9.70608@seap.minhap.es> (Nelson Benitez Leon's message
 of "Wed, 14 Mar 2012 10:54:49 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 14FED0DC-6E16-11E1-8784-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193160>

Nelson Benitez Leon <nelsonjesus.benitez@seap.minhap.es> writes:

> On 03/14/2012 05:36 AM, Junio C Hamano wrote:
>
>> Are you sure $no_proxy is spelled in lowercase?  man curl(1) seems to
>> indicate otherwise.
>
> Instead here[1] in section "Environment Variables" it's spelled lowercase,
> and given that cURL reads $http_proxy only in lowercase I think it does
> the same for $no_proxy.

Don't think, but read ;-).  Quoting from man curl(1):

	ENVIRONMENT

        The environment variables can be specified in lower case or upper
        case. The lower case version has precedence. http_proxy is an
        exception as it is only available in lower case.
