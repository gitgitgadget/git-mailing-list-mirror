From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/alternative/raw and rough] setup.c: denote repo wide
 pathspecs by ':'
Date: Wed, 02 Mar 2011 19:52:21 -0800
Message-ID: <7vy64w97yi.fsf@alter.siamese.dyndns.org>
References: <AANLkTi=xrnxUtkayyW1Merh49N6uHy5p-GMrYe6+p==t@mail.gmail.com>
 <bc49592f5e524a0d12aa55eeca1c5ca659b6525f.1298974647.git.git@drmicha.warpmail.net> <AANLkTimJ7QsPTW0Vm9JgYVbcRQRoTnuiXUxOK=0unk6P@mail.gmail.com> <4D6CD593.2090705@drmicha.warpmail.net> <AANLkTinke05gcQbrDLSUoBUus5gnx+ci5830766d2Jqs@mail.gmail.com> <4D6CDF20.3020701@drmicha.warpmail.net> <AANLkTikzSsBZ757p4gnwsUrGNmRKHsxrqXeqPKyLihjT@mail.gmail.com> <7vsjv6evy4.fsf@alter.siamese.dyndns.org> <4D6D0A51.9030701@drmicha.warpmail.net> <AANLkTi=YHNnuBAF_GitrmMYFK1h_p9JP54hRyj9vWTzc@mail.gmail.com> <AANLkTimPGxzP+XfX8Ng5U_4UnPWZCFLQ-3rP4oPTE3o+@mail.gmail.com> <4D6E4246.5080407@drmicha.warpmail.net> <7vhbblcvl7.fsf@alter.siamese.dyndns.org> <4D6E7EF0.5040106@drmicha.warpmail.net> <buo4o7kc4ce.fsf@dhlpc061.dev.necel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>, git@vger.kernel.org
To: Miles Bader <miles@gnu.org>
X-From: git-owner@vger.kernel.org Thu Mar 03 04:52:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Puzai-0002wv-79
	for gcvg-git-2@lo.gmane.org; Thu, 03 Mar 2011 04:52:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932230Ab1CCDwf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Mar 2011 22:52:35 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:55480 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932106Ab1CCDwf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Mar 2011 22:52:35 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 610674FB8;
	Wed,  2 Mar 2011 22:53:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=AAi6X4itoKK64U1e3QZkPeWEe5g=; b=Fea6HV
	51h7eY/VUGFY6qhWJ91uVVAupzZnthj0aY6eh+ljQmYVL/b38O+FvdpuNugZtTTY
	YFnuVj0kxa8KLvpBxdtiHCdlK+b7qy0bIM546swKdiwq00bLllyC0+lFln+JCe68
	Jdd3Dx0S28iop3bRbNdv106SsKEy+/3yOnCB0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NnIXEosRogCmVLHJuB1qce9GIXa/BjaG
	tQaZIt9phiCd+C1zT35Mf0FsVyuB9hbJdxpGP4AP/acUl00KnfF+NoL+8lY88qcp
	4HPcl6781xdMsWNMJaW8AAj+gg/XNizYt3PRJcKsYYVjSCECcjCfhUgLtXGGoGTU
	mmBBRy2l5Cs=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 116324FB7;
	Wed,  2 Mar 2011 22:53:50 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 663194FB0; Wed,  2 Mar 2011
 22:53:43 -0500 (EST)
In-Reply-To: <buo4o7kc4ce.fsf@dhlpc061.dev.necel.com> (Miles Bader's message
 of "Thu\, 03 Mar 2011 11\:42\:09 +0900")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D9370D62-4549-11E0-80C8-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168373>

Miles Bader <miles@gnu.org> writes:

> Michael J Gruber <git@drmicha.warpmail.net> writes:
>>>  Would this ':'
>>> trick affect that argument?  If a command is relative to the cwd with no
>>> pathspec, you can now give a single ':' to affect the whole tree.
>>
>> In my view yes. I would even say: If we don't change every single
>> command to repo-wide default there is no need to change (and break
>> things) if we have an easy one-character way of saying "repo-wide".
>
> ... except, of course that the current state is still confusingly
> inconsistent....

You should know that we are already in violent agreement, if you re-read
my message where I say "a good default matters".
