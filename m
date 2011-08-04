From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 09/18] revert: Don't create invalid replay_opts in parse_args
Date: Thu, 4 Aug 2011 15:04:21 +0530
Message-ID: <CALkWK0k3ySLuY+7ogVJ6fmz59E6Gh2k26YLLY_LCvKFyDN5_iQ@mail.gmail.com>
References: <1312222025-28453-1-git-send-email-artagnon@gmail.com>
 <1312222025-28453-10-git-send-email-artagnon@gmail.com> <201108020828.37904.chriscool@tuxfamily.org>
 <201108020841.41593.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Thu Aug 04 11:34:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QouKI-000860-A1
	for gcvg-git-2@lo.gmane.org; Thu, 04 Aug 2011 11:34:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752937Ab1HDJen convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Aug 2011 05:34:43 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:45573 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751675Ab1HDJem convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Aug 2011 05:34:42 -0400
Received: by wyf22 with SMTP id 22so386145wyf.19
        for <git@vger.kernel.org>; Thu, 04 Aug 2011 02:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=vLzUNg8TYnoRWbb5mCsKixYaQ9O9VnsM+xRT8bnILXg=;
        b=wq63d2QWBZdkVp8Vj52xDuvdoHvF8odC9pKPxkDODtWiJFdHW0LctaSwsuMCIUnvpv
         DzhjagbMZBqBGC5WuD5IINqW8AEUcCZME2s+ZXdv6vPzSr/B1BlvztDukGVtWoo/Wuj6
         LKu2j3nSuq1kfiZVXeDX6rRXJd3Zp8NhegoiU=
Received: by 10.216.255.18 with SMTP id i18mr503528wes.64.1312450481113; Thu,
 04 Aug 2011 02:34:41 -0700 (PDT)
Received: by 10.216.137.134 with HTTP; Thu, 4 Aug 2011 02:34:21 -0700 (PDT)
In-Reply-To: <201108020841.41593.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178711>

Hi Christian,

Christian Couder writes:
> ... and we could remove the "set" variable like this:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0while ((this_opt =3D va_arg(ap, const char=
 *))) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (va_arg(ap,=
 int))
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0break;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}

Very elegant- I especially like this.
You've reduced this to simply checking if the while loop ended
properly, or broke (using a break statement) by checking the
conditional that drove the loop.

Thanks.

-- Ram
