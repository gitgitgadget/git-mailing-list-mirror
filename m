From: dhruva <dhruva@ymail.com>
Subject: Re: Get a copy of an old version of a file, using git gui/gitk
Date: Fri, 19 Sep 2008 14:02:30 +0530 (IST)
Message-ID: <884843.41605.qm@web95002.mail.in2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: =?iso-8859-1?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>,
	Peter Krefting <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Fri Sep 19 10:34:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KgbR6-0000fk-Dn
	for gcvg-git-2@gmane.org; Fri, 19 Sep 2008 10:33:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757174AbYISIcg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 19 Sep 2008 04:32:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757114AbYISIcg
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Sep 2008 04:32:36 -0400
Received: from n1a.bullet.in.yahoo.com ([202.43.219.18]:45326 "HELO
	n1a.bullet.in.yahoo.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1756874AbYISIce convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Sep 2008 04:32:34 -0400
Received: from [202.86.4.171] by n1.bullet.in.yahoo.com with NNFMP; 19 Sep 2008 08:32:31 -0000
Received: from [203.104.18.55] by t2.bullet.in.yahoo.com with NNFMP; 19 Sep 2008 08:32:31 -0000
Received: from [127.0.0.1] by omp107.mail.in2.yahoo.com with NNFMP; 19 Sep 2008 08:32:30 -0000
X-Yahoo-Newman-Property: ymail-3
X-Yahoo-Newman-Id: 984555.5699.bm@omp107.mail.in2.yahoo.com
Received: (qmail 42066 invoked by uid 60001); 19 Sep 2008 08:32:30 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=ymail.com;
  h=X-YMail-OSG:Received:X-Mailer:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=wIZlG0shyWzMRhsjoit50Lh4Ske5BAhNEv5rI8K2ucOjIbm19RQD7aDksnpVjca7mZfdt8g953FwI62My4fZ4jHQtSaIWNc6lqHCMyVTtefJeBClZqsnkVIBAFzLqry6K65wfiOKcgUcWBgY/K/fj+SPHGtNr87nZtFUxFJQNCE=;
X-YMail-OSG: Nu9T.6IVM1lUOKRDc07dkpyGRFUNBYImqmGnCZCfn7EUUqeGJmqYquSgteLauzuiQWrTf67okMyc0Pe.mw4UNqes60kAIPAcmDJSwecd_fSlCM6iA44zJ1RkmYqC1aI-
Received: from [202.3.112.9] by web95002.mail.in2.yahoo.com via HTTP; Fri, 19 Sep 2008 14:02:30 IST
X-Mailer: YahooMailRC/1096.28 YahooMailWebService/0.7.218.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96267>

Using gitk, you can branch at the change that has the file (and content=
, I am not using version as git does not version files) you want. Check=
 out that branch and you will have that file (and all other files at th=
at changeset). When you are done, you can just delete that branch... br=
anching is _cheap_

-dhruva



----- Original Message ----
> From: Bj=F6rn Steinbrink <B.Steinbrink@gmx.de>
> To: Peter Krefting <peter@softwolves.pp.se>
> Cc: Git Mailing List <git@vger.kernel.org>
> Sent: Friday, 19 September, 2008 1:50:47 PM
> Subject: Re: Get a copy of an old version of a file, using git gui/gi=
tk
>=20
> On 2008.09.19 08:58:04 +0100, Peter Krefting wrote:
> > From the command line, I would try to find the SHA-1 and use git
> > cat-file, but I can't figure out how to do it from the GUIs. Or, to
> > fall back to the command-line, how to get the SHA-1 for the object =
out
> > of git gui/gitk.
>=20
> You don't need the sha1 of the blob object, just the revision and the
> filename, and then you can reference the blob using the
> :syntax.
>=20
> For example:
>     git cat-file blob HEAD^^^:some/file.c
> or less plumb-ish:
>     git show HEAD^^^:some/file.c
>=20
> I've been told that neither cares about the CRLF conversion, and I do=
n't
> know if there's anything except "git checkout" that actually does car=
e
> about it. With checkout, you would do:
>=20
> git checkout HEAD^^^ -- some/file.c
>=20
> But that replaces the current version of that file in your working tr=
ee
> and index with the version from the HEAD^^^ revision, so that might n=
ot
> be exactly what you were looking for.
>=20
> Bj=F6rn
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



      Did you know? You can CHAT without downloading messenger. Go to h=
ttp://in.webmessenger.yahoo.com/
