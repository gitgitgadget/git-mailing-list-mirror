From: Magnus =?utf-8?B?QsOkY2s=?= <magnus.back@sonyericsson.com>
Subject: Re: Excluding some refspecs from git push?
Date: Sun, 24 Jul 2011 21:32:40 +0200
Message-ID: <20110724193240.GA16283@jpl.local>
References: <20110724004650.408741c5@x34f>
 <CAH+XAApbbMSPW9XJPjYnmqNiECoWBz5du6CeD_hfAww9o_LcXA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Paul Sokolovsky <paul.sokolovsky@linaro.org>, git@vger.kernel.org,
	repo-discuss <repo-discuss@googlegroups.com>
To: Shawn Pearce <sop@google.com>
X-From: git-owner@vger.kernel.org Sun Jul 24 21:53:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ql4kD-00048y-Tw
	for gcvg-git-2@lo.gmane.org; Sun, 24 Jul 2011 21:53:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752010Ab1GXTxm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 24 Jul 2011 15:53:42 -0400
Received: from smtprelay-b11.telenor.se ([62.127.194.20]:38732 "EHLO
	smtprelay-b11.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751230Ab1GXTxk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jul 2011 15:53:40 -0400
X-Greylist: delayed 1254 seconds by postgrey-1.27 at vger.kernel.org; Sun, 24 Jul 2011 15:53:40 EDT
Received: from ipb1.telenor.se (ipb1.telenor.se [195.54.127.164])
	by smtprelay-b11.telenor.se (Postfix) with ESMTP id D1277EA91C
	for <git@vger.kernel.org>; Sun, 24 Jul 2011 21:32:44 +0200 (CEST)
X-SMTPAUTH-B2: [b627879]
X-SENDER-IP: [83.227.167.132]
X-LISTENER: [smtp.bredband.net]
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AikTABxzLE5T46eEPGdsb2JhbAA0AQEEASkPASclBQwMDgoCAiQOAgIUARwBDQsiF4RWkyuPUQsBAQEBNzKIfAKtCZAPgSuEBTBfBKNS
X-IronPort-AV: E=Sophos;i="4.67,258,1309730400"; 
   d="scan'208";a="209985009"
Received: from ua-83-227-167-132.cust.bredbandsbolaget.se (HELO elwood.jpl.local) ([83.227.167.132])
  by ipb1.telenor.se with ESMTP; 24 Jul 2011 21:32:41 +0200
Received: by elwood.jpl.local (Postfix, from userid 1000)
	id 9440E422CF; Sun, 24 Jul 2011 21:32:40 +0200 (CEST)
Mail-Followup-To: Shawn Pearce <sop@google.com>,
	Paul Sokolovsky <paul.sokolovsky@linaro.org>, git@vger.kernel.org,
	repo-discuss <repo-discuss@googlegroups.com>
Content-Disposition: inline
In-Reply-To: <CAH+XAApbbMSPW9XJPjYnmqNiECoWBz5du6CeD_hfAww9o_LcXA@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177777>

On Sunday, July 24, 2011 at 21:19 CEST,
     Shawn Pearce <sop@google.com> wrote:

> On Sat, Jul 23, 2011 at 14:46, Paul Sokolovsky
> <paul.sokolovsky@linaro.org> wrote:
> > Is there a way to exclude some refspec from being processed by "git
> > push"? What I'm looking for is a syntax like:
> >
> > push some-remote 'refs/*' '!refs/meta/config'
> >
> > , with the meaning of "push all refs except refs/meta/config". What
> > I'm trying to do with this is to find out a generic way to mirror
> > git repositories managed by the Gerrit tool
> > (http://code.google.com/p/gerrit/), which since version 2.2 uses
> > refs/meta/config branch to store repository-local configuration, so
> > should not be mirrored between two Gerrit's.
>=20
> Unfortunately no. But you should be able to just mirror the namespace=
s
> that matter:
>=20
>   refs/heads/*
>   refs/tags/*

Any reason to omit refs/notes/*?

> Its not a good idea to mirror refs/meta/config unless you want the
> same access controls, *AND ITS REALLY NOT A GOOD IDEA TO MIRROR
> refs/changes/* BETWEEN GERRIT SERVERS*. Yes, that last part is worth
> writing in full caps.

Because of the excessive number of refs to advertise for a non-Gerrit
server, or what's the reason for the full caps?

--=20
Magnus B=C3=A4ck                   Opinions are my own and do not neces=
sarily
SW Configuration Manager      represent the ones of my employer, etc.
Sony Ericsson
