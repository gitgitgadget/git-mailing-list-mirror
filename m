From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: remote tracking branches
Date: Wed, 25 Feb 2009 12:53:14 -0500
Message-ID: <76718490902250953u2c6a7783x89c1ea49d045a49a@mail.gmail.com>
References: <450196A1AAAE4B42A00A8B27A59278E709E0485C@EXCHANGE.trad.tradestation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: John Dlugosz <JDlugosz@tradestation.com>
X-From: git-owner@vger.kernel.org Wed Feb 25 18:55:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LcNy1-0001X0-2c
	for gcvg-git-2@gmane.org; Wed, 25 Feb 2009 18:54:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754054AbZBYRxR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 Feb 2009 12:53:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753013AbZBYRxR
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Feb 2009 12:53:17 -0500
Received: from rv-out-0506.google.com ([209.85.198.227]:1770 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752338AbZBYRxQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 Feb 2009 12:53:16 -0500
Received: by rv-out-0506.google.com with SMTP id g37so120030rvb.1
        for <git@vger.kernel.org>; Wed, 25 Feb 2009 09:53:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=3ov4HdunUZsdht+CtsPrzROJUE2wwz4UALENRLu0bes=;
        b=dq+TM0XIduWv+evMxXeQZcRz/Bf+3fFx5bGwpUc43xIiE6v0DvB5XVTnp/M9m4spCP
         a5DPo1Qj91ttXbw4Mab8sl1K57lp2vio48+9wP9WER8/PU4b3Thg/Q+3a3O1OdTo0IlG
         wWkHVeo7Ii+jUoRAOXSvGh65H5cETKy5hve+0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=bug5tv8DOVPFRDOANOEftgijlwF3/DiQyjgaJ3coKtXwABYh3SlO0IFVa2bLMDm2h1
         0wx69glhzgcSWcQkkbRgMB3Ym/VGSJFiDJch4Kbkl/xDDPCdVNIEhBDMdHzusdifm8Jb
         Vj1bO2V/Tlg4L9O9owLLXy08HPhvW5Qw7Gwcs=
Received: by 10.141.26.19 with SMTP id d19mr147513rvj.184.1235584394703; Wed, 
	25 Feb 2009 09:53:14 -0800 (PST)
In-Reply-To: <450196A1AAAE4B42A00A8B27A59278E709E0485C@EXCHANGE.trad.tradestation.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111471>

On Wed, Feb 25, 2009 at 12:41 PM, John Dlugosz
<JDlugosz@tradestation.com> wrote:
> The repository on my machine was apparently originally a simple file
> copy from another development machine, or set up manually. =C2=A0That=
 is, was
> not done by using the "git clone" command. =C2=A0I have a [remote "pu=
b"] in
> the config file with only a url in it, so I can use "pub" when I push
> and pull.
>
> The command "git branch -r" shows nothing.
>
> So, there are no remote tracking branches. =C2=A0So what? =C2=A0At fi=
rst, I think
> that this is nothing more than the defaults to use when pulling, to g=
et
> everything. =C2=A0But, the example at the very end of Chapter 1 of th=
e user
> manual shows:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0fetch =3D +refs/heads/*:refs/remotes/linux=
-nfs/*
>
> I don't have a refs/remotes directory now. =C2=A0So what does
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git pull pub xx
> do? =C2=A0The _result_ is just fine, as expected. =C2=A0But if pull c=
alls fetch,
> it needs to fetch it to some temporary place first and then merge tha=
t,
> right?

=46ETCH_HEAD is the temporary place.

> If I add a suitable line to my config file (changing linux-nfs in the
> example to pub to match the remote name), what does that buy me? =C2=A0=
But
> first, is that all I need to do to enable this feature?

Yes.

$ git config remote.pub.fetch "+refs/heads/*:refs/remotes/pub/*"

will command fetch to store what it retrieves under refs/remotes/pub
as well as in FETCH_HEAD.

> I'm guessing that it means I will be able to examine, e.g. using gitk=
,
> what is in pub, to see if there are changes I need and keep apprised =
of
> other's work.

Well it also lets you track every branch that is on pub. Otherwise
you're only retrieving whatever HEAD is on the remote. You may also
find it more natural to examine changes before merging them w/remote
tracking branches. e.g.:

$ git fetch
$ git log pub/master..master

Oh, and "git branch -v" can now tell you how far ahead/behind your
local branch is compared to the remote tracking branch.

j.
