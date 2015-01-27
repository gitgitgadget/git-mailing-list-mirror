From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] dumb-http: do not pass NULL path to parse_pack_index
Date: Tue, 27 Jan 2015 12:46:44 -0800
Message-ID: <xmqq386wkl3f.fsf@gitster.dls.corp.google.com>
References: <1422372041-16474-1-git-send-email-charles@hashpling.org>
	<20150127181220.GA17067@peff.net> <20150127200226.GA19618@peff.net>
	<20150127201921.GA24365@hashpling.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, Shawn Pearce <spearce@spearce.org>,
	git@vger.kernel.org
To: Charles Bailey <charles@hashpling.org>
X-From: git-owner@vger.kernel.org Tue Jan 27 21:46:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YGD2D-0001CG-8O
	for gcvg-git-2@plane.gmane.org; Tue, 27 Jan 2015 21:46:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932840AbbA0Uqt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jan 2015 15:46:49 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:63599 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932569AbbA0Uqs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jan 2015 15:46:48 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C9348323A9;
	Tue, 27 Jan 2015 15:46:47 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xkTdMscz+twXAp1FgsdmoS+KVF4=; b=mnk+gP
	z1FGxJAIlvlOqMcSWoc0EfYHzNtf5SFBt0C147W7d3PamW7YKtYMmRze6D50VGP8
	AwC2soBdvT7xqreeYx2dxYSPf7s8St5QS2hbxfYwdPbnBsf2WQvXg7f50NVj+/wB
	i/XFF0Lya5QgdPVn81KAk5+SpGvtuhUV1rBqQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GbUIBKUe888hIUD2GQrWB3s3KNa8RqE8
	Wl+MI8+UNTZ8dEUyI4N3/IHHGblV+exb8PVhJN3LBF3sY4r3P4/lQK1faG9Awhce
	rRwZN3fKs+GLOMsa8yy20LvVFGHpn4fj4eg61/co6bgaD9BgDqReS3nu3UDpU1bz
	ovVsdfuUKSg=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B9D76323A8;
	Tue, 27 Jan 2015 15:46:47 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8ED86323A6;
	Tue, 27 Jan 2015 15:46:45 -0500 (EST)
In-Reply-To: <20150127201921.GA24365@hashpling.org> (Charles Bailey's message
	of "Tue, 27 Jan 2015 20:19:21 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 9B55CCD2-A665-11E4-80D6-7BA29F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263090>

Charles Bailey <charles@hashpling.org> writes:

> On Tue, Jan 27, 2015 at 03:02:27PM -0500, Jeff King wrote:
>> Discovery and tests by Charles Bailey <charles@hashpling.org>.
>> 
>> Signed-off-by: Jeff King <peff@peff.net>
>> ---
>> I'm happy to flip the authorship on this. You have more lines in it than
>> I do. :)
>
> No, I'm happy with you taking the blame/praise for this, it's definitely
> your fix.

Looks good (rather, makes the original look obviously broken and
makes me wonder why our review process did not catch that bogus NULL
in the first place).

Thanks, both.
