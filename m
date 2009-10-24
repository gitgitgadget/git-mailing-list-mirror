From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] git checkout --nodwim
Date: Sat, 24 Oct 2009 12:25:48 -0700
Message-ID: <7v7huk61c3.fsf@alter.siamese.dyndns.org>
References: <1254775583-49452-1-git-send-email-jaysoffian@gmail.com>
 <alpine.DEB.1.00.0910052314580.4985@pacific.mpi-cbg.de>
 <7vzl7pyvzl.fsf@alter.siamese.dyndns.org>
 <7v63adxh9a.fsf_-_@alter.siamese.dyndns.org>
 <81b0412b0910180540u7030c22br7efcaf7f51df771d@mail.gmail.com>
 <7v7huspjg0.fsf@alter.siamese.dyndns.org>
 <32541b130910211029x2f4295c3w40dd13b3cdc7762c@mail.gmail.com>
 <20091022062145.6117@nanako3.lavabit.com>
 <alpine.DEB.1.00.0910220226270.4985@pacific.mpi-cbg.de>
 <7vzl7h8fjp.fsf@alter.siamese.dyndns.org>
 <117f2cc80910240759oa9f57e7h67f06816d37e328c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Nanako Shiraishi <nanako3@lavabit.com>,
	Avery Pennarun <apenwarr@gmail.com>,
	Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org,
	Jay Soffian <jaysoffian@gmail.com>
To: David Roundy <roundyd@physics.oregonstate.edu>
X-From: git-owner@vger.kernel.org Sat Oct 24 21:26:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N1mG2-0002zj-JU
	for gcvg-git-2@lo.gmane.org; Sat, 24 Oct 2009 21:26:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751857AbZJXT0E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Oct 2009 15:26:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751400AbZJXT0D
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Oct 2009 15:26:03 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:45049 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751857AbZJXT0B (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Oct 2009 15:26:01 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C2A608415B;
	Sat, 24 Oct 2009 15:26:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=BhZkwyijKbVK91rIxyVqEaxwJyU=; b=jC8OqaQtt4VANz96poozNCb
	DIVP3bEp5CG4EvrZcUbkQ4xuMifwiP53oQPpdsPj1axKhjiBCpiBOdVwrM7vQqAX
	y9YUx5FuOl5varnhQToQSQb6bcwgHRR15WdpWar0QRaQamZGAbjAQvI8pCI1gv58
	MRLBpWQ+u9bf+aWwfmdQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=gavueClau+g+pxoOWABhonve/EIhWFgMQsiDDO3sXTlGyKwoj
	ZDuJETeAR6K7tMmrCMKmHaTFudhXMAIHkdA54XfPpYl7nlZ7NuuSC9AwwU6FKMFY
	ZYzE8tzyfxQuP/LjDea7BTyy3jxMEvniFMdzW26mvWhE/nDcUfWQgWlN8s=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5F33B8415A;
	Sat, 24 Oct 2009 15:25:59 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 425EB84156; Sat, 24 Oct 2009
 15:25:49 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 0F355696-C0D3-11DE-9E68-A67CBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131175>

David Roundy <roundyd@physics.oregonstate.edu> writes:

> Perhaps a universal --plumbing flag would be handy?

Yes in general but it is unclear what aspect of its behaviour we will
be casting in stone with a generic --plumbing option in this case.  I
also think that "checkout" Porcelain is not yet mature enough for us
to do this right now. For example, I am reasonably sure that somebody
motivated enough will teach it to touch submodule trees when switching
to another branch by default, and it is unclear if we should turn off
these expected additions when --plumbing is seen.
