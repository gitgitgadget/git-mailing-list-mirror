From: bill lam <cbill.lam@gmail.com>
Subject: Re: how to combine 2 commits?
Date: Tue, 13 Jan 2009 15:51:21 +0800
Message-ID: <20090113075121.GA6923@b2j>
References: <20090113045422.GA6940@b2j> <200901122327.21102.bss@iguanasuicide.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jan 13 08:52:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMe53-0000ES-GB
	for gcvg-git-2@gmane.org; Tue, 13 Jan 2009 08:52:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754708AbZAMHv3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 13 Jan 2009 02:51:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753538AbZAMHv2
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Jan 2009 02:51:28 -0500
Received: from ti-out-0910.google.com ([209.85.142.185]:28787 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751148AbZAMHv1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jan 2009 02:51:27 -0500
Received: by ti-out-0910.google.com with SMTP id b6so12213822tic.23
        for <git@vger.kernel.org>; Mon, 12 Jan 2009 23:51:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:subject
         :message-id:mail-followup-to:references:mime-version:content-type
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=r7PzS8QIMSDY4CbYjFZtt0qT202iwHRvPprgkr/8dGU=;
        b=gL6yCkyAbEyEtzyORou7DeD8GLfl9c/+bc8MuCcK28rqXzG+BI3RD2CS8IyjobjITD
         Ayjyl/E1WdqCdzYhKP0tCDEJnE7e/ZVvQc2oAgoGqLg9mxvrt+pzQOVpDDjyVAKdOHQO
         ACUFRCZ7yQmjtgfNjpLFwVu248b02y5thpEOo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:mail-followup-to:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        b=Pa2xTtN+Ll3HmhIipwvPW2izgysXVKp+xnErZXMwaTlG1ubUgjDvz9QkEaBPkj7mmS
         sIP8D1s+2iobsIyb68BFf0nuOH9nFKYY9yT8Ec7FYyt/8cBQHvW/PEUNK3ouq/yK3qsj
         uWTzQItGPdgQlHaHf6nmWqkqcQvpyYWVmKmz8=
Received: by 10.110.41.20 with SMTP id o20mr1527596tio.26.1231833085352;
        Mon, 12 Jan 2009 23:51:25 -0800 (PST)
Received: from localhost (pcd430181.netvigator.com [203.218.220.181])
        by mx.google.com with ESMTPS id d1sm247127tid.4.2009.01.12.23.51.23
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 12 Jan 2009 23:51:24 -0800 (PST)
Mail-Followup-To: git <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <200901122327.21102.bss@iguanasuicide.net>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105465>

On Mon, 12 Jan 2009, Boyd Stephen Smith Jr. wrote:
> git rebase --interactive (read "git help rebase" first)

I tried rebase the last 3 commit, but it failed.

bill@b2j:jproject$ git log --pretty=3Doneline | head
39ed365c11391bede0e1b6578adfac6619b78c0a for yajpp to use unix LF
70c812db2439bc84a8dd7ea831067b9ebf29885c revert last crlf error
f338a768d635b868e6fddaae670ad91d46ea7c4e format scripts  =20

bill@b2j:jproject$ git rebase -i HEAD~3
error: Entry 'trunk/jcalc/mmenu-mm.ijs' not uptodate. Cannot merge.
fatal: merging of trees a1eafe6cdbb428f851d6ca878bbc53149fb7e7eb and
a00e6dcd3ec3f4ffde0d1aad1958db724093de69 failed

Could not apply 70c812d... revert last crlf error

It looks like cannot resolve conflict of linefeed changes. It was
expected all scripts will conflict, so I have to abort the rebase.

What is the procedure to generate a patch of the HEAD from HEAD~4,
then cancel all changes from HEAD~3 up to HEAD, and then apply the
patch to the previous HEAD~4 ?

BTW, what is the norm of reply in this list, should it be reply to
list only, or reply to group (list plus all cc)?

--=20
regards,
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
GPG key 1024D/4434BAB3 2008-08-24
gpg --keyserver subkeys.pgp.net --recv-keys 4434BAB3
=E5=94=90=E8=A9=A9213 =E6=9D=8E=E5=95=86=E9=9A=B1  =E7=84=A1=E9=A1=8C=E4=
=BA=8C=E9=A6=96=E4=B9=8B=E4=BA=8C
    =E9=A2=AF=E9=A2=AF=E6=9D=B1=E9=A2=A8=E7=B4=B0=E9=9B=A8=E4=BE=86  =E8=
=8A=99=E8=93=89=E5=A1=98=E5=A4=96=E6=9C=89=E8=BC=95=E9=9B=B7  =E9=87=91=
=E8=9F=BE=E9=BD=A7=E7=92=85=E7=87=92=E9=A6=99=E5=85=A5  =E7=8E=89=E8=99=
=8E=E7=89=BD=E7=B5=B2=E6=B1=B2=E4=BA=95=E8=BF=B4
    =E8=B3=88=E6=B0=8F=E7=AA=BA=E7=B0=BE=E9=9F=93=E6=8E=BE=E5=B0=91  =E5=
=AE=93=E5=A6=83=E7=95=99=E6=9E=95=E9=AD=8F=E7=8E=8B=E6=89=8D  =E6=98=A5=
=E5=BF=83=E8=8E=AB=E5=85=B1=E8=8A=B1=E7=88=AD=E7=99=BC  =E4=B8=80=E5=AF=
=B8=E6=83=B3=E6=80=9D=E4=B8=80=E5=AF=B8=E7=81=B0
