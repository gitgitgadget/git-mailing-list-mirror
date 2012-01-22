From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: Finding all commits which modify a file
Date: Sun, 22 Jan 2012 12:03:19 +0800
Message-ID: <CALUzUxpy+XdfMYqX8TGnpQ72FfvpF_VYP-19fTDLrD-=9CN3uw@mail.gmail.com>
References: <46043.208.70.151.129.1327095331.squirrel@mail.lo-cal.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Neal Groothuis <ngroot@lo-cal.org>
X-From: git-owner@vger.kernel.org Sun Jan 22 05:03:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RooeM-0008Gl-6c
	for gcvg-git-2@lo.gmane.org; Sun, 22 Jan 2012 05:03:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751505Ab2AVEDV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 21 Jan 2012 23:03:21 -0500
Received: from mail-wi0-f174.google.com ([209.85.212.174]:43614 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751373Ab2AVEDU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 21 Jan 2012 23:03:20 -0500
Received: by wics10 with SMTP id s10so1378490wic.19
        for <git@vger.kernel.org>; Sat, 21 Jan 2012 20:03:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=+bjjD9uj8CGc7gxV8P6xb+H4DUM1TlkH3Ann6dYP6no=;
        b=RogKQstsuDf5cnsnNPkwPb2xe/a7iEguPYPHnuyHFU1tvoZLY+FdhUHvF3rSgnbyW7
         GtrMATpTJQ9ymgZ0PpUito+JsGCNcLkAup1bsqU/6CMyReRL5fPemDQgPU+u6z6Gifad
         pCf2DlPSp3+WJnpI+HKYC6/QrTNMBNTGIPrtg=
Received: by 10.180.94.97 with SMTP id db1mr5591756wib.16.1327204999667; Sat,
 21 Jan 2012 20:03:19 -0800 (PST)
Received: by 10.223.92.135 with HTTP; Sat, 21 Jan 2012 20:03:19 -0800 (PST)
In-Reply-To: <46043.208.70.151.129.1327095331.squirrel@mail.lo-cal.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188944>

On Sat, Jan 21, 2012 at 5:35 AM, Neal Groothuis <ngroot@lo-cal.org> wro=
te:
> Hello,
>
> I'm trying to find /all/ commits that change a file in the
> repository...and its proving to be trickier than I thought. :-)
>
> The situation that we were dealing with is this:
>
> - Person A and person B both pull from the same central repository.
>
> - Person A makes a change to file foo.txt and bar.txt, commits, and p=
ushes
> to the central repository.
>
> - Person B makes a similar change to bar.txt and commits it.
>
> - Person B does a fetch and merge. =A0Since both A and B made changes=
 to
> bar.txt, this requires conflicts to be resolved manually.
>
> - B reverts A's changes to foo.txt. (If B is coming from a different
> revision control system, this may happen due to confusion about how m=
erges
> are handled.)

How is this "revert" done? Was it done at the conflict resolution
level or with a git-revert invocation?

Nonetheless, either way, A's commit would be still be present in the
log history.

>[snip]
> Graphically:
>
> =A0 =A0A1
> =A0 / =A0^
> =A0v =A0 =A0\
> =A0C1 =A0 B2<-B3
> =A0^ =A0 =A0/
> =A0 \ =A0v
> =A0 =A0B1
>
> B1, B2, and B3 have the same version of foo.txt as C1, A1 modifies it=
=2E

Just to clarify, is C1 the commit that both A and B both share when
they first pull in the first step? And B2 is the merge?

--=20
Cheers,
Ray Chuan
