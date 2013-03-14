From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFD] Combine diff improvements
Date: Thu, 14 Mar 2013 15:52:17 -0700
Message-ID: <7vfvzxwq5a.fsf@alter.siamese.dyndns.org>
References: <CALWbr2zY3uo==QTd69t1eXNS4-CX1w3T-AaMjOLVmxj-SMJyvg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Antoine Pelisse <apelisse@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 14 23:52:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UGH0x-0003BL-Td
	for gcvg-git-2@plane.gmane.org; Thu, 14 Mar 2013 23:52:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753268Ab3CNWwU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Mar 2013 18:52:20 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64739 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753068Ab3CNWwT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Mar 2013 18:52:19 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 52A93B27F;
	Thu, 14 Mar 2013 18:52:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=txglHWFzXGjGfmfii+WRa/H0Ai0=; b=Ch0zfq
	KMklQKMK2BR8y6jptMH6YFL3MNCogIVKzZwiFWRO6eopiHqI3cpeY/lNhoi/SrRf
	9lXqzeDKTxJ3umwl7nE6O5ZssX52yM+TuhUA46Fvki7irqMjURiU+TON3OXr89D6
	7DU6U3pn4/h27NhcqSHedTVEDLblbPuWFmXe0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Ky20qCcLb23o3VVTrcEBtBeFv0QEQ0J5
	kjfLvl3bqEI/FFusvTNXjwdStZ2TTz+dBaYpO277AoArgBXK3XQMca5410HUvFtj
	U80kxasMS5vclmBRf7jEq6zKm7c4cIkhIYZkIhVqfyfmdIBb9iZLsEDsV0u7JLSo
	ESFyGa6ukq8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 47372B27E;
	Thu, 14 Mar 2013 18:52:19 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C3551B27A; Thu, 14 Mar 2013
 18:52:18 -0400 (EDT)
In-Reply-To: <CALWbr2zY3uo==QTd69t1eXNS4-CX1w3T-AaMjOLVmxj-SMJyvg@mail.gmail.com> (Antoine
 Pelisse's message of "Thu, 14 Mar 2013 23:32:35 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D2EDD31A-8CF9-11E2-BAAD-4AAA2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218180>

Antoine Pelisse <apelisse@gmail.com> writes:

> I would like to discuss some improvements.

;-)

> The current implementation doesn't look for optimal solution but for the
> easiest/greedy solution.

Yes, you nailed it.

> Does it make any sense? And is it worth implementing?

Probably yes, and definitely.
