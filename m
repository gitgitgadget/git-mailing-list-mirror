From: Mahesh Vaidya <forvaidya@gmail.com>
Subject: Re: Uncommitted source and header files disappeared after a git mv 
	operation
Date: Wed, 23 Jun 2010 16:17:31 +0530
Message-ID: <AANLkTimi_kN_i2XmKiCB4JdqGD4_kFSjIbajtvpBWnwE@mail.gmail.com>
References: <AANLkTikeW1-Kzdyu1APSqzKGsNnny6InueWluXsKMccU@mail.gmail.com>
	<AANLkTiloMDccUDObmPXPGWI_HYVDMk57EoHxZjFUiSvi@mail.gmail.com>
	<AANLkTilNI0lq0rUqvUIdNRpubNUNqKf3_5nX3TGauvQv@mail.gmail.com>
	<AANLkTinernf5BMowVb-iJZi0c9d6SlsGSoy2L3p4H-3E@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 23 12:47:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ORNUo-0008E5-Vn
	for gcvg-git-2@lo.gmane.org; Wed, 23 Jun 2010 12:47:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752727Ab0FWKrd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 23 Jun 2010 06:47:33 -0400
Received: from mail-yw0-f198.google.com ([209.85.211.198]:35821 "EHLO
	mail-yw0-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751988Ab0FWKrc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Jun 2010 06:47:32 -0400
Received: by ywh36 with SMTP id 36so3804587ywh.4
        for <git@vger.kernel.org>; Wed, 23 Jun 2010 03:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=jblqeRt9LTI14Yqmt9OWPB7KPIkCuaYsS88JDYJuPsY=;
        b=XaIFqfBvr4m1rrEC6Zb8ji0tXRO5kHjf6L6WSwbRIILLthpUvWVTrVtCBF96lKy/eQ
         bGuaGfWvu+k7VBhnqeI6AL/Ic1IS3Gz8Re2TXeVJVrnu4Nmp759RtEttof7cmdkWvEzb
         C+pQWYyisIq0sRU52e9I6+g7vTDfCky8RCjv4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=c6OOTYv7mt+1TxfPlZEg0Q181yx1GATkTHMHBNFMUPXt9X9hz8Myujba5eGpNhuA30
         tfL50mISxUkwnaDScfIoZf2AV6yM/qN/vsUd2ueWGVIYd73ui+wn2S1Wh/uXI4u2P2XW
         6m5ZG4lozDzThV1H0/PUvYCc2jKD2w07BenLw=
Received: by 10.91.26.26 with SMTP id d26mr4979207agj.149.1277290051126; Wed, 
	23 Jun 2010 03:47:31 -0700 (PDT)
Received: by 10.90.25.8 with HTTP; Wed, 23 Jun 2010 03:47:31 -0700 (PDT)
In-Reply-To: <AANLkTinernf5BMowVb-iJZi0c9d6SlsGSoy2L3p4H-3E@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149505>

That means those files were not added to index ;
Even that private files should stay intact

I have done following test case
PWD - lowflow
touch foo bar car
cd ..
git mv  lowflow workflow
git commit -m "mv test" -a
git push
cd workflow # Uncommited files visible


On Wed, Jun 23, 2010 at 4:04 PM, Laszlo Papp <djszapi@archlinux.us> wro=
te:
> On Wed, Jun 23, 2010 at 12:31 PM, Santi B=E9jar <santi@agolina.net> w=
rote:
>> On Wed, Jun 23, 2010 at 12:24 PM, Laszlo Papp <djszapi@archlinux.us>=
 wrote:
>>> Hello,
>>>
>>> I have got a very big trouble, so please help me if you can :(
>>>
>>> I have done a git mv operation for a whole directory, so I have put=
 it
>>> into another subfolder and all my uncommitted/unpushed source and
>>> header files were lost ... How can I regain them ?
>>>
>>> So I did "git mv some-directory-containing-lots-of-uncommitted-chan=
ges
>>> total_different_folder/some-new-name". If I remember well then I di=
d
>>> commit/push for that git mv operation.
>>>
>>> git status doesn't show my changes either.
>>
>> I can't reproduce it. Can you provide a test case so we can reproduc=
e
>> it. Additionally you should tell us more information, like git
>> version, architecture.
>>
>> Santi
>>
>
> http://www.archlinux.org/packages/extra/i686/git/
>
> So the version is 1.7.1 and the architecture is i686.
>
> I have tried the following commands:
> git log -1
> git log -1 --stat
> git reflog
>
> Only this commit happened and I can't find the files in the new direc=
tory.
>
> Best Regards,
> Laszlo Papp
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>



--=20
Thank you and best regards.
Mahesh Vaidya  / 9740500144
http://www.twitter.com/forvaidya
