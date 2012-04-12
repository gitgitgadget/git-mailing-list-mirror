From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 4/4] git-rebase: add keep_empty flag
Date: Wed, 11 Apr 2012 20:16:15 -0700
Message-ID: <7vpqbdhc74.fsf@alter.siamese.dyndns.org>
References: <1334175716-11391-1-git-send-email-nhorman@tuxdriver.com>
 <1334175716-11391-5-git-send-email-nhorman@tuxdriver.com>
 <7vsjgaht7d.fsf@alter.siamese.dyndns.org>
 <20120411235909.GC16937@hmsreliant.think-freely.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Phil Hord <phil.hord@gmail.com>
To: Neil Horman <nhorman@tuxdriver.com>
X-From: git-owner@vger.kernel.org Thu Apr 12 05:16:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SIAWE-0000HX-Sl
	for gcvg-git-2@plane.gmane.org; Thu, 12 Apr 2012 05:16:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932637Ab2DLDQS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Apr 2012 23:16:18 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51367 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755462Ab2DLDQS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2012 23:16:18 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A121B8971;
	Wed, 11 Apr 2012 23:16:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=I5OIC9pCc4Na1FBoGG80T48jE1I=; b=JL2h+q
	N7MxalNKNLejPE+sqKHL4Pb9lVDJWRhG76+fImIrAyf9wvl8/8rLR4K4+3kC/LoH
	ccqCjbfx4xv3Q/+x2ylCJZPfEeDqRs50cSAEQ4eZX3IAR7Oigi4ULXOiesPthHjd
	DmmpxJUUpkYuRyVEdrrCuQH+HnWQ9wYXVT1as=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=T+UoE39kX53OBrXK0WqpyjCTo/yqE4gN
	CNWXvSsFlVqb1cIdu+N/4ohbwb5mcakUxlZVSB14flzUP5C9zzaL7KZOP86N6IwQ
	3HlL+goV6LCEd23cQirpoC8OKB4xVEiFoZ3mWn5nei/nXZ9kZrDy6OU81gbz7Ygz
	qyTdYZUCcBY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 98CEA8970;
	Wed, 11 Apr 2012 23:16:17 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2F148896F; Wed, 11 Apr 2012
 23:16:17 -0400 (EDT)
In-Reply-To: <20120411235909.GC16937@hmsreliant.think-freely.org> (Neil
 Horman's message of "Wed, 11 Apr 2012 19:59:09 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DE2364F8-844D-11E1-BBB9-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195289>

Neil Horman <nhorman@tuxdriver.com> writes:

> I did not, mostly because those tests didn't seem to work with empty commits at
> all.

Yeah, existing tests won't even try to rebase an empty or unnecessary
commit, so if the change breaks them, you found regressions.
