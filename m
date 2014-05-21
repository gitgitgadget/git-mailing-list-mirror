From: Karsten Blees <karsten.blees@gmail.com>
Subject: Re: [RFC/PATCH v4 1/3] add high resolution timer function
 to debug performance issues
Date: Wed, 21 May 2014 11:14:16 +0200
Message-ID: <537C6E68.8030104@gmail.com>
References: <537BA806.50600@gmail.com> <537BA8D1.1090503@gmail.com> <537C5634.3050807@peralex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
To: Noel Grandin <noel@peralex.com>, Git List <git@vger.kernel.org>, 
 msysGit <msysgit@googlegroups.com>
X-From: msysgit+bncBCH3XYXLXQDBB2O46GNQKGQECOPRFGY@googlegroups.com Wed May 21 11:14:18 2014
Return-path: <msysgit+bncBCH3XYXLXQDBB2O46GNQKGQECOPRFGY@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-lb0-f186.google.com ([209.85.217.186])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCH3XYXLXQDBB2O46GNQKGQECOPRFGY@googlegroups.com>)
	id 1Wn2bK-000692-Ea
	for gcvm-msysgit@m.gmane.org; Wed, 21 May 2014 11:14:18 +0200
Received: by mail-lb0-f186.google.com with SMTP id c11sf168562lbj.23
        for <gcvm-msysgit@m.gmane.org>; Wed, 21 May 2014 02:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type
         :content-transfer-encoding;
        bh=/ZxDbE0kkC9MiJ4jJf6S61UmaoWfNAApTvkt9A0FscY=;
        b=RPHgv11arOrFIV3Sv3+zRC8rhwx5sTtmdafdXij1aIAE4dsdd5CzZqFQRzvlJ1H8a/
         NpxwKbmIgqkJyoAOobpCAgC5/aF6SR5iSK1AoRZxwxfJzoBxOGoOP1h/+qMsvRMODaGW
         VChL+m/EE1QRTvS3PEjJz5BoHyoKx2FL5hUfEOZ//o3Ps/CYbarNogyxxi1OsMSvYiVn
         0TU0d0pAjCE06iR0gQiuLc061KzoKlmWhumreGssOMWUmqM4R935lHS8880HbbYOFtzS
         RvysD0bCMIh4BXAEtz/3t2IBZoNkFXOy0rfRT/XVBO7Kt33Qn0UmV1dHmSTSEgFTqSTa
         8Z3Q==
X-Received: by 10.152.203.193 with SMTP id ks1mr5333lac.29.1400663658165;
        Wed, 21 May 2014 02:14:18 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.43.226 with SMTP id z2ls108625lal.28.gmail; Wed, 21 May
 2014 02:14:17 -0700 (PDT)
X-Received: by 10.152.43.3 with SMTP id s3mr2744702lal.5.1400663657104;
        Wed, 21 May 2014 02:14:17 -0700 (PDT)
Received: from mail-ee0-x22d.google.com (mail-ee0-x22d.google.com [2a00:1450:4013:c00::22d])
        by gmr-mx.google.com with ESMTPS id r49si1653628eep.0.2014.05.21.02.14.17
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 21 May 2014 02:14:17 -0700 (PDT)
Received-SPF: pass (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:4013:c00::22d as permitted sender) client-ip=2a00:1450:4013:c00::22d;
Received: by mail-ee0-f45.google.com with SMTP id d49so1362245eek.32
        for <msysgit@googlegroups.com>; Wed, 21 May 2014 02:14:17 -0700 (PDT)
X-Received: by 10.14.246.68 with SMTP id p44mr35711888eer.8.1400663657003;
        Wed, 21 May 2014 02:14:17 -0700 (PDT)
Received: from [10.1.116.56] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id x45sm10351983eeu.23.2014.05.21.02.14.15
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 21 May 2014 02:14:16 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
In-Reply-To: <537C5634.3050807@peralex.com>
X-Original-Sender: karsten.blees@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:4013:c00::22d
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249777>

Am 21.05.2014 09:31, schrieb Noel Grandin:
> On 2014-05-20 21:11, Karsten Blees wrote:
>>   * implement Mac OSX version using mach_absolute_time
>>
>>
>=20
>=20
> Note that unlike the Windows and Linux APIs, mach_absolute_time does not =
do correction for frequency-scaling

I don't have a MAC so I can't test any of this, but supposedly mach_timebas=
e_info() returns the frequency of mach_absolute_time(), so you could do sim=
ilar frequency-scaling as I do for Windows with QueryPerformanceFrequency()=
.

> and cross-CPU synchronization with the TSC.
>=20

The TSC is synchronized across cores and sockets on modern x86 hardware [1]=
 (at least since Intel Nehalem, i.e. all Core i[357] processors). On older =
machines, I would expect the OS API to choose a more appropriate time sourc=
e, e.g. the HPET. I'm not proposing to use asm("rdtsc") or anything like th=
at...

[1] https://software.intel.com/en-us/articles/best-timing-function-for-meas=
uring-ipp-api-timing

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
