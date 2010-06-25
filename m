From: Carlos S <neubyr@gmail.com>
Subject: Re: git config over http and ssh went wrong
Date: Fri, 25 Jun 2010 13:08:44 -0500
Message-ID: <AANLkTilui6O9dNk1D5BaIFZUVKi2ByuYeMw0hkfxVRcn@mail.gmail.com>
References: <AANLkTimc_T6qS5zVo92F8lw7hNPFp-9BhLP_g4ojntlZ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 25 20:08:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OSDKd-000260-9P
	for gcvg-git-2@lo.gmane.org; Fri, 25 Jun 2010 20:08:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756641Ab0FYSIq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 25 Jun 2010 14:08:46 -0400
Received: from mail-qw0-f43.google.com ([209.85.216.43]:47347 "EHLO
	mail-qw0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756638Ab0FYSIq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 Jun 2010 14:08:46 -0400
Received: by qwd7 with SMTP id 7so1412441qwd.2
        for <git@vger.kernel.org>; Fri, 25 Jun 2010 11:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=M9PaF+yMVJ88BJmlgRjbSPf3z8OVI039BV+27buuoSM=;
        b=DrmacYsmA7gvo74oKBM6TJH4UP3hwaoFSVVKRGCfYlPNx0tWV9XLzQoZnnNxpxPpoK
         5utBsZvOD8TbkbCd+kPJWK1+4kMhCHwemElKyTdchlHWqeIAG10UsvdYPorOZ1ExQj9o
         KgxgDQbEMatc9F+dauI4OJ3RnETyQzR8gzRso=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=u5KV6KelZrz148+23orYlYBdUrKvNLw+pD7tqYK5/E2Fj+EXY/LudWijQRVZHuhrfw
         gZpqhqGSy3QrgsaSgE84hwkICuVyKeD0jplCwPM38Fr8Mdhzk1h0t5sf81wHTLPVWcUl
         f2z46qLVilDlFG7nJJOXSL/5NNRWUE3ad9xiQ=
Received: by 10.224.27.221 with SMTP id j29mr877065qac.132.1277489325046; Fri, 
	25 Jun 2010 11:08:45 -0700 (PDT)
Received: by 10.229.231.85 with HTTP; Fri, 25 Jun 2010 11:08:44 -0700 (PDT)
In-Reply-To: <AANLkTimc_T6qS5zVo92F8lw7hNPFp-9BhLP_g4ojntlZ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149701>

It's working fine. I forgot to add-commit my changes after file modific=
ation.

--
CS.

On Fri, Jun 25, 2010 at 11:28 AM, Carlos S <neubyr@gmail.com> wrote:
> Hi,
>
> I need some help in setting up Git repository to be shared over ssh
> and http. I was able to share my server/public bare repository over
> ssh and http, but now client/private repositories are unable to push
> their changes. Would really appreciate any help on configuring both
> SSH and HTTP. And not sure why my SSH is not updating/pushing changes
> to server, as it did before. Any pointers on where I went wrong?
>
> Here is what I did:
>
> [server - public]
> * On CentOS5 - Git 1.7.1 server:
> =A0-- Initialize bare git repo
>
> [client - private SSH]
> =A0* From another Debian VM:
> =A0-- Create git repo
> =A0-- =A0Add remote origin ssh://user@centos5/var/gitpubrepos/test
> =A0-- git push origin master
>
> [server - public]
> =A0* Then I changed HTTP conf to enable DAV for this directory.
>
> [client - private HTTP] - May be I should have cloned the repo here
> rather than pull?
> =A0* git init
> =A0 Initialized empty Git repository in /ncs/tempgit-http/.git/
> =A0* =A0git remote add origin http://centos5/git/fifa
> =A0* =A0git pull
> =A0 =A0 fatal: http://centos5/git/fifa/info/refs not found: did you r=
un
> git update-server-info on the server?
>
> [server - public]
> =A0* git update-server-info
>
>
> [client - private HTTP]
> =A0* git pull origin master
> =A0 =A0From http://centos5/git/fifa
> =A0 =A0branch =A0 =A0 =A0 =A0 =A0 =A0master =A0 =A0 -> FETCH_HEAD
> =A0 =A0(Got all files)
>
>
> [client-private HTTP]
> =A0* Make some changes and try to push: git push
> =A0* git push
> =A0 =A0Fetching remote heads...
> =A0 =A0refs/
> =A0 =A0refs/tags/
> =A0 =A0refs/heads/
> =A0 =A0'refs/heads/master': up-to-date
>
> =A0[client-private SSH]
> =A0* git push
> =A0 =A0 =3D [up to date] =A0 =A0 =A0master -> master
> =A0 =A0 updating local tracking ref 'refs/remotes/origin/master'
> =A0 =A0 Everything up-to-date
>
> -----
>
> Thanks,
> CS.
>
