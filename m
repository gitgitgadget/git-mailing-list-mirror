From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Relative ls-files
Date: Wed, 23 Mar 2011 15:44:12 -0700
Message-ID: <7vaaglcv9f.fsf@alter.siamese.dyndns.org>
References: <AANLkTi=fP+jBpLuxst2rv02pYRmj4HOkv8Yenc-dR-N_@mail.gmail.com>
 <4D89D052.5030801@drmicha.warpmail.net>
 <AANLkTimc7gNKbh3C2hyMtFK6D1OWNALD+GvzmhG5cZrn@mail.gmail.com>
 <AANLkTimdLGgGXGRNVH5+X-cnhK2NWfWx9k0apt-6rr1Z@mail.gmail.com>
 <4D89DCBE.3060400@drmicha.warpmail.net>
 <AANLkTi=BrgZe47Bt5evr_qFzKBL=MY-6NmH22gsRurVV@mail.gmail.com>
 <7v7hbqgc7g.fsf@alter.siamese.dyndns.org>
 <AANLkTi=OJ_o2WQ2W6d30HXQZrg7=W70+fZWrbQPrAs=s@mail.gmail.com>
 <7v39mdhni3.fsf@alter.siamese.dyndns.org>
 <AANLkTin=y=THaQEzgMhyBVLBriJBCa-pVvONXDnzUmew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Git List <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 23 23:44:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q2Wn1-0005wZ-UA
	for gcvg-git-2@lo.gmane.org; Wed, 23 Mar 2011 23:44:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932880Ab1CWWo0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Mar 2011 18:44:26 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:33403 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932870Ab1CWWoZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Mar 2011 18:44:25 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 4A401419A;
	Wed, 23 Mar 2011 18:46:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=UbqLDvtvLQLWQYm+aFJrrdPnkI4=; b=G+yQUc
	PKNGyoCyuxI/g1sZmkAwrMMJsDMjvFMAIfybZv7q75KHzAO6i3xRsnKrjB3T2FRR
	c5oy9NlSSJgc1mhXXbnYc8oqJPk7PzpkyXoCPltNo10yxM0g7kZfynvoNzB604T4
	zUsoEkstsCJKTMAE6zb1lBJFvosWSFCeBoRU8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gLnWXOAZgyD/gFLjImMHn5YHujWeR4q1
	fG3ugKZ05W+p5+u8qX0GWc+KasdxZtzHVK6OvZDSWP6EU5a0YtWSiawwhfWcl05k
	KjSmTkaCz570kui2zvDyCc92HjRrLzPeqDRtpU6meux3KqNGadSMAPF7tExO+iCC
	K6OdOJKMv00=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id F226A4199;
	Wed, 23 Mar 2011 18:45:59 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 54AD34198; Wed, 23 Mar 2011
 18:45:54 -0400 (EDT)
In-Reply-To: <AANLkTin=y=THaQEzgMhyBVLBriJBCa-pVvONXDnzUmew@mail.gmail.com>
 (Nguyen Thai Ngoc Duy's message of "Wed, 23 Mar 2011 22:41:47 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 52D607F8-559F-11E0-A441-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169878>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> This read_tree_recursive() affects 'archive' and 'checkout -- paths'
> (ie. no wildcard awareness). I will probably move match_tree_entry()
> to ls-tree.c to preserve its behavior, then change
> read_tree_recursive() to use tree_entry_interesting().

[jc: culled people other than those in the "magic pathspec" discussion
from CC list]

Wouldn't it be more sensible to add a bit ("is this a glob or are we
expected to match it literally") to each element in the pathspec array,
and pass a pathspec whose elements are all marked as "literal" down from
ls-tree?

The internal matcher (and traversal optimizer) would need to become aware
of "not a glob" match (and possibly different kinds of matches like "**/"
support) sooner or later, and when that happens you would need something
like the above on the caller side in ls-tree.
