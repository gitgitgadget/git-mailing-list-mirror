From: Dingyuan Wang <abcdoyle888@gmail.com>
Subject: Re: assert failed in pathspec.c
Date: Thu, 11 Feb 2016 16:56:32 +0800
Message-ID: <56BC4CC0.1090209@gmail.com>
References: <56BC0714.1010007@gmail.com> <56BC4535.6070301@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 11 09:56:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aTn3R-0004xB-3F
	for gcvg-git-2@plane.gmane.org; Thu, 11 Feb 2016 09:56:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752512AbcBKI4k convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 11 Feb 2016 03:56:40 -0500
Received: from mail-pa0-f44.google.com ([209.85.220.44]:36036 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751661AbcBKI4j (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Feb 2016 03:56:39 -0500
Received: by mail-pa0-f44.google.com with SMTP id yy13so25804491pab.3
        for <git@vger.kernel.org>; Thu, 11 Feb 2016 00:56:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-type:content-transfer-encoding;
        bh=gl+1WX6gN3sE/iibsHCKQfShYQmJuFioBdPFqpJly60=;
        b=icdrZ9tjD4WeifiIdz+wySGHRmrjBir6mWfPKajHsQtBYWZM9Kssy65LOk5891roT1
         nVV+6+X4D5IdWAHMhU/MM3w4w+Uq1kBao/JA7VXK7n5E1gX+PxL/cRvCtgCYRozCqw7R
         UJK/DHS5Mg4iNAx/L34kjRJO4uftwy8O3FVlb0NO0rEpkKW3u1Cqd1LMNj3qXropTV1m
         l928PK89vZ67+dMuVu+qqqcZn2johwY50lj6zlgoF3bvQkoyXNTlGMra5aEyqLlY9S05
         M6Lz5OL8jH04h/nXR2nV9reyxZA8o7V7wWNn0c/Ig0zkULZeO7wnmria+wEV28oCPuFI
         MRxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-type
         :content-transfer-encoding;
        bh=gl+1WX6gN3sE/iibsHCKQfShYQmJuFioBdPFqpJly60=;
        b=gQRznGPj0RX0MgkZtdZnkmX5Rbn+r124TaL0y6bhysbfg+5Rr+91JGVcMP5II/4z3G
         fzdd+/EK4/4TfaMKCFh0y7DSH6R7PU3qZqgDW7xGObVA7+jGQxmk5Z5MbmfVnbr1mE77
         cxuOt7BLkg+eJU2X3GWsigEd3zQ0nuJH9xECp/hQHk63AC8NUq0hUQgSE7BCaZhi9ybN
         e+yaiuA8SgzrZmqojI7c7aMKZhjlD5bITA1fMK7ouGtigEBMKGBJPZsHGF1XZ8bUgVFw
         AZ/vvHKfHuRTagAWIFPJN/9wgDdoSgzkYPjgLtNuXxrbvmLyvImSlwgN8jMreNHZuQCd
         UlIg==
X-Gm-Message-State: AG10YOSrlXO9jv8Rt53Si8uOVVMUJTTUgjGWCL3JPv7rwwOGriiWV9nNdSo61ZOE4jRA6g==
X-Received: by 10.66.251.68 with SMTP id zi4mr12454301pac.113.1455180998818;
        Thu, 11 Feb 2016 00:56:38 -0800 (PST)
Received: from [192.168.1.12] ([114.85.11.215])
        by smtp.gmail.com with ESMTPSA id vy6sm10524172pac.38.2016.02.11.00.56.35
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 11 Feb 2016 00:56:38 -0800 (PST)
X-Enigmail-Draft-Status: N1110
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Icedove/38.5.0
In-Reply-To: <56BC4535.6070301@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285953>

git version 2.7.0.GIT (latest git master)

Sorry, I have found out that this problem is exactly the same as the
previous post I mentioned.

When I created the repo, scripts/ was a subrepo, and then I moved
scripts/.git out. If I add files in the scripts/ dir, SIGABRT.

=E5=9C=A8 2016=E5=B9=B402=E6=9C=8811=E6=97=A5 16:24, Torsten B=C3=B6ger=
shausen =E5=86=99=E9=81=93:
> On 02/11/2016 04:59 AM, Dingyuan Wang wrote:
> []
>=20
> Thanks for the bug report.
>=20
> What does
> git --version
> give you ?
>=20
> And what happens, if you run the latest version of Git ?
>=20

--=20
Dingyuan Wang
