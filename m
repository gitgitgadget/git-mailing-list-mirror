From: Zenaan Harkness <zen@freedbms.net>
Subject: Re: merge two local mirrors with detached heads and similar remotes
Date: Sun, 7 Nov 2010 20:27:50 +1100
Message-ID: <AANLkTi=JmpXEiEe-7-ZicUp-QosWjTZQgK77-f=9iAtL@mail.gmail.com>
References: <AANLkTinidbrJjmt5w=TyFGMyNpaGobE1iDBm3VAWmZvX@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 07 10:28:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PF1Y8-0002Ep-LN
	for gcvg-git-2@lo.gmane.org; Sun, 07 Nov 2010 10:28:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753018Ab0KGJ2Y convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 7 Nov 2010 04:28:24 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:49584 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752102Ab0KGJ2W convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 7 Nov 2010 04:28:22 -0500
Received: by bwz11 with SMTP id 11so3921293bwz.19
        for <git@vger.kernel.org>; Sun, 07 Nov 2010 01:28:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:sender:received
         :in-reply-to:references:from:date:x-google-sender-auth:message-id
         :subject:to:content-type:content-transfer-encoding;
        bh=/QTxkN53luJ3MaMmjvD44mH+kXE1t7JM4b8bxX/PhZw=;
        b=dNq8tPOgrBgrPssYnVtY42ZzBsaxK5Qf80RCWpmB09gXR2px939HpTyOgWtk6XiJZY
         ruXTJxArPnsQRDSiuxUxYDcMBOaJJZHJmHD+S3KEXZZHNLiHNWspXnQKyE4rL5cCn8c7
         C7g/wUMxi9uWSmS1fj5ZZ5CSM+pRt1BmXSIJk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:content-type
         :content-transfer-encoding;
        b=TLhZ5zENFkdMiMTMKqwsUq0yLPvnfIJwKh4tSgEft8vLjXOoMZu71BpO++iQbyscFK
         s2XVh9qrVvDXa2/PkLtRXvS+eKKDbR+qMqfWIo0ABtqIGQaTLTna61uV98fo2rQ+r48C
         cWN+AuW+z9gcllwD1T2QQ6T3vsPYA3wcsouL0=
Received: by 10.204.66.145 with SMTP id n17mr3751741bki.73.1289122101086; Sun,
 07 Nov 2010 01:28:21 -0800 (PST)
Received: by 10.204.83.4 with HTTP; Sun, 7 Nov 2010 01:27:50 -0800 (PST)
In-Reply-To: <AANLkTinidbrJjmt5w=TyFGMyNpaGobE1iDBm3VAWmZvX@mail.gmail.com>
X-Google-Sender-Auth: 6A0aTqURadPig7Wmw-cHgN3lBeI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160868>

On Sun, Nov 7, 2010 at 13:40, Zenaan Harkness <zen@freedbms.net> wrote:
> I wish to merge two local mirrors, which each should share the same
> object store
=2E..
> So I want to achieve the same thing (multiple remotes in one local
> repo) for an earlier clone of two separate repos, which really ought
> to be just one, as follows:
>
> A)
> $ cd gitjour.git/
> $ cat .git/config

> [remote "origin"]
> =A0 =A0 =A0 =A0fetch =3D +refs/heads/*:refs/remotes/origin/*
> =A0 =A0 =A0 =A0url =3D https://github.com/chad/gitjour.git
> [branch "master"]
> =A0 =A0 =A0 =A0remote =3D origin
> =A0 =A0 =A0 =A0merge =3D refs/heads/master

> $ git branch -a
> * master
> =A0remotes/origin/HEAD -> origin/master
> =A0remotes/origin/master
>
> B)
> $ cd gitjour-new.git/
> $ cat .git/config

> [remote "origin"]
> =A0 =A0 =A0 =A0fetch =3D +refs/heads/*:refs/remotes/origin/*
> =A0 =A0 =A0 =A0url =3D https://github.com/lachlanhardy/gitjour.git
> [branch "master"]
> =A0 =A0 =A0 =A0remote =3D origin
> =A0 =A0 =A0 =A0merge =3D refs/heads/master
> $ git branch -a
> * master
> =A0remotes/origin/8.2.0
> =A0remotes/origin/HEAD -> origin/master
> =A0remotes/origin/lachlanhardy
> =A0remotes/origin/master
> =A0remotes/origin/v8.1.0

It looks to me like I finally solved the first half of the problem,
with clarification from the following URL:
http://www.gelato.unsw.edu.au/archives/git/0601/15567.html

In A) I modified .git/config to be as follows:
$ cat .git/config
[core]
        repositoryformatversion =3D 0
        filemode =3D true
        bare =3D false
        logallrefupdates =3D true
[remote "origin"]
        fetch =3D +refs/heads/*:refs/remotes/origin/*
        url =3D https://github.com/chad/gitjour.git
[branch "master"]
        remote =3D origin
        merge =3D refs/heads/master
[remote "lach"]
        url =3D ../u
#       fetch =3D +refs/heads/*:refs/remotes/origin/*
        fetch =3D +refs/remotes/origin/*:refs/remotes/lach/*
$ git fetch lach d
remote: Counting objects: 583, done.
remote: Compressing objects: 100% (303/303), done.
remote: Total 568 (delta 229), reused 566 (delta 229)
Receiving objects: 100% (568/568), 65.29 KiB, done.
Resolving deltas: 100% (229/229), completed with 3 local objects.
=46rom ../u
 * [new branch]      origin/8.2.0 -> lach/8.2.0
 * [new branch]      origin/HEAD -> lach/HEAD
 * [new branch]      origin/lachlanhardy -> lach/lachlanhardy
 * [new branch]      origin/v8.1.0 -> lach/v8.1.0

# and finally:
$ git branch -a
* master
  remotes/lach/8.2.0
  remotes/lach/HEAD
  remotes/lach/lachlanhardy
  remotes/lach/master
  remotes/lach/v8.1.0
  remotes/origin/HEAD -> origin/master
  remotes/origin/master

---------
Looks very much like success to me. Small thing I notice is this line:
  remotes/origin/HEAD -> origin/master

has become this:
  remotes/lach/HEAD

(ie it's not a link any more - probably not particularly relevant,
perhaps git gc would automate tidying this?)
----------
So now I just update the remote URL for lach to point back to upstream
and I think I'm done. Happy days.

That tutorial email URL up top above might be old -
http://www.gelato.unsw.edu.au/archives/git/0601/15567.html is from
January 2006! - and is out of date a bit wrt the .git/config file
format (eg remotes wildcards), BUT in that email, Junio explained this
"local mirror" concept well enough that I could solve my problem here
(it appears) - implementing a fixup of my "local mirror" use case -
I'm a happy camper; thank you Junio!

May be I missed how to do this somewhere in the docs already, but I've
been reading and searching the web for two days, learning lots for
sure, but frustrated that it took me so long to find out how to do
this.

Should something like Junio's tutorial go into
Documentation/gitworkflows.xml(ARGGH!) ?
If not, where else?
Is there anything besides vim (about all I know) you can recommend for
editing xml(ARGGH!) docs?

Thanks
Zenaan
