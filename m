From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Submodules always use a relative path to gitdir
Date: Tue, 03 Jan 2012 14:17:11 -0800
Message-ID: <7vhb0csa6w.fsf@alter.siamese.dyndns.org>
References: <1325192426-10103-1-git-send-email-antony.male@gmail.com>
 <7vsjk3vw67.fsf@alter.siamese.dyndns.org> <4F007492.8010909@web.de>
 <7vsjjwvdyl.fsf@alter.siamese.dyndns.org> <4F037CBF.9010005@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Antony Male <antony.male@gmail.com>, git@vger.kernel.org,
	iveqy@iveqy.com
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Tue Jan 03 23:17:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RiCfX-0006XQ-Kl
	for gcvg-git-2@lo.gmane.org; Tue, 03 Jan 2012 23:17:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754960Ab2ACWRP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jan 2012 17:17:15 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58177 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754800Ab2ACWRO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jan 2012 17:17:14 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2D82053C2;
	Tue,  3 Jan 2012 17:17:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xsFbeP4qhDqJshOS4dZFpIk3GC4=; b=XvhKS6
	2A9rxO24F7jAmazCFr6u2kaDvUduEeYLiHluxEzu6eZ30qjO2G+7RjGz3Y7lhYO5
	VAzIO6Fc2CFJW7K1iZ+qrtfFKd8xzwjZSGvf+j88lOJ67OkTcoO5H3mt/qi1XY0P
	oD6Nh3hTn0JiumGFrfKqaZeBd/N7d3svbcRlo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JACojeJoC/qfTOMHX/wEqIDPp2j1fhDy
	/XIeqvyVAazQkowFU7WnDhxDfD15IqMvoPyIyE5VQufzN9RCQK6Uq8CGom+C9aNZ
	MzBMwB8gUQd3tQgKsBCQmgBTq3oiGaXREZJdf5vWLtIeWutCw39fvtJLiyx1/ntA
	AvpPglIwpUI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2449E53BF;
	Tue,  3 Jan 2012 17:17:13 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8F52B53BB; Tue,  3 Jan 2012
 17:17:12 -0500 (EST)
In-Reply-To: <4F037CBF.9010005@web.de> (Jens Lehmann's message of "Tue, 03
 Jan 2012 23:10:07 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AF6DA58A-3658-11E1-8E21-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187901>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> Not if we would implement a "if no worktree is set but we came here via
> a gitfile, then take the directory the gitfile was found in as worktree"
> heuristic. And that heuristic looks quite sane to me, as a gitfile can
> only be found in a work tree, or am I missing something obvious here?

Like it wouldn't work without changes to the core side?
