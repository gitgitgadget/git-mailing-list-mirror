From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] diffcore-pickaxe doc: document -S and -G properly
Date: Tue, 14 May 2013 10:41:52 -0700
Message-ID: <7vwqr1jw67.fsf@alter.siamese.dyndns.org>
References: <1368540759-25598-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 14 19:42:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UcJEd-0006zZ-RE
	for gcvg-git-2@plane.gmane.org; Tue, 14 May 2013 19:42:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754772Ab3ENRl4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 May 2013 13:41:56 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62501 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753517Ab3ENRlz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 May 2013 13:41:55 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C34EC1E3A9;
	Tue, 14 May 2013 17:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DHX3R1/x0ViadhKdsECBTwFYo8w=; b=X11VGy
	4v8XnLNNsvnEgrBUATHEtFkeAfH8y1xnaEMdfISLVKZ9Ncfwotnnjg+IBsA1HMBD
	fWIlRk95bonPIl7Gklow5iEe7d2fOF8sULKultVipSRiUNQ37nUbbKXCvkjeKO3y
	Eu6RoRSUp9dVEtc2XQ4Q//VcitxoENdBhCHy0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gNom0NYMqc76G3Gu2oRKErNpiy3xPuYv
	GZerBG1BmcrV2UFpEB2eDrJF/KzrUOxlJ4UKZVw+mjlqdl9cfR/tvHmjnuH6LTzY
	Jl5yYrrz6KU1tNJpZUp41zT6j8IWk8KImWAVLUFUVtFgO0qltFKP0ZMygi0VwMNO
	pEporSzdY4Q=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B7BFB1E3A8;
	Tue, 14 May 2013 17:41:54 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D645C1E3A4;
	Tue, 14 May 2013 17:41:53 +0000 (UTC)
In-Reply-To: <1368540759-25598-1-git-send-email-artagnon@gmail.com> (Ramkumar
	Ramachandra's message of "Tue, 14 May 2013 19:42:39 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 90CEDF44-BCBD-11E2-A925-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224303>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

>  -S<string>::
> -	Look for differences that introduce or remove an instance of
> -	<string>. Note that this is different than the string simply
> -	appearing in diff output; see the 'pickaxe' entry in
> -	linkgit:gitdiffcore[7] for more details.
> +	Look for commits where the specified string was added or
> +	removed.  More precisely, find commits that change the number
> +	of occurrences of the specified string.

Any time you say "This means that", "More precisely", etc. please
check if you can rewrite it to lose everything before them (i.e. a
vague sentence that needs to be clarified may not have to be there
at all).

> ++
> +It is often useful when you're looking for an exact string (like a
> +function prototype), and want to know the history of that string since
> +it first came into being.

I think you should remind that the most useful case (and indeed the
intended one) is for "an exact string" to be a multi-line "block of
text".  People often get a (wrong) impression from the word "string"
that it is meant to be used with a single-liner.
