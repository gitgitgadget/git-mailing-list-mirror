From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Regression in `git add' in 1.7's 48ffef966c with a wildcard in
  .gitignore
Date: Mon, 08 Mar 2010 21:06:02 +0100
Message-ID: <4B9558AA.90907@drmicha.warpmail.net>
References: <51dd1af81003080908i3bc94f27lc99e146bb57993ba@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 08 21:05:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NojD7-0005BG-O5
	for gcvg-git-2@lo.gmane.org; Mon, 08 Mar 2010 21:05:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755575Ab0CHUFt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Mar 2010 15:05:49 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:35792 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755411Ab0CHUFr (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Mar 2010 15:05:47 -0500
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 1A2DBE32AE;
	Mon,  8 Mar 2010 15:05:47 -0500 (EST)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Mon, 08 Mar 2010 15:05:47 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=DLzIzy8qKccGf7mxIWzTHAuinIc=; b=TjjM5pk26/s9zHqmga60f7UrxV5LqJZ56QFnjlptdjEIQc50poHFbL2hImPwmLn2p2Ara/eN/e1/EfiH9z9nb314jKFofyR/QAgL2Rcac36nGnSgW7twRSR9ZYTh7xts/QbowC4DaHLR/6LF6sbldrOXKujW+fRp3uMQNii5lYM=
X-Sasl-enc: QPvt7AL05IsTzYMAjU+9xy5dy5Atd7t82Lyfd8SwwTWR 1268078746
Received: from localhost.localdomain (gast-99-220.tagung.uni-jena.de [141.35.99.220])
	by mail.messagingengine.com (Postfix) with ESMTPSA id D0CB74CBF9D;
	Mon,  8 Mar 2010 15:05:45 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.9pre) Gecko/20100301 Lightning/1.0b2pre Shredder/3.0.3pre
In-Reply-To: <51dd1af81003080908i3bc94f27lc99e146bb57993ba@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141781>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason venit, vidit, dixit 08.03.2010 1=
8:08:
> I've discovered a regression in git-add the 1.7 release which I can't
> see reported anywhere. It was introduced in
> 48ffef966c762578eb818c0c54a7e11dd054f5db by Junio C Hamano at Fri Jan
> 8 23:05:41 2010.
>=20
> The problem is that when you have a .gitignore file with * in it
> git-add will only complain that you're trying to add ignored files if
> they're in the top level of your repository, for files in
> subdirectories it now just silently fails:
>=20
>     $ mkdir test && cd test && git init
>     $ echo "*" > .gitignore
>     $ mkdir directory && touch foo directory/foo

Could this possibly be fixed by 13bb0ce (builtin-add: fix exclude
handling, 2010-02-28) which is on pu?

Michael
