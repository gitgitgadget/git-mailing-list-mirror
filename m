From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] git put: an alternative to add/reset/checkout
Date: Mon, 23 Jan 2012 10:10:57 -0800
Message-ID: <7vaa5e9tn2.fsf@alter.siamese.dyndns.org>
References: <20110607200659.GA6177@sigill.intra.peff.net>
 <CACsJy8BCGi3s8gXr4kk-u8tDWztV6ozg1Tap23Q=TxA5d9iL+g@mail.gmail.com>
 <CADo4Y9iH+J-X-TdqTN2Y9KhQnprnCVvC4Xy6qhVHwsBRmsZUrg@mail.gmail.com>
 <CACsJy8AB-6b_PMvyM7hRV3b=5o0Cn4CtosygUQOevTzVJhU=hg@mail.gmail.com>
 <CADo4Y9j5MwKr+rWza0ncLWuthY6x+s68CQYbY2+c8-E5pAa=Sw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Jeff King <peff@peff.net>, git@vger.kernel.org,
	Scott Chacon <schacon@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: mike@nahas.com
X-From: git-owner@vger.kernel.org Mon Jan 23 19:11:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RpOMF-0007mK-G4
	for gcvg-git-2@lo.gmane.org; Mon, 23 Jan 2012 19:11:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753251Ab2AWSLB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jan 2012 13:11:01 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47967 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750890Ab2AWSLA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jan 2012 13:11:00 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 730166AA3;
	Mon, 23 Jan 2012 13:10:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=u2PmPobJoQwm7Q3kmgXTbrPLn1M=; b=qmPmnk
	BXHmRd8zuVEXGcJ7c59HXDwKIRftj42O8gYINOwQ/TePkNtTZq1vuykD/+2RkW6i
	VjOJTBk3DxMD3cNGaVJZ6pHFvQ762Z9gSmeYOjpitwDcgSMueOwVs5eWzthntXn+
	6H5clcDU9+CbTd/0GQ9cbrXAAOyGOL482k77k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lNt/huKi2tO11WpSkXy9ik3usLYqdtPs
	7xS8hdQ94soc1QwfwqV64sTiiDxhnA5TgeG6cPoZuIVSIsLKzRU5AEogz4gaiiJK
	p0xFzrNkXFOcRUmEy1ZSuEodXSye8SVtQ0SX8cQE/jhYhCISvHG9fIhoYq5BMYTD
	gu88eariuoc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6890E6AA2;
	Mon, 23 Jan 2012 13:10:59 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CA9BA6AA1; Mon, 23 Jan 2012
 13:10:58 -0500 (EST)
In-Reply-To: <CADo4Y9j5MwKr+rWza0ncLWuthY6x+s68CQYbY2+c8-E5pAa=Sw@mail.gmail.com> (Michael
 Nahas's message of "Mon, 23 Jan 2012 09:56:37 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 99D7C620-45ED-11E1-8C5A-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189003>

Michael Nahas <mike.nahas@gmail.com> writes:

> It obviously isn't the design-first-then-find-a-willing-programmer of
> the project I ran. I don't know if it's the IETF's "running code and
> a general consensus".

These two are not necessarily incompatible.

A proposed new feature needs to be explained well, describing in what
situation it will help what kind of users and without hurting others and
why it is a worthy addition.

We require a general consensus that any proposed change is a worthy
addition, and a working code is often a good addition to help us reaching
one, because people can guess what is being proposed even when the idea is
presented poorly. A poorly presented idea without working code often fares
no better than just a handwaving with crazy talk, as you fail to make
others realize what you are trying to achieve.

But working code is not a requirement to present good ideas. It just helps
to add clarity to it.
