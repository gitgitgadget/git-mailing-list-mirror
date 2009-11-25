From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] grep: --full-tree
Date: Wed, 25 Nov 2009 14:21:47 -0800
Message-ID: <7vljhuqm84.fsf@alter.siamese.dyndns.org>
References: <7vk4xggv27.fsf@alter.siamese.dyndns.org>
 <20091125203922.GA18487@coredump.intra.peff.net>
 <7viqcytjic.fsf@alter.siamese.dyndns.org>
 <20091125210034.GC18487@coredump.intra.peff.net>
 <7vmy2as319.fsf@alter.siamese.dyndns.org> <4B0DAC9F.2010205@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: gitzilla@gmail.com
X-From: git-owner@vger.kernel.org Wed Nov 25 23:22:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDQFP-0004hz-Og
	for gcvg-git-2@lo.gmane.org; Wed, 25 Nov 2009 23:22:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755174AbZKYWVv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Nov 2009 17:21:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754445AbZKYWVv
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Nov 2009 17:21:51 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:34281 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754000AbZKYWVv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Nov 2009 17:21:51 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 06FFCA1F05;
	Wed, 25 Nov 2009 17:21:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=j1h2/e1EbZ1qUQNgLESfHjRHuPM=; b=DCkiGi
	06FBnxp4B2FSB26/olgJ9AlMbCUWYFfidXKAuS9VmQ0eMA6zxMltZpQ16oaChCTv
	MON/H1TsHQwOrG8h49vy1Iu3aSV7vQaN0ooVOK0e3+NMK9YD1R04/t0Chp1z38D/
	P25TjvmGxylJXs1CDpcoiPsF40250xLKXxPs0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MYBU0nrlzVnBljfAEx2HA/wN575CoQCv
	nv/EjnxHApfHrZCN/ihvf5WCrWbEyu9OnrkegEPiMxjyx1qLtQ270lASS13YchQ9
	WXwgieUmA+F99mhzm4au6HZ63eMNZOtBlTrklj1ji7c34Rd0GOzskj0pbI2K2lLV
	Dq9lYm2d6Gw=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id CA7C2A1F04;
	Wed, 25 Nov 2009 17:21:53 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 938D7A1F03; Wed, 25 Nov 2009
 17:21:49 -0500 (EST)
In-Reply-To: <4B0DAC9F.2010205@gmail.com> (A. Large Angry's message of "Wed\,
 25 Nov 2009 17\:15\:59 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: EF5CA1F6-DA10-11DE-AE6D-EF34BBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133685>

A Large Angry SCM <gitzilla@gmail.com> writes:

> To make the reconciliation  even more difficult, some git commands
> will also work on out-of-tree paths.

I think people know my feeling towards "diff --no-index".  It makes many
nice features invented in git to people who do not use "git" (e.g, to
compare files outside of control of git using --color-words).  If it
happened in an ideal world, it wouldn't have been done as a patch to "git"
but to something like "GNU diff" to benefit people who do not even want to
install "git".  But unfortunately that wasn't the way it was done.

It has turned out to be an unnecessary maintenance burden ever since it
was applied and every time we needed to change small things to "git diff".
I would not be very unhappy if we need to ejected it from "git diff" if it
turns out to hinder the necessary UI changes too much.
