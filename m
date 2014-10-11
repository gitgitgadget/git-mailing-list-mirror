From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 07/14] Fix BASIC_LDFLAGS and COMPAT_CFLAGS for
 64bit MinGW-w64
Date: Sat, 11 Oct 2014 11:11:42 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.1410111045100.990@s15462909.onlinehome-server.info>
References: <1412791267-13356-1-git-send-email-marat@slonopotamus.org> <1412791267-13356-8-git-send-email-marat@slonopotamus.org> <alpine.DEB.1.00.1410092115100.990@s15462909.onlinehome-server.info> <CAOYw7dsNQZNYZRz1c7RM0+CuOtzTXMH-2zWJR5MbM_kH9eZ1Eg@mail.gmail.com>
 <alpine.DEB.1.00.1410092146310.990@s15462909.onlinehome-server.info> <CAOYw7dtouon0EXYQPnvpc7ZMARKwaureNTK6ZL+aByknpPG-9A@mail.gmail.com> <alpine.DEB.1.00.1410100809450.990@s15462909.onlinehome-server.info>
 <CAOYw7dtSdR8GVYK2YrVjgQ7ZRExHjPBLCNQk7vchV66fx27xBw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Cc: git@vger.kernel.org, msysgit@googlegroups.com, 
    git-for-windows@googlegroups.com
To: Ray Donnelly <mingw.android@gmail.com>
X-From: msysgit+bncBCZPH74Q5YNRBUHI4OQQKGQEWXI3IMQ@googlegroups.com Sat Oct 11 11:11:47 2014
Return-path: <msysgit+bncBCZPH74Q5YNRBUHI4OQQKGQEWXI3IMQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-ee0-f64.google.com ([74.125.83.64])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCZPH74Q5YNRBUHI4OQQKGQEWXI3IMQ@googlegroups.com>)
	id 1XcsiI-0002H0-PE
	for gcvm-msysgit@m.gmane.org; Sat, 11 Oct 2014 11:11:46 +0200
Received: by mail-ee0-f64.google.com with SMTP id d49sf474171eek.19
        for <gcvm-msysgit@m.gmane.org>; Sat, 11 Oct 2014 02:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type:content-transfer-encoding;
        bh=/cUCkSbWKCOaq37VMl7v10ZmQfSnFHoorxRDPF3C1MQ=;
        b=o/7QZcaowb2Tru70gJHgg8TzIM9wPtRWrTLgHfZLXoLRjvs/ggSMap274o4k/nvqZt
         ytn1/QyB8NW+YKt80XsiKXZgjktCKO7p/Hv6pVqaY+Q+MoemJSDXn/XYw/Ngao5N4KKk
         tV5yzvqglKNJPM+njtQ5WAq5/DvK+q0I/ALsONu2p5ewrbqYhBjNowjHzwzuTUSyXlHM
         4jKdkH15MzIMvPPWWCPcpOhZA0YHjg/B1tUaOiexxetm0OS6H6LVo8YUcrqQq4kK3+kl
         j+dFq7uDTCEtp25Ncj2a1wEtNIdsAkRECMdLRa5ZQS8POxFmpPROnhJt1AnhHSyaRnoq
         +d0g==
X-Received: by 10.153.11.171 with SMTP id ej11mr369lad.18.1413018706332;
        Sat, 11 Oct 2014 02:11:46 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.234.233 with SMTP id uh9ls357139lac.70.gmail; Sat, 11 Oct
 2014 02:11:44 -0700 (PDT)
X-Received: by 10.152.42.229 with SMTP id r5mr164197lal.8.1413018704065;
        Sat, 11 Oct 2014 02:11:44 -0700 (PDT)
Received: from mout.gmx.net (mout.gmx.net. [212.227.15.18])
        by gmr-mx.google.com with ESMTPS id us10si37930lbc.1.2014.10.11.02.11.43
        for <msysgit@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 11 Oct 2014 02:11:44 -0700 (PDT)
Received-SPF: pass (google.com: domain of Johannes.Schindelin@gmx.de designates 212.227.15.18 as permitted sender) client-ip=212.227.15.18;
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx003) with ESMTPSA (Nemesis) id 0LZynd-1Y2Hyc042X-00ljuO;
 Sat, 11 Oct 2014 11:11:43 +0200
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <CAOYw7dtSdR8GVYK2YrVjgQ7ZRExHjPBLCNQk7vchV66fx27xBw@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:ae03bxZiWwzqF2gQ6lvj+eYLBq35PAC3QmpLlkBlMTi9k7xadOl
 IZCBsAVdnGSRy8WcmAu4nY2t9fTNezLY2tbmL52OfIQRBy7yQQ5I966r0mES4PnW0L7agn5
 oLvBDNN/NKl1+xPqbQxxQOJ99XOMMFH7vFd0sSkobKawi+Jn2VDOaXW9gyNqiY8YD8ZDwht
 cAzJdFi3y1QH2tUAAmiGA==
X-UI-Out-Filterresults: notjunk:1;
X-Original-Sender: johannes.schindelin@gmx.de
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of Johannes.Schindelin@gmx.de designates 212.227.15.18 as
 permitted sender) smtp.mail=Johannes.Schindelin@gmx.de
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/msysgit/subscribe>

Hi Ray,

On Fri, 10 Oct 2014, Ray Donnelly wrote:

> what's the difference between https://github.com/msysgit/git and
> https://github.com/git-for-windows/git ? I noticed that your fork is
> forked from msysgit, not git-for-windows?

I am glad you asked!

Git for Windows was developed using the development environment called
"msysGit" ever since 2007. Unfortunately the name caused a *real* lot of
confusion, not only because some people wondered what the heck MSys is,
but those who did not wonder mistook it for a *different* version of Git
for Windows.

Apart from the name, msysGit also has the shortcoming of abusing Git to
deploy binaries. In other words, msysGit itself is a Git-managed project
that delivers the complete development environment. Upgrading individual
components is unnecessarily hard, but msysGit's way was necessary because
there was no nice package manager for MinGW/MSys yet.

Things have changed in the meantime, and pushed forward by Thomas Braun
and Sebastian Schuberth, we now have a light-weight Git for Windows SDK =E2=
=80=93
which is essentially a standard MinGW/MSys system managed through the
package manager mingw-get. The only two add-ons we have is a nicer
installer (that Sebastian offered to MinGW but they declined) and the
addition of our own mingw-get'able packages (such as openssl, libpcre, and
git itself).

Needless to say, I am a big fan of that new strategy. This is why we
decided to just phase out the name "msysGit" (as well as the GitHub org of
the same name) and work on Git for Windows (with the corresponding GitHub
org, and using the name "Git for Windows" for the installer aimed at
"end-users" and "Git for Windows SDK" for the development environment
targeting Git for Windows developers).

I also added this writeup to the FAQ on the msysGit wiki:
https://github.com/msysgit/msysgit/wiki/Relationship-to-Git-for-Windows

Ciao,
Johannes

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
Git for Windows" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
