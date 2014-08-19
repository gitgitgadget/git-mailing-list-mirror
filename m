From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] Allow the user to change the temporary file name for mergetool
Date: Tue, 19 Aug 2014 15:14:21 -0700
Message-ID: <xmqqk364unya.fsf@gitster.dls.corp.google.com>
References: <xmqqa970wgy0.fsf@gitster.dls.corp.google.com>
	<1408468545-6879-1-git-send-email-robin.rosenberg@dewire.com>
	<53F3B565.5080309@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Robin Rosenberg <robin.rosenberg@dewire.com>, git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Wed Aug 20 00:14:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XJrfn-0000oL-LY
	for gcvg-git-2@plane.gmane.org; Wed, 20 Aug 2014 00:14:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751626AbaHSWOc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2014 18:14:32 -0400
Received: from smtp.pobox.com ([208.72.237.35]:52163 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751353AbaHSWOa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2014 18:14:30 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4F7D2333B2;
	Tue, 19 Aug 2014 18:14:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5sXYRnxsBk4jgTXOkg0lCnOdEUA=; b=e2EJip
	30VDu7gHs3NrLW751rE35UUhzlKhQLn1ODvQnNM5kSg4E2zACriUJstAX/1xSv88
	zcGs3EbL1QNRefsRfRWLU010nFUbJ7XzfuMZUSP5i4ARDRrk7ZWqWma2fbajK2gl
	k9AynVAye/0Obmkdw393P6bwaRnqCjHtdzB4A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jnJVEotrGKnDLPwhliuQbVsyfuHzYKnH
	A1duM2D7b71xvAWnpOZBfMabYi3hnLSynZerPhxMvnuMFcSe7jWYuK6ZWrwCUWVP
	EaK5UB7h1/ldKqEivZdAL78uvos/yeqVaOT/hnmsNx+pQKSrGMOLRlSJZh63OC72
	G8f7Usw+hS0=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 45270333B1;
	Tue, 19 Aug 2014 18:14:30 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id C10E7333A5;
	Tue, 19 Aug 2014 18:14:22 -0400 (EDT)
In-Reply-To: <53F3B565.5080309@kdbg.org> (Johannes Sixt's message of "Tue, 19
	Aug 2014 22:36:53 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 2C5DDAA4-27EE-11E4-8B42-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255539>

Johannes Sixt <j6t@kdbg.org> writes:

> Am 19.08.2014 19:15, schrieb Robin Rosenberg:
>> Using the original filename suffix for the temporary input files to
>> the merge tool confuses IDEs like Eclipse. This patch introduces
>> a configurtion option, mergetool.tmpsuffix, which get appended to
>> the temporary file name. That way the user can choose to use a
>> suffix like ".tmp", which does not cause confusion.
>
> I have a merge tool that does syntax highlighting based on the file
> extension. Given this:
>
>> +	BACKUP="./$MERGED.BACKUP.$ext$tmpsuffix"
>> +	LOCAL="./$MERGED.LOCAL.$ext$tmpsuffix"
>> +	REMOTE="./$MERGED.REMOTE.$ext$tmpsuffix"
>> +	BASE="./$MERGED.BASE.$ext$tmpsuffix"
>
> I guess I lose syntax highlighting if I were to use mergetool.tmpsuffix;
> but then I don't use Eclipse. Could it be that this is really just a
> band-aid for Eclipse users, not IDEs in general as you are hinting in
> the Documentation of the new variable?

The phrase "IDEs like Eclipse" in the proposed log message did not
tell me (which I think is a good thing) if IDEs that need "band-aid"
are majority or minority, but I agree that we should not hint that
IDEs in general would benefit by setting this variable.  A warning
on the syntax-aware editors may be necessary.

Thanks for a careful reading.
