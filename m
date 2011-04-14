From: Junio C Hamano <gitster@pobox.com>
Subject: Re: textconv not invoked when viewing merge commit
Date: Thu, 14 Apr 2011 12:26:18 -0700
Message-ID: <7vipughbxh.fsf@alter.siamese.dyndns.org>
References: <201104111912.47547.kumbayo84@arcor.de>
 <4DA415AB.9020008@drmicha.warpmail.net>
 <20110414190901.GA1184@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Peter Oberndorfer <kumbayo84@arcor.de>,
	Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 14 21:26:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QASBj-0005Xe-OR
	for gcvg-git-2@lo.gmane.org; Thu, 14 Apr 2011 21:26:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934002Ab1DNT0e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Apr 2011 15:26:34 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:64089 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932180Ab1DNT0c (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Apr 2011 15:26:32 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1F51B4857;
	Thu, 14 Apr 2011 15:28:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Ay7VSI30v2AUbxaJflR2hybOd3g=; b=VS5Crq
	Q8J/zDDpdsWBxbmn30AukEN+Gu0v2JST7dHjDepPRUdRG+RPANQbMzJ16tD/xNnZ
	NsscHp71q5G88UNDKc8m3t49SyOXuYrHMa9U/dOl9m2sJovJ+VZSPh2TTtVhIL3o
	La5WNRvdJPA7afXxXqwborSRnSGORUENRPQJw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wME/MqivUqUyEZJbgddPd0L5FsVwyvNa
	cDWtMndF7uN5cDygJpoXSW232SVO2RT1IrLwJnT4tgmRro7DFU7naAhr2u8Z8zSz
	HJTzo8OcyWR6laUzCQVlLMB2Uace6uERnK/nOiFvqyPUPCHy3e4GVdk8W2iO+j6p
	rGRddQAwoAg=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D35B84855;
	Thu, 14 Apr 2011 15:28:24 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 8FB534853; Thu, 14 Apr 2011
 15:28:19 -0400 (EDT)
In-Reply-To: <20110414190901.GA1184@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 14 Apr 2011 15:09:01 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5DB73FB8-66CD-11E0-9218-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171537>

Jeff King <peff@peff.net> writes:

> We just dump the binary goo all over the terminal. So I think the whole
> combined-diff code path needs to learn how to handle binaries properly.

How would you show multi-way diffs for binary files?

It would probably be sufficient to say "binary files differ" at the
beginning of the patch-combining codepath of the combined diff, which
would at least keep the --raw -c/--cc output working.
