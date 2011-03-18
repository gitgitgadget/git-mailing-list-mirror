From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFD 0/2] revision.c: --merges, --no-merges and
 --merges-only
Date: Fri, 18 Mar 2011 01:22:20 -0700
Message-ID: <7vbp18yh1f.fsf@alter.siamese.dyndns.org>
References: <cover.1300359256.git.git@drmicha.warpmail.net>
 <20110317195905.GG20508@sigill.intra.peff.net>
 <4D831043.1060709@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Mar 18 09:22:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0UxE-0001IM-WC
	for gcvg-git-2@lo.gmane.org; Fri, 18 Mar 2011 09:22:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753268Ab1CRIWg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Mar 2011 04:22:36 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:61179 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750996Ab1CRIWc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Mar 2011 04:22:32 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E7A6329E1;
	Fri, 18 Mar 2011 04:24:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jXTQ2bL8qdHzweYoieRDNRcef1w=; b=A2TMd7
	wCyT3+ub91FNZupVWGQv5QfFtT5DvrT1MTDNGMKZTJZdY7kzOsuIYzgAzOvHrc51
	MU00m8iDmk7D25kyw9Fk7kMKeBTIlDWgAkrY1a23ERhP7SjYECAaE6nlsdRJwukW
	4VK/w30AG6+HAdDInhDvvfsPiALp5IOqOWaqs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=edLMpEXd2R1MRZmY3ZSmjJsqry6RBIFL
	Veij9RWME8vvAY303dT5JoZk5S66q3PIIV2I6BZIp6jattMtFeAF5vCTv7Yl5hZC
	tJe48MQ976rrea7BLuvI4NSBrjOMQfoA3h3QRpRAyaz07Mbfh7orzZ0Rt37XFmkr
	b9XsIKhQgfs=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9C03B29E0;
	Fri, 18 Mar 2011 04:24:00 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 9142329DF; Fri, 18 Mar 2011
 04:23:56 -0400 (EDT)
In-Reply-To: <4D831043.1060709@drmicha.warpmail.net> (Michael J. Gruber's
 message of "Fri, 18 Mar 2011 08:56:51 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 13A3A4A6-5139-11E0-BF0D-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169301>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> From the ui perspective I'm somehow not a big fan of tri-state options
> but can't give hard reasons why; maybe because they force you to use
> option arguments.

But in this particular case, you cannot really hack it with two options
that appear independent on surface but in reality are not. Logically, it
is an enum <everything, non-merges, merges-only> and you can choose only
one of them, and it is even worse from the UI perspective to use
combination of two not-quite-independent options.

Also I have a hidden agenda to add "because we could" --show=octopus to
the enum later perhaps only to my private edition ;-)
