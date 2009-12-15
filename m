From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 03/23] Introduce "skip-worktree" bit in index, teach Git 
	to get/set this bit
Date: Tue, 15 Dec 2009 15:05:56 +0700
Message-ID: <fcaeb9bf0912150005w356744a0j6f543fd4bd2449e@mail.gmail.com>
References: <1260786666-8405-4-git-send-email-pclouds@gmail.com> 
	<20091214230619.GA30538@dr-wily.mit.edu> <fcaeb9bf0912141951l5bbb4baanb991354aa3f11ae4@mail.gmail.com> 
	<4B2738D1.90002@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Greg Price <price@ksplice.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Dec 15 09:06:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NKSQJ-0007n8-MK
	for gcvg-git-2@lo.gmane.org; Tue, 15 Dec 2009 09:06:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751809AbZLOIGS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Dec 2009 03:06:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751757AbZLOIGS
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Dec 2009 03:06:18 -0500
Received: from mail-px0-f174.google.com ([209.85.216.174]:40513 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751685AbZLOIGR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Dec 2009 03:06:17 -0500
Received: by pxi4 with SMTP id 4so2431874pxi.33
        for <git@vger.kernel.org>; Tue, 15 Dec 2009 00:06:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=pJKZUaS9BOOVs/1+OeuxfQy3lYIcbggrJBsUqPdg3cU=;
        b=fqYAgOSE1Wc9ODAp/dVnzE/kGADF+p6q00aLx17xKCyRz+YWJBQ8N6fOrivmMP/uGl
         Hi/8XZ8hxfliVmMgeol4lBPe5XrvOhGwrMVcfpO0D1ILRarPGCPKrFh1Q1N9XJllbL/2
         1o1EIMSVlkxZiS2PLe0N4TcddqxJgH3kYhD0c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=RGfv1sioX+klkcIN6Y3n00jnpMJ6WqJULLYHnd91SRxHTd0D65R9VdAG8C3/7qRDBH
         gO/ruj4LuBjXBFZXVd4W/ctEYGg7bYmDXfXxwQ1u7iuBuL0IXJf5jje6fLc3Tttty1q8
         EFvJfUJ3POAXaHO24WJboLFjdYyIkV9+8dPP8=
Received: by 10.115.86.3 with SMTP id o3mr4028863wal.206.1260864376103; Tue, 
	15 Dec 2009 00:06:16 -0800 (PST)
In-Reply-To: <4B2738D1.90002@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135279>

On Tue, Dec 15, 2009 at 2:20 PM, Johannes Sixt <j.sixt@viscovery.net> w=
rote:
> Nguyen Thai Ngoc Duy schrieb:
>> 2009/12/15 Greg Price <price@ksplice.com>:
>>> I confess I can't tell how the skip-worktree bit does differ from
>>> assume-unchanged. =C2=A0Is its 'goal' different only in that you ha=
ve a
>>> different motivation for introducing it, or does it actually have a
>>> different effect -- and what is that different effect?
>>
>> On the fun side, you could use both bits in the same worktree, to
>> narrow your worktree and have some assume-unchanged files.
>>
>> Another difference is that with assume-unchanged bit, you make a
>> promise to Git that those assume-unchanged files are "good", Git doe=
s
>> not have to care for them. If somehow you violate the promise, Git c=
an
>> harm your files on worktree.
>
> So, the difference is that skip-worktree will not overwrite a file th=
at is
> different from the version in the index, but assume-unchanged can? Ri=
ght?

Yes.
--=20
Duy
