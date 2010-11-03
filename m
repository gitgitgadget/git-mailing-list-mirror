From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] teach update-index --refresh about --data-unchanged
Date: Wed, 03 Nov 2010 10:37:40 -0700
Message-ID: <7vzktqwbob.fsf@alter.siamese.dyndns.org>
References: <20101031174430.GA30236@arf.padd.com>
 <20101031195933.GA21240@burratino> <20101031222644.GA31257@arf.padd.com>
 <20101031222805.GB31257@arf.padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Wed Nov 03 18:38:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PDhHi-0004Ri-2x
	for gcvg-git-2@lo.gmane.org; Wed, 03 Nov 2010 18:38:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756133Ab0KCRhx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Nov 2010 13:37:53 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:40430 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753115Ab0KCRhw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Nov 2010 13:37:52 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1F76912FC;
	Wed,  3 Nov 2010 13:37:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Vr///Jn51Orun/SQVOjYp6siQ1s=; b=nOl69X
	r2+UH1MDXhKwu9eSuKjMztjyNOC1yX0YpyZ+119zjxVJSsfEba7jgACnbKqwWP+W
	OzHRSmQmpAQHO1DuRPmXlNNSLOv7lAwX71wDAwcZ6n1d0FxH0MlLlLR+wy3gJkgr
	4RQz6FwG6xDcIVngE5pANE/1L7ouCE2kdUMac=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EAOhzAAYPJTxQJuh2TVA1+d/yEynnF8U
	vtAJLnlpMAmuCtEQVV6//2hYDN5OP07eZ3hxe2eov8JNa+BHPqiqMPBcyTB1HlTt
	zkFQKBQjzPrlL/w95W44YUUYYldzDN/5NNKgqkYtlMfsbJTgtOA0Kyfw1Cq7+QDy
	f1wSzJBlNm8=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D3E6B12F8;
	Wed,  3 Nov 2010 13:37:46 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0DA4912F2; Wed,  3 Nov
 2010 13:37:41 -0400 (EDT)
In-Reply-To: <20101031222805.GB31257@arf.padd.com> (Pete Wyckoff's message of
 "Sun\, 31 Oct 2010 18\:28\:05 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 124784A6-E771-11DF-988B-B51D107BB6B6-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160631>

Pete Wyckoff <pw@padd.com> writes:

> When a repository has been copied with rsync, or cloned using
> a volume manager, the index can be incorrect even though the
> data is unchanged.  This new flag tells update-index --refresh
> that it is not necessary to reread the data contents.

I know our traditional attitude towards the plumbing commands have been
"give them long enough rope and let users hang themselves", but this
particular rope feels a bit too long for my taste.
