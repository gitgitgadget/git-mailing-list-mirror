From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] git-web--browse: invoke kfmclient directly
Date: Mon, 19 Sep 2011 14:32:24 -0700 (PDT)
Message-ID: <m38vpkrzhq.fsf@localhost.localdomain>
References: <20110918032933.GA17977@sigill.intra.peff.net>
	<1316341224-4359-1-git-send-email-judge.packham@gmail.com>
	<20110918183846.GA31176@sigill.intra.peff.net>
	<7vvcso9zzi.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-4
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Chris Packham <judge.packham@gmail.com>,
	git@vger.kernel.org, chriscool@tuxfamily.org, jepler@unpythonic.net
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 19 23:32:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R5lS3-0001Uy-AV
	for gcvg-git-2@lo.gmane.org; Mon, 19 Sep 2011 23:32:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932335Ab1ISVc0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 19 Sep 2011 17:32:26 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:64946 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932213Ab1ISVc0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Sep 2011 17:32:26 -0400
Received: by fxe4 with SMTP id 4so4399086fxe.19
        for <git@vger.kernel.org>; Mon, 19 Sep 2011 14:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=IoMTBnt76YGlRKKTTnoPaiKJbC6sXYF26CM5VdWlX18=;
        b=huXJKRJRlXMrxFw1Id9XSy5GJO6tEaUwxjGV3419oApnp5a2I9vleYrtX8FSYvl4cR
         fS5mCnfCRnCk3z35BxYuyomZ6r7HolgxdFwwdIsDfx8irc0OiABNAuAKtF1WsATutp48
         VntcNOVB4GMaJc1Bs7ngs4HmlkZY0qcjsv7C8=
Received: by 10.223.33.19 with SMTP id f19mr5670576fad.122.1316467944943;
        Mon, 19 Sep 2011 14:32:24 -0700 (PDT)
Received: from localhost.localdomain (abvo48.neoplus.adsl.tpnet.pl. [83.8.212.48])
        by mx.google.com with ESMTPS id x22sm22929922faa.5.2011.09.19.14.32.23
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 19 Sep 2011 14:32:24 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p8JLVXGT016223;
	Mon, 19 Sep 2011 23:31:44 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id p8JLUwoI016211;
	Mon, 19 Sep 2011 23:30:58 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <7vvcso9zzi.fsf@alter.siamese.dyndns.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181709>

Junio C Hamano <gitster@pobox.com> writes:
> Jeff King <peff@peff.net> writes:
>=20
> > If you want to make a test, I think you would do better with someth=
ing
> > like:
> >
> >   echo someurl_with_&_in_it >expect &&
> >   git config browser.custom.cmd echo &&
> >   git web--browse --browser=3Dcustom someurl_with_&_in_it >actual &=
&
> >   test_cmp expect actual
> >
> > That won't test that we are invoking kfmclient correctly, obviously=
, but
> > you can confirm at least that URLs are making it through to the bro=
wser
> > script intact.
>=20
> Hmm, isn't '&' somewhat an unusual in URL? ...ah, not really, if it i=
s in
> the query parameter part it is quite common.

In newstyle URLs the name=3Dvalue pairs in CGI parameter query string
are separated with semicolons ';' rather than ampersands '&', because
of problem with & <-> &amp;.

Just FYI.
--=20
Jakub Nar=EAbski
