From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 3/3] push: add 'prune' option
Date: Wed, 22 Feb 2012 12:56:18 -0800
Message-ID: <7v8vjua8p9.fsf@alter.siamese.dyndns.org>
References: <1329505957-24595-1-git-send-email-felipe.contreras@gmail.com>
 <1329505957-24595-4-git-send-email-felipe.contreras@gmail.com>
 <7vobsxqebz.fsf@alter.siamese.dyndns.org>
 <CAMP44s3+XCM1E_AtW1yGifmGoGSkFSpSTaFbbMffz+hmUzWahw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 22 21:56:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S0JEk-0002bV-Gv
	for gcvg-git-2@plane.gmane.org; Wed, 22 Feb 2012 21:56:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754538Ab2BVU4X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Feb 2012 15:56:23 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56142 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754053Ab2BVU4V (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Feb 2012 15:56:21 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8EACE6CB2;
	Wed, 22 Feb 2012 15:56:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=C2Vp0VNUCH3kkTyyn9sYFplygCg=; b=UUxU3h
	bYmGTzUn2bf2nLOOvaX7AS2a/wJHrjnaV2bvGdDv325GCd9bna05Jbd6h2GZIE5/
	dgL8vZlRj5f6ht4aCFjH2DMDNDgjtJXF0kUkUf54cKEl59evl8e7IDDLwb23JRec
	beJPcy7/thw3MDqrIe4DyKafQGYbNE+ZsTSyk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=q7GBwvPzcb6KVGO/1ypGy9xcBy/+/aTi
	DTEnK3XRitLM5VvEtGJF6Z50SbkLsjR3gzqIc2MHUUVi8l+wcBnqSkvFJhm0jRQ6
	PTMpCD/GZkDvY7/EYsZqcubg1Qvzm1vwm399XA2HJwWHKop64pE16Wj+LkdmlKdi
	s85LOSKEUv0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8597B6CB1;
	Wed, 22 Feb 2012 15:56:20 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 18EEF6CB0; Wed, 22 Feb 2012
 15:56:20 -0500 (EST)
In-Reply-To: <CAMP44s3+XCM1E_AtW1yGifmGoGSkFSpSTaFbbMffz+hmUzWahw@mail.gmail.com> (Felipe
 Contreras's message of "Wed, 22 Feb 2012 22:43:05 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: ABC5AAAC-5D97-11E1-BCDB-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191288>

Felipe Contreras <felipe.contreras@gmail.com> writes:

>> Perhaps "enum map_direction { SRC_TO_DST, DST_TO_SRC }" or something?
>
> I think only FROM_SRC, FROM_DST is more than enough to figure it out.

Yeah, as you can tell from my "or something", as long as the name makes
the direction clear, I don't care too much about the exact spelling.

>> Perhaps rename this to "map_push_refs()" or something in the patch 2/3?
>
> I think get_ref_match() would be more appropriate because we are
> acting on a specific (singular) ref, and the primary thing we care
> about is getting the peer name, based on the refspec match, which we
> might want as a return value.

Again, as long as the name makes it clear this is meant only for "push"
and never be used for "fetch", I am fine with it.  One way to make it sure
is to have a substring "_push" somewhere in that name.

> Probably some rebase mistake =/

Thanks; I was wondering if there is something subtle unexplained going on.
