From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] perf: compare diff algorithms
Date: Tue, 06 Mar 2012 11:52:47 -0800
Message-ID: <7vhay1se0g.fsf@alter.siamese.dyndns.org>
References: <87pqcp6fyh.fsf@thomas.inf.ethz.ch>
 <f113867bcf2fec3210cd1a997e1398903b3bdd76.1331039505.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>, Michal Privoznik <mprivozn@redhat.com>,
	Jeff King <peff@peff.net>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Mar 06 20:53:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S50Rb-0000TD-03
	for gcvg-git-2@plane.gmane.org; Tue, 06 Mar 2012 20:53:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965252Ab2CFTwu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Mar 2012 14:52:50 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53675 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965234Ab2CFTwt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Mar 2012 14:52:49 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4C434661D;
	Tue,  6 Mar 2012 14:52:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+OqTn7qX7wpZkkCM8A2fCIB6+IQ=; b=lmt6eH
	10Qs/Q3dvhOiZdj47gcaqLgrYN12Yngi2aPKPNXhV0UcaJ+T6o6v3/boVvQ7NrXo
	eFjm4iFEz7RuvMGNFUvl81crZzTX0yvrqvdcimmyyTUrrpNET7OR/Mmh8shXzUXD
	nn69aQ1UZnv5YSt+Yxo075Yko1Eg/Ag6tYEYY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hXwptsggfWsTo0zKOYwetPGxrQo7eBdx
	lqq9BitdrLtkyfawsahCfM0d8apPMr3mkZkURMdr49hRL+hTkJr3T/zMjLDnsYDG
	AMs3K9E2NXX03wyIORMhco8vx24LjyPZPrM9Ff+2fDIcXLOPqVlERXu0HtbwiZPJ
	yl6ny1VI59w=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4408D661C;
	Tue,  6 Mar 2012 14:52:49 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C4226661B; Tue,  6 Mar 2012
 14:52:48 -0500 (EST)
In-Reply-To: <f113867bcf2fec3210cd1a997e1398903b3bdd76.1331039505.git.trast@student.ethz.ch> (Thomas Rast's message of "Tue, 6 Mar 2012 14:15:01 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F36E6384-67C5-11E1-B43C-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192382>

Thomas Rast <trast@student.ethz.ch> writes:

> 8c912ee (teach --histogram to diff, 2011-07-12) claimed histogram diff
> was faster than both Myers and patience.
>
> We have since incorporated a performance testing framework, so add a
> test that compares the various diff tasks performed in a real 'log -p'
> workload.  This does indeed show that histogram diff slightly beats
> Myers, while patience is much slower than the others.
>
> Signed-off-by: Thomas Rast <trast@student.ethz.ch>
> ---

Fun.

I am getting this (probably unrelated to this patch), by the way:

$ make perf
make -C t/perf/ all
make[1]: Entering directory `/srv/project/git/git.git/t/perf'
rm -rf test-results
./run
...
perf 4 - grep --cached, expensive regex: 1 2 3 ok
# passed all 4 test(s)
1..4
Can't locate Git.pm in @INC (@INC contains: /etc/perl ...) at ./aggregate.perl line 5.
BEGIN failed--compilation aborted at ./aggregate.perl line 5.
