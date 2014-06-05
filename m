From: Karsten Blees <karsten.blees@gmail.com>
Subject: Re: [PATCH v2] Add a Windows-specific fallback to getenv("HOME");
Date: Thu, 05 Jun 2014 23:44:22 +0200
Message-ID: <5390E4B6.60206@gmail.com>
References: <20140604114730.GB22250@camelia.ucw.cz> <CACsJy8BDk4gdRzjp_XpQXXMW1sEnS4DoedanFLONODuJXdeeRA@mail.gmail.com> <CABPQNSYXsu1muRTVUg6ybB9_MJP_wJi-4PmSec+8EwrvsCHMRw@mail.gmail.com> <alpine.DEB.1.00.1406041713500.14982@s15462909.onlinehome-server.info> <CABPQNSavYCrdUDyNru-HHMFkdgDRvaCp++f8ZgGKv07sS0eXGQ@mail.gmail.com> <alpine.DEB.1.00.1406041725460.14982@s15462909.onlinehome-server.info> <alpine.DEB.1.00.1406041741470.14982@s15462909.onlinehome-server.info> <538FCAF5.7030102@gmail.com> <20140605080317.GA28029@camelia.ucw.cz> <53903B22.70507@gmail.com> <CABPQNSYtxLyWkRGOyst7VOpw-_=rQvKF_VsbDB7Y0-K=d9rvkQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Cc: Stepan Kasal <kasal@ucw.cz>, 
 Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 Duy Nguyen <pclouds@gmail.com>, GIT Mailing-list <git@vger.kernel.org>, 
 Thomas Braun <thomas.braun@virtuell-zuhause.de>,
 msysGit <msysgit@googlegroups.com>
To: kusmabite@gmail.com
X-From: msysgit+bncBCH3XYXLXQDBBNOJYOOAKGQERYB6PDY@googlegroups.com Thu Jun 05 23:44:25 2014
Return-path: <msysgit+bncBCH3XYXLXQDBBNOJYOOAKGQERYB6PDY@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-lb0-f185.google.com ([209.85.217.185])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCH3XYXLXQDBBNOJYOOAKGQERYB6PDY@googlegroups.com>)
	id 1WsfSQ-0005DM-3P
	for gcvm-msysgit@m.gmane.org; Thu, 05 Jun 2014 23:44:22 +0200
Received: by mail-lb0-f185.google.com with SMTP id w7sf194105lbi.12
        for <gcvm-msysgit@m.gmane.org>; Thu, 05 Jun 2014 14:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type:content-transfer-encoding;
        bh=J8x5wD0to0eQJZmTgmoEQpOz4g2MrRIprRHDnCDf+DM=;
        b=rkadHCCmW7QD/Bm3bgDsQeLYKt3y4UsDP2FXnWwRdy9ePLie8gPD7Z9uJaWSDiK5b7
         Dz4qEufQIgIwZGTO7OzlDjvWF5At/kQmtypwgm48ukZ2SKVQmzfjwbvvNuk9DTii9w4J
         ej4YmX8uqQvGi902Yovzu1c4VEqQT2Hr1sHC3F+h3imGUpMt/E5lTLRQL4bqf0VHGkOC
         S/zkhEsw2dTt3iWshLkUxeQGbvbfNoWqWzgeyb2mvromBPSud1qYxVMSKiimXpIwNP7N
         /SyepqW8U6oQMLT9QobhjdSvMPeJjfoCtxxOcDuZCVYI5iC7G5Fj4ADSn1+OlW7rSmy0
         xF9g==
X-Received: by 10.152.26.129 with SMTP id l1mr5289lag.38.1402004661948;
        Thu, 05 Jun 2014 14:44:21 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.206.37 with SMTP id ll5ls67854lac.97.gmail; Thu, 05 Jun
 2014 14:44:20 -0700 (PDT)
X-Received: by 10.112.49.229 with SMTP id x5mr277592lbn.14.1402004660971;
        Thu, 05 Jun 2014 14:44:20 -0700 (PDT)
Received: from mail-we0-x229.google.com (mail-we0-x229.google.com [2a00:1450:400c:c03::229])
        by gmr-mx.google.com with ESMTPS id ck3si419775wib.0.2014.06.05.14.44.20
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 05 Jun 2014 14:44:20 -0700 (PDT)
Received-SPF: pass (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:400c:c03::229 as permitted sender) client-ip=2a00:1450:400c:c03::229;
Received: by mail-we0-f169.google.com with SMTP id q58so1689452wes.0
        for <msysgit@googlegroups.com>; Thu, 05 Jun 2014 14:44:20 -0700 (PDT)
X-Received: by 10.14.108.198 with SMTP id q46mr269087eeg.31.1402004660834;
        Thu, 05 Jun 2014 14:44:20 -0700 (PDT)
Received: from [10.1.116.52] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id i2sm17577447eem.11.2014.06.05.14.44.19
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 05 Jun 2014 14:44:19 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
In-Reply-To: <CABPQNSYtxLyWkRGOyst7VOpw-_=rQvKF_VsbDB7Y0-K=d9rvkQ@mail.gmail.com>
X-Original-Sender: karsten.blees@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:400c:c03::229
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250866>

Am 05.06.2014 11:58, schrieb Erik Faye-Lund:
> On Thu, Jun 5, 2014 at 11:40 AM, Karsten Blees <karsten.blees@gmail.com> =
wrote:
>> Am 05.06.2014 10:03, schrieb Stepan Kasal:
>>> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>>> Date: Wed, 2 Jun 2010 00:41:33 +0200
>>>
>>> If HOME is not set, use $HOMEDRIVE$HOMEPATH
>>>
>>> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>>> Signed-off-by: Stepan Kasal <kasal@ucw.cz>
>>> ---
>>>
>>> Hello Karsten,
>>> thanks for your explanation.  There are more things to be done, but
>>> I hope you can ack this patch as a step forward.
>>>
>>
>> No, not really. Its sure better than introducing a special get_home_dire=
ctory(), but it still increases the diff between upstream and msysgit rathe=
r than reducing it. The main critique points still remain:
>>
>>  * $HOME is usually set up correctly before calling git, so this is esse=
ntially dead code (just checked, portable git's git-bash.bat and git-cmd.ba=
t also do this correctly)
>=20
> What about when tools like TortoiseGit and Git Extensions call git?
> We're not guaranteed that they did the $HOME-dance, are we?
>=20

GitExtensions does the same thing, see issue 497. I don't know about Tortoi=
seGit, but I suspect the same.

>>  * even if $HOME was empty, git should setenv("HOME") so that child proc=
esses can benefit from it (similar to TMPDIR and TERM in current msysgit's =
mingw_startup()). Not setting $HOME because it may hypothetically break chi=
ld processes is a very weak argument, as we always did set $HOME in etc/pro=
file (since the initial version back in 2007).
>>
>>  * no fallback to $USERPROFILE doesn't work with diconnected home share
>>
>> If you really have time to spare, I suggest you focus on getting the Uni=
code patches upstream so that we can progress from there (e.g. move $HOME s=
etup to mingw_startup() so that we can get rid of redundant logic in etc/pr=
ofile, git-wrapper, git-bash.bat, git-cmd.bat etc.).
>=20
> Perhaps we can patch up the upstream to better match Git for Windows
> without upstreaming the Unicode patches? Don't get me wrong; I think
> upstreaming them is a good idea, but in case time is lacking...
>=20

The unicode patch series happens to be one of the first on top of upstream,=
 and its also the longest (~40 patches) and I believe most intrusive one (~=
1500 lines changed). So I think the most time-preserving option is to send =
it upstream as unchanged as possible (probably with the bugfix-patches squa=
shed). There's only ~50 lines changed outside of compat, so hopefully there=
 won't be too many additional review-rounds...

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
