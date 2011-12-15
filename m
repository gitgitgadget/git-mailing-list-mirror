From: Miles Bader <miles@gnu.org>
Subject: Re: [PATCH 3/3] Do not create commits whose message contains NUL
Date: Thu, 15 Dec 2011 10:04:06 +0900
Message-ID: <CADCnXoaqEXJV+Mb1=nQge_bjA3H6R7=BPt213CKLX55zyTHEtg@mail.gmail.com>
References: <1323777368-19697-1-git-send-email-pclouds@gmail.com>
 <1323871699-8839-1-git-send-email-pclouds@gmail.com> <1323871699-8839-4-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 15 02:04:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Razkj-00005u-Jy
	for gcvg-git-2@lo.gmane.org; Thu, 15 Dec 2011 02:04:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758473Ab1LOBEt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 14 Dec 2011 20:04:49 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:58362 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758429Ab1LOBEs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Dec 2011 20:04:48 -0500
Received: by eekc4 with SMTP id c4so1489101eek.19
        for <git@vger.kernel.org>; Wed, 14 Dec 2011 17:04:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=BRQSwQrGCx3rPotxmlLVvYbW9iXFPNEVL0DFUmfet6I=;
        b=RCwLVRnVKT5XUoAwX86KCbh6ZZmGEdrxC6Yo6tizQp+986fTJXVH+Af7W+DpSlaR3Y
         9UMr6eJsy+0RKrm0fRWtK+QIglgNgavuXPS9E/LRCTl6Iq20jz1DQrshH4DCuejT8yxK
         LJ1OZSdaN/D2sSpwcdsye12G6EIH0imWECcgk=
Received: by 10.14.120.10 with SMTP id o10mr341068eeh.128.1323911087332; Wed,
 14 Dec 2011 17:04:47 -0800 (PST)
Received: by 10.14.37.193 with HTTP; Wed, 14 Dec 2011 17:04:06 -0800 (PST)
In-Reply-To: <1323871699-8839-4-git-send-email-pclouds@gmail.com>
X-Google-Sender-Auth: 8a2sBjxmNaTiiKnn3WpUU6AslAg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187181>

> + =A0 =A0 =A0 commitWideEncoding::
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 Advice shown when linkgit::git-commit[1=
] refuses to
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 proceed because there are NULs in commi=
t message.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 Default: true.

Although "wide encoding" is a reasonable guess at cause of embedded
zero characters (and so a useful term for diagnostic messages, as it
can help users identify the problem in their environment which is
causing such zero bytes), it's really only a guess in most cases...

Shouldn't the variable be named based on what it actually does, which
is allow zero-bytes in commit messages...?

-Miles

--=20
Cat is power. =A0Cat is peace.
