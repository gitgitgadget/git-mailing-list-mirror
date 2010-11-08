From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] attr: support quoting pathname patterns in C style
Date: Mon, 08 Nov 2010 10:40:21 -0800
Message-ID: <7v8w13r756.fsf@alter.siamese.dyndns.org>
References: <AANLkTinNctmWpshBeSTzZRm6+EJ=Cjdpoaj4Aon+52_b@mail.gmail.com>
 <1288878944-14066-1-git-send-email-pclouds@gmail.com>
 <7vvd4bu2pl.fsf@alter.siamese.dyndns.org>
 <15C4C111-824D-4657-B034-A1BE1DAD50D4@sb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org, Marc Strapetz <marc.strapetz@syntevo.com>
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Mon Nov 08 19:40:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PFWe0-0001zQ-45
	for gcvg-git-2@lo.gmane.org; Mon, 08 Nov 2010 19:40:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754875Ab0KHSke (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Nov 2010 13:40:34 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:60653 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752720Ab0KHSkd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Nov 2010 13:40:33 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E688030F8;
	Mon,  8 Nov 2010 13:40:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KwGdUDrIb1qYFUj/N6JKr76tKrs=; b=KzKLGG
	S5gZUW2rMWxbkZSyhpqS90xprG13zlbRoSTh/4vdp7qT6gbsIx70tqNpHtgxKME3
	2MgMZ68P728i5HYNGdl3kyWSsoZFkl+oZPBnUB1+lG1f+QYMDGTR2P1nlt0GB55e
	OEI7qZpgjXw4wVvlI4/vHm50ha/FWTmeKcaCU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IpUvAyobnN3MWk35GIsw4P9rk6SyF2it
	/chxWnSBkKc+hQFhA7oZeB3g444RlklmIWKW8kdE0Z0Qpwlgnhxg6YF090qcnAwW
	37egcpL/aXPPapkQFKJr2igO9zU+Avx3fDliaYJkHUb0r0LCmA+hWJPFqHAMTALW
	CPMWbtOcjGc=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A642D30F7;
	Mon,  8 Nov 2010 13:40:31 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 5C2C330F3; Mon,  8 Nov 2010
 13:40:26 -0500 (EST)
In-Reply-To: <15C4C111-824D-4657-B034-A1BE1DAD50D4@sb.org> (Kevin Ballard's
 message of "Fri\, 5 Nov 2010 14\:46\:32 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: AA5746E2-EB67-11DF-8D67-B53272ABC92C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160968>

Kevin Ballard <kevin@sb.org> writes:

> Would this actually break any existing setups? The only ones that are affected
> are ones beginning with ", which I imagine would be rather rare.

No regression policy means just that.  We try not to break "rather rare"
people, only to add support for different kinds of "rather rare" setups,
especially when the latter have working workarounds.
