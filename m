From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 00/31] refactor rebase
Date: Thu, 10 Feb 2011 14:44:48 -0800
Message-ID: <7vd3mz33xb.fsf@alter.siamese.dyndns.org>
References: <1293528648-21873-1-git-send-email-martin.von.zweigbergk@gmail.com>
 <1297017841-20678-1-git-send-email-martin.von.zweigbergk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Christian Couder <chriscool@tuxfamily.org>,
	Thomas Rast <trast@student.ethz.ch>
To: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 10 23:45:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PnfGF-0005UE-EK
	for gcvg-git-2@lo.gmane.org; Thu, 10 Feb 2011 23:45:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757184Ab1BJWpI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Feb 2011 17:45:08 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:57119 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756869Ab1BJWpG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Feb 2011 17:45:06 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 368733110;
	Thu, 10 Feb 2011 17:46:04 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Btyk+8MGGtIDhWPKEh2E+AGwmfA=; b=JAbS7b
	tsDQ4f3DLvs9Y/LurK9Br5vcBIa+COMsm0r3C4/OoO7vgtFOKN4hnkEOtV7sDbzS
	s/3PfNtgcOkqCJwxGL4UGxVOD0dEba1Q3w+vfEMHnPy596KSyl4X5tTbyZ19kkoW
	LOfG4K1zmTMyVDCO6TD3LjbNtQqOkFbjytTPA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Mkleh9DeU0MMRroi6Z7FYrhPUG1GQgJQ
	l48qWbEqCUThSWEU9XLc2JFlykcpAvegVUnuAsU5cx6+pz8iXLobeDFzOK0b4oXB
	UhRcBU2AY3vpBSLtJX4It//0+VLyjC3+MM1QFmpAlrt254OAlte6us3fwHFnVELF
	tpSlp+CCczM=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C1EE43101;
	Thu, 10 Feb 2011 17:45:57 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 1935C30F8; Thu, 10 Feb 2011
 17:45:49 -0500 (EST)
In-Reply-To: <1297017841-20678-1-git-send-email-martin.von.zweigbergk@gmail.com> (Martin
 von Zweigbergk's message of "Sun\,  6 Feb 2011 13\:43\:29 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 869E72C6-3567-11E0-9D0E-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166508>

I see there are a few minor fix-ups made since the last round.

The majority of the difference between the old one and this round was the
downcasing of the variables, which was a bit distracting to read the
remainder, but overall the result looks better.

I am not sure if forbidding "-v --continue" adds any value; would it be
too much effort to allow "--continue -v" instead to achieve the same
degree of consistency between the two?

Honestly speaking, I do not deeply care either way, but the users may want
to say "ok, keep going but this time with verbose output", no?
