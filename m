From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: git repository modified after migration
Date: Tue, 12 Jan 2016 08:01:58 +0100
Message-ID: <5694A4E6.6020508@drmicha.warpmail.net>
References: <CAFwKRnQ_EZ73DBfrb0HNks3dt3=YJbLRoHvB0mfsD9FA-ey6hA@mail.gmail.com>
 <5693C48A.7060801@drmicha.warpmail.net>
 <xmqq4mekx9ld.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Cc: Yang Yu <yang.yu.list@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 12 08:02:08 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aIsxz-0000dr-Cr
	for gcvg-git-2@plane.gmane.org; Tue, 12 Jan 2016 08:02:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761289AbcALHCC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jan 2016 02:02:02 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:34319 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759870AbcALHCA (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Jan 2016 02:02:00 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id D52FF211A9
	for <git@vger.kernel.org>; Tue, 12 Jan 2016 02:01:59 -0500 (EST)
Received: from frontend1 ([10.202.2.160])
  by compute6.internal (MEProxy); Tue, 12 Jan 2016 02:01:59 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=nGOwGF1WxtZLPvs+hep1Y0K16qQ=; b=MMtl9X
	SFxz09a33iG53JwQxvhm6bjVc20z4D+qlFCeyz61Rby+vc7J1xtH63mlaFm0gCSk
	kJLvGale7qjKzWDChSai2j3JWk4+coY/0eRgY/2+g5IOU2vf4sh/NYLF5mOWN+fa
	RB+TYGt1JwiaYjB02b4H2RnHI5xlHqQPycZ8E=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=nGOwGF1WxtZLPvs
	+hep1Y0K16qQ=; b=OagOR2Sk///USQcAsYpNqA9ChQXgTanafet5B5NDalMLupw
	Gp3s7sf9GUhTraOPa1bQBhGRM0gWsblyXczBGVqcaYqJ3kyD4D40qa211eXzg1af
	uwQSh7e00oQd4oTmY30uGcGhZal2pRIlYPEhbokU9N710DN1CHEcJFbTlP8k=
X-Sasl-enc: IH8S/jbYxwsyKl4L20/0no2ecjwlznYVQimUop9R/aIk 1452582119
Received: from skimbleshanks.math.uni-hannover.de (skimbleshanks.math.uni-hannover.de [130.75.46.4])
	by mail.messagingengine.com (Postfix) with ESMTPA id 49334C00017;
	Tue, 12 Jan 2016 02:01:59 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.0
In-Reply-To: <xmqq4mekx9ld.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283769>

Junio C Hamano venit, vidit, dixit 11.01.2016 19:19:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
>> This happens whenever the "stat" information changes, e.g. due to
>> changed device numbering and such. "git reset --hard" would have been
>> the quickiest way to reset the stat cache/index - after git diff, of
>> course ;)
> 
> That does not quite explain why 'git status' reported modified files
> in the first place.  It would have refreshed the cached stat info in
> the index as the first thing to do.  "git status" I think is the
> recommended way these days ("update-index --refresh" for us old
> timers) to nondestructively correct the cached stat information
> discrepancy caused by "cp -R".
> 
> If you need to resort to "reset --hard", then there is something
> else going on.

Back than when I had the same problem with git repos on removable file
systems (if I remember correctly) git status did not correct that
information. It may be different now.

Michael
