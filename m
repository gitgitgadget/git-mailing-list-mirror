From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] help.c: add a compatibility comment to cmd_version()
Date: Tue, 16 Apr 2013 15:35:07 -0700
Message-ID: <7vvc7mhzok.fsf@alter.siamese.dyndns.org>
References: <1366144405-61438-1-git-send-email-davvid@gmail.com>
 <3D6BDB8830FC44A38B1AC508488049C0@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "David Aguilar" <davvid@gmail.com>, <git@vger.kernel.org>
To: "Philip Oakley" <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Wed Apr 17 00:35:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USETD-0007PT-Ku
	for gcvg-git-2@plane.gmane.org; Wed, 17 Apr 2013 00:35:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965492Ab3DPWfT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Apr 2013 18:35:19 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44980 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965426Ab3DPWfS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Apr 2013 18:35:18 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B7A4617C6E;
	Tue, 16 Apr 2013 22:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1AwzyCSDNOSA3cgdxWh+y3xPgcA=; b=StWgPA
	HKgOuBj06EI82eGdHGF+9xuMLEFIur+vH+Lyqlxxd969qQsfIKyy2XkN2pizjrsd
	G5dKqm3I52e+3TnW4OW8o5CCoAkEUoDyNPO9I/Kup7Zo2ZnpPFmoscZe8P3WV2Gf
	Dh3kLsFtIw+jKUX1vBazyGFgvMaXiyynTatFM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZzAxEfrQOKwT2F66z7qcwI/wwSXOP19L
	qFkEtffOhG4e7RB7ZoCzX2yRe55Jn00dfvIPRqcScb9A35jFEqEU+blN23OeV6QB
	+SpD+ITP/BjWh98ifXDtpxD4YFBRlmTBkSBUL3kygv95l0xdXdiBkOeRxPfOHyZI
	QpA9k26ZYDc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AD2BF17C6C;
	Tue, 16 Apr 2013 22:35:17 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2821E17C69; Tue, 16 Apr
 2013 22:35:17 +0000 (UTC)
In-Reply-To: <3D6BDB8830FC44A38B1AC508488049C0@PhilipOakley> (Philip Oakley's
 message of "Tue, 16 Apr 2013 22:59:56 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E99E66D2-A6E5-11E2-BDA0-CC48E7F0ECB6-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221485>

"Philip Oakley" <philipoakley@iee.org> writes:

>> int cmd_version(int argc, const char **argv, const char *prefix)
>> {
>> + /*
>> + * The format of this string should be kept stable for compatibility
>> + * with external projects that rely on the output of "git version".
>
> Shouldn't the expected format of our known external project also be
> indicated?
> ...
>>  printf("git version %s\n", git_version_string);

It is fairly clear from the commented code that the only guarantee
they will be getting is that it begins with a string "git version ".
git_version_string[] has anything of the builder's choice.  I am not
sure if there anything more to "indicate".

Really, if you run

	$ git version

and you get "Git Source Code Management Version 3.56" from its
output, it is likely that the version is very different from what
you know, and you should not assume any your assumption would hold.

> Or mention "such as git gui"?

I do not see what it would buy us.  It is not like it is OK as long
as we upadte Git gui at the same time.
