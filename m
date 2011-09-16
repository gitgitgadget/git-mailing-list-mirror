From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: New setup, trying to clone . . .
Date: Fri, 16 Sep 2011 01:29:07 -0700 (PDT)
Message-ID: <m3pqj0sxfy.fsf@localhost.localdomain>
References: <CAOZxsToJk45UHGAuno-r=B76+SUg5icbYvUsY5EfgcGv_UkxHg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-4
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: Joshua Stoutenburg <jehoshua02@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 16 10:29:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R4Tnr-0008Nl-Bd
	for gcvg-git-2@lo.gmane.org; Fri, 16 Sep 2011 10:29:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754866Ab1IPI33 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 16 Sep 2011 04:29:29 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:36992 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754849Ab1IPI3K convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 Sep 2011 04:29:10 -0400
Received: by fxe4 with SMTP id 4so1437071fxe.19
        for <git@vger.kernel.org>; Fri, 16 Sep 2011 01:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=AVubh3nVl8ltiHXYBCGMAfvN5gp1XzCUHwoYBzqn2OM=;
        b=GYOHsVVJDre6kkIDgTanxG/FXpil7rS1XZFasj6xFSloc9Et3ahiEE5SWBBW1gbsHf
         lzgxktZh2VDvr7MIdGSKEYosBtvdz5j+DL4rMjUZmPdS0TUu/0d0kPTLO37JU/S7u7WZ
         RjJzG5X8yM7q3Xt2/6QQQk54C/UcHO0AxRBUs=
Received: by 10.223.48.214 with SMTP id s22mr976145faf.104.1316161749357;
        Fri, 16 Sep 2011 01:29:09 -0700 (PDT)
Received: from localhost.localdomain (abve9.neoplus.adsl.tpnet.pl. [83.8.202.9])
        by mx.google.com with ESMTPS id x22sm9700632faa.5.2011.09.16.01.29.06
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 16 Sep 2011 01:29:07 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p8G8SibS008189;
	Fri, 16 Sep 2011 10:28:55 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id p8G8SXRk008184;
	Fri, 16 Sep 2011 10:28:33 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <CAOZxsToJk45UHGAuno-r=B76+SUg5icbYvUsY5EfgcGv_UkxHg@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181528>

Joshua Stoutenburg <jehoshua02@gmail.com> writes:

> I'm following these instructions:  http://progit.org/book/ch4-4.html
>=20
> Everything has gone fine up until about halfway down the page, where =
it says:
>=20
> >  At this point, the others can clone it down and push changes back =
up just as easily:
> >  $ git clone git@gitserver:/opt/git/project.git
>=20
> Of course, replacing [git@gitserver:/opt/git/project.git] according t=
o
> my setup, and I change directory to an empty directory apart from the
> original project, then I try the command, I get the following output:
>=20
> At this point, the others can clone it down and push changes back up
> just as easily:
>=20
> $ git clone gituser@192.168.1.102:/git/project.git
> Cloning into project...
> Connection closed by 192.168.1.102
> fatal: The remote end hung up unexpectedly
>=20
> Any ideas what's going on here?

Note that 'gituser@192.168.1.102:/git/project.git' is an SSH URL.

There are two possible issues:

1. The path to repository is incorrect.

   If you are on the same machine as server, you can try cloning (or
   just 'git ls-remote') with a local path:

      git clone /git/project.git

   or

      git clone file:///git/project.git

2. The SSH setup is not correct: either SSH daemon is not started, or
   there is no 'gituser' account, or 'gituser' account doesn't have
   access to /git/project.git

   You can check first two with

      ssh gituser@192.168.1.102 echo Hello

HTH
--=20
Jakub Nar=EAbski
