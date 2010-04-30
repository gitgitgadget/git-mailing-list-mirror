From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: push instead of
Date: Fri, 30 Apr 2010 19:59:10 -0400
Message-ID: <m2g76718491004301659n7665d221se131a7a194530e32@mail.gmail.com>
References: <z2gb42431c81004300256ke7248f40y7bce060d52cfa943@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Mahesh Vaidya <forvaidya@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 01 01:59:25 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O8077-0004U3-3r
	for gcvg-git-2@lo.gmane.org; Sat, 01 May 2010 01:59:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754953Ab0D3X7P convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 30 Apr 2010 19:59:15 -0400
Received: from mail-iw0-f182.google.com ([209.85.223.182]:40864 "EHLO
	mail-iw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752998Ab0D3X7N convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 30 Apr 2010 19:59:13 -0400
Received: by iwn12 with SMTP id 12so947014iwn.15
        for <git@vger.kernel.org>; Fri, 30 Apr 2010 16:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=bYu2mviVMEmd17QFwtZf+qnyHqbiUYNL/9iio6MeH88=;
        b=pE/pJh5KMK93n4Y1Y0F7toRs/hddOLXlMyn5Tbg+lXy+xgUAeb2OMcx+ZG+nBbOlD+
         WdGBzm5ei3mqCg4RdHraAbp1EaCRcLnPsIxlEI+TuGDuQumgZBB6fxqOVMVgsd4ABaln
         9Dc25yLg9ADCx7C5DUiSmYGnl4uLjv14yKqBI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Ogvr7vdoFz7wiBBZ+w0IlKTAICHNUiCeDnhVmGlMb1drALer8Ipx2MoXdC00HNKfmZ
         K+ba1m6xaB25omlWwnw267KnF+YAu3DKiWX84lA/MHgX/fXKU/HLCCbAhcdEVrLeUAv5
         +Z7W2pUxj7gLLzc1CS/gWZuQu/HMtW7l/mIQk=
Received: by 10.231.191.16 with SMTP id dk16mr1615752ibb.90.1272671950589; 
	Fri, 30 Apr 2010 16:59:10 -0700 (PDT)
Received: by 10.231.17.141 with HTTP; Fri, 30 Apr 2010 16:59:10 -0700 (PDT)
In-Reply-To: <z2gb42431c81004300256ke7248f40y7bce060d52cfa943@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146069>

On Fri, Apr 30, 2010 at 5:56 AM, Mahesh Vaidya <forvaidya@gmail.com> wr=
ote:
> I am facing problem at pushInsteadIOf. I would like pull from
> "pullhost" and push to "pushhost" as my pullhost as pre-receive
> trigger which not accepting pushes.
>
> However when I do git push it still hits pull host. I have following =
config.
>
> [remote "origin"]
> =C2=A0 =C2=A0 =C2=A0 =C2=A0fetch =3D +refs/heads/*:refs/remotes/origi=
n/*
> =C2=A0 =C2=A0 =C2=A0 =C2=A0url =3D gitosis@pull_host:repos.git
> [url "gitosis@localhost"]
> =C2=A0 =C2=A0 =C2=A0 =C2=A0pushInsteadOf =3D gitosis@PUSH_host:repos.=
git

I think you have your arguments backwards if I understand your mail
correctly. Try:

[url "gitosis@PUSH_host:repos.git"]
       pushInsteadOf =3D gitosis@pull_host:repos.git

Now when pushing, _instead_ of pushing to
"gitosis@pull_host:repos.git" (which is the origin url), you will push
to "gitosis@PUSH_host:repos.git".

I'm not sure what gitosis@localhost was supposed to represent in your e=
mail.

j.
