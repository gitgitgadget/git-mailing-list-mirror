From: Junio C Hamano <gitster@pobox.com>
Subject: Re: rebase -p loses amended changes
Date: Wed, 04 Apr 2012 15:59:40 -0700
Message-ID: <7vlimb6r37.fsf@alter.siamese.dyndns.org>
References: <592E2EEC-6CBA-48D6-8D44-34A971DD78EC@gmail.com>
 <CAH3Anrqorf481jw6GdHqOPg9WC0rD-OraOHZ7twWRF4+oJ9X4A@mail.gmail.com>
 <87fwcpun95.fsf@thomas.inf.ethz.ch>
 <CAH3AnrpasFU2bLEZsAXRQu4U+=R_YyW+-yRXDfzy2JQpqf9dNw@mail.gmail.com>
 <CADb3U=4Y0njLiYC1qrYbdm+h0h8vLh78yfz_u3B6veEqCX0xCQ@mail.gmail.com>
 <CAH3Anrq_Z0V=DpU1iH-A3F8RFWTG0_C1hEe3iDZYe=AYDTRT3g@mail.gmail.com>
 <CABURp0pnXvnT2=fDJXk-yiGctsJBHiNGSCOZiT4Vo74woi0Zxg@mail.gmail.com>
 <4F7BEA9F.3060805@viscovery.net> <7vpqbna0cd.fsf@alter.siamese.dyndns.org>
 <7viphf8cqh.fsf@alter.siamese.dyndns.org>
 <CAH3AnrrE9Fbs_p_=ETRns4vyz8J879-m+KDF5K4j7vDdTh9bEg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Phil Hord <phil.hord@gmail.com>,
	J Robert Ray <jrobertray@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 05 00:59:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SFZB7-0003BR-JC
	for gcvg-git-2@plane.gmane.org; Thu, 05 Apr 2012 00:59:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932399Ab2DDW7o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Apr 2012 18:59:44 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40282 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757355Ab2DDW7n (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Apr 2012 18:59:43 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CE08E4D08;
	Wed,  4 Apr 2012 18:59:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mGrfT0/flFBXJpE+yMMQlhiVQmU=; b=Vn9LDY
	G1z4hxEVPIfbRf16ipzu0WXDpAWulus8VvKClbyM/jiZwA3fJKfhvYU54TemxXt0
	FDWnzHRi/ugtiMraSjOSTESKcz/wLI0eYo3l8+NRHjMl+qNgWVtRn2/Zw1zJZ3Qw
	o3qzULy2ChWFG77bOuuNN7Hm0eXvsbVqk2s2k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YTehzdSG/OgjK/+JwX3eSWig4dgwrbwK
	kIkWqUF5By7PTn7TCg2MkA7+eqjr8hYecBXtq9GlGlSmP1LfUFC1ZvSMuhJcHBDt
	Xveb7ER5BNrDTw+m1RuelfCzPODagDT/gFJmhuBrQBtJFsRpeiYeVsEt+Nf/97xL
	sknyPzOjuU0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C58AB4D07;
	Wed,  4 Apr 2012 18:59:42 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 560F44D06; Wed,  4 Apr 2012
 18:59:42 -0400 (EDT)
In-Reply-To: <CAH3AnrrE9Fbs_p_=ETRns4vyz8J879-m+KDF5K4j7vDdTh9bEg@mail.gmail.com> (Jon
 Seymour's message of "Thu, 5 Apr 2012 08:55:30 +1000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DD37C31C-7EA9-11E1-9B77-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194752>

Jon Seymour <jon.seymour@gmail.com> writes:

> Are there any flaws, I wonder?

It all depends on how close the base is to M^1.  The difference might make
it unnecessary (or even more necessary) to do any evil merge.
