From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 08/10] remote-hg: update bookmarks when pulling
Date: Tue, 14 May 2013 16:32:14 -0700
Message-ID: <7vmwrxdtoh.fsf@alter.siamese.dyndns.org>
References: <1368486720-2716-1-git-send-email-felipe.contreras@gmail.com>
	<1368486720-2716-9-git-send-email-felipe.contreras@gmail.com>
	<51929dfa8122e_13a8f89e182115@nysa.mail>
	<7vzjvxfck2.fsf@alter.siamese.dyndns.org>
	<CAMP44s0Wd4VEc_mwr=xguVAnXvn+YVz24u8eS4Nyy0HCjwJ+dw@mail.gmail.com>
	<7vbo8dfbbr.fsf@alter.siamese.dyndns.org>
	<CAMP44s0u0WPNneM-GoiqCkWTC-CT_Xa2z3on=smRiFJdd9ffeQ@mail.gmail.com>
	<7v38tpfa7u.fsf@alter.siamese.dyndns.org>
	<CAMP44s32KkJY3OxifDEmqp0ZkhQiRQCVwxYvSNGgqTnwC3DLEw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 15 01:32:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UcOhh-0003R4-6U
	for gcvg-git-2@plane.gmane.org; Wed, 15 May 2013 01:32:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758615Ab3ENXcR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 May 2013 19:32:17 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51188 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758538Ab3ENXcQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 May 2013 19:32:16 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 26DBF1F072;
	Tue, 14 May 2013 23:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1GRGVyMYXqyNCGuX1t/EVPL2SK8=; b=Myaxpn
	4OVeftHGM54rCLldYsKdegJRbTVvedPKSBTLrTLsdsi0oe/5Fk/hCDPYXla7W+T/
	YRduatIn9E7Cl9Lkio6yc3GwnhrmeAzom6engE4pVPOfcip9HWsPDbdBG+vUGFus
	lg8rqhX2y4P+Y8bQvuTjnjBVVZhGmh0GNZH1w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=prO9ir4Hi8CxBjTNE0HLevAizZg2Kt4V
	HRS3ywCtjvoHEuHRRgGBhCpIsGxD+U215ZdtKl8ZSYUf6g9dfvuadoB6L0ZHEaL4
	VBZDUNhCNKv7tpRYMZw8xZj3ivzbmx46qPW0JUdBE0JYM0T9VRyYScFAvfpQvYqb
	uMBpNiv/+YI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1E7D01F071;
	Tue, 14 May 2013 23:32:16 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 99A8C1F06D;
	Tue, 14 May 2013 23:32:15 +0000 (UTC)
In-Reply-To: <CAMP44s32KkJY3OxifDEmqp0ZkhQiRQCVwxYvSNGgqTnwC3DLEw@mail.gmail.com>
	(Felipe Contreras's message of "Tue, 14 May 2013 18:11:51 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 82BFFFB0-BCEE-11E2-86F4-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224371>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> ... After all, this is in the contrib area,
> so if there's a time for a possible future maintainer of a core part
> of git to make mistakes, it would be now.

That sounds reasonable.

Incidentally, before I had to stop working in order to respond to
your endless arguments, I already queued the 8 patches to 'master'
(also remote-bzr one is in below that).

I had no time checking other topics in flight nor merging the result
up to 'next' and 'pu' yet, and it will take a while for the result
to be published, but we'll see these in 1.8.3.
