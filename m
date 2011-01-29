From: Francis Moreau <francis.moro@gmail.com>
Subject: Re: Can't find the revelant commit with git-log
Date: Sat, 29 Jan 2011 14:57:07 +0100
Message-ID: <m2k4hn6cek.fsf@gmail.com>
References: <m2ipxd2w78.fsf@gmail.com> <4D3EF650.20407@lsrfire.ath.cx>
	<m2ipxc27zi.fsf@gmail.com> <m239og12pe.fsf@gmail.com>
	<4D4063EC.7090509@lsrfire.ath.cx> <4D433CA7.9060200@lsrfire.ath.cx>
	<m2sjwb6feo.fsf@gmail.com> <4D440FED.2010203@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>
To: =?iso-8859-1?Q?Ren=E9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Sat Jan 29 14:57:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PjBJ0-00027C-2C
	for gcvg-git-2@lo.gmane.org; Sat, 29 Jan 2011 14:57:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752634Ab1A2N5P convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 29 Jan 2011 08:57:15 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:32947 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752142Ab1A2N5O convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 29 Jan 2011 08:57:14 -0500
Received: by wyb28 with SMTP id 28so4127254wyb.19
        for <git@vger.kernel.org>; Sat, 29 Jan 2011 05:57:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=LJyMACwoBzNvsqa4inqindvu8ofm7g4zL6MS6xQQY0Y=;
        b=OD7Rh26V5ZMlzH3YO1INwuRbsVnJunT10Tr0rQSL9DWjaxlzk23t82yxCsrwTGpqRe
         8rE53pLhr+zxxOJ+qHUDCkDVLRYUduNA+ySWqT5Rric0HfOVOJUxM9h5T1eMhpowzrXs
         bEzpt51o7yrOebpfAGZqQWf3h8Gso55sfd65k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:content-transfer-encoding;
        b=CTZC1SROdlo+2W6gkctMC9EtyVm/aiqYtxsVXjFRQQaYdZ+YvxL2TUkyluLlhimuAJ
         c56M6MgQDsiVALNIe/c9dCnI1DYrVB+cGMUMEslv87PI5uRZHrZZ3UjJpVAdzDW84lIT
         wz73aPTgFSWk2ESo/TYdaRDqsbwsrqvcTfX3U=
Received: by 10.227.175.4 with SMTP id v4mr4047223wbz.204.1296309432292;
        Sat, 29 Jan 2011 05:57:12 -0800 (PST)
Received: from localhost (au213-1-82-235-205-153.fbx.proxad.net [82.235.205.153])
        by mx.google.com with ESMTPS id b54sm5505528wer.45.2011.01.29.05.57.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 29 Jan 2011 05:57:10 -0800 (PST)
In-Reply-To: <4D440FED.2010203@lsrfire.ath.cx> (=?iso-8859-1?Q?=22Ren=E9?=
 Scharfe"'s message of
	"Sat, 29 Jan 2011 14:02:37 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165659>

Ren=E9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

> Am 29.01.2011 13:52, schrieb Francis Moreau:
>> Ren=E9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:
>>=20
>>> Am 26.01.2011 19:11, schrieb Ren=E9 Scharfe:
>
>>>> - Make git grep report non-matching path specs (new feature).
>>>
>>> This is a bit complicated because grep can work on files, index ent=
ries
>>> as well as versioned objects and supports wildcards,
>>> so it's not that easy to tell if a path spec matches something or i=
s a
>>> rather typo.  But it's not impossible either, of course.
>>=20
>> I don't understand this for the following use case:
>>=20
>>    $ cd ~/linux-2.6/drivers/pci/
>>    $ git grep blacklist v2.6.27 -- drivers/pci/intel-iommu.c
>>=20
>> From what you said, it sounds that git grep is actually searching th=
e
>> string 'somewhere'. But where ?
>
> All files in the directory are looked at and checked if they match th=
e
> given path spec first.  Since none of them do, no actual text search =
has
> to take place.

and in this case, it is complicated to tell that the given path spec
match nothing. right ?

--=20
=46rancis
