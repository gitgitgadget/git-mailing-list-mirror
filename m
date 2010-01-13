From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] grep: -L should show empty files
Date: Wed, 13 Jan 2010 11:48:38 -0800
Message-ID: <7viqb5n5ux.fsf@alter.siamese.dyndns.org>
References: <7vtyv4cpna.fsf@alter.siamese.dyndns.org>
 <7vvdf9402f.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.1001110739280.13040@localhost.localdomain>
 <alpine.LFD.2.00.1001110748560.13040@localhost.localdomain>
 <7vtyusr4r7.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.1001110830070.13040@localhost.localdomain>
 <7v63774tfd.fsf@alter.siamese.dyndns.org>
 <7vvdf73eql.fsf_-_@alter.siamese.dyndns.org>
 <fabb9a1e1001121327s392f7311t2a7f11081ed70ff8@mail.gmail.com>
 <7vpr5esdbp.fsf@alter.siamese.dyndns.org>
 <fabb9a1e1001130804s4716587l57d56884b5d0d068@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Miles Bader <miles@gnu.org>, Jeff King <peff@peff.net>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 13 20:48:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NV9D8-0002vx-47
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jan 2010 20:48:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754627Ab0AMTsz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2010 14:48:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754159Ab0AMTsy
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jan 2010 14:48:54 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:40544 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753781Ab0AMTsy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2010 14:48:54 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 95D0D909F2;
	Wed, 13 Jan 2010 14:48:53 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=g5cokfyRg2uBSR/PlSZUi2Pzu3Y=; b=ToOd4fH8xwlwMhsnGRvb1eB
	MpwqdLOsOwNT7kiOKV/SO6lHAe82FKo7EdZJ33B2Kh/vCpILGNYHyRvZNHNp6r9e
	XvSCccKYTLl4u6/P7xRF3vBdE+y+Z7s1bVFB/P4ZBj8OvtEqV3e8CB3AsA7f3oZB
	A0EwZJQ8U3gSom3pRwLE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=eJda6Pmu/BfSlxOsRqZ7Z8axz0224xmtUg5BSx8+F9zTfIMED
	UO1SqvAU8C5xOX+irpVh3HqfUqkD74nXkT7RsNJoNAYXUs/rHnIc8sT4m9f2vLdq
	GSAVOdJYZPeooB3OAeaXoB9zEtqSyVFoAnWRyQObsNwGgceJmnoxTWpd+I=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 32F8F909EC;
	Wed, 13 Jan 2010 14:48:47 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0F5AA909EB; Wed, 13 Jan
 2010 14:48:39 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A9F58CC6-007C-11DF-B44B-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136865>

Sverre Rabbelier <srabbelier@gmail.com> writes:

> I'm not that familiar with the code, but wouldn't it be possible to
> keep the early abort, but make it dependent on not using the '-L'
> flag?

Anything codable is possible to code, but my point was I don't think such
an optimization to avoid reading empty files is worth the time to write
and maintain extra code necessary for it.
