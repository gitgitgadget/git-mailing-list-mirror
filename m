From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] doc: technical details about the index file format
Date: Tue, 01 Mar 2011 22:02:20 -0800
Message-ID: <7voc5ucb6b.fsf@alter.siamese.dyndns.org>
References: <AANLkTi=iFe=MmUiXzC_HMwueZxLJDCea+zp_-SNWvSup@mail.gmail.com>
 <1283769430-9263-1-git-send-email-pclouds@gmail.com>
 <AANLkTi=YJkk6KHChCrrazij_ziyG-Ru7kGLWc7JnUGoN@mail.gmail.com>
 <AANLkTi=hz0xRsTy5f8xhzBhu0md_iPCxvdTrEPrzYwzt@mail.gmail.com>
 <20110226100310.GA21724@do> <7vsjvb6qmt.fsf@alter.siamese.dyndns.org>
 <20110226133639.GA32442@do> <7vpqqaffy2.fsf@alter.siamese.dyndns.org>
 <AANLkTi=GhdfWCyx7MN3w0ZPhqKHcC1e6RmPeZt67OeqG@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sverre Rabbelier <srabbelier@gmail.com>, git@vger.kernel.org,
	kusmabite@gmail.com, raa.lkml@gmail.com, jjuran@gmail.com,
	Robin Rosenberg <robin.rosenberg@dewire.com>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 02 07:02:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Puf97-0006jS-Bd
	for gcvg-git-2@lo.gmane.org; Wed, 02 Mar 2011 07:02:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756671Ab1CBGCo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Mar 2011 01:02:44 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:64893 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753014Ab1CBGCn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Mar 2011 01:02:43 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 42E804C77;
	Wed,  2 Mar 2011 01:04:01 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kgq8muFBaWsgp08ntcu4F4Jk/2I=; b=OoiYf9
	qzJpVp7e7mZOv3TbSa/glon+/HGo8VmNd0jwLNmwupRT/VgSmS0aisVJfWaTv4T9
	Skopf/+TvuDz7KNUqiOSHUYqFb2qrqvp8DiqHmueI4BF0Rk3esgLAoQeuPFlS74A
	VL6TmxbgFyxskMp2ydYSDqwAXxWgt6fGE+g1o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lMJLXHLR/pGv0DXd83xjap2tyzHKZ7EH
	e2BkLurb5xqs6uKByJRzEHMY8Ktv9k4kTayIDhDxiN9jyb/+3RNgYpUI+JRlLB/9
	DDxwY2YKYiqZkghb1/zocivUt5oI4ve1bbyiPrFtIIQX2Z2XTYVRXUA10GRQQ0f/
	cX+SssprXMc=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C481A4C6A;
	Wed,  2 Mar 2011 01:03:53 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id CBFCE4C69; Wed,  2 Mar 2011
 01:03:41 -0500 (EST)
In-Reply-To: <AANLkTi=GhdfWCyx7MN3w0ZPhqKHcC1e6RmPeZt67OeqG@mail.gmail.com>
 (Nguyen Thai Ngoc Duy's message of "Wed\, 2 Mar 2011 10\:34\:23 +0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: DA224ED8-4492-11E0-A5B8-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168294>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> Looks good. I don't really like ending a sentence with semicolon, but
> that's just my taste.

I tend to do enumerated list like "A; B; and C."  Perhaps just a personal
taste.

> I wonder if we should also point to relevant source files, so if this
> document becomes out of date, the readers can jump in the source and
> verify themselves (perhaps coming up with patches to this doc)?

I suspect that is a sure way to guarantee the document to go stale.

I didn't like the way I explained the cache-tree entry order.  Was it
understandable?

I am wondering if an illustration with an example might be in order.  I
think anybody halfway intelligent may be able to get a fuzzy idea of what
is going on by looking at the output from test-dump-cache-tree after
"reset --hard && write-tree" and then by comparing it with the output from
test-dump-cache-tree after running ">t/something && git add t/something"
(which invalidates the top-level tree and t/ subtree). But a well written
documentation should be able to help clarifying the idea obtainable that
way.  I don't think what I wrote in the previous message is sufficient
even for that (i.e. comparing the two output would give you better
explanation of what is going on than what I wrote--iow, what I wrote may
not be very useful for people who are motivated to learn).
