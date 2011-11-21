From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 1/3] revert: rename --reset option to --quit
Date: Mon, 21 Nov 2011 14:35:33 -0800 (PST)
Message-ID: <m3bos5m7ez.fsf@localhost.localdomain>
References: <20111120073059.GA2278@elie.hsd1.il.comcast.net>
	<CALkWK0=45OwcBoH2TorsgwTbaXjnffVuh0mGxh2+ShN9cuF-=A@mail.gmail.com>
	<20111120094650.GB2278@elie.hsd1.il.comcast.net>
	<20111120094824.GC2278@elie.hsd1.il.comcast.net>
	<7vpqglfc1k.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-4
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>, git@vger.kernel.org,
	Christian Couder <chriscool@tuxfamily.org>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Phil Hord <phil.hord@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 21 23:35:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RScSj-0005SG-94
	for gcvg-git-2@lo.gmane.org; Mon, 21 Nov 2011 23:35:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752645Ab1KUWfg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 21 Nov 2011 17:35:36 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:61828 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751332Ab1KUWfg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Nov 2011 17:35:36 -0500
Received: by bke11 with SMTP id 11so7150351bke.19
        for <git@vger.kernel.org>; Mon, 21 Nov 2011 14:35:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=GHhffYXDEjG+nKCBSLOUDAAluD6YCvtqsbXZpbVGb9A=;
        b=ujnyDSRVqZK1a8PvbH/jK1KfKv4FQo6jf8JCDOLy3+OA8Uag5ZIh+lRGwikpntS5Pj
         sMs8hPJqZ055DN/fUV5dPC2tKyVvJ+lbR7ze+He1AzQazB/cizUfFNasYti6fs06QN6k
         EBZkX+rl22kesK4nNCKfzPTY2/aH93Z+ZnaxE=
Received: by 10.205.128.15 with SMTP id hc15mr15902413bkc.110.1321914934727;
        Mon, 21 Nov 2011 14:35:34 -0800 (PST)
Received: from localhost.localdomain (abwj146.neoplus.adsl.tpnet.pl. [83.8.233.146])
        by mx.google.com with ESMTPS id l18sm16877131fab.9.2011.11.21.14.35.32
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 21 Nov 2011 14:35:33 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id pALMYpTW026686;
	Mon, 21 Nov 2011 23:35:01 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id pALMYTRf026674;
	Mon, 21 Nov 2011 23:34:29 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <7vpqglfc1k.fsf@alter.siamese.dyndns.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185767>

Junio C Hamano <gitster@pobox.com> writes:
> Jonathan Nieder <jrnieder@gmail.com> writes:
>=20
> > The option to "git cherry-pick" and "git revert" to discard the
> > sequencer state introduced by v1.7.8-rc0~141^2~6 (revert: Introduce
> > --reset to remove sequencer state, 2011-08-04) has a confusing name=
=2E
> > Change it now, while we still have the time.
> >
> > Mechanics:
> >
> > This commit removes the "git cherry-pick --reset" option.  Hopefull=
y
> > nobody was using it.  If somebody was, we can add it back again as =
a
> > synonym.
> >
> > The new name for "cherry-pick, please get out of my way, since I've
> > long forgotten about the sequence of commits I was cherry-picking w=
hen
> > you wrote that old .git/sequencer directory" is --quit. =20
>=20
> Wouldn't it match other commands better if we called this --abort ins=
tead
> of --quit?

Actually from what I understand --reset / --quit has to have different
meaning than --abort.  While for multi-commit operation --abort goes ba=
ck
to the state before last operation, --reset / --quit just clears sequen=
cer
state, but does not change working area, nor index, not HEAD.  This is =
to
be used when encounering stale old rebase / am / cherry-pick / revert.

BTW. I think that '--clear' (or '--clear-state') would be a better name
for this option.
=20
> Other than that I think I agree with the reasoning (and I think I too=
 had
> encountered the irritation with the "sequencer state").

--=20
Jakub Nar=EAbski
