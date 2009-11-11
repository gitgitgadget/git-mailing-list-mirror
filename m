From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Clarify documentation on the "ours" merge strategy.
Date: Wed, 11 Nov 2009 13:02:23 -0800
Message-ID: <7vskckn5b4.fsf@alter.siamese.dyndns.org>
References: <alpine.DEB.1.00.0911031047510.4985@pacific.mpi-cbg.de>
 <200911111411.nABEBfox031023@ds9.cixit.se>
 <2faad3050911110713y4e33c7d2h21ad42efe4fd70b3@mail.gmail.com>
 <200911112135.25839.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Baz <brian.ewins@gmail.com>,
	Peter Krefting <peter@softwolves.pp.se>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	=?utf-8?Q?Bj=C3=B6rn?= Steinbrink <B.Steinbrink@gmx.de>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Wed Nov 11 22:03:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N8KL2-0003GS-8L
	for gcvg-git-2@lo.gmane.org; Wed, 11 Nov 2009 22:02:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759214AbZKKVCg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Nov 2009 16:02:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759212AbZKKVCg
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Nov 2009 16:02:36 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:63672 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759154AbZKKVCf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Nov 2009 16:02:35 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 6918698B78;
	Wed, 11 Nov 2009 16:02:40 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=AsXUwuZRvwRq5fs59pMHWiANeC4=; b=JyPtnr
	AAF5GHEcI8Q9tu62XCltdIJz68YCF60IBMF+7eAyu3pIqGn6IJWnNdOeJ/Bpnaal
	gArUpGhDD7tpVcuUA4uRt1v5EYcvf8UtA+oDmSCuqFyKkhsENQ0Fvx4H7DwUwnLC
	P1fp+brH5gre9u8Uas5xPT/2EMG0vxZlWQkLA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VkL0Hvf9PUfiuLA3E3nOwSJusJparKAI
	XopPULCQnamWvmu8gvx41ERMY57q6LJwhgNRAn3Llj6NgAKq5WTxA3AlBSZQgOX+
	dD1fRw74uMQ0yacP5zPg3uEVk3XSJ8YKEq0MvDw4dfnUUO/QIuEdEZOki8opboHD
	hgDysVXpZPI=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0935498B6D;
	Wed, 11 Nov 2009 16:02:34 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id B539C98B65; Wed, 11 Nov 2009
 16:02:25 -0500 (EST)
In-Reply-To: <200911112135.25839.trast@student.ethz.ch> (Thomas Rast's
 message of "Wed\, 11 Nov 2009 21\:35\:24 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 88813AE8-CF05-11DE-AC15-B888BBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thomas Rast <trast@student.ethz.ch> writes:

> I'd much rather see this explained in the description of the rebase
> -m/-s options since it (the swap) applies to all uses of 'git rebase
> -m'.  Perhaps with an extra (but short) note in the "ours"
> description, like so:
>
> diff --git i/Documentation/git-rebase.txt w/Documentation/git-rebase.txt
> index 33e0ef1..181947c 100644
> --- i/Documentation/git-rebase.txt
> +++ w/Documentation/git-rebase.txt
> @@ -228,6 +228,10 @@ OPTIONS
>  	Use merging strategies to rebase.  When the recursive (default) merge
>  	strategy is used, this allows rebase to be aware of renames on the
>  	upstream side.
> ++
> +Note that in a rebase merge (hence merge conflict), the sides are
> +swapped: "theirs" is the to-be-applied patch, and "ours" is the so-far
> +rebased series, starting with <upstream>.
>  
>  -s <strategy>::
>  --strategy=<strategy>::
> diff --git i/Documentation/merge-strategies.txt w/Documentation/merge-strategies.txt
> index 4365b7e..0cae1be 100644
> --- i/Documentation/merge-strategies.txt
> +++ w/Documentation/merge-strategies.txt
> @@ -33,6 +33,9 @@ ours::
>  	merge is always the current branch head.  It is meant to
>  	be used to supersede old development history of side
>  	branches.
> ++
> +Because the sides in a rebase are swapped, using this strategy with
> +git-rebase is never a good idea.
>  
>  subtree::
>  	This is a modified recursive strategy. When merging trees A and

Looking very good.
