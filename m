From: Karsten Blees <karsten.blees@gmail.com>
Subject: Re: [PATCH v2] Add a Windows-specific fallback to getenv("HOME");
Date: Thu, 05 Jun 2014 22:03:42 +0200
Message-ID: <5390CD1E.5080500@gmail.com>
References: <20140604114730.GB22250@camelia.ucw.cz> <CACsJy8BDk4gdRzjp_XpQXXMW1sEnS4DoedanFLONODuJXdeeRA@mail.gmail.com> <CABPQNSYXsu1muRTVUg6ybB9_MJP_wJi-4PmSec+8EwrvsCHMRw@mail.gmail.com> <alpine.DEB.1.00.1406041713500.14982@s15462909.onlinehome-server.info> <CABPQNSavYCrdUDyNru-HHMFkdgDRvaCp++f8ZgGKv07sS0eXGQ@mail.gmail.com> <alpine.DEB.1.00.1406041725460.14982@s15462909.onlinehome-server.info> <alpine.DEB.1.00.1406041741470.14982@s15462909.onlinehome-server.info> <538FCAF5.7030102@gmail.com> <20140605080317.GA28029@camelia.ucw.cz> <53903B22.70507@gmail.com> <alpine.DEB.1.00.1406051411580.14982@s15462909.onlinehome-server.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Cc: Stepan Kasal <kasal@ucw.cz>, Erik Faye-Lund <kusmabite@gmail.com>, 
 Duy Nguyen <pclouds@gmail.com>,
 GIT Mailing-list <git@vger.kernel.org>, 
 Thomas Braun <thomas.braun@virtuell-zuhause.de>,
 msysGit <msysgit@googlegroups.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: msysgit+bncBCH3XYXLXQDBBHM2YOOAKGQE2D5YVJY@googlegroups.com Thu Jun 05 22:03:42 2014
Return-path: <msysgit+bncBCH3XYXLXQDBBHM2YOOAKGQE2D5YVJY@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wg0-f61.google.com ([74.125.82.61])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCH3XYXLXQDBBHM2YOOAKGQE2D5YVJY@googlegroups.com>)
	id 1Wsdt0-0003nh-Gl
	for gcvm-msysgit@m.gmane.org; Thu, 05 Jun 2014 22:03:42 +0200
Received: by mail-wg0-f61.google.com with SMTP id m15sf178513wgh.6
        for <gcvm-msysgit@m.gmane.org>; Thu, 05 Jun 2014 13:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type:content-transfer-encoding;
        bh=4edIX5gs73RNCWC/gPDpN8w+vdBDd3MKqv59xATPhkM=;
        b=NV1SKWebALtcZ7k8U1x5Aq3tXNsRUGZtW9EhBm5w7CK2Eu8bZ3N2Codm0j1/zbEHzY
         /BYyvWOG0qATGJ7iemUT1Sgcs4xFzMbAz5eCE6zRU066ip94PVg6UuW9+wNL/XdTEHE9
         ysXTONnlbKsJJxIa8s2ZP5iILyeum74cOIQCWP/vJrsT6qxfp5LO+eCQWlZAsuyvelCJ
         BqE+WB9clhTaLYhO2glSGK5HuOj8SEyr6GvYLFLTQ8PmF0mu0VzbIRE9kGF74C8inb7y
         lG9f67DEPKLNGvVseDuMBjCpIB+PkYaTJbFBOCnVrIFJfgICyJMEaLGR/P57iXca3l0j
         10+w==
X-Received: by 10.152.120.37 with SMTP id kz5mr37564lab.30.1401998622256;
        Thu, 05 Jun 2014 13:03:42 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.44.165 with SMTP id f5ls71020lam.39.gmail; Thu, 05 Jun
 2014 13:03:41 -0700 (PDT)
X-Received: by 10.112.54.169 with SMTP id k9mr7251637lbp.1.1401998621325;
        Thu, 05 Jun 2014 13:03:41 -0700 (PDT)
Received: from mail-we0-x234.google.com (mail-we0-x234.google.com [2a00:1450:400c:c03::234])
        by gmr-mx.google.com with ESMTPS id h4si1697866wib.2.2014.06.05.13.03.41
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 05 Jun 2014 13:03:41 -0700 (PDT)
Received-SPF: pass (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:400c:c03::234 as permitted sender) client-ip=2a00:1450:400c:c03::234;
Received: by mail-we0-f180.google.com with SMTP id q58so1730772wes.39
        for <msysgit@googlegroups.com>; Thu, 05 Jun 2014 13:03:41 -0700 (PDT)
X-Received: by 10.15.111.195 with SMTP id cj43mr240502eeb.17.1401998621186;
        Thu, 05 Jun 2014 13:03:41 -0700 (PDT)
Received: from [10.1.116.52] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id b12sm16995052eeh.45.2014.06.05.13.03.39
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 05 Jun 2014 13:03:40 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
In-Reply-To: <alpine.DEB.1.00.1406051411580.14982@s15462909.onlinehome-server.info>
X-Original-Sender: karsten.blees@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:400c:c03::234
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250861>

Am 05.06.2014 15:39, schrieb Johannes Schindelin:
> And in particular with your changes to Unicodify the complete environment=
,
> I am *highly* doubtful that child processes will be able to handle
> themselves properly, unless we spend a whole lot of time converting back
> and forth the environment when calling children.

The unicode version _does_ convert back and forth, in mingw_startup and mak=
e_environment_block, respectively. However, as the unicode environment is s=
orted, this is actually much faster than the original version.

To put things in perspective *:

entire mingw_startup: ~450 =B5s
 * _wgetmainargs: 25 =B5s
 * allocate+convert args and environment: 25 =B5s
 * qsort environment: 15 =B5s
 * winansi_init: 393 =B5s

entire mingw_spawnve_fd: ~1250 =B5s
 * make_environment_block: 25 =B5s
 * CreateProcessW: 690 =B5s

Now, the unicode mingw_getenv is O(log n) (~0.15 =B5s per call) and MSVCRT'=
s getenv is O(n) (~3.6 =B5s per call).

A git command that just launches a script (e.g. git gui) calls getenv ~25 t=
imes. (3.6 =B5s - 0.15 =B5s) * 25 =3D 86 =B5s, i.e. this compensates the ad=
ditional startup time (including qsort) more than twice.

(*) Measurements done via QueryPerformanceCounter, with 75 environment entr=
ies, on a Core i7 960, Windows 7 x64

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
