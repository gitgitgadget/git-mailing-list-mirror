From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] blame: accept multiple -L ranges
Date: Mon, 22 Jul 2013 14:34:34 -0700
Message-ID: <7va9lecm8l.fsf@alter.siamese.dyndns.org>
References: <1373186706-19284-1-git-send-email-sunshine@sunshineco.com>
	<7vk3l26695.fsf@alter.siamese.dyndns.org>
	<CAPig+cQ9sfV+PRqn5vrL0=xOZrKDDmsKdAPiB4PsCFb=jnk4kQ@mail.gmail.com>
	<7v38rnwuvb.fsf@alter.siamese.dyndns.org>
	<87ehb7d3za.fsf@hexa.v.cablecom.net>
	<CAPig+cT9U7L-03Fe5YLft=WS2EZY1B_BhLzkM_sT_3wQQ1g1MQ@mail.gmail.com>
	<7vy59fv9zr.fsf@alter.siamese.dyndns.org>
	<87a9lvcztv.fsf@hexa.v.cablecom.net>
	<7vppurv8bl.fsf@alter.siamese.dyndns.org>
	<51DC6B37.9030108@alum.mit.edu>
	<7vli5fv5ud.fsf@alter.siamese.dyndns.org>
	<CAPig+cTh2t_Rc13U_F-prmm=sjs2OEHX5AX2DbC5DH+Tx_E5jg@mail.gmail.com>
	<87r4er2ct4.fsf@linux-k42r.v.cablecom.net>
	<7vr4eqcxub.fsf@alter.siamese.dyndns.org>
	<87bo5uqu6i.fsf@linux-k42r.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Git List <git@vger.kernel.org>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Jul 22 23:34:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V1Nkg-0002bd-Hk
	for gcvg-git-2@plane.gmane.org; Mon, 22 Jul 2013 23:34:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932703Ab3GVVei (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Jul 2013 17:34:38 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43360 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932388Ab3GVVeh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jul 2013 17:34:37 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0A44A32B50;
	Mon, 22 Jul 2013 21:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gyQ5q0LCxfzCGqpcqRSUl5B6iRM=; b=TczgyG
	e8d0UTjSSSDG0xsX/ZkzmdFHqwG2yFTkiuwfZJ8NFHvtJ3Q1Cv5c836Fc5oDmf9D
	LYmjwn9zD1fyIcuICQou3GkE4ize3OGjFxIfvURohgcyn8Z2oh/kt/nEpULB4T5E
	AUS+3UrHnl5tEZoGEMFXk9FqA0QigAKFVB1Gw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AVC2zQYxNm6ObitZeuabiEJM2zItUNOW
	koJ/lj1+LfZZ5xSsb4nrBxf6WuxMIbTuyZMmWDHOWUrtcHZ2wJFAO1GaAuibT6mX
	2m7DBP6RgmyJkU6uUg7IjZey6cTOCmrbazDeeMb65KQDEhNDq7SLwx9Uju7RrEDA
	eJ4RdMCYQkg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F1C2032B4F;
	Mon, 22 Jul 2013 21:34:36 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4FE5F32B4E;
	Mon, 22 Jul 2013 21:34:36 +0000 (UTC)
In-Reply-To: <87bo5uqu6i.fsf@linux-k42r.v.cablecom.net> (Thomas Rast's message
	of "Mon, 22 Jul 2013 21:19:17 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8194DCA6-F316-11E2-92AF-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230993>

Thomas Rast <trast@inf.ethz.ch> writes:

> I'll just leave it at that and let you decide what to do (presumably go
> ahead as you already outlined).  I've never actually ever used multiple
> -L in the same log/blame invocation, anyway.

Nobody has ;-).

It is just between my "I often wished while looking at 'less foo.c'
I wanted to give more than on -L to cover two ranges I see in the
file" and your "I do not know if the user can give the first -L to
cover the first range and the second -L to cover the second range".
I do not think neither of us successfully gave more than one -L and
got any useful result.
