From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH/RFC] clone: suggest index version 4 when the index is
 bigger than 512 KiB
Date: Tue, 19 Feb 2013 17:54:55 +0700
Message-ID: <CACsJy8CA8N1Hiz4JAXx++5BGEyYa6JnP3bhh++vtxb+6-ah-vA@mail.gmail.com>
References: <1360848843-12092-1-git-send-email-pclouds@gmail.com> <loom.20130219T113730-546@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Thomas Ackermann <th.acker@arcor.de>
X-From: git-owner@vger.kernel.org Tue Feb 19 11:55:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7krd-0008Fz-5b
	for gcvg-git-2@plane.gmane.org; Tue, 19 Feb 2013 11:55:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758665Ab3BSKz3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 19 Feb 2013 05:55:29 -0500
Received: from mail-ob0-f176.google.com ([209.85.214.176]:64527 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758647Ab3BSKz1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Feb 2013 05:55:27 -0500
Received: by mail-ob0-f176.google.com with SMTP id v19so6455938obq.35
        for <git@vger.kernel.org>; Tue, 19 Feb 2013 02:55:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=08uo3wOw2qz7shsKuaqtRpimn3NyHTmVFZf7FxTDqYQ=;
        b=e8LHOTKGx4xhoXZI3UDfxIAwV+z/l7aK0ACGnu6n4coBwbsTqyy08eFwWHU72A7kIk
         zFq5/JfGSc7Hf5sGYooFVcQA99OfL0zJEKfOe2x03oQZSoSQbKgKhejXazZJ4a11eMH2
         knz55F8vw9wBzqQfe37MXhSm45+36x3f4GgxSTiSRvnCraMT7gws9FcwE3xkoIteMKxJ
         H0Ose5xkZnx6gaosKC9y8YRrx42X7/EGCRQYPGxipYtSG2++tYn/AEjJRn9mye2bfH29
         jiTSWzoHkbEfl3O1bd5z1lDtamZKEfoLhxY6AX9uF6KRpgn+O7Ibse3bi5GiqY0hT3UW
         sLWg==
X-Received: by 10.182.235.49 with SMTP id uj17mr7383872obc.18.1361271325495;
 Tue, 19 Feb 2013 02:55:25 -0800 (PST)
Received: by 10.76.154.197 with HTTP; Tue, 19 Feb 2013 02:54:55 -0800 (PST)
In-Reply-To: <loom.20130219T113730-546@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216602>

On Tue, Feb 19, 2013 at 5:45 PM, Thomas Ackermann <th.acker@arcor.de> w=
rote:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds <at> gmail.com> wr=
ites:
>
>>
>> I just realized that many of my big repos are still on index v2 whil=
e
>> v4 should reduce its size significantly (3.8M -> 2.9M for linux-2.6
>> and 25M -> 14M for webkit, for example). I wanted to propose index v=
4
>> as the new default version, because I guess that not many people
>> outside git <at> vger are aware of it, but perhaps this approach is =
less
>> drastic. It only suggest index v4 when the index size after clone hi=
ts
>> 512K limit.
>>
>
> Is V4 really recommended for general use?
> Default seems to be V3 and all I found in the docs is
> the coresponding release not describing V4 as "experimental".
> (I have repos with index files > 40MiB (!) which will shrink to
> approx. 20MiB with V4 so using V4 would be an interessting option for=
 me.)

The default could be either v2 or v3, depending on whether you use
some extra features. v4 is basically v3 with pathname compression.
Yes, I think it's ok for general use.
--=20
Duy
