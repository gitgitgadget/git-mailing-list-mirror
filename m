From: Joe Angell <joe.d.angell@gmail.com>
Subject: Re: git bug: moved file with local unstaged changes are lost during merge
Date: Thu, 12 Apr 2012 10:13:04 -0600
Message-ID: <CAAZnV3EwZ6kminW7D3ssn_Rtj2SsMHd++VCx7w14K5rQKba4_g@mail.gmail.com>
References: <CAAZnV3Einocd4TJ0iqcxPJNsr44j3RwhczS9OhyURX0faGWgBQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 12 18:13:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SIMe1-00080C-Ex
	for gcvg-git-2@plane.gmane.org; Thu, 12 Apr 2012 18:13:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965642Ab2DLQNH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Apr 2012 12:13:07 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:59185 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965638Ab2DLQNF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Apr 2012 12:13:05 -0400
Received: by yhmm54 with SMTP id m54so1161005yhm.19
        for <git@vger.kernel.org>; Thu, 12 Apr 2012 09:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        bh=pvfddDAk10h5ZAOrLvzgDp+CkGKhKM8mXdSRqivlzT0=;
        b=yFtPhXLCMZ/l2gzOewEqhYDvq1yeYSk0eJ45lsaRsF2Vrt8L+j44+SSD8xOFMu2nxM
         wCfzT1xIMwZ0NYdLkUkDvrN3l8FJn7Jnwd3vcVvfAtPF8Ix/T/hcVad0TJzNHxNAG7DX
         owwPRLRmcn25QTQEPyBTb9wceVOsHRy12xHobwFPY2Cn60naJ1pO1ZEAQ8UDN8/a91nj
         H0WppG2TRhmBS9Stxpc2Ta560SdKC92v3YOt429PpwcU9oNQwa7r4vpqaidC5jJvPV3C
         mKbZSqIJ3DGRKdvklnRMOuSuc2vt9ryVcvEC6OJrYiuJhb3z+8GQS2KPdzyd7qsXOeNE
         Br3g==
Received: by 10.50.157.137 with SMTP id wm9mr6840305igb.64.1334247184172; Thu,
 12 Apr 2012 09:13:04 -0700 (PDT)
Received: by 10.231.132.196 with HTTP; Thu, 12 Apr 2012 09:13:04 -0700 (PDT)
In-Reply-To: <CAAZnV3Einocd4TJ0iqcxPJNsr44j3RwhczS9OhyURX0faGWgBQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195344>

Is this the right place to post bug reports?



On Wed, Apr 11, 2012 at 12:20 PM, Joe Angell <joe.d.angell@gmail.com> w=
rote:
> What steps will reproduce the problem?
> git init
> echo "initial checkin" >> readme
> git add readme
> git commit -m "inital checkin"
> git branch b1
> git checkout b1
> echo "b1" >> readme
> git add readme
> git commit -m "b1 readme"
> git checkout master
> git mv readme readme_master
> git ci -m "moved readme"
> echo "master" >> readme_master
> git merge b1
>
> What is the expected output? What do you see instead?
> I expect to have git prevent the merge due to local changes to the
> file. =A0Instead it overwrites the file (erasing the local modificati=
on
> "master") and you end up with:
> cat readme_master
> initial readme
> b1
>
> What version of the product are you using? On what operating system?
> Reproduced on 1.7.9.6 and from the git-core repo 1.7.10.128.g7945c.
> This is on ubuntu 10.04.
>
> Please provide any additional information below.
>
> This problem only seems to occur after you check in the move, then
> make local modifications, then do the merge.
>
> --
> ---------------
> Joe Angell
> cell: (720) 260-2190



--=20
---------------
Joe Angell
cell: (720) 260-2190
