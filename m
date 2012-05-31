From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: How to find all the commits that comprise a branch?
Date: Thu, 31 May 2012 08:52:12 +0530
Message-ID: <CAMK1S_i5-ALrMA+iJ1Q4R5FuVbjVdFLfxKoEF4BVHERHSzmjeg@mail.gmail.com>
References: <CAMP44s2kEMK8ik2NTiP4uiN4FPWFNYNJfY5qh5QE_hRH2AiNYA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 31 05:22:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SZvxp-0000pj-W7
	for gcvg-git-2@plane.gmane.org; Thu, 31 May 2012 05:22:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752357Ab2EaDWO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 30 May 2012 23:22:14 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:61553 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752026Ab2EaDWN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 30 May 2012 23:22:13 -0400
Received: by obbtb18 with SMTP id tb18so709943obb.19
        for <git@vger.kernel.org>; Wed, 30 May 2012 20:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=vzwvu60/Edqbe9SU+UHn+by9i+wwT65l5UnA8g9hDOU=;
        b=UZg4ryPqgJqsCtszuvHckReOctPaLI1l522+2bZYAxDUD2VrX6NBs7gnPw4ezoRuKj
         a+z1FJCULDjNVj1HGkrtphVe8DKgc1j6Y6OQy0muReH3VOmtfOxCs75k9IMRTo3ym5Fa
         Zcu55jF3u9HyNga7AUaPeJtBfa4uUf3ZGRytooBPGraT2lxucrQRzPYZX8HDueFxkshn
         UYfu/f1K27Wz3Zwa+EfRfXOUeI/ktb0sMCiPNMntV1wBBEQ8+x4rExgW6sEQKYDjGWVV
         SCE/FVuaJ4Pu12L6lbyKmWX98BSyiC/oZrQtKDcfU11Ld2yiGnc4wtMS0Ix5HFO/1Piv
         zBDQ==
Received: by 10.60.26.65 with SMTP id j1mr17943718oeg.9.1338434532796; Wed, 30
 May 2012 20:22:12 -0700 (PDT)
Received: by 10.182.108.67 with HTTP; Wed, 30 May 2012 20:22:12 -0700 (PDT)
In-Reply-To: <CAMP44s2kEMK8ik2NTiP4uiN4FPWFNYNJfY5qh5QE_hRH2AiNYA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198858>

On Wed, May 30, 2012 at 11:09 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> Hi,
>
> Basically what I want to do is:
>
> =C2=A0% git log branch ^<any-other-branch>
>
> IOW; all the commits were 'git branch --contains' would show 'branch'
> and nothing else.

I have a script called "otb" (only this branch, I guess; I tend to use
crappily short names for stuff I don't make public!) that looks like
this:

#!/bin/bash

m=3D$(git rev-parse HEAD)
n=3D$(git rev-parse --branches | grep -v $m)
git log --oneline $m --not $n

I think that fits your description, but it's not *one* command.

> Is there any easy way to do that?
>
> Cheers.
>
> --
> Felipe Contreras
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml



--=20
Sitaram
