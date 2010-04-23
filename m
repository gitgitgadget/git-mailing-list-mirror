From: Tor Arntsen <tor@spacetec.no>
Subject: Re: Please default to 'commit -a' when no changes were added
Date: Fri, 23 Apr 2010 11:35:02 +0200
Message-ID: <p2qd2d39d861004230235tacb970bftc96f2c1473843b1c@mail.gmail.com>
References: <20100422151037.2310.2429.reportbug@frosties.localdomain>
	 <20100422155806.GC4801@progeny.tock>
	 <87wrvzs590.fsf@frosties.localdomain>
	 <alpine.LFD.2.00.1004221445310.7232@xanadu.home>
	 <87sk6n4426.fsf@frosties.localdomain>
	 <7vsk6n2n48.fsf@alter.siamese.dyndns.org>
	 <vpq7hnzcgjq.fsf@bauges.imag.fr> <87r5m6tu0l.fsf@frosties.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>,
	Nicolas Pitre <nico@fluxnic.net>,
	Jonathan Nieder <jrnieder@gmail.com>, 578764@bugs.debian.org,
	git@vger.kernel.org
To: Goswin von Brederlow <goswin-v-b@web.de>
X-From: git-owner@vger.kernel.org Fri Apr 23 11:35:26 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O5FID-0003o9-Ky
	for gcvg-git-2@lo.gmane.org; Fri, 23 Apr 2010 11:35:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756875Ab0DWJfJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 23 Apr 2010 05:35:09 -0400
Received: from mail-bw0-f225.google.com ([209.85.218.225]:57856 "EHLO
	mail-bw0-f225.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756871Ab0DWJfE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 23 Apr 2010 05:35:04 -0400
Received: by bwz25 with SMTP id 25so10927669bwz.28
        for <git@vger.kernel.org>; Fri, 23 Apr 2010 02:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:received:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=7hoEnkl62WfrjKsDfGeEO6Ew5v0frOl6Rq1m0cSmnY4=;
        b=S/m39qmj7+vxyvrTk3hqc2FxryHVlqkv5AjqdNAS4Z9OtO+8Mvd65gbqRe9m4+REM9
         3dITEqj3f5dFU2ivdNwnBz5nLDBFuUtTCC1Ski9lutMhNVj9A0y5C7+p7tw7fNPiT2zp
         bc+80xCBH5Se5we5j5gCrYhoA1VVD0vmWWhBo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=gdo6e75KuHUMB1STkEBgge36B+dfmWH0v62SILJ02mBsJtDoNb/8zY/t3MTK7uIrmi
         wKpmRnr3FmsnX8HYNlGQgZ0ADqFKRVK9BEVw/ZaFCG4P0D3toGRsK3s5pExjhfIplTYE
         ++q7P4YkZrAM7a9hK1XVwZ/xudOjBd6AcftWM=
Received: by 10.239.179.197 with HTTP; Fri, 23 Apr 2010 02:35:02 -0700 (PDT)
In-Reply-To: <87r5m6tu0l.fsf@frosties.localdomain>
X-Google-Sender-Auth: 966890cc8b1d4bdc
Received: by 10.239.184.80 with SMTP id x16mr1025821hbg.88.1272015302384; Fri, 
	23 Apr 2010 02:35:02 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145605>

On Fri, Apr 23, 2010 at 11:09, Goswin von Brederlow <goswin-v-b@web.de>=
 wrote:

> For SVN users it gets much worse:
>
> vi existing-file.c # do some changes
> vi new-file.c =A0 =A0 =A0# create the file
> git add new-file.c
> vi new-file.c =A0 =A0 =A0# do some more changes
> git commit
>
> A SVN user would expect the current working copies of existing-file.c
> and new-file.c to be commited. Instead only new-file.c is commited an=
d
> only the fist modification.

I come from CVS, i.e. a similar background.

> While this case is still highly confusing to non git users I do see t=
hat
> it can't be easily changed. And my suggestion doesn't change it. The
> call to "git add" creates an index so the commit would only act on th=
e
> index.

I wouldn't agree it's highly confusing. As soon as you understand why
(and it shouldn't take long), it's a relief. With CVS I would
constantly make copies of my working tree so that I could sort out all
the different things I was working on at the same time (which is a
necessity when you work with development and bugfixing and customer
reports with different priorities are dropping in). It's much easier
now (with Git) to do a couple of different things at the same time.

Besides, I would argue that the SVN/CVS behaviour is creating problems
also for SVN/CVS users. Where I work it's not unusual that developers
accidentally commit different changes in the same commit, making it
hard to extract the one you want when you later wish to e.g. push a
specific change to a maintenance branch or hotfix tree.

And git add --patch is also wonderful sometimes. (Unfortunately that
won't work on systems with pre-5.8 versions of Perl, which I just
found out - but that's another story.)

I plan to create a short course for my fellow co-workers when we move
more stuff over from CVS to Git. Just an hour should do I think. I'll
clarify how the index works very early on and I believe they'll all
"get it" very quickly. I'll probably also take some parts from 'Git
from the bottom up' by John Wiegley, at least I found (after having
used Git for some time) that knowing how it works from blobs and up
actually helps a lot.

I won't join in on the discussion of any actual changes to Git, for
that I'm too fresh as Git user. I would only like to stress that I
wouldn't want the current flexibility to get limited or changed to be
more like SVN/CVS -- I come from there, remember, and I don't see why
I would wish to go back.

-Tor
