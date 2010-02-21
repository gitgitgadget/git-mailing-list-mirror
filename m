Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-0.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: (qmail 17225 invoked by uid 107); 21 Feb 2010 22:22:47 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.180.67)
    by peff.net (qpsmtpd/0.40) with ESMTP; Sun, 21 Feb 2010 17:22:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753482Ab0BUWW0 (ORCPT <rfc822;peff@peff.net>);
	Sun, 21 Feb 2010 17:22:26 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:51857 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753262Ab0BUWWZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Feb 2010 17:22:25 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B74149BDDC;
	Sun, 21 Feb 2010 17:22:24 -0500 (EST)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=s/uvIsr4d0veh5bCFpcpDSNaRlc=; b=nWi9Uq
	SWdQKHRIVkAk1mn5SGpWk7e/ouCly+UPeFfPT5KPaYntYBEYu9qrzzjUowh4Ddig
	ado++qNh7keRcn6oc1VTKKArn5qeuQnk7LG1BoIP+d5qsgGn6tCyHBP57ezkVHDp
	AGWJ5dc6qT7ZLuQj3lFmXYo3k7npclGBHe7BA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=t+Wg8GcA+mKFdu/l4JCA2TLnzMu9R/gj
	4gL92E0evsHjdZWkS/p3K1LPuHnMlGjhE1vRKYjNgPIp/oDKeN7za2guaIZyjE/Q
	2sZRtGjyE4yTJT3s5VZyNJqZ9F12BYliMQZS+xc/eC0/7O4GU7unPPJXM5zXdcB1
	D0HSW+//qn4=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 7871B9BDDA;
	Sun, 21 Feb 2010 17:22:22 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 93EE79BDD9; Sun, 21 Feb
 2010 17:22:19 -0500 (EST)
To:	Nicolas Pitre <nico@fluxnic.net>
Cc:	git@vger.kernel.org
Subject: Re: [PATCH] sha1_file: don't malloc the whole compressed result when
 writing out objects
References: <alpine.LFD.2.00.1002202323500.1946@xanadu.home>
 <7vd3zys79d.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.1002211522120.1946@xanadu.home>
From:	Junio C Hamano <gitster@pobox.com>
Date:	Sun, 21 Feb 2010 14:22:17 -0800
In-Reply-To: <alpine.LFD.2.00.1002211522120.1946@xanadu.home> (Nicolas
 Pitre's message of "Sun\, 21 Feb 2010 16\:26\:51 -0500 \(EST\)")
Message-ID: <7v7hq6mdpi.fsf@alter.siamese.dyndns.org>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Pobox-Relay-ID: 94BDF38C-1F37-11DF-9911-D83AEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Nicolas Pitre <nico@fluxnic.net> writes:

> I disagree.
>
> Here's my take on the paranoia issue.

Ahh, yes, of course.

You are always a better programmer than I am and I keep getting reminded.

Thanks, and I agree it is a sane thing to do this unconditionally.
