From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git attributes ignored for root directory
Date: Wed, 05 Oct 2011 11:35:22 -0700
Message-ID: <7vvcs370d1.fsf@alter.siamese.dyndns.org>
References: <4E8B55FB.1050203@svario.it> <4E8C481A.1070808@alum.mit.edu>
 <7vd3eb8hkb.fsf@alter.siamese.dyndns.org> <4E8C9A35.5030504@svario.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org
To: Gioele Barabucci <gioele@svario.it>
X-From: git-owner@vger.kernel.org Wed Oct 05 20:35:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBWJV-0003tZ-Hb
	for gcvg-git-2@lo.gmane.org; Wed, 05 Oct 2011 20:35:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933864Ab1JESfZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Oct 2011 14:35:25 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49949 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933242Ab1JESfY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Oct 2011 14:35:24 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DC27C611D;
	Wed,  5 Oct 2011 14:35:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lJvZh20faomWOwVygl7hMbIPtwQ=; b=fL0XzE
	y5EoRsresI7uu4qfa/cGn040LO8icaM/lkhr1okwIz6UQlweodYBMg0m+BF/PSJE
	XnqDuNKGn/hres9P7eM4EjqW8lAYsIeB6A4PzJSs+oj7A2nbzbBiK+JkZhvSi6cj
	a7P+sRzrvzrpDjJg7qJCyiAJYaREOGlWnpFnY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LVbPwgrzT8a7PFBV6dFxn+ndWuZmFLGB
	doZGsRSavhu/kM9B3UnBEkKtRbd0/jCE+K16lLGS7M/nGS24BE4wOIr0tNVirIRc
	vuZdrrpQgXdZCr3EsTlCj+/Bawehg/ZCCLW4N9emDOg14hq+0DpVD440xefM1jhH
	/oH6JwhlTKk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D367E611C;
	Wed,  5 Oct 2011 14:35:23 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6CC0E611B; Wed,  5 Oct 2011
 14:35:23 -0400 (EDT)
In-Reply-To: <4E8C9A35.5030504@svario.it> (Gioele Barabucci's message of
 "Wed, 05 Oct 2011 19:56:05 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C961481C-EF80-11E0-B56D-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182875>

Gioele Barabucci <gioele@svario.it> writes:

> On 05/10/2011 19:38, Junio C Hamano wrote:
>>> In fact the support for gitattributes using patterns involving "." was
>>> pretty spotty in v1.7.6 too.  For example,
>>
>> The attribute patterns (or exclude patterns for that matter) were never
>> designed to name "the current directory". The way to name "everything *in*
>> this directory" has always been to say "*" (the "* text=auto" example in
>> the documentation says it shows how to set the attribute "for all
>> files"). Admittedly the pattern may miss ".*" files.
>
> What if I do not want to say things about the "content" of the
> directory but about the directory itself? This is exactly my case.

Oh, that is totally different. We do not store directories, and they do
not have attributes, period.
