From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH v2] git svn : hook before 'git svn dcommit'
Date: Sat, 20 Aug 2011 18:41:49 +0000
Message-ID: <20110820184149.GA32688@dcvr.yhbt.net>
References: <1313438699-9926-1-git-send-email-frederic.heitzmann@gmail.com>
 <7vty9ijs1i.fsf@alter.siamese.dyndns.org>
 <20110817003023.GA30153@dcvr.yhbt.net>
 <CALeToSWJNK=q4iPwxNvgGin0T61oLKJd=b9F3cSSo0vVebrhhQ@mail.gmail.com>
 <CALeToSUidWgiJ+PxuphnBZOQGNStNOO9==EswfLDpFr2GYy=nA@mail.gmail.com>
 <20110817203701.GB24581@dcvr.yhbt.net>
 <CALeToSUUJ4egjU_Pduub4VC+CJ3b2YSvPFEfJikRMsm9w4Ad5w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?RnLDqWTDqXJpYw==?= Heitzmann 
	<frederic.heitzmann@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 20 20:46:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QuqYq-00031s-44
	for gcvg-git-2@lo.gmane.org; Sat, 20 Aug 2011 20:46:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754704Ab1HTSlv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 20 Aug 2011 14:41:51 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:58614 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754388Ab1HTSlu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Aug 2011 14:41:50 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id A7B72210A5;
	Sat, 20 Aug 2011 18:41:49 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <CALeToSUUJ4egjU_Pduub4VC+CJ3b2YSvPFEfJikRMsm9w4Ad5w@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179771>

=46r=C3=A9d=C3=A9ric Heitzmann <frederic.heitzmann@gmail.com> wrote:
> 2011/8/17 Eric Wong <normalperson@yhbt.net>:
> >> 2011/8/17 Eric Wong <normalperson@yhbt.net> wrote:
> >> > Perhaps an interactive option for dcommit would be just as usefu=
l?
> >
> > 1 and 3 can both implemented, but I think 3 would be easier to
> > use/setup/standardize. =C2=A0I suspect it's also easier to train on=
eself to
> > always use "dcommit -i". =C2=A0Perhaps even default to interactive =
mode
> > like git-send-email does nowadays.
> >
> > Unfortunately interactive dcommit requires more effort to implement=
=2E
>=20
> It seems that proposal 3 is somehow equivalent to
> $ git rebase -i --onto remotes/trunk remotes/trunk
> ... check commits, maybe remove some of them, ...
> $ git svn dcommit

No, it would just prompt before making every commit (showing the log
message), like git-send-email can before sending every message.

> note : is the SVN remote branch always named "remote/trunk" ? If not,
> is there a way to guess its name ?

git svn dcommit --dry-run will print the URL from which you can
infer the remote branch.  There might be an easier way, but I
can't remember... (I don't see SVN much nowadays, most projects
I've cared about migrated to git)

--=20
Eric Wong
