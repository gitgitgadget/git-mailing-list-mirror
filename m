From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Potential bug in ls-files (version 1.7.9.5)
Date: Mon, 7 Jul 2014 15:22:40 -0700
Message-ID: <20140707222240.GA12427@google.com>
References: <CAFow3A_f+nPCR1zqS9WdH1V9pNdSP=zRNt2UxbHpOz1d6miQEg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Hamilton Turner <hamiltont@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 08 00:22:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X4HJD-0006Kr-4f
	for gcvg-git-2@plane.gmane.org; Tue, 08 Jul 2014 00:22:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751906AbaGGWWr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 7 Jul 2014 18:22:47 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:44795 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751205AbaGGWWq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jul 2014 18:22:46 -0400
Received: by mail-pa0-f43.google.com with SMTP id lf10so6172029pab.30
        for <git@vger.kernel.org>; Mon, 07 Jul 2014 15:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=B2+O8c/2fJnAytVAGfKPy9kdCo46VWMuuhYX8ZkdiwY=;
        b=V5LSAGBuxK8qHgwGwL67BaQWRcnSlXqXdFVO+lhS9DfcirI5G3Fuw7TowIoFJV3QtD
         D/lEK/rmmFlxt/FbJCn1mb34x9yuytHU7xnrqKkEV72ntnrOV0rWUrXqWiPav+geZM6X
         b/EyR26VOkm+qbtcd8O8NDULuYj+Ejbq585izZqYY/rK3NPClHzpbPAdXHwyw8wR9ox8
         Som564fPvWTRCcmKtV1vQlx0GXm9HasNNQTih/WdXhoGR5cDsO6CDd/TpSuHtoezZYwG
         46wiHi/qm+xPBU/TQ0J/JTstYlAcP07BcUq02GsBevtltkaw6bHFtPzL7P8om+JnXeYW
         G8IA==
X-Received: by 10.66.252.35 with SMTP id zp3mr31166244pac.40.1404771766377;
        Mon, 07 Jul 2014 15:22:46 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:4d4c:bf6d:2cbc:1158])
        by mx.google.com with ESMTPSA id uv5sm53674449pbc.52.2014.07.07.15.22.45
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 07 Jul 2014 15:22:45 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAFow3A_f+nPCR1zqS9WdH1V9pNdSP=zRNt2UxbHpOz1d6miQEg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252993>

Hi Hamilton,

Hamilton Turner wrote:

> My project has this directory structure
>=20
> .
> =E2=94=9C=E2=94=80=E2=94=80 aspnet
> =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 .gitignore
> =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 __init__.py
> =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 lib
> =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 <lots of big stuf=
f>
>=20
> My aspnet/.gitignore lists lib/*, and git add aspnet/lib/foo reports
> that this path is ignored.
>=20
> But git ls-files --others --ignored --exclude-standard does not list
> the files under lib. These are untracked files, they do show up in
> output if I do git ls-files --others, but not if I provide the ignore=
d
> flag.
>=20
> With 1.8.5.2, all of the files under lib are listed if I ls-files
> --ignored --others --exclude-standard

This was probably fixed by v1.7.11.2~12^2~5 (ls-files -i: pay
attention to exclusion of leading paths, 2012-06-01).

[...]
> I'm not sure if this 1.7.X is still supported, but I think it's still
> the latest git-core available
> in Ubuntu 12.04 repositories.

I haven't had much luck in the past working with the Ubuntu
maintainers to update old releases. :(

https://launchpad.net/~git-core/+archive/ppa may help if PPAs are
usable in your environment.

Thanks and hope that helps,
Jonathan
