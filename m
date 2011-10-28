From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 00/22] Refactor to accept NUL in commit messages
Date: Thu, 27 Oct 2011 21:07:52 -0700
Message-ID: <7vr51xwyg7.fsf@alter.siamese.dyndns.org>
References: <7vehy459bg.fsf@alter.siamese.dyndns.org>
 <20111023160744.GA22444@sigill.intra.peff.net>
 <7v39ej5uqb.fsf@alter.siamese.dyndns.org>
 <7vy5wb3sto.fsf@alter.siamese.dyndns.org>
 <20111024224558.GB10481@sigill.intra.peff.net>
 <7vvcrd411x.fsf@alter.siamese.dyndns.org>
 <20111027181303.GF1967@sigill.intra.peff.net>
 <7v7h3qz2yo.fsf@alter.siamese.dyndns.org>
 <20111027185220.GA26621@sigill.intra.peff.net>
 <7v39eez1ph.fsf@alter.siamese.dyndns.org>
 <20111027234429.GA28187@sigill.intra.peff.net>
 <buo39edao6r.fsf@dhlpc061.dev.necel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>
To: Miles Bader <miles@gnu.org>
X-From: git-owner@vger.kernel.org Fri Oct 28 06:08:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RJdjb-0005mp-Gy
	for gcvg-git-2@lo.gmane.org; Fri, 28 Oct 2011 06:07:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750804Ab1J1EHz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Oct 2011 00:07:55 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44497 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750716Ab1J1EHy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Oct 2011 00:07:54 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 177D65A3E;
	Fri, 28 Oct 2011 00:07:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=oY35v6g6LE4q2AlmM0yYrBn4e4Q=; b=WFp6hZ
	cYDDK47OmthXq9PeApm3cNoGRyqlI3YwaB0Y+MzyXOupEqg6hshE0mjsgWmvwaYR
	NbywXFYrAK0GCJgVvW4XJRteL46ZWA6fETlgK86Jn1Y31IQFzN+PwX9ZsRY/8eCk
	ZEMDcWp59FZEvxzXFo6f0x+NgKBxjg2RvT34U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HnwnVor8yciM5OG4s1e5HlPiKQAEnpqf
	2PMMLO4OYK29pC6mDsM7/d3c6uGXfhyv33deGM7rxHwWlu7WhXDASw1v/n25SS1c
	xCwzYlcmOxmyYY1Zk3wd44JqFIOTvGw+Vs0w/Spuqn1RYMMwr6+EbOOJ8z1UF8fl
	9C47UXHFJNk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0F11A5A3D;
	Fri, 28 Oct 2011 00:07:54 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 998125A3C; Fri, 28 Oct 2011
 00:07:53 -0400 (EDT)
In-Reply-To: <buo39edao6r.fsf@dhlpc061.dev.necel.com> (Miles Bader's message
 of "Fri, 28 Oct 2011 10:40:28 +0900")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 68C5FA56-011A-11E1-B5F6-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184338>

Miles Bader <miles@gnu.org> writes:

> Jeff King <peff@peff.net> writes:
>> We do have people with utf-16 in their repositories on github. I
>> have no idea why they do such a thing, or what kinds of tricks they
>> do to make it usable (because without it, they just get "binary
>> files differ").
>
> Hmm, you could ask them ...  [or, I suppose more diplomatically, post
> a blog entry asking "Hey all you people who use github for utf-16
> encoded files, ..."]

People will hate such a flag day event initially and later thank you for
it ;-) 

I am afraid that that is a wishful thinking, though.
