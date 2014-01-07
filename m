From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] format-patch: introduce branch.*.forkedFrom
Date: Tue, 07 Jan 2014 12:42:40 -0800
Message-ID: <xmqq4n5fcym7.fsf@gitster.dls.corp.google.com>
References: <1389126588-3663-1-git-send-email-artagnon@gmail.com>
	<xmqq8uurcyw2.fsf@gitster.dls.corp.google.com>
	<CALkWK0=vXGiHbd__ZNfp42fRS_gK5MNmYx13=uzDfc0m==V5Fw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Junio C Hamano <gister@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 07 21:42:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0dUH-0000GQ-IC
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jan 2014 21:42:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753523AbaAGUmv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jan 2014 15:42:51 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58459 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753493AbaAGUmn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jan 2014 15:42:43 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AED09617A8;
	Tue,  7 Jan 2014 15:42:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=J2oF3hKsTsLZrnSzce4/Wg2RwYQ=; b=I//Ljc
	ARUMf/m93vuAHa/ADOSJXGXLq+fhf0zzfTZdb1nHuKswEI+Lu+k8xIWBWzAUR89z
	9ytGDeK65u55ef3wt/UcNKlyunyvTmA1aTupgErNrm4Zhwzy01V5zgkJOFwGYFOD
	u6zUujGAJlp//Io5DqpD8DfZlQY70S/vMLNfM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QnD44q8UyJyna1cXH677P64fy4nNqap/
	xc0wS/OzNFbUqD5KE8NGTQU6cLYiZYcdzVY3m9N+HfmG7JszGy8Knij1FX5POKFQ
	/LLlfWp1A2Ly54bGBK+16lt8qus+BvTYKsZW9DmmOx/RfbC64TfawEMh7rSQvpvj
	SYeFAacgHqM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 96DB7617A7;
	Tue,  7 Jan 2014 15:42:42 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C5378617A4;
	Tue,  7 Jan 2014 15:42:41 -0500 (EST)
In-Reply-To: <CALkWK0=vXGiHbd__ZNfp42fRS_gK5MNmYx13=uzDfc0m==V5Fw@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Wed, 8 Jan 2014 02:10:45 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 40FE817E-77DC-11E3-AF64-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240150>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Junio C Hamano wrote:
>> I do not mind allowing laziness by defaulting to something, but I am
>> not enthused by an approach that adds the new variable whose value
>> is questionable.  The description does not justify at all why
>> @{upstream} is not a good default (unless the workflow is screwed up
>> and @{upstream} is set to point at somewhere that is _not_ a true
>> upstream, that is).
>
> Did you find the explanation I gave in
> http://article.gmane.org/gmane.comp.version-control.git/240077
> reasonable?

No.
