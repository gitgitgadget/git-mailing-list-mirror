From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 2/2] handle_alias: provide GIT_PREFIX to !alias
Date: Wed, 27 Apr 2011 16:06:09 +0700
Message-ID: <BANLkTi=gjuOqLEArk_0Nj1faEu62dzjbZA@mail.gmail.com>
References: <3422485b672000ecdc72d82ffce8c89f258831b9.1303893279.git.git@drmicha.warpmail.net>
 <4DB7CF72.3080205@drmicha.warpmail.net> <5058a9853a75bff71187f553e67632997761de44.1303893279.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Matej Batic <matej.batic@ge.infn.it>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Apr 27 11:06:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QF0hr-0005Vv-2m
	for gcvg-git-2@lo.gmane.org; Wed, 27 Apr 2011 11:06:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755493Ab1D0JGm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Apr 2011 05:06:42 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:40218 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754822Ab1D0JGk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Apr 2011 05:06:40 -0400
Received: by bwz15 with SMTP id 15so1201072bwz.19
        for <git@vger.kernel.org>; Wed, 27 Apr 2011 02:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=VNrXppzu5omElXBNwDfybT7j/M+vXEguWkLb4vowF4k=;
        b=gsBx9PgEly2eLKoQdKGwBDZoaVlRX5xA+lacrzAVfS0wR/DNyDTlJVmQGcKJfo1Ff2
         n8LZyqPp5S+n6eFunRTivwF+73X89lPuxGPvWryQLvvYFHzl05GaRN54zQ19kk6/XyMo
         /ZL1Z7+Hq+o6I+tafsuxibhTkhvgfyV5VbDI0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=JlRE/Esw/1nrkfWIFspTIPqSRwYC3mhwuqvAE84q44tRKUGh+AZJ44uxBEVcvoJ7eA
         UEw/o04MOFBRnyEHAt1vbdpQSVcBjB3JVQ3vmdW7e9KwC8NCYu2i1Dg1LMpwzStJ/PsW
         rL2VEd4f8/9XpeqCzEk9HzCP+1CbEkGL1uQyQ=
Received: by 10.204.20.143 with SMTP id f15mr1674846bkb.173.1303895199178;
 Wed, 27 Apr 2011 02:06:39 -0700 (PDT)
Received: by 10.204.17.14 with HTTP; Wed, 27 Apr 2011 02:06:09 -0700 (PDT)
In-Reply-To: <5058a9853a75bff71187f553e67632997761de44.1303893279.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172203>

2011/4/27 Michael J Gruber <git@drmicha.warpmail.net>:
> @@ -589,6 +589,8 @@ it will be treated as a shell command. =C2=A0For =
example, defining
> =C2=A0"gitk --all --not ORIG_HEAD". =C2=A0Note that shell commands wi=
ll be
> =C2=A0executed from the top-level directory of a repository, which ma=
y
> =C2=A0not necessarily be the current directory.
> +'GIT_PREFIX' is set as returned by running 'git rev-parse --show-pre=
fix'
> +from the original current directory. See linkgit:git-rev-parse[1].

It made me wonder "but then why should not we just do GIT_PREFIX=3D`git
rev-parse --show-prefix` in the alias?" then realized by the time we
do that, it's already too late. Maybe

> +'GIT_PREFIX' is set as returned by running 'git rev-parse --show-pre=
fix'
> +before current directory is changed to top-level directory. See link=
git:git-rev-parse[1].

?
--=20
Duy
