From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3 01/11] Makefile: sort LIB_H list
Date: Wed, 20 Jun 2012 13:00:01 -0700
Message-ID: <7vwr31u532.fsf@alter.siamese.dyndns.org>
References: <20120620182855.GA26948@sigill.intra.peff.net>
 <20120620183008.GA30995@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jun 20 22:00:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ShR4X-0006V4-Q1
	for gcvg-git-2@plane.gmane.org; Wed, 20 Jun 2012 22:00:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758007Ab2FTUAI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jun 2012 16:00:08 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41851 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754458Ab2FTUAH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jun 2012 16:00:07 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B39E1806B;
	Wed, 20 Jun 2012 16:00:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=SDW3gmzr0qG+rRwJgoKsT9GWFGY=; b=vrghrV
	hb4lErqKdD2MIK22F4+QH1jzQ5tmV1A7FgKqYldQVHMtud1P+o8AKNY2OYxdPUQH
	HuLSDSiyd0fkZg8EWVnIjq+xcK4ovE6SR6g57o/vVrvkY0UPOVp9n0hudIaGWoxB
	PP/KDb14BwrSz9fXrFdvGi6/9qGNzlnd5pY3w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wjNoZl6f5WcINaDytRRxlgo5TVHWHdrf
	OpmcyMg8DrZiG45KOtShCAukCe1kR69+GizcAp0H8PwL9FfmA0sv4wiV/pIfL9M2
	5pBn9cxMQhaA+zowfvsqm9xQbDtakT9tkaZGLhZFN7QvJp2TpmY7kjpC4nYHV3QR
	5EveVkn0Kgw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 86D818068;
	Wed, 20 Jun 2012 16:00:06 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6608F805F; Wed, 20 Jun 2012
 16:00:02 -0400 (EDT)
In-Reply-To: <20120620183008.GA30995@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 20 Jun 2012 14:30:08 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 85AC4776-BB12-11E1-9FC0-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200351>

Jeff King <peff@peff.net> writes:

> This was mostly sorted already, but put things like
> "cache-tree.h" after "cache.h", even though "-" comes before
> "." (at least in the C locale). This will make it easier to
> keep the list sorted later by piping it through "sort".

I agree this would make it easier to blindly run "sort", but I think
the result hurts scannability.  Is it a good change?

> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  Makefile | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index 62de0b4..72cdb56 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -595,8 +595,8 @@ LIB_H += attr.h
>  LIB_H += blob.h
>  LIB_H += builtin.h
>  LIB_H += bulk-checkin.h
> -LIB_H += cache.h
>  LIB_H += cache-tree.h
> +LIB_H += cache.h
>  LIB_H += color.h
>  LIB_H += commit.h
>  LIB_H += compat/bswap.h
> @@ -636,13 +636,13 @@ LIB_H += mailmap.h
>  LIB_H += merge-file.h
>  LIB_H += merge-recursive.h
>  LIB_H += mergesort.h
> -LIB_H += notes.h
>  LIB_H += notes-cache.h
>  LIB_H += notes-merge.h
> +LIB_H += notes.h
>  LIB_H += object.h
> -LIB_H += pack.h
>  LIB_H += pack-refs.h
>  LIB_H += pack-revindex.h
> +LIB_H += pack.h
>  LIB_H += parse-options.h
>  LIB_H += patch-ids.h
>  LIB_H += pkt-line.h
> @@ -668,8 +668,8 @@ LIB_H += submodule.h
>  LIB_H += tag.h
>  LIB_H += thread-utils.h
>  LIB_H += transport.h
> -LIB_H += tree.h
>  LIB_H += tree-walk.h
> +LIB_H += tree.h
>  LIB_H += unpack-trees.h
>  LIB_H += userdiff.h
>  LIB_H += utf8.h
