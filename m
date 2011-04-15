From: Junio C Hamano <gitster@pobox.com>
Subject: Re: textconv not invoked when viewing merge commit
Date: Fri, 15 Apr 2011 13:45:35 -0700
Message-ID: <7v7havckgg.fsf@alter.siamese.dyndns.org>
References: <201104111912.47547.kumbayo84@arcor.de>
 <4DA415AB.9020008@drmicha.warpmail.net>
 <20110414190901.GA1184@sigill.intra.peff.net>
 <7vipughbxh.fsf@alter.siamese.dyndns.org>
 <7vd3kohb5n.fsf@alter.siamese.dyndns.org>
 <7v8vvcha2s.fsf@alter.siamese.dyndns.org>
 <20110414202356.GB6525@sigill.intra.peff.net>
 <vpq62qg3sxy.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Peter Oberndorfer <kumbayo84@arcor.de>,
	Git List <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Apr 15 22:46:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QAptx-0001gX-BX
	for gcvg-git-2@lo.gmane.org; Fri, 15 Apr 2011 22:46:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755245Ab1DOUpw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Apr 2011 16:45:52 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:38879 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750776Ab1DOUpv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Apr 2011 16:45:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9DE684A1D;
	Fri, 15 Apr 2011 16:47:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=UL2+oxPIVjqZ9izrlostEkG3zJE=; b=OimBKV
	SlB5Tp8aXSrSAp6znnChUth9FY3nigCZnP4fTkzY5716hX4JpdVCDPxRKWsRekmy
	NmKxoVCMpqiD9Rk/k0/0DwEAJ+h8ONGKEx7JlB0nuu5X3uP4DbT3zL+tjXqtnGpX
	dClbylv/4FbGqUvvHIT2g7/68SKEDkm+hD3zE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HA0mAAvlB010a03YJaWqA318XDuLGh1m
	uhVb7n1ahDXYf78DKxvxJyqJqDqQoWgeAOQVY9RdBPVsoRBaTnnQvkdh1TL8b4QA
	aCeANSWaERwHEg+L/5ZtdzdOcs1IyIdn3WrN1E0IHkyGkfFptj2Qkbl+V/z+kxHC
	Q7tnCnuoc5g=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 4C8164A17;
	Fri, 15 Apr 2011 16:47:42 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id CAE8E4A0F; Fri, 15 Apr 2011
 16:47:35 -0400 (EDT)
In-Reply-To: <vpq62qg3sxy.fsf@bauges.imag.fr> (Matthieu Moy's message of
 "Fri, 15 Apr 2011 08:54:49 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9BCBD190-67A1-11E0-BD1A-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171641>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

>> I can't think of a case where it matters, though, so maybe it is just
>> paranoia.
>
> A line-counting, statistics tool would think that 1 line has been
> removed from both branches, and one new added by the merge.
>
> Well, I know no tool parsing combined diff actually, so it's indeed a
> hypothetical case.

And the ones that have been parsing cdiff wouldn't have done anything good
before this change on such a binary blob anyway, no?
