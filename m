From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/largely untested/PATCH] sha1_name: interpret ~n as HEAD~n
Date: Fri, 29 Apr 2011 22:33:55 -0700
Message-ID: <7vfwp0uwu4.fsf@alter.siamese.dyndns.org>
References: <6c53916752bf79178113157291fd675ead0804c9.1304092338.git.git@drmicha.warpmail.net> <20110429223433.GA3434@sigill.intra.peff.net> <m2k4ecy6rv.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	git@vger.kernel.org
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Sat Apr 30 07:34:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QG2ow-0000Mb-OV
	for gcvg-git-2@lo.gmane.org; Sat, 30 Apr 2011 07:34:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754850Ab1D3FeP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Apr 2011 01:34:15 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:43836 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754504Ab1D3FeK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Apr 2011 01:34:10 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D83F54E6D;
	Sat, 30 Apr 2011 01:36:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vTmvjEi9BArY5P4nPEup83CFSOs=; b=RBCvMT
	Lo6RPCbkVEqgwlMbJxk7kei2qDhtBdtfYFixcEBuqbSJ4MWk5tLWRYT+Nx7TzKB9
	PMQeahVZ8b7Ikem8nTbrF8ySQNO9PAls1IfJT/al55mgb77U7mAZfJ1tcRw7j9Cv
	jOS+WWUVqSyFQcdmQDjr4R6nZKyY7Tszwqy9U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=i4u2+IDaRMirdQkSs4UqgkZPx+6t/SwC
	mPvZycxMUvtqk+2fCfXQ1jN/+2S2R9saTvEyAY7qt6gQ6qm824ZAsWKeQK1SMGk3
	HHEPNsfmsEV9YZB2nHTmw4ahuPg/qS4QmyhyjDzS6atIxq1gwnQQRFkQJI1nkXmI
	An2MVlb3w+c=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 94EFA4E6A;
	Sat, 30 Apr 2011 01:36:06 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 4D96F4E67; Sat, 30 Apr 2011
 01:36:01 -0400 (EDT)
In-Reply-To: <m2k4ecy6rv.fsf@igel.home> (Andreas Schwab's message of "Sat, 30
 Apr 2011 01:31:00 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BED02510-72EB-11E0-A5DE-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172517>

Andreas Schwab <schwab@linux-m68k.org> writes:

> Jeff King <peff@peff.net> writes:
>
>> It also conflicts a little with the shell's "~user" syntax, though
>> presumably you don't have users named "1" and "2".
>
> Well, you sorta do if you did use pushd.

Yeah, I was also worried about that.  Or some arcane system
misinterpreting "~0" as the home directory of root ;-)
