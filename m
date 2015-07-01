From: Paul Tan <pyokagan@gmail.com>
Subject: Re: [PATCH v4 01/44] wrapper: implement xopen()
Date: Wed, 1 Jul 2015 14:04:13 +0800
Message-ID: <CACRoPnRN0ET17USKVFFJHc_y1jK1xdmgc0r-omaUy_+Qgg=ffg@mail.gmail.com>
References: <1435500366-31700-1-git-send-email-pyokagan@gmail.com>
	<1435500366-31700-2-git-send-email-pyokagan@gmail.com>
	<5590CE10.3020104@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>
To: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Wed Jul 01 08:04:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZAB87-0003fE-CU
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jul 2015 08:04:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750765AbbGAGEQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 1 Jul 2015 02:04:16 -0400
Received: from mail-lb0-f171.google.com ([209.85.217.171]:33893 "EHLO
	mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750936AbbGAGEO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Jul 2015 02:04:14 -0400
Received: by lbnk3 with SMTP id k3so6335653lbn.1
        for <git@vger.kernel.org>; Tue, 30 Jun 2015 23:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=cfHxEPHq1XRChh8P4Ccf5RalTI14Z4N5ycuYzeIDt0E=;
        b=Ff4qOrXkHUP2bNPZW9zxVxn1ZS177t3X1jVtHJsZtuTMmMW1rlUijdKIR2mkmH9rMZ
         9DgwfkL+RRGy/WJr+A2syl45rbPzy11/pq/hYyk15gu5Aj4q9VYtm/LV+nvYmJocvn+M
         IKxI1+r0Z1NB3Xo0LBwzJHUY4KzGF0OYk7rShndnxDZHK+GW5OcjM2UFoQ8PGhF0qxC4
         VnVO/mxtwro24HHOITheK/HToGqdJyDnMLKSs740GvAalv9vnrvq6b6W1hISB8E8jcAk
         p80/4KmwKpKIcfEVM7+x2dWuvCpicFMx9G0jQ0QJlByWj5hYcN1X8AtJYov6c6Cr7SK+
         aUiw==
X-Received: by 10.152.164.193 with SMTP id ys1mr23324554lab.65.1435730653262;
 Tue, 30 Jun 2015 23:04:13 -0700 (PDT)
Received: by 10.112.74.133 with HTTP; Tue, 30 Jun 2015 23:04:13 -0700 (PDT)
In-Reply-To: <5590CE10.3020104@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273116>

On Mon, Jun 29, 2015 at 12:48 PM, Torsten B=C3=B6gershausen <tboegi@web=
=2Ede> wrote:
> - Having xopen() with 2 or 3 parameter is good, but the current may n=
eed
> some tweaks for better portability:
>
> int xopen(const char *path, int oflag, ...)
> {
>         mode_t mode =3D 0;
>         if (oflag & O_CREAT) {
>                 va_list ap;
>                 va_start(ap, oflag);
>                 mode =3D va_arg(ap, int);
>                 va_end(ap);
>
>             }
>
> See e.g.
> <http://blitiri.com.ar/git/r/libfiu/c/37f6a98110e3bb59bbb4971241baa3a=
385c3f724/>
> why va_arg(ap, int) should be used:

Ah OK. I've learned about yet another dark corner of C :-).

Thanks,
Paul
