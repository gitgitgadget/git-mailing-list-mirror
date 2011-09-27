From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Docs: git checkout --orphan: `root commit' and `branch
 head'
Date: Tue, 27 Sep 2011 10:25:10 -0700
Message-ID: <7v39fhyk21.fsf@alter.siamese.dyndns.org>
References: <1316960136073-6829212.post@n2.nabble.com>
 <1316961212.4388.5.camel@centaur.lab.cmartin.tk>
 <7vaa9r2jii.fsf@alter.siamese.dyndns.org>
 <1317073309.5579.9.camel@centaur.lab.cmartin.tk>
 <e88b6e560cab4ed1937dd191b4180387-mfwitten@gmail.com>
 <4E81F080.7010905@drmicha.warpmail.net>
 <CAMOZ1BsvnZ7PyfjOJURX+B7vCZcYheLS4pissGvPNjEivbYXtw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Carlos =?utf-8?Q?Mart?= =?utf-8?Q?=C3=ADn?= Nieto 
	<cmn@elego.de>, vra5107 <venkatram.akkineni@gmail.com>,
	git@vger.kernel.org
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 27 19:25:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8bPN-0007jS-UI
	for gcvg-git-2@lo.gmane.org; Tue, 27 Sep 2011 19:25:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751220Ab1I0RZQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 27 Sep 2011 13:25:16 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46359 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750928Ab1I0RZO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Sep 2011 13:25:14 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 71B1F500C;
	Tue, 27 Sep 2011 13:25:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=jxIXA5sNzxle
	rXkcnfBFK6bR2qw=; b=pFxw+lH5Z7RW0TYOG+D+Nor0ovyKxL8aBkLKtf3ZAMWg
	vo71x+b7FMUjPem3OCLP6RcBu5+2OTi68nH/+LgT8Wp1LgMbI9tTPzYEybM1FbeM
	x1HweIG4U6w0793fec4F6HuP/e+XSJEFCF9cHtga4acBmzC4Xa/PMUxBhBHe9yE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=nBAH+s
	gHkPJ/taz+WUVKbsDlsTNLlW4Gx754GsW44TedDOWYPeB+DnYGJoMi9QXobkXZf9
	1sqBsKc/VryQQyBnyHSWaCCMXhZyGu4LjV2g8DQZmv9EPOo1W5/U8/AxTanpZARD
	SM1GZrdYyfetUHMoq48TSkT/B4uW3bXM1WZO0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 68A5B500B;
	Tue, 27 Sep 2011 13:25:14 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9FB085007; Tue, 27 Sep 2011
 13:25:11 -0400 (EDT)
In-Reply-To: <CAMOZ1BsvnZ7PyfjOJURX+B7vCZcYheLS4pissGvPNjEivbYXtw@mail.gmail.com> (Michael
 Witten's message of "Tue, 27 Sep 2011 16:02:32 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A7A7184A-E92D-11E0-AB56-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182255>

Michael Witten <mfwitten@gmail.com> writes:

> It seems like a more logical approach would be instead for "git
> commit" to take a "--root" option that would create a new root commit
> based on the current index and then point the current branch head to
> the new root commit. Thus:
>
>   $ git checkout -b new_branch old_branch
>   $ # Manipulate or not
>   $ git commit --root
>
> That's how people think.

This may indeed be an improvement. I suspect that we'd need to think ab=
out
it a bit more, but it feels right (perhaps introduce this new option,
deprecate --orphan from the checkout, and then eventually remove it
sometime in 1.8.0 timeframe).

>>> =C2=A0The index and the working tree are adjusted as if you had pre=
viously run
>>> =C2=A0"git checkout <start_point>". =C2=A0This allows you to start =
a new history
>>> -that records a set of paths similar to <start_point> by easily run=
ning
>>> +that records a set of paths similar to <start_point> by just runni=
ng
>>> =C2=A0"git commit -a" to make the root commit.
>>
>> "similar" is an understatement here, maybe "as in"?

I do not think "as in" is an improvement. It completely ignores the
"Manipulate or not" part in the above, and "similar" was very much an
attempt to say "you do not have to commit it right away, but start from
the state and commit a deviation of it".
