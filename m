From: Grant Grundler <grundler@chromium.org>
Subject: Re: [PATCH] staging: brcm80211: SDIO/MMC cleanups
Date: Fri, 6 May 2011 08:21:45 -0700
Message-ID: <BANLkTimQ8A9bfRE=Uu59QDWhBgxvVRJW7g@mail.gmail.com>
References: <20110504165947.40EED208186@grundler.mtv.corp.google.com>
	<4DC3B086.90802@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Greg Kroah-Hartman <greg@kroah.com>,
	"devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
	Dowan Kim <dowan@broadcom.com>,
	Henry Ptasinski <henryp@broadcom.com>,
	Venkat Rao <vrao@broadcom.com>, git@vger.kernel.org
To: Arend van Spriel <arend@broadcom.com>
X-From: git-owner@vger.kernel.org Fri May 06 17:21:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QIMqq-000857-Rz
	for gcvg-git-2@lo.gmane.org; Fri, 06 May 2011 17:21:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756415Ab1EFPVv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 6 May 2011 11:21:51 -0400
Received: from smtp-out.google.com ([74.125.121.67]:62891 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756247Ab1EFPVu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 May 2011 11:21:50 -0400
Received: from hpaq7.eem.corp.google.com (hpaq7.eem.corp.google.com [172.25.149.7])
	by smtp-out.google.com with ESMTP id p46FLmec020325
	for <git@vger.kernel.org>; Fri, 6 May 2011 08:21:48 -0700
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=google.com; s=beta;
	t=1304695309; bh=klqZFbygVR5UfPzpfek+pssKIjU=;
	h=MIME-Version:Sender:In-Reply-To:References:Date:Message-ID:
	 Subject:From:To:Cc:Content-Type:Content-Transfer-Encoding;
	b=aOk6hMIowNEEix3ZqhmJ/lCy+3adsSVWUfYLAlcdknmDnaKUU59hqHGJvEMOjz8WE
	 RNnDPDLAjmKtNE7x9rdNw==
Received: from gyg4 (gyg4.prod.google.com [10.243.50.132])
	by hpaq7.eem.corp.google.com with ESMTP id p46FLkns011968
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <git@vger.kernel.org>; Fri, 6 May 2011 08:21:47 -0700
Received: by gyg4 with SMTP id 4so1424245gyg.4
        for <git@vger.kernel.org>; Fri, 06 May 2011 08:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=beta;
        h=domainkey-signature:mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=IWvckPup+gevGo9K/hW3rxcEp6IqE+CI6EKZwm+R/TA=;
        b=anBcQMo5UPp4gEmeVl9ftb7xfZma/OvIiUbhq59V7tzR2Tff19Eovm/yRxTUoKgBnr
         IMgB5UvESdTYdJJe/Urw==
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=google.com; s=beta;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=cftLN6HpEbylUM+57iDDYyia2+xH8CSN6Vvgq+K5EXH/92DX2EsbeP4Dv8r0EPJN9d
         fTBtgsIPkmPwPvKw8j1w==
Received: by 10.91.219.6 with SMTP id w6mr3404472agq.154.1304695305775; Fri,
 06 May 2011 08:21:45 -0700 (PDT)
Received: by 10.90.114.12 with HTTP; Fri, 6 May 2011 08:21:45 -0700 (PDT)
In-Reply-To: <4DC3B086.90802@broadcom.com>
X-Google-Sender-Auth: h7BNZLAdg8kBtc1IuVVxld8walI
X-System-Of-Record: true
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172980>

On Fri, May 6, 2011 at 1:25 AM, Arend van Spriel <arend@broadcom.com> w=
rote:
=2E..
>> Signed-off-by: Grant Grundler<grundler@chromium.org>
>>
>> diff --git a/drivers/staging/brcm80211/brcmfmac/dhd_sdio.c
>> b/drivers/staging/brcm80211/brcmfmac/dhd_sdio.c
>> index 0c248aa..4bfd8d8 100644
>
> I am having difficulties applying a patch and want to turn it into a
> learning experience for me. I tried to apply this patch using the fol=
lowing
> steps:
> 1. save the email to grundler.eml
> 2. checkout staging-next branch (HEAD 7cc8243)
> 3. run 'git am grundler.eml'
> Applying: staging: brcm80211: SDIO/MMC cleanups
> error: patch failed: drivers/staging/brcm80211/brcmfmac/dhd_sdio.c:13=
5
> error: drivers/staging/brcm80211/brcmfmac/dhd_sdio.c: patch does not =
apply
> Patch failed at 0001 staging: brcm80211: SDIO/MMC cleanups

In case it matters, that patch was generated with simple "git diff"
and then hand edited to prepend the commit log, S-o-B, and comments.
I'm still too chicken to use git-mail.

I haven't touched that tree since making the diff. Any information
that might help explain the state is available. Here are some basics:
grundler <2083>git config -l
user.name=3DGrant Grundler
user.email=3Dgrundler@google.com
color.ui=3Dauto
core.repositoryformatversion=3D0
core.filemode=3Dtrue
core.bare=3Dfalse
core.logallrefupdates=3Dtrue
remote.origin.fetch=3D+refs/heads/*:refs/remotes/origin/*
remote.origin.url=3Dgit://git.kernel.org/pub/scm/linux/kernel/git/gregk=
h/staging-2.6.git

grundler <2084>git status
# Not currently on any branch.
# Changed but not updated:
#   (use "git add <file>..." to update what will be committed)
#   (use "git checkout -- <file>..." to discard changes in working dire=
ctory)
#
#       modified:   drivers/staging/brcm80211/brcmfmac/bcmsdh_sdmmc.c
#       modified:   drivers/staging/brcm80211/brcmfmac/dhd_sdio.c
#
no changes added to commit (use "git add" and/or "git commit -a")

grundler <2054>cat .git/ORIG_HEAD
3d51406d08649d166b3f3d552da2bdfbcf46fcde
grundler <2055>cat .git/FETCH_HEAD
5933f2ae353a93b1d3b501bc63c925531849bbc7        not-for-merge   branch
'master' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/stagin=
g-2.6
6c7ed917a237a0605ebe3ea2237a8d1744b0bad5        not-for-merge   branch
'ralink' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/stagin=
g-2.6
b27b8ea853c4c1c1d5d95448cf69b3f10a9558d4        not-for-merge   branch
'staging-linus' of
git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging-2.6
7cc82439baf3faa45cbb9f05a6a8b6b55891621a        not-for-merge   branch
'staging-next' of
git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging-2.6
grundler <2056>cat .git/HEAD
7cc82439baf3faa45cbb9f05a6a8b6b55891621a


> The git documentation on the git am command is not very elaborate. I
> investigated the issue and checked following:
> 1. line 135 in dhd_sdio.c in the patch does match line 135 in my chec=
ked out
> branch.

Just for grins, can you apply the patch by hand?
    patch -p1 < grundler.eml

This would just confirm it's not a problem with the "diff" portion of
the patch. It's possible something else in the file is
confusing/annoying git-am command.

> 2. did 'git hash-object'
> =C2=A0 =C2=A0$ git hash-object drivers/staging/brcm80211/brcmfmac/dhd=
_sdio.c
> =C2=A0 =C2=A00c248aa43a37cfd1701f97988ec7cf4ff76a2789

grundler <2086>git hash-object drivers/staging/brcm80211/brcmfmac/bcmsd=
h_sdmmc.c
25fbd9c54bb0039f1a4d17e6fc9c12c4d83e0e20
grundler <2087>git hash-object drivers/staging/brcm80211/brcmfmac/dhd_s=
dio.c
4bfd8d867d29c0afd6e6b6fb4330871481e1c8bc

hth,
grant
