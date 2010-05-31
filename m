From: Fred <fred@akafred.com>
Subject: Re: git+svn - repo upgrade from 1.6.6.4 to 1.7.1 fails
Date: Mon, 31 May 2010 14:27:06 +0200
Message-ID: <AANLkTilTx0Eh5WTxucWRVcvFcFUQoYfauU953pXx-P5N@mail.gmail.com>
References: <AANLkTin-k5zIDZysiLbTusqDwqxGWDxxAOPljLuRlIMD@mail.gmail.com> 
	<AANLkTikYYjl6Gv8SRMvtmzW1pyzkyu_mwLyEGHdWuH00@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 31 14:34:57 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJ4Cm-0001Yr-NO
	for gcvg-git-2@lo.gmane.org; Mon, 31 May 2010 14:34:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753915Ab0EaMev convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 31 May 2010 08:34:51 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:44163 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753767Ab0EaMeu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 31 May 2010 08:34:50 -0400
Received: by gye5 with SMTP id 5so175536gye.19
        for <git@vger.kernel.org>; Mon, 31 May 2010 05:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:sender:received
         :in-reply-to:references:from:date:x-google-sender-auth:message-id
         :subject:to:content-type:content-transfer-encoding;
        bh=KtheHwNEsjn7wXUZzqb1pnEH0UoTH1cQPSHJxrsKsMQ=;
        b=shK5uwDXzAw2DuCP709n82H0GpIrYDIKzKDwyiyMqOwMgSaujHz80wLEsAYoqwtY0G
         GhVxq/ygPu4j23TOq2UXv56OulNW0Y7zd9+AdhES+9TtSu/CieAMV18SWmrp4ZBuDe33
         7sKYIyxJJ7NLGOawt67HsxCTI9leACZptt+V0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:content-type
         :content-transfer-encoding;
        b=TxaYfJ4sIC6WHNjKbxtGeyCq24DnKO8yV5ezl6fSliJX5JmwmChyhd61La7ifuNrAw
         lq95hBqtPFlhrNPbrJbvctgQbhIsByv+GMMK2RwY51O5SOy1DqXptOWjqZwYmLfEf9W0
         /chq0ThBILg4ffqZ3rQAROBqKUMy368ZGFAQo=
Received: by 10.101.145.16 with SMTP id x16mr4661463ann.226.1275308846267; 
	Mon, 31 May 2010 05:27:26 -0700 (PDT)
Received: by 10.100.210.10 with HTTP; Mon, 31 May 2010 05:27:06 -0700 (PDT)
In-Reply-To: <AANLkTikYYjl6Gv8SRMvtmzW1pyzkyu_mwLyEGHdWuH00@mail.gmail.com>
X-Google-Sender-Auth: ruDAM2ViHprOY4R1UoHDoksLL0g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148041>

On 31 May 2010 13:09, Fred <fred@akafred.com> wrote:
> Hi,=A0I have a project with two remotes - one git and one svn. One
> branch is only used for "git svn rebase", and then I cherrypick or
> merge from it into my master branch. Most work is done in the master
> branch (or other topic branches only available in git)
>
> The repo was created under git 1.6.6.4. After updating git a while
> back (to 1.7.1) it was time to merge inn a few things from svn - so i
> switched to my "subversion" branch and did a
>
> $ git svn rebase
>
> Migrating from a git-svn v1 layout...
> Data from a previous version of git-svn exists, but
> .git/svn
> (required for this version (1.7.1) of git-svn) does not exist.
> Done migrating from a git-svn v1 layout
> Unable to determine upstream SVN information from working tree histor=
y
> ---
> I read this as: "I see your repo has some svn stuff and that it is
> backlevel. I'll fix it for you. Oh shit, now I can't determine what
> svn revision you are on."
>
> Any ideas on how to resolve this? We're a dozen developers relying on
> this so it would be nice find a way with minimal impact to the
> users...
>
> For now I'll do the rebasing in a back-level git client...
>
> - Fred
>

Additional info:

$ git log --grep=3D^git-svn-id --first-parent

returns mulitple commits - the first one here:

commit e2f9e115f07fa1fb0932f893c6f94173f9dc4515
Author: geir <geir@f9caaf5b-9695-4c42-8d37-d0d3d7799616>
Date:   Mon Apr 26 12:37:09 2010 +0000

    Modofied search for ED01119000 from web. Handles the case that the
user enters the birth date as a complete ssn or as 8 digits in

    git-svn-id: svn://svnserver/Decision/decisionmaker/trunk@45839
f9caaf5b-9695-4c42-8d37-d0d3d7799616

----

And here is the config-file - only changed the github username to xxx

[core]
	repositoryformatversion =3D 0
	filemode =3D true
	bare =3D false
	logallrefupdates =3D true
	ignorecase =3D true
[svn-remote "svn"]
	url =3D svn://svnserver/
	fetch =3D Decision/decisionmaker/trunk:refs/remotes/trunk
	branches =3D Decision/decisionmaker/branches/*:refs/remotes/*
	tags =3D Decision/decisionmaker/tags/*:refs/remotes/tags/*
[remote "origin"]
	fetch =3D +refs/heads/*:refs/remotes/origin/*
	url =3D git@github.com:xxx/decisionmaker.git
[branch "master"]
	remote =3D origin
	merge =3D refs/heads/master
[branch "subversion"]
        remote =3D origin
        merge =3D refs/heads/subversion

---
