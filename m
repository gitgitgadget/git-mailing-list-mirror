From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Recovering from commit --amend in rebase --interactive
Date: Wed, 02 Jun 2010 16:37:58 -0700
Message-ID: <7viq619fah.fsf@alter.siamese.dyndns.org>
References: <alpine.DEB.2.00.1006011022030.2352@ds9.cixit.se>
 <20100601115755.04ff4a0d@jk.gs>
 <AANLkTinNpIjirZQL1lBi3t4i6_utCIUMuXc8q2gSJvmO@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jan =?utf-8?Q?Kr=C3=BCger?= <jk@jk.gs>,
	Peter Krefting <peter@softwolves.pp.se>,
	Git Mailing List <git@vger.kernel.org>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 03 01:38:18 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJxVo-000170-DI
	for gcvg-git-2@lo.gmane.org; Thu, 03 Jun 2010 01:38:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933294Ab0FBXiL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 Jun 2010 19:38:11 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:53654 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932832Ab0FBXiJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 Jun 2010 19:38:09 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 6151DB7346;
	Wed,  2 Jun 2010 19:38:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=imDZ6pAsfvMsa3zdzVBDOnWCk
	h4=; b=xgH/GWekFat0qacRc6jJWDO3UJZ8wr/q6A04u1I96DUhYeIDkaBEAWkOd
	f1HtxEJQ5CBF3YkiMdMzSyRlc+KiXjZxIVFiaAOtKCmplY4hGXY+/rgWlseSP0zw
	2vchd1lLfhEzjSOmIB0XqFegTGPfyVKlOcHiqpaylBz8URN9CA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=QimJxIUdB2em+VNZxdO
	aXjedLhCevdg4X/je/k+mjALuqSg6w7IXVFkyMvPAXqiTqbgBIT+/We/Zn4U2QNa
	TaqaR6kaq0jIMlc5dkE5tK4S/rACbpdTHjv5eHFHW1JETU5y8qa5aq+Gbe9p1WaF
	iFhj2/O1gJDSU2V+Dw4q3IAc=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0F2D6B7344;
	Wed,  2 Jun 2010 19:38:05 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3D10DB7342; Wed,  2 Jun
 2010 19:38:00 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: E41BC7E4-6E9F-11DF-9C6A-6730EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148283>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

>> In general, it might be helpful to warn very loudly upon doing a com=
mit
>> --amend after fixing conflicts, but an implementation would probably=
 be
>> ugly and for all I know, there might be people who frequently cause
>> conflicts while amending; those guys would probably be quite annoyed=
 at
>> such a warning.
>
> I've also introduced the error Peter describes into my history becaus=
e
> I wasn't careful. That required some splitting / reflog fixes later.
>
> Perhaps the best way to solve this would be to change the content of
> COMMIT_EDITMSG in cases like these so it gives you an explicit warnin=
g
> about what you're about to do.
>
> We already do this for merges, from builtin/commit.c:

Very good point.  "Users are told when the command gives back control, =
is
the best "rebase -i" could do, but by definition the users are free to
shoot themselves in the foot when given control, and "commit --amend" i=
s
the only sensible place to give further safeguard against this issue.

Thanks.
