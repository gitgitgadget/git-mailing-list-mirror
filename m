From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 1/4] Refactor skipping DOS drive prefixes
Date: Mon, 11 Jan 2016 10:32:36 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1601111029540.2964@virtualbox>
References: <25a2598e756959f55f06ae6b4dc6f448e3b6b127.1443624188.git.johannes.schindelin@gmx.de> <cover.1452270051.git.johannes.schindelin@gmx.de> <c70ed05f275a44fbfae831b4cb67e59a0ce05724.1452270051.git.johannes.schindelin@gmx.de>
 <CAPig+cRRaMbEGibYnQBTfGFQT6fybNU8e6ZAkX11V-TLAo9AfA@mail.gmail.com> <xmqq8u3z20aj.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 11 10:32:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aIYqJ-0001ry-N2
	for gcvg-git-2@plane.gmane.org; Mon, 11 Jan 2016 10:32:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757743AbcAKJcs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jan 2016 04:32:48 -0500
Received: from mout.gmx.net ([212.227.17.20]:60540 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750813AbcAKJcr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jan 2016 04:32:47 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0MTfZc-1air9L0Ek4-00QWEC; Mon, 11 Jan 2016 10:32:39
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <xmqq8u3z20aj.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:AwJfm/HbwUCgHa65WIsGmc5FlyUrSfzw7V+/owIg1L4ZiOpXwrT
 +GmMRzoiajnQMQxGfTip56zgj310j8v5/gYYJMjGbs6Jd86vZOw0biM6ortg8tJX3Z69JPk
 ypkrIOJYhiPF6M80LifFmT+8rJ3+awCzm1H6NFBYChzQ//EHBHZXV5aLe62UlSkJeGOXIwd
 GMQxF9kpsF0kd0imqtCAA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:xSNfBiBMTVA=:4r5MAjc/XQhsjOsV2Sk8Yb
 YBY5sn/djuv/W+niTAJI34PMScNIiMWf934xc0l5HXlAW7ZSJDqy9Ly8nOLmUt9cfKenNsCnG
 mOFnLa3nVeim7BgY3NLzQlua0niMu3/OdKoOxxGLZkNlmS+8fyHhs3O8Cs2lKP4F7hdsj6gXZ
 ZjodyhM6TXgZuMryKSKxQ0lOWkaREEFczys6HB70WcGQOARQLOP6QjlajCgST1wRfj7KKtNNt
 vIPI6NWCrpDpUbQFVoOGTOAeVZeOIAC8MdpI+vBr0TGSYZDZ3xixq6s6fXthHMlerkFw1BXK0
 iJlQLU2wxCIT/jg1eOQ/n8sOzFGSqhipe+rzK7e1ctAXf3hVptbagJ+U+1yKhtRrFyoL1dCCd
 PsJ6T6nDPoskBlAt7P3Hv2oe8AmFVTBYPbNejWU0wXGCW4F+jJk7B/nt/ib7lO8d/L5oePcFa
 B38bxEhAha4TpCcCrArrC0iwtKtb02J0elb1AyNtMh1g9mrukQ5xKQqmzs6WJYjfwuIq3/4MA
 znrhwHq9BOwOBnJgZASM5dj2nDHSFQeh0c/DNRso/vBeenHJliy/PmsyecSk3LgrBSkmAe0hw
 +KsoG6nzAr2qoQW2LDr9ujApb5Qeu4nBCKu92seGKwQNLfe2p3GM/BDx2MfxGKdBjlORzvMH7
 IG/Mbrk91Er3qYxA1h92/Ant6ljy2gV2vxpbZAQfwR9DJ4yHvKxkL3yQp90tyGNWZ6hf2sHm3
 SfY55lEaB4niYCRqMQwf0NxC+yoRQpu7o2sey29xQ+k4CxJ5s6upLu1F4I4zEwHEEUXa++Y7 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283642>

Hi Eric & Junio,

On Fri, 8 Jan 2016, Junio C Hamano wrote:

> Eric Sunshine <sunshine@sunshineco.com> writes:
> 
> > With this change, code such as:
> >
> >     for (i = has_dos_drive_prefix(src); i > 0; i--)
> >         ...
> >
> > in path.c reads a bit oddly. Renaming the function might help. For instance:
> >
> >     for (i = dos_drive_prefix_len(src); i > 0; i--)
> >         ...
> 
> Renaming may be unnecessary churn, but I do not think we mind an
> additional synonym, e.g.
> 
>     #define has_dos_drive_prefix(x) dos_drive_prefix_len(x)
> 
> if some people prefer.

I am actually not so sure about this: if I read
`dos_drive_prefix_len(path)` I would have assumed the return value to be
-1 if `path` does not, in fact, have a DOS drive prefix.

Sure, returning the length of the DOS drive prefix when just asking
whether it has one is a bit surprising at first, but it also makes sense:
we already have that information, so we might just as well use it.

In any case, I think this change (if it is really considered desirable)
could easily be an add-on patch by people who care about this ;-)

Ciao,
Dscho
