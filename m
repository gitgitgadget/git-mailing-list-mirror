From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [IGNORETHIS/PATCH] Choosing the sha1 prefix of your commits
Date: Wed, 19 Oct 2011 21:31:16 -0700
Message-ID: <7vvcrk9td7.fsf@alter.siamese.dyndns.org>
References: <CACBZZX5PqYa0uWiGgs952rk2cy+QRCU95kF63qzSi3fKK-YrCQ@mail.gmail.com>
 <20111019190114.GA4670@sigill.intra.peff.net>
 <20111019193834.GA14168@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Oct 20 06:31:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RGkHs-0006Ly-2W
	for gcvg-git-2@lo.gmane.org; Thu, 20 Oct 2011 06:31:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752252Ab1JTEbT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Oct 2011 00:31:19 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56286 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751257Ab1JTEbS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Oct 2011 00:31:18 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 211002341;
	Thu, 20 Oct 2011 00:31:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9R2K1BWzXEIlkCYA0NGiy4r1Mzo=; b=pT1bOr
	W38tczr89t2kEkzVEcMJpaEkilv7C2UmQhOVLTK0bvVDYEaENXAUSp1quCKRdOV1
	cppK5kpONIRkEY3eU0tWSICwmOES87pPtTp4yM9ixHQLuDcijuuuipbr2Ou9cfko
	6nPSLguWe6NBqNnIlMSberu/kSn5kB0o5Kyj0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=juvYjqmzUnNCZ7/4O6XvMFsOmPrha8QU
	OZd5Mj5K+AptpLrc+fqvFjZJVwf+dhN1LQuJOCJ/ptvlrv8ob17lDiTv7Lmop7Z0
	VuqeI8ehQHDoB3a6GcNUHofADmHXlCArIbftZIke18PVYl/l3Tk/Y0YA7zVxplXg
	VFrIu6foiwk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 17D622340;
	Thu, 20 Oct 2011 00:31:18 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8C9A9233F; Thu, 20 Oct 2011
 00:31:17 -0400 (EDT)
In-Reply-To: <20111019193834.GA14168@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 19 Oct 2011 15:38:34 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5A49208A-FAD4-11E0-A375-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184003>

Jeff King <peff@peff.net> writes:

> And nothing shows up in the body, because git truncates at the NUL we
> added:
>
>   $ git show
>   commit 31337a1093af2d97eb2e6c08b261c2946395fdd3
>   Author: Jeff King <peff@peff.net>
>   Date:   Wed Oct 19 15:34:00 2011 -0400
>
>       10
>
>   diff --git a/file b/file

But you cannot hide from "cat-file commit" ;-)

With the recent push to more (perceived) security, it may probably make
sense to teach "log" family commands to quote-show ^@ and what is behind
in their output by default, perhaps with an option to turn it off.
