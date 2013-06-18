From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 00/13] bash prompt speedup
Date: Tue, 18 Jun 2013 09:48:28 -0700
Message-ID: <7vsj0f5pr7.fsf@alter.siamese.dyndns.org>
References: <1371521826-3225-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, "Eduardo R. D'Avila" <erdavila@gmail.com>,
	Simon Oosthoek <s.oosthoek@xs4all.nl>
To: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Tue Jun 18 18:48:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uoz5E-0006Jh-6D
	for gcvg-git-2@plane.gmane.org; Tue, 18 Jun 2013 18:48:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932670Ab3FRQsg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 18 Jun 2013 12:48:36 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41153 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754090Ab3FRQsf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 18 Jun 2013 12:48:35 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2ECDA29C79;
	Tue, 18 Jun 2013 16:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=JozJ5uc5kitg
	Jw/gVAM0Y0Ka5Ss=; b=xc4Tyy/tmnBV75fJ7FkURNXR74GnpJUmtVIkQzpY6si6
	a8DJ/uYNimEOGlK2a2D4tb3tI1iQTAE2IcF+D/GKCFmQHGUtW5229Ym74sc3qqKN
	9wQptpx+hZkFoOWoxPNAPGCpwOu+b4wn1T8ruX6DWHa+wDmHAAgfY4QG6WbmNm0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=sWntzQ
	c5j9jLYQ4sKS7XVUZ7X9FXerURH3O695KL7qHL71pRp1EuQ+w+4pZtXiIwYIGmh9
	vWKBOcnITO7Gje3QQ7QHJM5tiTOU1ZZtRQPsH8TrdX+MlCvF1j6YrKZWZjrFr+oq
	gPZVdIf1aZAozNpOi+NbZ3M9LsinR6JkVNpOY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2216D29C78;
	Tue, 18 Jun 2013 16:48:34 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 76A0A29C75;
	Tue, 18 Jun 2013 16:48:32 +0000 (UTC)
In-Reply-To: <1371521826-3225-1-git-send-email-szeder@ira.uka.de> ("SZEDER
	=?utf-8?Q?G=C3=A1bor=22's?= message of "Tue, 18 Jun 2013 04:16:53 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E95FCEF4-D836-11E2-A70B-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228270>

SZEDER G=C3=A1bor <szeder@ira.uka.de> writes:

> This patch series eliminates many command substitutions and commands
> in __git_ps1() from top to bottom by replacing them with bash builtin=
s
> or consolidating them.  A few timing results are shown in the log
> message of patch 10.

Nice.  I think I saw Peff's comment and discussion between you two
already resuted in a fixup, so perhaps I'll see a reroll sometime
later when the dust settles?

Also, could you help review the other topic by Eduardo R. D'Avila
about colored prompt (Sion Oosthoek, who did the color support,
CC'ed)?

    http://thread.gmane.org/gmane.comp.version-control.git/228017

The impression I got when the PROMPT_COMMAND series was discussed
last October was that you need to use \[...\] pairs to get the
cursor position right for the purpose of command line editing, and
D'Avila's series seemed to only do so in PROMPT_COMMAND mode.
