From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Sources for 3.18-rc1 not uploaded
Date: Wed, 22 Oct 2014 11:42:48 +0200
Message-ID: <54477C18.5060806@drmicha.warpmail.net>
References: <20141020115943.GA27144@gmail.com>	<CA+55aFyDuHskYE66rBVL_P-T2pxg6f2m6mUicfz-mk+ysePBxg@mail.gmail.com>	<20141020222809.GB223410@vauxhall.crustytoothpaste.net>	<CA+55aFyZ1Mzjdx+JsD4jmFnJo+xL8xLz5+mtbh+_25bCak-7hQ@mail.gmail.com>	<54461483.9010600@drmicha.warpmail.net> <xmqqwq7tz3wt.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
	infra-steering@kernel.org, Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 22 11:42:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XgsRS-0007MZ-Tq
	for gcvg-git-2@plane.gmane.org; Wed, 22 Oct 2014 11:42:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932458AbaJVJmv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Oct 2014 05:42:51 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:56191 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932123AbaJVJmu (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Oct 2014 05:42:50 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by gateway2.nyi.internal (Postfix) with ESMTP id B20AA209EC
	for <git@vger.kernel.org>; Wed, 22 Oct 2014 05:42:49 -0400 (EDT)
Received: from frontend1 ([10.202.2.160])
  by compute4.internal (MEProxy); Wed, 22 Oct 2014 05:42:49 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:message-id:date:from
	:mime-version:to:cc:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=dFiKETDnNLXzq6DAL7GHpq
	zlPZU=; b=kucljSuIZysBJnHBLRhiipVtJ/xYKSuS8I7AXAbT7YFltrMccRTt36
	jrAfEX0/Li7vu3iXr0L9yKM/O8A8Z3BzW+BtKygSx+satpNaqG6QvcT7pCL7sX3d
	A5xx27sHb4++24vDGAmul7yM5A04TVu/pLWyhtooraOtkurPuaVbs=
X-Sasl-enc: mFy7so7dggAHfevHlkt+UA9tKyo+mFl54HxwVHC28wJo 1413970969
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id D9C54C00006;
	Wed, 22 Oct 2014 05:42:48 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
In-Reply-To: <xmqqwq7tz3wt.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano schrieb am 21.10.2014 um 20:14:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
>> Unfortunately, the git archive doc clearly says that the umask is
>> applied to all archive entries.
> 
> Is an extended pax header "an archive entry"?  I doubt it, and the
> above is not relevant.  The mode bits for the archive entry that it
> applies to does not come from there.

The problem seem to be old tar versions which mis-take the extensions
for archive entries, aren't they?

> See my other message for my final judgement on this one.  I wouldn't
> have minded if the original used the same umask for those ignored
> mode bits, but changing the bits to be ignored after the fact is not
> helping any real use case and only hurts existing users.
> 
> That is not to say that we cannot later fix bigger issues in the
> output.  I just do not see that otherwise-unused mode bits in the
> extended pax header big enough an issue to spend brain cycles to
> carefully lay and execute transition plans to avoid breaking
> existing users.

My question to Brian still stands which existing users he was trying to
cater for with his patch. If there indeed are no existing affected users
besides the KUP users (as you seem to assume) it's a clear case. Pun
intended ;)

As I pointed out (and you cut out), I don't mind doing the revert. I
just want us to do the right things for the right reasons (the ones you
ponted out, Junio).

Michael
