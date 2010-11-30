From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Make the tab width used for whitespace checks
 configurable
Date: Mon, 29 Nov 2010 17:31:12 -0800
Message-ID: <7vhbezwqan.fsf@alter.siamese.dyndns.org>
References: <4CF366B1.8070400@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Nov 30 02:31:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNF46-0002TL-0t
	for gcvg-git-2@lo.gmane.org; Tue, 30 Nov 2010 02:31:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756013Ab0K3BbZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Nov 2010 20:31:25 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:57913 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755812Ab0K3BbY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Nov 2010 20:31:24 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9D9783F29;
	Mon, 29 Nov 2010 20:31:40 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GdJ7kJP1paw3IIJV2jzL0Cw0FNE=; b=fM+8E6
	T6JLflDTyoXyfb8KcF+H3V6A4B4mGg5AkNswSFrANIWLlQkAXAhtTgV+WHiqXSn4
	Pex27q1Z3zz+IlJmTgHxja5mE1STvd1HNZKhlQsjQz7ZeJlLLSUe7MkGdDtPUtI/
	FMlp4fi/9T0wWav7In323nXENcLsYWkhg6LqA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Gc4sO6JooJ9un8qJBfiN0CMvaxZvCs/L
	5rt0GtnYatTfnNQJnGKFa7gM/fADycJ2j3ytSvnWwRJqkgYWK2byD1qnM6MBOpgJ
	rloW63nizSxoBRPUgRPiH4403Gx+5fjaLNc39+rnUIwbyOfWYRh5PL36v0TDb4lz
	HKWhNdyAeOs=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 7C71E3F28;
	Mon, 29 Nov 2010 20:31:38 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 1EEAD3F1E; Mon, 29 Nov 2010
 20:31:31 -0500 (EST)
In-Reply-To: <4CF366B1.8070400@viscovery.net> (Johannes Sixt's message of
 "Mon\, 29 Nov 2010 09\:39\:13 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 9396A4C8-FC21-11DF-882D-CDEAE6EC64FC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162460>

Johannes Sixt <j.sixt@viscovery.net> writes:

> From: Johannes Sixt <j6t@kdbg.org>
>
> A new whitespace "rule" is added that sets the tab width to use for
> whitespace checks and fix-ups and replaces the hard-coded constant 8.
>
> Since the setting is part of the rules, it can be set per file using
> .gitattributes.
>
> The new configuration is backwards compatible because older git versions
> simply ignore unknown whitespace rules.
>
> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
> ---
>  I have a project that uses tab width 4, and which has a lot of whitespace
>  errors. This is very helpful to spot them when lines are changed that
>  are indented with 4 spaces.

Heh, I like it.  This will be the second killer feature to upgrade to the
upcoming release.  We really should start calming things down.

I am sort of surprised how the patch does not have to touch neither diff.c
nor apply.c at all---it demonstrates how solidly and cleanly the ws.c
infrastructure was done in the first place, I guess ;-).

Thanks.
