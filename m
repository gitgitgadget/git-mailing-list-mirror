From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH] doc: enhance git describe --tags help
Date: Tue, 30 Sep 2008 12:09:16 +0200
Message-ID: <48E1FACC.2010204@op5.se>
References: <ce513bcc0809280648s352cda3fj5eb35b6e9cd40af9@mail.gmail.com> <20080928135526.GG5302@artemis.corp> <ce513bcc0809280729p47cc3790nb77b3cae8b805221@mail.gmail.com> <20080928143949.GH5302@artemis.corp> <20080928150318.GI5302@artemis.corp> <20080928151259.GJ5302@artemis.corp> <20080929150127.GB18340@spearce.org> <20080930095641.GA9001@strlen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Pierre Habouzit <madcoder@debian.org>,
	Erez Zilber <erezzi.list@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	open-iscsi@googlegroups.com, Junio C Hamano <gitster@pobox.com>
To: =?ISO-8859-15?Q?Uwe_Kleine-K=F6nig?= <ukleinek@strlen.de>
X-From: git-owner@vger.kernel.org Tue Sep 30 12:10:39 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KkcBd-0000Lf-Ku
	for gcvg-git-2@gmane.org; Tue, 30 Sep 2008 12:10:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752570AbYI3KJX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 30 Sep 2008 06:09:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752532AbYI3KJW
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Sep 2008 06:09:22 -0400
Received: from mail.op5.se ([193.201.96.20]:47558 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752525AbYI3KJW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Sep 2008 06:09:22 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id F1F6E24B0004;
	Tue, 30 Sep 2008 12:00:37 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LfntP4JbWJzs; Tue, 30 Sep 2008 12:00:36 +0200 (CEST)
Received: from clix.int.op5.se (unknown [172.27.78.22])
	by mail.op5.se (Postfix) with ESMTP id 42CBD1B80007;
	Tue, 30 Sep 2008 12:00:35 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
In-Reply-To: <20080930095641.GA9001@strlen.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97088>

Uwe Kleine-K=F6nig wrote:
> Hello,
>=20
> On Mon, Sep 29, 2008 at 08:01:27AM -0700, Shawn O. Pearce wrote:
>> --tags::
>> 	If a lightweight tag exactly matches, output it.  If no
>> 	annotated tag is found in the ancestry but a lightweight
>> 	tag is found, output the lightweight tag.
> IMHO --tags should behave as Erez expected (because it's what I
> expected, too).  As --tags currently behaves it's only usable in very
> rare cases (most of the time it only makes a difference on repos with=
out
> any annotated tag).
>=20
> When do you pass --tags?  Only if a lightweight tag is OK for an answ=
er.
> And then I would prefer a "near" lightweight tag to a "farer" annotat=
ed
> one.
>=20

The reason lightweight tags aren't considered is that they're often put
somewhere to just mark some refs one wants to keep around, or as a sort
of movable snapshot marker (we have "latest/build", "latest/tested" etc
as lightweight tags). It's nifty to use lw tags for that since they can=
't
be committed to by accident. That doesn't mean we want 'git describe' t=
o
start outputting "latest-build" whenever we want to pull a version numb=
er
from it though.

This was especially true before the creation of "git stash" and the ref=
log,
but quite a lot of people still use them for similar purposes.

In short; "git describe" output stays the way it is, or things will sta=
rt
unexpectedly breaking for quite a lot of people.

--=20
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
