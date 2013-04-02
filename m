From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rev-parse: clarify documentation for the --verify option
Date: Tue, 02 Apr 2013 07:57:30 -0700
Message-ID: <7vobdxgeud.fsf@alter.siamese.dyndns.org>
References: <1364625865-8459-1-git-send-email-mhagger@alum.mit.edu>
 <7vwqsnnpwj.fsf@alter.siamese.dyndns.org>
 <7vli92jijz.fsf@alter.siamese.dyndns.org> <515A8D79.6050808@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Apr 02 16:58:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UN2ex-0006rH-Gm
	for gcvg-git-2@plane.gmane.org; Tue, 02 Apr 2013 16:58:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932454Ab3DBO5e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Apr 2013 10:57:34 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43281 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932286Ab3DBO5d (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Apr 2013 10:57:33 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D9D7F12F01;
	Tue,  2 Apr 2013 14:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9WxFMfC3teaDNS1Wew51BkLnEKQ=; b=NcE3we
	ScK679R46y54uF5cv5zgTLksoRl2oYv30x1AnOjv4Az9NUCbqLVdbNqnyYFm8399
	CGEzwlYGBxyc/P7Z29FdRM6eME8dn6eSlPcjra3QnvT51TJITtoR2kj4jOP0yTfq
	j+Ue/9d78rZicvTiSYTKMKf4L8aoixT7pswgE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=x3SMw3IPISsA4pz2WjREVerfo6siN7VA
	rWHvjMemjp6wDa5/Lj8P4BO4W7JaMqhwGn0KGFgAcygjcSJP50YfCAIbE4e/w4lT
	cslH2RtDmhINa6rmeu45bBHNMM23jSAEAFYeTzq7AR/1DJRk1NZCvz0Bsue+oICl
	x2Y59ma5Ots=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D1F9012F00;
	Tue,  2 Apr 2013 14:57:32 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3C9F012EFE; Tue,  2 Apr
 2013 14:57:32 +0000 (UTC)
In-Reply-To: <515A8D79.6050808@alum.mit.edu> (Michael Haggerty's message of
 "Tue, 02 Apr 2013 09:49:13 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A57895E0-9BA5-11E2-B7D3-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219779>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> On 04/01/2013 06:56 PM, Junio C Hamano wrote:
>> Junio C Hamano <gitster@pobox.com> writes:
>> 
>>> Because the primary use case of this option is to implement end-user
>>> input validation, I think it would be helpful to clarify use of the
>>> peeler here.  Perhaps
>>> ...
>> 
>> A "SQUASH???" patch on top of your original is queued on 'pu',
>> together with the earlier "^{object}" peeler patch.  Comments,
>> improvements, etc. would be nice.
>
> Yes, your version is better.  I would make one change, though.  In your
>
> +	Make sure the single given parameter can be turned into a
> +	raw 20-byte SHA-1 that can be used to access the object
> +	database, and emit it to the standard output. If it can't,
> +	error out.
>
> it could be made clearer that exactly one parameter should be provided.
> Maybe
>
> +	Verify that exactly one parameter is provided, and that it

That is probably better (I was hoping "the single" would mean the
same to the reader, though).  Thanks.

> +     can be turned into a raw 20-byte SHA-1 that can be used to
> +	access the object database.  If so, emit the SHA-1 to the
> +	standard output; otherwise, error out.
>
> But this makes it sound a little like the "raw 20-byte SHA-1" will be
> output to stdout,...

I did consider that point, wrote "and outputs 40-hex" in my earlier
draft, and then rejected it because it was even more misleading.
The output follows the usual rules for "rev" parameters, e.g.

	git rev-parse --short --verify HEAD
	git rev-parse --symbolic --verify v1.8.2^{tree}

and "--verify" does not mean 40-hex output.  That is why I left it
vague as "emit it".

I agree that the wording incorrectly hints that you may be able to
get 20-byte raw output.  I didn't find a satisfactory phrasing.
