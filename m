From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] Add .gitconfig variable commit.gpg-sign
Date: Wed, 24 Apr 2013 11:51:12 +0200
Message-ID: <5177AB10.30209@drmicha.warpmail.net>
References: <CAASwCXf3YHmdQ_eSkShyzn5VniO=ufm3VTqV1JVOUN610bzE_A@mail.gmail.com> <7vip3em8rs.fsf@alter.siamese.dyndns.org> <CAASwCXcfCNqiMXD5JasTRKWZgCNsxnUY7k9E=f86xsTZjk37CA@mail.gmail.com> <51767290.2010208@drmicha.warpmail.net> <7va9opi163.fsf@alter.siamese.dyndns.org> <CAASwCXdhgNPzm51MfWTCTNYQwT0gC-UbV7xTNGcXhs6k9f4wsQ@mail.gmail.com> <7v1ua1hwx6.fsf@alter.siamese.dyndns.org> <CAASwCXcs8Q7qGWSNKttEuk0zPetDWNCse4J-KSm20r9h5XSo3Q@mail.gmail.com> <51779DA1.7080606@physik.tu-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Joel Jacobson <joel@trustly.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: =?ISO-8859-1?Q?Sebastian_G=F6tte?= <jaseg@physik.tu-berlin.de>
X-From: git-owner@vger.kernel.org Wed Apr 24 11:51:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUwM4-0003YS-98
	for gcvg-git-2@plane.gmane.org; Wed, 24 Apr 2013 11:51:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932269Ab3DXJvH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 24 Apr 2013 05:51:07 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:52887 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757617Ab3DXJvG (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 24 Apr 2013 05:51:06 -0400
Received: from compute4.internal (compute4.nyi.mail.srv.osa [10.202.2.44])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id B356420E33;
	Wed, 24 Apr 2013 05:51:04 -0400 (EDT)
Received: from frontend1.nyi.mail.srv.osa ([10.202.2.160])
  by compute4.internal (MEProxy); Wed, 24 Apr 2013 05:51:04 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=ENfBuAFFQgZ/Mjc8tHRB9V
	BnbVE=; b=DdZqI7NgcxAmymieheWKAx9zhO59hCmj10Y0IhK8Yo80ag+h7mltyd
	9viPpxVAkdg5mMjkxeHfSMV060oFXVxpzuYNz+jVLOSm1d5Q0B+wvJZy3pYAMgwY
	6XrZc/06c7ENJSdQ75w2Rt5RGhwvw4XMHqFdGegX13kMB1DbeP0Nw=
X-Sasl-enc: wpG99qRM3rwS6KQdhuUUG6aUEK4cXj/W/UCLB/ZWH6nN 1366797064
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id F1E8DC8000E;
	Wed, 24 Apr 2013 05:51:03 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130402 Thunderbird/17.0.5
In-Reply-To: <51779DA1.7080606@physik.tu-berlin.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222244>

Sebastian G=F6tte venit, vidit, dixit 24.04.2013 10:53:
> On 04/23/2013 09:56 PM, Joel Jacobson wrote:
>>> But stepping back a bit, I have a suspicion that your upstream
>>> project _only_ cares about what you feed them (either by pushing
>>> your work yourself to them, or telling them to pull from your
>>> repository).  There is no reason for you to be constantly signing
>>> your commits you make during your exploratory development that you
>>> may throw-away in the end.
>>
>> Your suspicions are correct.
>> But I'm a bit paranoid, so it feels better to sign even local commit=
s.
>>
>>> It _might_ be a better option to just teach "-S" option to "git
>>> rebase" that tells it to replay all the commits with "commit -S",
>>> instead of adding commit.gpgSign configuration.
>>
>> In my case, I don't do that much exploratory development locally,
>> so I usually just commit, pull and push.
>>
>> Always signing everything can't really hurt, can it? Takes a few clo=
ck
>> cycles more, and a few more bytes, but apart from that I don't see a=
ny
>> problems?
> I have my GPG-keys password-protected, and I would be severely annoye=
d by
> GnuPG password prompts popping up on every commit. I think the -S opt=
ion
> to rebase would be the more elegant way. What could be nice would be =
a
> config option that makes "git push" warn/abort in case I try to push =
an
> unsigned head commit to a repo where I want to have signed commits:
>> remote.<name>.abortUnsigned
> This of course needs an command line override switch.

This appears to be more suited for a server side hook (update), or a ne=
w
pre-push hook.

> Something to be considered is whether "git rebase -S" should sign *ev=
ery*
> commit in the series or only the *head* commit.

The idea is probably to sign a commit that used to signed?

Otherwise, "git commit --amend -S" is your friend, either during rebase
(for individual commits) or after (for the head commit).

Michael
