From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add .gitconfig variable commit.gpg-sign
Date: Tue, 23 Apr 2013 10:53:24 -0700
Message-ID: <7va9opi163.fsf@alter.siamese.dyndns.org>
References: <CAASwCXf3YHmdQ_eSkShyzn5VniO=ufm3VTqV1JVOUN610bzE_A@mail.gmail.com>
	<7vip3em8rs.fsf@alter.siamese.dyndns.org>
	<CAASwCXcfCNqiMXD5JasTRKWZgCNsxnUY7k9E=f86xsTZjk37CA@mail.gmail.com>
	<51767290.2010208@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Joel Jacobson <joel@trustly.com>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Apr 23 19:53:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUhPI-0007Es-OB
	for gcvg-git-2@plane.gmane.org; Tue, 23 Apr 2013 19:53:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756765Ab3DWRx2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Apr 2013 13:53:28 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50585 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756701Ab3DWRx1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Apr 2013 13:53:27 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 45A2919C52;
	Tue, 23 Apr 2013 17:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=LEj5i/Vq1Mn+CUlGnn/LWtpTOWQ=; b=sCsIHz
	l10LJd5KlNtVkoZgeznJLdYqOZWPE387e/CxginfweVUzBwsUIevu9KgVQASM2GC
	9uGALwWkkOmnrDqqSO0F7DWgyWYU3+GLppkCLdzOvl4TghqCjtMweX9c5MHVFcgh
	jsJoKnWnLV5crMoKc47B4jvHZ+B4yX/tWLQ7w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WAAGDUQmos2VGe7abjQkDj2mJ5TUGEhd
	KMp4ukHYfbxQnQOKdJK1RuVusBk2Zx8VmNrwFoe2O6PehsJI3rw/EghIuVeLfDxw
	jF7liobEB1guuKWh6B7SZLcnQWwj1yjmg/+M5WqW8d5EPv27koEIrYtMN01DKM4p
	UE93S+kxTWQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3934019C51;
	Tue, 23 Apr 2013 17:53:26 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B3E8D19C4E;
	Tue, 23 Apr 2013 17:53:25 +0000 (UTC)
In-Reply-To: <51767290.2010208@drmicha.warpmail.net> (Michael J. Gruber's
	message of "Tue, 23 Apr 2013 13:37:52 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B2838E76-AC3E-11E2-A62E-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222203>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> As for the command line override:
>
> Don't we have "git -c commit.gpgsign=false" and such these days, so that
> we don't have to inflate options any more?

I would consider such use of "git -c key=val" a last-resort escape
hatch to work around broken commands that do not implement a proper
escape hatch designed in to help users, unless the "key" is for
something very obscure and not meant for every-day use (read: not
deserving a proper command line override).
