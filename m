From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCHv2 2/6] add metadata-cache infrastructure
Date: Wed, 13 Jul 2011 12:40:09 -0700
Message-ID: <7vei1u6kbq.fsf@alter.siamese.dyndns.org>
References: <20110713064709.GA18499@sigill.intra.peff.net>
 <20110713070405.GB18566@sigill.intra.peff.net>
 <CAKPyHN1FgK6NXqZFZ=OvMgouhfxnGF0aXU+--y-P1u9BcK9Z4A@mail.gmail.com>
 <20110713083139.GA26838@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Bert Wesarg <bert.wesarg@googlemail.com>, git@vger.kernel.org,
	Jakub Narebski <jnareb@gmail.com>, Ted Ts'o <tytso@mit.edu>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Clemens Buchacher <drizzd@aon.at>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jul 13 21:40:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qh5IB-0000sJ-J3
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jul 2011 21:40:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751195Ab1GMTkN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jul 2011 15:40:13 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:64480 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750877Ab1GMTkM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jul 2011 15:40:12 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9CB9C5F52;
	Wed, 13 Jul 2011 15:40:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zCp3NX+eIGcb+idVwB2+aGcUIfw=; b=aeJJsg
	Fs3kTiBP/wrGKKd+Y6lO+MYOvgiDklmKeHaXa9zXKnedmF6IcC+GN0YFMxZnbzNS
	lAjqATu946R8G0vlVDsrY6r3CF1Ld55H0GEgY+JKN9JryeXfZXk9q/MGJ68lBSmA
	1H5L+xBVpaCn1tB/4GQQvKcj3tqbYwrQ1rES0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ctbzhe3pTPGaNqkV8ndwnEbQvpv04cwr
	PhdaLzqegxwmoAvKcgRQnGY2d99FRD97KsyGVDJzcSTkFtsqfZEzwPbK/pKLsKzm
	qg94Qme6hLZsnYeKCsW4J23F8lAC2vXVQ58YAo7v5klEuhSHdjdBYXzViTfeCnWp
	LocCtXnD5xE=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 93A685F50;
	Wed, 13 Jul 2011 15:40:11 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id E19195F4F; Wed, 13 Jul 2011
 15:40:10 -0400 (EDT)
In-Reply-To: <20110713083139.GA26838@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 13 Jul 2011 04:31:39 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EBD0CAB6-AD87-11E0-82B3-B086C023C68D-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177073>

Jeff King <peff@peff.net> writes:

> I considered briefly that a zero-width cache might actually be useful
> for storing a membership list (i.e., "is this sha1 in the list or not").
> But then you have no way of distinguishing "not in the list" from "have
> no checked whether it should be in the list". You are probably better
> off storing a single byte flag in such cases.

Good reasoning; if you are going to add "BUG:zero width", the above is a
good comment to have nearby.

Thanks.
