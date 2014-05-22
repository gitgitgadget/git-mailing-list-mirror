From: Karsten Blees <karsten.blees@gmail.com>
Subject: Re: [RFC/PATCH v4 1/3] add high resolution timer function
 to debug performance issues
Date: Thu, 22 May 2014 03:33:25 +0200
Message-ID: <537D53E5.2070605@gmail.com>
References: <537BA806.50600@gmail.com> <537BA8D1.1090503@gmail.com> <537D2528.3090806@bbn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
To: Richard Hansen <rhansen@bbn.com>, Git List <git@vger.kernel.org>, 
 msysGit <msysgit@googlegroups.com>
X-From: msysgit+bncBCH3XYXLXQDBBZFH6WNQKGQEFGRK3FA@googlegroups.com Thu May 22 03:33:26 2014
Return-path: <msysgit+bncBCH3XYXLXQDBBZFH6WNQKGQEFGRK3FA@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-ee0-f57.google.com ([74.125.83.57])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCH3XYXLXQDBBZFH6WNQKGQEFGRK3FA@googlegroups.com>)
	id 1WnHsr-0000QF-R4
	for gcvm-msysgit@m.gmane.org; Thu, 22 May 2014 03:33:25 +0200
Received: by mail-ee0-f57.google.com with SMTP id e53sf286370eek.22
        for <gcvm-msysgit@m.gmane.org>; Wed, 21 May 2014 18:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type
         :content-transfer-encoding;
        bh=pU4ZF+ZDlAZnh5MQqyTC9J4+0u3Hi6Hf3VUWioGM86M=;
        b=HKTIIabQ5NDNIiuzyOJIuMxbxEyquoyk0xwJKaC8Jp9vLNRhPnYw8jMkH1wyTP/q4z
         zTjcuKY+nUd/IrCf0IjIzCfxblXROXlfUvRjnpsYiErY0qTwtqwBG7SOsl/JhgLPlO2Q
         H/C3ajtSF9SMlb8AUzlBARFd7V8gd/2vlGoCvOkZQAHaiUTm3CSklPr/ioY3ZiDcIAot
         CmVHyIzvZXUGlizapezNP1Ct9cQdS5JCcX6htYy/uA187VFHLOPxOfrStfpyTYlNKKUR
         yeeYzX5kDgUdpKNHJt0urHiImibiQXzm0czHlIHsyGlvsDf2/k6ZGznL25LZlgKm+eQs
         0YcQ==
X-Received: by 10.152.23.165 with SMTP id n5mr251336laf.5.1400722405537;
        Wed, 21 May 2014 18:33:25 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.4.67 with SMTP id i3ls184742lai.81.gmail; Wed, 21 May 2014
 18:33:24 -0700 (PDT)
X-Received: by 10.112.140.170 with SMTP id rh10mr4494059lbb.7.1400722404245;
        Wed, 21 May 2014 18:33:24 -0700 (PDT)
Received: from mail-ee0-x22c.google.com (mail-ee0-x22c.google.com [2a00:1450:4013:c00::22c])
        by gmr-mx.google.com with ESMTPS id r49si2463914eep.0.2014.05.21.18.33.24
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 21 May 2014 18:33:24 -0700 (PDT)
Received-SPF: pass (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:4013:c00::22c as permitted sender) client-ip=2a00:1450:4013:c00::22c;
Received: by mail-ee0-f44.google.com with SMTP id c41so2153289eek.3
        for <msysgit@googlegroups.com>; Wed, 21 May 2014 18:33:24 -0700 (PDT)
X-Received: by 10.14.215.5 with SMTP id d5mr8662781eep.62.1400722404142;
        Wed, 21 May 2014 18:33:24 -0700 (PDT)
Received: from [10.1.116.56] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id g8sm15906933eep.0.2014.05.21.18.33.22
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 21 May 2014 18:33:22 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
In-Reply-To: <537D2528.3090806@bbn.com>
X-Original-Sender: karsten.blees@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:4013:c00::22c
 as permitted sender) smtp.mail=karsten.blees@gmail.com;       dkim=pass
 header.i=@gmail.com;       dmarc=pass (p=NONE dis=NONE) header.from=gmail.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249867>

Am 22.05.2014 00:14, schrieb Richard Hansen:
> On 2014-05-20 15:11, Karsten Blees wrote:
>> Add a getnanotime() function that returns nanoseconds since 01/01/1970 a=
s
>> unsigned 64-bit integer (i.e. overflows in july 2554).
>=20
> Must it be relative to epoch?  If it was relative to system boot (like
> the NetBSD kernel's nanouptime() function), then you wouldn't have to
> worry about clock adjustments messing with performance stats and you
> might have more options for implementing getnanotime() on various platfor=
ms.
>=20
> -Richard
>=20

Normalizing to the epoch adds the ability to use the same timestamps (div 1=
0e9) in other time-related functions (e.g. gmtime, ctime etc.), with very l=
ittle overhead (one 64-bit integer addition per call).

The getnanotime() implementation is actually platform independent and can b=
e backed by any time source that returns nanoseconds relative to anything. =
Getnanotime() is synced to the system clock only once on startup, so if you=
r time source is monotonic (which I think NetBSD's nanouptime() is), you do=
n't have to worry about clock adjustments.

--=20
--=20
*** Please reply-to-all at all times ***
*** (do not pretend to know who is subscribed and who is not) ***
*** Please avoid top-posting. ***
The msysGit Wiki is here: https://github.com/msysgit/msysgit/wiki - Github =
accounts are free.

You received this message because you are subscribed to the Google
Groups "msysGit" group.
To post to this group, send email to msysgit@googlegroups.com
To unsubscribe from this group, send email to
msysgit+unsubscribe@googlegroups.com
For more options, and view previous threads, visit this group at
http://groups.google.com/group/msysgit?hl=3Den_US?hl=3Den

---=20
You received this message because you are subscribed to the Google Groups "=
msysGit" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
