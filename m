From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 11/14] t3032-*.sh: Pass the -b (--binary) option to sed
 on cygwin
Date: Tue, 14 Dec 2010 11:24:20 -0800
Message-ID: <7vtyigtaxn.fsf@alter.siamese.dyndns.org>
References: <4D07B8B5.2030409@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT Mailing-list <git@vger.kernel.org>, sunshine@sunshineco.com
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Tue Dec 14 20:24:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSaUK-00088T-DP
	for gcvg-git-2@lo.gmane.org; Tue, 14 Dec 2010 20:24:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759512Ab0LNTYd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Dec 2010 14:24:33 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:40259 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759294Ab0LNTYc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Dec 2010 14:24:32 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id DBEC02E25;
	Tue, 14 Dec 2010 14:24:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=41rZdGenKFY9rd0/OY6rDJJ6Z8o=; b=xbuCfB
	LKyWyD1DQp7C+CT8mZJmlqeJLn0H31ikcaeGkeKcF8sm9/6ZtXH5LFk7yPmLxDH5
	qaPLtDVy4J+0DVtyhsHrVbycO4cWXQiIYqPmpo2T1Lra3rJFLdNm+5hQdaw4K1lo
	G63vDEqa6ScMdqnELhHeEmM1sR4EhiDY1ekt0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=npiEfm7kfu8caUJ4k/LIHWOoZTBP3412
	pua67BcIL4dZ3X2DP09WR1VOKcqDG4AIW4dGQcY9MlheF/GGxiN9+iVzpJNdgpQz
	WUO1MXVsM6HBBt4uaUw4KP6ntaMPJftPvZlKbyAnwB6swkL8DezGPdGjTyp5sXNv
	/whUwmKSVx4=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A98762E22;
	Tue, 14 Dec 2010 14:24:51 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 940362E1F; Tue, 14 Dec 2010
 14:24:47 -0500 (EST)
In-Reply-To: <4D07B8B5.2030409@ramsay1.demon.co.uk> (Ramsay Jones's message
 of "Tue\, 14 Dec 2010 18\:34\:29 +0000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D2B36686-07B7-11E0-B230-C4BE9B774584-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163680>

Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:

> The test using the conflict_hunks helper function (test 9) fails
> on cygwin, since sed (by default) throws away the CR from CRLF
> line endings. This behaviour is undesirable, since the validation
> code expects the CRLF line-ending to be present. In order to fix
> the problem we pass the -b (--binary) option to sed, using the
> SED_OPTIONS variable. We use the SED_STRIPS_CR prerequisite in the
> conditional initialisation of SED_OPTIONS.
>
> Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
> ---
>
> Note that this test does not fail on MinGW, but I don't
> really know why, given commit ca02ad3... ahem ;-)

Ahem, indeed.  Why?
