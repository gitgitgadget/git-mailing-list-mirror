From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH v2] Add a Windows-specific fallback to getenv("HOME");
Date: Thu, 5 Jun 2014 11:58:33 +0200
Message-ID: <CABPQNSYtxLyWkRGOyst7VOpw-_=rQvKF_VsbDB7Y0-K=d9rvkQ@mail.gmail.com>
References: <20140604114730.GB22250@camelia.ucw.cz> <CACsJy8BDk4gdRzjp_XpQXXMW1sEnS4DoedanFLONODuJXdeeRA@mail.gmail.com>
 <CABPQNSYXsu1muRTVUg6ybB9_MJP_wJi-4PmSec+8EwrvsCHMRw@mail.gmail.com>
 <alpine.DEB.1.00.1406041713500.14982@s15462909.onlinehome-server.info>
 <CABPQNSavYCrdUDyNru-HHMFkdgDRvaCp++f8ZgGKv07sS0eXGQ@mail.gmail.com>
 <alpine.DEB.1.00.1406041725460.14982@s15462909.onlinehome-server.info>
 <alpine.DEB.1.00.1406041741470.14982@s15462909.onlinehome-server.info>
 <538FCAF5.7030102@gmail.com> <20140605080317.GA28029@camelia.ucw.cz> <53903B22.70507@gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Cc: Stepan Kasal <kasal@ucw.cz>, Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
	Duy Nguyen <pclouds@gmail.com>, GIT Mailing-list <git@vger.kernel.org>, 
	Thomas Braun <thomas.braun@virtuell-zuhause.de>, msysGit <msysgit@googlegroups.com>
To: Karsten Blees <karsten.blees@gmail.com>
X-From: msysgit+bncBDR53PPJ7YHRB4P6YCOAKGQECB3CZ7I@googlegroups.com Thu Jun 05 11:59:15 2014
Return-path: <msysgit+bncBDR53PPJ7YHRB4P6YCOAKGQECB3CZ7I@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-yk0-f192.google.com ([209.85.160.192])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDR53PPJ7YHRB4P6YCOAKGQECB3CZ7I@googlegroups.com>)
	id 1WsUS3-0000ew-2J
	for gcvm-msysgit@m.gmane.org; Thu, 05 Jun 2014 11:59:15 +0200
Received: by mail-yk0-f192.google.com with SMTP id 20sf67665yks.19
        for <gcvm-msysgit@m.gmane.org>; Thu, 05 Jun 2014 02:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type
         :content-transfer-encoding;
        bh=SumJtyv2s5P6p+zOMJt6EUKHP8VHfddA1avy/8qezbE=;
        b=LdAjwlotQSMpUsbFkLNanZhzWOnLBij5Ti366hF6iidKIc5nhM4O80u/wFXA3KSQVd
         sUR0DNen7pD4VYRKoHTaCTwt1HAYJIF3zbqRVV6PcF/CUTlwTlHQJTJNFPm4K4bXf1Vs
         NDmAei6p2xhBhqyo+aU3glK4E1zwKCbGTp6/ud740OEhhpvZeiXbaqzzkUlgRoAA2Pe7
         S3FOVmk0+NfktP/eBjnhTPUH+0Eh4L2OrXiVhLI7TAi1d69Fd7nTkSveoBKHb1ccKBs1
         9T7tZBVK1pKC1WZswwW5Vgc/oZAxDFa3/U1I1EBUQS/ZYcIfL7tD5KqThoKa6SzX9Fo1
         Wlkg==
X-Received: by 10.140.92.227 with SMTP id b90mr1631qge.25.1401962354126;
        Thu, 05 Jun 2014 02:59:14 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.140.51.132 with SMTP id u4ls72413qga.36.gmail; Thu, 05 Jun
 2014 02:59:13 -0700 (PDT)
X-Received: by 10.236.228.98 with SMTP id e92mr12337151yhq.58.1401962353589;
        Thu, 05 Jun 2014 02:59:13 -0700 (PDT)
Received: from mail-ie0-x22d.google.com (mail-ie0-x22d.google.com [2607:f8b0:4001:c03::22d])
        by gmr-mx.google.com with ESMTPS id fp3si1906357igd.1.2014.06.05.02.59.13
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 05 Jun 2014 02:59:13 -0700 (PDT)
Received-SPF: pass (google.com: domain of kusmabite@gmail.com designates 2607:f8b0:4001:c03::22d as permitted sender) client-ip=2607:f8b0:4001:c03::22d;
Received: by mail-ie0-f173.google.com with SMTP id lx4so673874iec.32
        for <msysgit@googlegroups.com>; Thu, 05 Jun 2014 02:59:13 -0700 (PDT)
X-Received: by 10.50.50.231 with SMTP id f7mr17902750igo.42.1401962353452;
 Thu, 05 Jun 2014 02:59:13 -0700 (PDT)
Received: by 10.64.227.43 with HTTP; Thu, 5 Jun 2014 02:58:33 -0700 (PDT)
In-Reply-To: <53903B22.70507@gmail.com>
X-Original-Sender: kusmabite@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of kusmabite@gmail.com designates 2607:f8b0:4001:c03::22d
 as permitted sender) smtp.mail=kusmabite@gmail.com;       dkim=pass
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250828>

On Thu, Jun 5, 2014 at 11:40 AM, Karsten Blees <karsten.blees@gmail.com> wr=
ote:
> Am 05.06.2014 10:03, schrieb Stepan Kasal:
>> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>> Date: Wed, 2 Jun 2010 00:41:33 +0200
>>
>> If HOME is not set, use $HOMEDRIVE$HOMEPATH
>>
>> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>> Signed-off-by: Stepan Kasal <kasal@ucw.cz>
>> ---
>>
>> Hello Karsten,
>> thanks for your explanation.  There are more things to be done, but
>> I hope you can ack this patch as a step forward.
>>
>
> No, not really. Its sure better than introducing a special get_home_direc=
tory(), but it still increases the diff between upstream and msysgit rather=
 than reducing it. The main critique points still remain:
>
>  * $HOME is usually set up correctly before calling git, so this is essen=
tially dead code (just checked, portable git's git-bash.bat and git-cmd.bat=
 also do this correctly)

What about when tools like TortoiseGit and Git Extensions call git?
We're not guaranteed that they did the $HOME-dance, are we?

>  * even if $HOME was empty, git should setenv("HOME") so that child proce=
sses can benefit from it (similar to TMPDIR and TERM in current msysgit's m=
ingw_startup()). Not setting $HOME because it may hypothetically break chil=
d processes is a very weak argument, as we always did set $HOME in etc/prof=
ile (since the initial version back in 2007).
>
>  * no fallback to $USERPROFILE doesn't work with diconnected home share
>
> If you really have time to spare, I suggest you focus on getting the Unic=
ode patches upstream so that we can progress from there (e.g. move $HOME se=
tup to mingw_startup() so that we can get rid of redundant logic in etc/pro=
file, git-wrapper, git-bash.bat, git-cmd.bat etc.).

Perhaps we can patch up the upstream to better match Git for Windows
without upstreaming the Unicode patches? Don't get me wrong; I think
upstreaming them is a good idea, but in case time is lacking...

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
