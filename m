From: Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: whither merge-tree?
Date: Wed, 24 Feb 2016 08:28:59 +0100
Message-ID: <1456298939.5430.1.camel@kaarsemaker.net>
References: <xmqqio1nge5b.fsf@gitster.mtv.corp.google.com>
	 <20160222221209.GA18522@sigill.intra.peff.net>
	 <xmqqsi0k4b52.fsf@gitster.mtv.corp.google.com>
	 <20160223050210.GA17767@sigill.intra.peff.net>
	 <56CC2B2E.6070203@uni-graz.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Stefan =?ISO-8859-1?Q?Fr=FChwirth?= 
	<stefan.fruehwirth@uni-graz.at>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 24 08:29:12 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYTsl-0005u9-HK
	for gcvg-git-2@plane.gmane.org; Wed, 24 Feb 2016 08:29:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757920AbcBXH3F convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 24 Feb 2016 02:29:05 -0500
Received: from mail-wm0-f47.google.com ([74.125.82.47]:35249 "EHLO
	mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757794AbcBXH3D (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2016 02:29:03 -0500
Received: by mail-wm0-f47.google.com with SMTP id c200so255333854wme.0
        for <git@vger.kernel.org>; Tue, 23 Feb 2016 23:29:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kaarsemaker-net.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :content-type:mime-version:content-transfer-encoding;
        bh=bNvMSPsDa/67eTzrnsUi+DOi7qUgTGabNnCqQYMKLp0=;
        b=drn5cgWiPtcJTAilL8cFqLpZkp5Ic7o0QNCkuEUwrNhsVfnbNqgEDglsx1OJE1aWdQ
         COEBDeKM9Ah6wuNqBps3gMD7HEVTRDFz7lyiq2PcInam41K/4Ev/t2ROtEQf0g9NHRbd
         h0ctQ5ZpMFYHgOnHhgyehCx11rZlOhYYBwahGzxebuCvGxf0AQ2RWMlsOeYrQi+q9ohO
         m/eOxUHNi+Z8F/3P1ikPW3iG+L1W9R3lh8B8bR+dgKTqL4GvIkf23tf7cSY8LtoSgwVl
         UAhjL2jI/EVaZ0jz5HLTtUlL+yNuEqvpNHwO+SkW4pMpoe2ybRzKym+bojlNKis/dW4h
         cB9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-type:mime-version:content-transfer-encoding;
        bh=bNvMSPsDa/67eTzrnsUi+DOi7qUgTGabNnCqQYMKLp0=;
        b=cO4ycxB1qUg8/wg8SljMjgnIvOK36L5Fbp3iPY26sJnZNeUj+GmETD9Er1FU69S/fV
         Ei3Nb7FNM0Ef+xkRVnWxsZsYt3mO2+/Eqn8+WoVsfqPjA1pu1MEfJkiA7pLN1p9e+Apz
         jlubM1S2ncvaoHS45WvR2OHv7XESZtnB4nYPG7NbR8Hz8M9GxG9HV+7/9B2CTDIafmV5
         MwufU3qZzZqbix+C+dweDfKb9m2TXCN5pkxMQtX7AlUbL0cHhUGYdHFD3acxxlZ3Qi6O
         DzDIKD+NPbFRSkMcg4/XyUMosYKJjHqiqEKPpjKUZXapc1j/hWsqFc2UnCdLDBq3oVrn
         aW0A==
X-Gm-Message-State: AG10YOSYcrxDNg9rQ4lOKHHaL3ZI6A7dAq2bjgRkeOg7fOQir5trUqJyyIcxXgurrhDUCw==
X-Received: by 10.194.81.103 with SMTP id z7mr36791525wjx.25.1456298941778;
        Tue, 23 Feb 2016 23:29:01 -0800 (PST)
Received: from [10.42.1.4] ([145.132.209.114])
        by smtp.gmail.com with ESMTPSA id x186sm29801759wmg.19.2016.02.23.23.29.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Feb 2016 23:29:00 -0800 (PST)
In-Reply-To: <56CC2B2E.6070203@uni-graz.at>
X-Mailer: Evolution 3.18.4-0ubuntu1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287175>

On di, 2016-02-23 at 10:49 +0100, Stefan Fr=C3=BChwirth wrote:
> On 23.02.2016 at 06:02 Jeff King wrote:
> > > Let's wait and see how many "please don't"s we hear, perhaps,
> > > before
> > > deciding to go 3.?
> >=20
> > I'm guessing we won't see much either way. Even Stefan, the
> > original
> > reporter, does not seem to actively be using it, but rather
> > relaying a
> > report.
>=20
> I _am_ actively using it. Maybe I was unclear on that topic. I'm in=C2=
=A0
> favour of keeping it, because this means I don't have to rewrite
> Chris'=C2=A0
> Code in order to be able to use the Python library that uses merge-
> tree=C2=A0
> (Acidfs). But as a sensible human being I want what's best in the
> long=C2=A0
> run. I leave that up to you as I have no way of assessing that.
>=20
> So that's a "please don't" leave the code as-is but provide a=C2=A0
> (transitional) solution that fixes the reported bug and has the best=C2=
=A0
> chances of not causing any more headaches :)

I am also actively using it. It's the only way (I know of) of trying to
preview a merge result without attempting the actual merge, which is
useful in some of my scripts.

--=20
Dennis Kaarsemaker
www.kaarsemaker.net
