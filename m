From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [bug] remotes-hg: timezones are transformed
Date: Sat, 3 Aug 2013 18:17:43 -0500
Message-ID: <CAMP44s0aiv7rNCFgQ4hz_KOMRJ5F4CXFTXME73biNA4Nv3Vwdw@mail.gmail.com>
References: <EDA1C92E-6872-40D5-8C25-89C3FFF62F7A@joernhees.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: =?UTF-8?Q?J=C3=B6rn_Hees?= <dev@joernhees.de>
X-From: git-owner@vger.kernel.org Sun Aug 04 01:17:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V5l53-0005w7-B4
	for gcvg-git-2@plane.gmane.org; Sun, 04 Aug 2013 01:17:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753155Ab3HCXRp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 3 Aug 2013 19:17:45 -0400
Received: from mail-la0-f42.google.com ([209.85.215.42]:53104 "EHLO
	mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752334Ab3HCXRo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 3 Aug 2013 19:17:44 -0400
Received: by mail-la0-f42.google.com with SMTP id mf11so1255961lab.1
        for <git@vger.kernel.org>; Sat, 03 Aug 2013 16:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=yUOaNkd+x+T135z0DGX9dGqa9EnEGnClqYM4Rh5angU=;
        b=lgnGHweDdh2CfXQILYkPbB+exJ+yQdy3S9/SIYHFWhH0Pp2jESax8Yht4Uk0vZmabR
         xyR7+u2kwvx2NCn9zLT08uY0+aVxBpi4UwDpBRtSdPh5uk5HAUzMrRAAc6gEzC1NC7BC
         z/ccUgoNiBxllqWUEv9PqAd92Kb7LhSNGgQHoDTJP7DYso21c2tPp5fgH+vWosYHzkSP
         duHfYjByTVeVx1Il9/WiNOrpR8ErjrgqHy9/QdFONiaKx8uu0IpDJ3R6yGUsxgVaNL51
         K2PCOoeCr20Ct69Eas6gpeGzyBff3wHdR67dV2WNq7+TfBUgCnQEiBJ8T0PNM9EJYk5p
         bteQ==
X-Received: by 10.112.157.226 with SMTP id wp2mr5923220lbb.65.1375571863384;
 Sat, 03 Aug 2013 16:17:43 -0700 (PDT)
Received: by 10.114.91.169 with HTTP; Sat, 3 Aug 2013 16:17:43 -0700 (PDT)
In-Reply-To: <EDA1C92E-6872-40D5-8C25-89C3FFF62F7A@joernhees.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231619>

Hi,

On Sat, Aug 3, 2013 at 11:36 AM, J=C3=B6rn Hees <dev@joernhees.de> wrot=
e:

> it seems that if you use the 1.8.3.4 remote-helpers/git-remote-hg to =
clone a mercurial repo the timezone information of commits gets transfo=
rmed into your current timezone.
> (command: git clone hg::=E2=80=A6)
>
> I noticed this when a colleague in another timezone used Kiln to also=
 export the same mercurial repo that i had cloned from git before.
> Fetching from his git repo gives me a "second root tree" with all com=
mits duplicated.
> A git show of two equivalent commit reveals that the Date: line of th=
e commits changed.
> Tracking this back into the original mercurial repo reveals that _his=
_ times are correct.
>
> This will also make two or more clones from different timezones all u=
sing the same hg remote repo incompatible!
>
>
> Example:
> Original mercurial commit (timezone: -7200 =3D -4h)
> https://bitbucket.org/lipis/gae-init/commits/a43078f90e727a13767cf14c=
740157763fb423b5/raw/
>
> Lipis git export via Kiln: (-4h)
> https://github.com/lipis/gae-init/commit/36b7cabf03fbba784cc41b634304=
33e9fc79ca8c
>
> My export via git clone hg::ssh://hg@bitbucket.org/lipis/gae-init (+2=
h)
> https://github.com/joernhees/git-hg-remote-bug_gae-init/commit/8341bf=
10f1f0a7a924717a8a2c1770f61acd51ae

Actually our version is the correct one:

% hg commit -m one -d "2012-04-28 11:28 +0200"
% hg export
# HG changeset patch
# User Felipe Contreras <felipe.contreras@gmail.com>
# Date 1335605280 -7200
#      Sat Apr 28 11:28:00 2012 +0200

--=20
=46elipe Contreras
