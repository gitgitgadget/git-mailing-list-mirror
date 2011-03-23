From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Weird behavior of shell variables in git aliases
Date: Tue, 22 Mar 2011 20:01:25 -0700
Message-ID: <7vmxkmilq2.fsf@alter.siamese.dyndns.org>
References: <d9c38309-c433-476c-bba3-f2c5b7e94a89@k15g2000prk.googlegroups.com>
 <20110321215310.GA2122@sigill.intra.peff.net>
 <7v8vw8nmh2.fsf@alter.siamese.dyndns.org>
 <7v4o6wnlxm.fsf@alter.siamese.dyndns.org>
 <20110322111844.GA32446@sigill.intra.peff.net>
 <20110322132820.GA14559@sigill.intra.peff.net>
 <AANLkTin3fXkGaC5cTVny5adU=FusQV0WAcPHLUEeEzLi@mail.gmail.com>
 <20110322134358.GA19064@sigill.intra.peff.net>
 <7vfwqfkphn.fsf@alter.siamese.dyndns.org>
 <20110322183201.GA22534@sigill.intra.peff.net>
 <AANLkTinvP1TvhNBsN+Y3wyhzg+qampa6J=3NMfwr76a=@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Erik Faye-Lund <kusmabite@gmail.com>,
	Dun Peal <dunpealer@gmail.com>, git@vger.kernel.org
To: Lasse Makholm <lasse.makholm@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 23 04:01:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q2EKS-0002HH-UD
	for gcvg-git-2@lo.gmane.org; Wed, 23 Mar 2011 04:01:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754266Ab1CWDBn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Mar 2011 23:01:43 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:54523 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751639Ab1CWDBm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Mar 2011 23:01:42 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9D2304676;
	Tue, 22 Mar 2011 23:03:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jPSJGimyQfbClSx4k0oX3G1cMjk=; b=nYmtcN
	0Q+O9sMF8Fn5wgJlcTpZsFzbVfQvR66V6CMQ+G4UM3YhQoxUfB/rJmAxUkRIKEbA
	l8HawgfueP/iUOE/cIpPGzvJbx9xHWJFaL9H5Z/lXBjrnbC1Vs1oxhNo69HV68zp
	s0OVUPuc9Vp6xiGmZu6h2L0qz6T35wbUDeF7g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FwFOuimDzg1LH1sCn1gRv+f8c/fuX6Rm
	hdlx8Wv2/IOjqEUJpv1pekTcVAVD0c6Mlco0EPFRbsgYsOGG2MNjTffZF6I//5Nt
	yuF9Pdy8EuxF/A6XsluwHPHerQBKp4VUsB7A2AWtb/vWx7wes4/QEeO8dkxakKSz
	yDg62RS9vQM=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 4CD184671;
	Tue, 22 Mar 2011 23:03:15 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 36CD1466E; Tue, 22 Mar 2011
 23:03:06 -0400 (EDT)
In-Reply-To: <AANLkTinvP1TvhNBsN+Y3wyhzg+qampa6J=3NMfwr76a=@mail.gmail.com>
 (Lasse Makholm's message of "Tue, 22 Mar 2011 23:22:04 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 188D5AC4-54FA-11E0-A7D5-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169795>

Lasse Makholm <lasse.makholm@gmail.com> writes:

> Whlie we're at it, is "sh -c ... -" and "sh -c ... --" equally
> portable, I wonder?

I suspect anything would work, but it is customary to pass the dummy $0 by
writing "-" there.  People who breathe shells would be able to recognize
the idiom more easily if you stick to that well-known form.
