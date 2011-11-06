From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fsck: print progress
Date: Sat, 05 Nov 2011 23:05:54 -0700
Message-ID: <7vpqh57pkt.fsf@alter.siamese.dyndns.org>
References: <20111103211819.GA17341@sigill.intra.peff.net>
 <1320376242-27851-1-git-send-email-pclouds@gmail.com>
 <4EB4EB70.40801@gmail.com> <7vk47e86j5.fsf@alter.siamese.dyndns.org>
 <CACsJy8DDKLrtmA3rGdW6xghwSs_e+zi1o2LzPDbmryH+XufpvQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stephen Boyd <bebarino@gmail.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 06 07:06:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RMvrm-0003AV-5X
	for gcvg-git-2@lo.gmane.org; Sun, 06 Nov 2011 07:06:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750875Ab1KFGF5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Nov 2011 01:05:57 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58355 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750743Ab1KFGF4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Nov 2011 01:05:56 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4AA30417D;
	Sun,  6 Nov 2011 01:05:56 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mGgnLsIkzDyWX3k9ikLIMBmlxxU=; b=w/ZJgn
	OmolX2lpGzGoB9MSdmnWfCDgezk+3T6HzXdDeeZTMP+onVvBxZ1SXRc9AWMlyX95
	TdgiqnneZftOjgYetGuUq0l1OfRlGzWtPitQ2cTiMZZiEguMdCXyc3SKVJurOFpM
	NR58+HR+8386nHJEFirTJhbOsIa683MHZC/Us=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NCfw5ERVTpJJvFtiNvVqm423pTLYowBR
	zUBwNEfQkero91/vvzud40QuquYHKgMmmlAi8QNCfoVQ3Tz9feUKzmGvRxHKZGQr
	akBEymlG5inHJ6kgrCpOz0W6Ul8vNP43HDvuLkC2SJGjGI/OzHCLsgFUnNvfxky0
	v9XEsZdgvkk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 36350417C;
	Sun,  6 Nov 2011 01:05:56 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AB9EB417B; Sun,  6 Nov 2011
 01:05:55 -0500 (EST)
In-Reply-To: <CACsJy8DDKLrtmA3rGdW6xghwSs_e+zi1o2LzPDbmryH+XufpvQ@mail.gmail.com> (Nguyen
 Thai Ngoc Duy's message of "Sun, 6 Nov 2011 09:37:55 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 63BC5AA8-083D-11E1-A5CC-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184902>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> Because in verbose mode, the screen is filled with "checking ..."
> lines for evevry object, there'll be no wonder why it stops for so
> long.

Ah, OK. It makes sense then, but the fact that you needed to explain it
would suggest that explanation deserves to be in the proposed commit log
message.

I was wondering if it was a typo of either "If --quiet is used, progress
is not shown", or "If --verbose=no is used, ..."
