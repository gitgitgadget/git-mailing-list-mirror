From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [1.8.0] Provide proper remote ref namespaces
Date: Tue, 08 Feb 2011 15:13:50 -0800
Message-ID: <7vzkq6p1ap.fsf@alter.siamese.dyndns.org>
References: <AANLkTi=yFwOAQMHhvLsB1_xmYOE9HHP2YB4H4TQzwwc8@mail.gmail.com>
 <201102070429.05033.johan@herland.net>
 <20110208010648.GA3132@dpotapov.dyndns.org>
 <201102080915.27484.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dmitry Potapov <dpotapov@gmail.com>, git@vger.kernel.org,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Jeff King <peff@peff.net>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Nicolas Pitre <nico@fluxnic.net>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Wed Feb 09 00:14:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PmwlE-0000S0-5Q
	for gcvg-git-2@lo.gmane.org; Wed, 09 Feb 2011 00:14:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755514Ab1BHXOL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Feb 2011 18:14:11 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:46371 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753790Ab1BHXOK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Feb 2011 18:14:10 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id BBB87394B;
	Tue,  8 Feb 2011 18:15:07 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=sBgYiIk8mvknA5RvJxSuEirlcGg=; b=r0CWCQ
	/dF8f8Tw2YiBw4qtWai7FXTFQb/ecO4b8UMXW9swwDCdxloeurtZ8eN1qX7lbJry
	fnLDFigMrM/qRE5LaBgDD/CvTxePpSzucsIr7qvNGEqFTTbj+7joZ1ECfuIO2Gng
	nTiTS0yWjft6wqT6BgFxL0pcdJYpUoMRx7cGg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=yFwirk3hpjy5oUbQe6HD3fs8gH5gC67V
	Pj8uC+8u4aWPIt9OWDzU3B5QPECdDOVDFogkn3fxG1faH/T929Ue5BzU+HB0qq8V
	9hmHNg9HXmDxHWgS8PyGvKqmkvvUeY0LfKC43PNzPFjzaLP4s90HKWbfo61RLZQs
	r1sRZD7jO0w=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 45170394A;
	Tue,  8 Feb 2011 18:15:00 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 50BA43946; Tue,  8 Feb 2011
 18:14:51 -0500 (EST)
In-Reply-To: <201102080915.27484.johan@herland.net> (Johan Herland's message
 of "Tue\, 08 Feb 2011 09\:15\:27 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 4064C420-33D9-11E0-A2FC-F13235C70CBC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166373>

Johan Herland <johan@herland.net> writes:

> Ah, yes, I should have been more specific:
>
>     remote.origin.fetch = ~refs/tags/*:refs/tags/*

Hmmm, I was in the vicinity of builtin/fetch.c:find_non_local_tags()
today, and I had to wonder what the implementation of this would look
like....
