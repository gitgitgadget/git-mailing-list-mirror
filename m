From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Update packfile transfer protocol documentation
Date: Tue, 03 Nov 2009 17:48:36 -0800
Message-ID: <7v1vkfnjpn.fsf@alter.siamese.dyndns.org>
References: <d411cc4a0911011518q15a8267bn642e6937be8c9ab1@mail.gmail.com>
 <7v4opbp1fa.fsf@alter.siamese.dyndns.org>
 <20091104005614.GD10505@spearce.org>
 <7vljinnllj.fsf@alter.siamese.dyndns.org>
 <20091104011802.GE10505@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Scott Chacon <schacon@gmail.com>,
	git list <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Nov 04 02:48:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5UzY-0001CP-VA
	for gcvg-git-2@lo.gmane.org; Wed, 04 Nov 2009 02:48:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753778AbZKDBsp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Nov 2009 20:48:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753633AbZKDBso
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Nov 2009 20:48:44 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:38549 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753328AbZKDBso (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Nov 2009 20:48:44 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B719E91969;
	Tue,  3 Nov 2009 20:48:47 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=REeD+PHy8nCZGizJAhdHPfuv848=; b=m92+lN
	aha+Nq5pSfGuspqpc/+XXhHf10cUkuUqYUlVLS9tkMT7ZCExwIMW6VKbuBAGD/tb
	nisuY5pwZ15e5FToOQy2Wpher0AuuXd3SjCp+pPcKuayrHpHSH7Ieqj9xpPI8eFp
	lCYy9pgjy7yOyFN4lyj2ES684RclbYiRiZ23M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wAhB7sSGEEhKA5FSoCRurAEpAtqgdVPc
	103hqV1iecL4nEU59sI1faoG2mydfuLlhoPVtdbcsfxExB6qcymYcRPywuEukUAN
	PlurmZoKTMTNl6o2ptUhenRIoKzovqSR+ZaCn6Aue8ZAioOnbikQmMIav/Rsa2Ux
	WFaBPyUagQI=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 87AE691968;
	Tue,  3 Nov 2009 20:48:44 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 0809391965; Tue,  3 Nov 2009
 20:48:38 -0500 (EST)
In-Reply-To: <20091104011802.GE10505@spearce.org> (Shawn O. Pearce's message
 of "Tue\, 3 Nov 2009 17\:18\:03 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 2FA4D0E6-C8E4-11DE-B11C-A67CBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132021>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Junio C Hamano <gitster@pobox.com> wrote:
>> "Shawn O. Pearce" <spearce@spearce.org> writes:
>> > I don't think we ever send an empty packet.  If we have no data to
>> > send, why the hell did we create the packet header?
>> 
>> Oh, I do not disagree that it is pointless, but the example that followed
>> the part we are discussing also had "0004".  I think it is Ok to allow it.
>
> If its pointless, why encourage it?  Why not discourage it with SHOULD NOT?

Oh, no, I didn't mean to _encourage_ it.

I just thought that it being pointless at the semantic level would already
be an enough discouragement for people who are intelligent enough.

As I said, this was not an objection to start with.

> Sure, but can't packet_write just return early without write()
> if format_packet returned 4 (aka vsnprintf returned 0)?

Ah, that's right.
