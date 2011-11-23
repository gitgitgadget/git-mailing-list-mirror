From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Fix revert --abort on Windows
Date: Wed, 23 Nov 2011 18:23:08 +0100
Message-ID: <CALxABCZ=phbFwUPNX+z8CeLGSsr03kULcxX3E7zepZDOGyb2jA@mail.gmail.com>
References: <20111120073059.GA2278@elie.hsd1.il.comcast.net>
 <CALkWK0=45OwcBoH2TorsgwTbaXjnffVuh0mGxh2+ShN9cuF-=A@mail.gmail.com>
 <20111120094650.GB2278@elie.hsd1.il.comcast.net> <20111122111207.GA7399@elie.hsd1.il.comcast.net>
 <20111122112001.GF7399@elie.hsd1.il.comcast.net> <7vr50zd5x0.fsf@alter.siamese.dyndns.org>
 <20111123012721.GA14217@elie.hsd1.il.comcast.net> <4ECCB3A2.5030102@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>, git@vger.kernel.org,
	Christian Couder <chriscool@tuxfamily.org>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Phil Hord <phil.hord@gmail.com>,
	Jay Soffian <jaysoffian@gmail.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Nov 23 18:23:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RTGXn-000136-Ee
	for gcvg-git-2@lo.gmane.org; Wed, 23 Nov 2011 18:23:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753919Ab1KWRXa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 23 Nov 2011 12:23:30 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:46090 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752421Ab1KWRXa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Nov 2011 12:23:30 -0500
Received: by vbbfc26 with SMTP id fc26so697519vbb.19
        for <git@vger.kernel.org>; Wed, 23 Nov 2011 09:23:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=qmFdJySwktTrIWazFkfEVs7/Kn/CiNSLQlw1Z4BI7lg=;
        b=dqIBEO10AqUSgAi08rcXe1QG/5ZmJUwLwKDCZ4zEAPwoqddWFtr7TouUPfuSauaN01
         BceQREi13OAnZws1QhS+BJtr4Ux6TMdxP8uyR0grBqXIOJJWTNbqnwLAIZ1tiRw8s1ej
         wtc3IGB0BHw01jVkHf5ispWAxSEim2ei5PyQo=
Received: by 10.182.141.68 with SMTP id rm4mr8713611obb.23.1322069009196; Wed,
 23 Nov 2011 09:23:29 -0800 (PST)
Received: by 10.182.121.8 with HTTP; Wed, 23 Nov 2011 09:23:08 -0800 (PST)
In-Reply-To: <4ECCB3A2.5030102@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185857>

On Wed, Nov 23, 2011 at 09:49, Johannes Sixt <j.sixt@viscovery.net> wro=
te:
> From: Johannes Sixt <j6t@kdbg.org>
>
> On Windows, it is not possible to rename or remove a directory that h=
as
> open files. 'revert --abort' renamed .git/sequencer when it still had
> .git/sequencer/head open. Close the file as early as possible to allo=
w
> the rename operation on Windows.
>
> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
> ---
> =C2=A0I guess it's too late to squash this in. ;)
>

Just made a patch for this of my own (noticed it on Cygwin), should hav=
e
looked in the archives first. Thanks!

The minority platforms can wait, I guess :)
