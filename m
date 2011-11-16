From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 3/4] ll-merge: initialize default_opts const
Date: Wed, 16 Nov 2011 11:36:05 +0530
Message-ID: <CALkWK0mVxxq0345B_OJQwejpTBD=evOU_iAv39CvXv4mAi=09A@mail.gmail.com>
References: <1321376379-31750-1-git-send-email-artagnon@gmail.com>
 <1321376379-31750-4-git-send-email-artagnon@gmail.com> <7vty65t1qp.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Thomas Rast <trast@student.ethz.ch>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 16 07:07:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RQYf1-0005YG-Dn
	for gcvg-git-2@lo.gmane.org; Wed, 16 Nov 2011 07:07:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753536Ab1KPGG2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 16 Nov 2011 01:06:28 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:43734 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753523Ab1KPGG2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Nov 2011 01:06:28 -0500
Received: by wwe5 with SMTP id 5so153956wwe.1
        for <git@vger.kernel.org>; Tue, 15 Nov 2011 22:06:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=NHrI2kzG0BfHiRhyJ+KOecHj6loyynywvrJmLIbYv9s=;
        b=lWMYTOVyiTAi3zqN6FGa3B4ctJjEIt9ljWXW5Of02yoeb+xnASWF9df6YD7aEc/xrZ
         jeux2joyzffLREDSUH15hGbfewRq1KNCW+W85U1rKz+2o3aEEDFtL0B6wl1Ja6DKLsbF
         rxvWqTibgEj0Whrk7elVITfLrn0sTfH2mOvi4=
Received: by 10.216.186.196 with SMTP id w46mr262237wem.24.1321423586153; Tue,
 15 Nov 2011 22:06:26 -0800 (PST)
Received: by 10.216.19.209 with HTTP; Tue, 15 Nov 2011 22:06:05 -0800 (PST)
In-Reply-To: <7vty65t1qp.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185508>

Hi Junio,

Junio C Hamano wrote:
> Ramkumar Ramachandra <artagnon@gmail.com> writes:
>> [...]
>> diff --git a/ll-merge.c b/ll-merge.c
>> index da59738..205aed3 100644
>> --- a/ll-merge.c
>> +++ b/ll-merge.c
>> @@ -351,7 +351,7 @@ int ll_merge(mmbuffer_t *result_buf,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const struct ll_merge_optio=
ns *opts)
>> =C2=A0{
>> =C2=A0 =C2=A0 =C2=A0 static struct git_attr_check check[2];
>> - =C2=A0 =C2=A0 static const struct ll_merge_options default_opts;
>> + =C2=A0 =C2=A0 static const struct ll_merge_options default_opts =3D=
 {0, 0, 0, 0};
>
> Doesn't "static" tell us that it will be in BSS, initialized to all z=
ero
> by definition?

I'm uncertain about whether the C89 standard says this explicitly- icc
is more pedantic than most mainstream compilers.  Feel free to drop
this part if you don't think it adds value.

Thanks.

-- Ram
