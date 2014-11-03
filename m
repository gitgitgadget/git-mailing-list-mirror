From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] submodule: Fix documentation of update subcommand
Date: Mon, 03 Nov 2014 15:08:55 -0800
Message-ID: <xmqq7fzbriew.fsf@gitster.dls.corp.google.com>
References: <1415009391-14979-1-git-send-email-sojkam1@fel.cvut.cz>
	<xmqqegtkrtt9.fsf@gitster.dls.corp.google.com>
	<5457E7DF.5070500@web.de>
	<xmqqbnooq863.fsf@gitster.dls.corp.google.com>
	<87k33bao7w.fsf@steelpick.2x.cz>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jens Lehmann <Jens.Lehmann@web.de>, git@vger.kernel.org,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Michal Sojka <sojkam1@fel.cvut.cz>
X-From: git-owner@vger.kernel.org Tue Nov 04 00:09:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XlQkD-0000pC-Nu
	for gcvg-git-2@plane.gmane.org; Tue, 04 Nov 2014 00:09:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751686AbaKCXJA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Nov 2014 18:09:00 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:54142 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750963AbaKCXJA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Nov 2014 18:09:00 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 930431B8A1;
	Mon,  3 Nov 2014 18:08:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kEwy/fMHEd0OESUMZ8w8iU/Z4PA=; b=TVhyvs
	CMO0OlqKTyeBm71d+DKx48+Mdrfq01Z7Ur3cHCNdWUoryR2S1hzgrfd591Y1wPHz
	DyPQ2qn56TiRlkHg3lhb9p4YAmWi10//RWhNf/K6Zsw+y8HS9aiBCJNBmrT28H/s
	johwZjugC3HxwSlb/pJmNOMy1j8piVijmEBGI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WI0wapP2ljfP1RJ/ZYjzXITdOPaayOKC
	Vi4ziSmoo4e++6kBi0s+08OVdKXNgYwSlOZD7hmHYnVb5H+1fWDZE95EmxT3l1PB
	XUQdjRmorMxuuEnSWweOpqdiAdMIO3gZoqsh5agWMMXogK5u09ry76EQVxBMAYqW
	r6p08YCPbDI=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 88CD41B8A0;
	Mon,  3 Nov 2014 18:08:57 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id ED13D1B89F;
	Mon,  3 Nov 2014 18:08:56 -0500 (EST)
In-Reply-To: <87k33bao7w.fsf@steelpick.2x.cz> (Michal Sojka's message of "Mon,
	03 Nov 2014 23:55:31 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 63537F36-63AE-11E4-83DE-692F9F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michal Sojka <sojkam1@fel.cvut.cz> writes:

> This sounds good, but it doesn't mention the `!command` value of
> .update.

That part is unchanged by what I did.  My rewrite was up to

	... by specifying `--checkout`.

of the existing text.

>> Or something perhaps?  Or the detailed description of
>> submodule.$name.update should be dropped from here and refer the
>> reader to config.txt instead?
>
> I guess you mean gitmodules.txt.

Actually, I do mean the configuration.  .gitmodules is just a
template to help the user populate .git/config, and the latter of
which should be the sole source of truth.  This is an important
principle, and it becomes even more important once we start talking
about security sensitive possiblity like allowing !command as the
value.

> The `!command` form is not documented in gitmodules.txt. Maybe it would
> be best to fully document .update in gitmodules.txt and just refer to
> there. Having documentation at two places seems to be confusing not only
> for users, but also for those who send patches :)
>
> I'm no longer able to formulate my proposal properly as a patch tonight,
> but if needed I'll try it later.

That is fine.  People have lived with the current text for more than
two years without problems, so we are obviously not in a hurry.
