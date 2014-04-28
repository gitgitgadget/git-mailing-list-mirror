From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 03/12] MINGW: compat/mingw.h: do not attempt to redefine
 lseek on mingw-w64
Date: Mon, 28 Apr 2014 14:58:41 -0500
Message-ID: <535eb2f15505_3c9cdef2ec5@nysa.notmuch>
References: <1398693097-24651-1-git-send-email-marat@slonopotamus.org>
 <1398693097-24651-4-git-send-email-marat@slonopotamus.org>
 <535EB32B.4050209@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>,
	Marat Radchenko <marat@slonopotamus.org>,
	GIT Mailing-list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 28 22:09:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Werrc-0002D6-55
	for gcvg-git-2@plane.gmane.org; Mon, 28 Apr 2014 22:09:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755207AbaD1UJQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Apr 2014 16:09:16 -0400
Received: from mail-ob0-f176.google.com ([209.85.214.176]:40723 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753758AbaD1UJP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Apr 2014 16:09:15 -0400
Received: by mail-ob0-f176.google.com with SMTP id wp4so7811403obc.21
        for <git@vger.kernel.org>; Mon, 28 Apr 2014 13:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=hSlyUrIysxrtjHXjk3mJUJ7QAdGb8tNeZIemXJav/Bw=;
        b=Pn0i7LH/1Ta+/K07qGtgbMDD4ZNeezETWgwLacKJ/QWFcODHQkwiwRBzIz33R/KDG/
         uiRsCvecvIzA/m2XnU3641Es7ocppRsdnmiPsPA69K75LVmxMjHYwY5gswQOqRSHxrjX
         kiW3dns6l/4iqZWZFz+N32WDOLUilR+svQHKP8EbRM8A8ST/29QxNtoeLG2+J6CbOD9e
         E778U0v9HwkE6WKGAypDeVzwb0ZNpuWWp3qgAvl4AS9NeHDoc31jBZSbtp36inKmRdvF
         rg3OMKZwxesd5NweZK9HIb2WobJmfbY+eP1iEO9vtkNKXnc/Co1r4qda/IcvGFTA52Zv
         k3Ug==
X-Received: by 10.60.55.97 with SMTP id r1mr24214525oep.5.1398715754625;
        Mon, 28 Apr 2014 13:09:14 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id qp6sm38850931obb.14.2014.04.28.13.09.12
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Apr 2014 13:09:13 -0700 (PDT)
In-Reply-To: <535EB32B.4050209@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247437>

Torsten B=C3=B6gershausen wrote:
> On 2014-04-28 15.51, Marat Radchenko wrote:
> > mingw-w64 has lseek defined in io.h.
> []
> >  #define off_t off64_t
> > +#ifndef lseek
> >  #define lseek _lseeki64
> > +#endif
> Is the commit message in line with the code?
>=20
> I would have expected something in this style:
>=20
> #if defined(__x86_64__) && ! defined(lseek))
> #include <io.h>
> #endif=20

mingw-w64 provides a 32-bit compiler as well, and it needs this fix as =
well
IIRC.

--=20
=46elipe Contreras