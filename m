From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Performance issue: initial git clone causes massive repack
Date: Tue, 07 Apr 2009 02:45:41 -0700 (PDT)
Message-ID: <m3tz5023rq.fsf@localhost.localdomain>
References: <20090404220743.GA869@curie-int> <20090405000536.GA12927@vidovic>
	<20090405T001239Z@curie.orbis-terrarum.net>
	<20090405035453.GB12927@vidovic> <20090405070412.GB869@curie-int>
	<20090405190213.GA12929@vidovic>
	<alpine.DEB.1.10.0904051419490.6245@asgard.lang.hm>
	<fabb9a1e0904051436i1dc9c1bdhe86a23e470c756f9@mail.gmail.com>
	<alpine.LFD.2.00.0904052315210.6741@xanadu.home>
	<20090407081019.GK20356@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nicolas Pitre <nico@cam.org>,
	Sverre Rabbelier <srabbelier@gmail.com>, david@lang.hm,
	Junio C Hamano <gitster@pobox.com>,
	Nicolas Sebrecht <nicolas.s-dev@laposte.net>,
	"Robin H. Johnson" <robbat2@gentoo.org>,
	Git Mailing List <git@vger.kernel.org>
To: =?iso-8859-15?q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Tue Apr 07 11:47:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lr7tm-0005C8-4s
	for gcvg-git-2@gmane.org; Tue, 07 Apr 2009 11:47:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752214AbZDGJpr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Apr 2009 05:45:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752045AbZDGJpq
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Apr 2009 05:45:46 -0400
Received: from wf-out-1314.google.com ([209.85.200.173]:5503 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751901AbZDGJpp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Apr 2009 05:45:45 -0400
Received: by wf-out-1314.google.com with SMTP id 29so2690983wff.4
        for <git@vger.kernel.org>; Tue, 07 Apr 2009 02:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=DMqPYWq5z0bvf3i9HKgpyjTfLrVAnIrfHq/x/9zgDRU=;
        b=FyBSOCRPKWgRt3hpzFJQRiosnovP+vPtqKsuZ8wA+G1FW/XK2hGhUwocCZ4F67WLP1
         9x8844R9XyTM56XW43laeFgTYpT0AqoDKC9nqvPo0+6REG+dYDsYpS+iqCyylLQRRy9N
         7wE/holAzQN7EykgusQyw1rWGuHRGN3IGp8cA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        b=K/JYdj5+AXo+fy6CIN2qlH31veoRU0l2lNjX3b3GMFMERQXONDuGfQgTJ6526wbDDM
         9u09RNh7LDcFthlDqqVf0WFQXHkwZ9KaVsA0gXKPIJdiKnnOsy+khCKEtjsdmf9Ja3Sh
         hrolO2wNeEAhaQYYeT5Q2Y+g99H3XzYg+TV7g=
Received: by 10.142.186.15 with SMTP id j15mr1574757wff.271.1239097543025;
        Tue, 07 Apr 2009 02:45:43 -0700 (PDT)
Received: from localhost.localdomain (abvx71.neoplus.adsl.tpnet.pl [83.8.221.71])
        by mx.google.com with ESMTPS id 31sm1643614wff.35.2009.04.07.02.45.39
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 07 Apr 2009 02:45:41 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n379mSia019163;
	Tue, 7 Apr 2009 11:48:29 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n379mPwq019160;
	Tue, 7 Apr 2009 11:48:25 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20090407081019.GK20356@atjola.homenet>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115941>

Bj=F6rn Steinbrink <B.Steinbrink@gmx.de> writes:
> On 2009.04.05 23:24:27 -0400, Nicolas Pitre wrote:
> > On Sun, 5 Apr 2009, Sverre Rabbelier wrote:
> > >=20
> > > I agree here, we should either say "look, we don't really support=
 big
> > > repositories because [explanation here], unless you [workarounds
> > > here]" OR we should work to improve the support we do have. Of co=
urse,
> > > the latter option does not magically create developer time to wor=
k on
> > > that, but if we do go that way we should at least tell people tha=
t we
> > > are aware of the problems and that it's on the global TODO list (=
not
> > > necessarily on anyone's personal TODO list though).
> >=20
> > For the record... I at least am aware of the problem and it is inde=
ed on=20
> > my personal git todo list.  Not that I have a clear solution yet (I=
've=20
> > been pondering on some git packing issues for almost 4 years now).
> >=20
> > Still, in this particular case, the problem appears to be unclear t=
o me,=20
> > like "this shouldn't be so bad".
>=20
> It's not primarily pack-objects, I think. It's the rev-list that's ru=
n
> by upload-pack.  Running "git rev-list --objects --all" on that repo
> eats about 2G RSS, easily killing the system's cache on a small box,
> leading to swapping and a painful time reading the packfile contents
> afterwards to send them to the client.

Than I think that "packfile caching" GSoC project (which is IIRC
"object enumeration caching", or at least includes it) should help
here.  You would, from what I understand, run "git rev-list -objects
--all --not <tops of cache>" + sequential read of object enumeration
cache...

--=20
Jakub Narebski
Poland
ShadeHawk on #git
