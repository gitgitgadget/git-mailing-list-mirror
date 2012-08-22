From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Don't use curl_easy_strerror prior to curl-7.12.0
Date: Wed, 22 Aug 2012 14:01:39 -0700
Message-ID: <7vwr0q63po.fsf@alter.siamese.dyndns.org>
References: <002201cd807d$0e83d300$2b8b7900$@schmitz-digital.de>
 <7v8vd6alqe.fsf@alter.siamese.dyndns.org>
 <003001cd808b$9d505730$d7f10590$@schmitz-digital.de>
 <7vk3wq964r.fsf@alter.siamese.dyndns.org>
 <003c01cd808f$f24e2a60$d6ea7f20$@schmitz-digital.de>
 <7v7gsq94gd.fsf@alter.siamese.dyndns.org>
 <004101cd8096$fce3a700$f6aaf500$@schmitz-digital.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
To: "Joachim Schmitz" <jojo@schmitz-digital.de>
X-From: git-owner@vger.kernel.org Wed Aug 22 23:01:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T4I3j-0004EY-Lb
	for gcvg-git-2@plane.gmane.org; Wed, 22 Aug 2012 23:01:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933344Ab2HVVBp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Aug 2012 17:01:45 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53889 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933330Ab2HVVBn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Aug 2012 17:01:43 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 19B2187DB;
	Wed, 22 Aug 2012 17:01:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=db/vw2jTyrE38GkWtRYzXF9Hj+c=; b=m/vNvS
	uSQRS1V5UqvMbIwE8ZVn/pu0CmAXYXxRNVhND/TXsKiNYpJWx4ro56j69NYZEvd2
	7UuMQ1y2XNa97phWo/jkU5psi0SWKDIZHvbt8ZcPWiTvAgXL4IfilPQyB1pFINkG
	erHNECLu6FQjRt06nh4kzHaeYIPZszI/XYUAw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=M5eVZMNZssES3ZzbxS+7Xk5Mx7oe27oy
	ST9GJxRAju3/OazgPlhtNm9omyV5wYUWxIpwa+Difx33JbcYJ0vGIeQZ0fXGgRgd
	rQi1pwxoErfxHe5lVEZHNO1oaVvPxhjBPbRcNsCnsGbaAqC8+PFyPvvKKtDaYkou
	ovPZhHyj360=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0853D87DA;
	Wed, 22 Aug 2012 17:01:43 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7721387D9; Wed, 22 Aug 2012
 17:01:42 -0400 (EDT)
In-Reply-To: <004101cd8096$fce3a700$f6aaf500$@schmitz-digital.de> (Joachim
 Schmitz's message of "Wed, 22 Aug 2012 20:50:22 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 931BD316-EC9C-11E1-8E4E-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204094>

"Joachim Schmitz" <jojo@schmitz-digital.de> writes:

>> > diff --git a/http.c b/http.c
>> > index b61ac85..18bc6bf 100644
>> > --- a/http.c
>> > +++ b/http.c
>> > @@ -806,10 +806,12 @@ static int http_request(const char *url, void
>> > *result, int target, int options)
>> 
>> Likewrapped X-<
>
> Any suggestion?

Other than "don't wrap" (or "get a real MUA and MTA" X-<),
unfortunately no.

I do not know if you have checked MUA specific hints section of
Documentation/SubmittingPatches; there may be environment specific
hints described for a MUA you may have at hand (or not).
