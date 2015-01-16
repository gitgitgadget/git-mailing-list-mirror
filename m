From: Achim Gratz <Stromeko@nexgo.de>
Subject: Re: [PATCH] t/lib-httpd: switch SANITY check for NOT_ROOT
Date: Fri, 16 Jan 2015 21:04:57 +0100
Organization: Linux Private Site
Message-ID: <87fvbasd92.fsf@Rainer.invalid>
References: <54B6C897.5030405@web.de> <20150114211712.GE1155@peff.net>
	<064010B3-BC58-42F2-B5C0-DAADAA59B87D@gmail.com>
	<xmqqwq4n6b4c.fsf@gitster.dls.corp.google.com>
	<20150115222719.GA19021@peff.net>
	<xmqqa91j6537.fsf@gitster.dls.corp.google.com>
	<20150115235752.GB25120@peff.net>
	<xmqqh9vr4mlz.fsf@gitster.dls.corp.google.com>
	<20150116013256.GA25894@peff.net>
	<BEFF558C-774D-4891-96A0-BE962F8070E7@gmail.com>
	<20150116033445.GA29572@peff.net>
	<1CCD6775-7A2E-4AC4-813B-6027C0D67336@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: msysgit@googlegroups.com
X-From: msysgit+bncBDX63A6DS4FBBB664WSQKGQEY6WGQNA@googlegroups.com Fri Jan 16 21:05:29 2015
Return-path: <msysgit+bncBDX63A6DS4FBBB664WSQKGQEY6WGQNA@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wg0-f58.google.com ([74.125.82.58])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDX63A6DS4FBBB664WSQKGQEY6WGQNA@googlegroups.com>)
	id 1YCD96-0003sK-DQ
	for gcvm-msysgit@m.gmane.org; Fri, 16 Jan 2015 21:05:28 +0100
Received: by mail-wg0-f58.google.com with SMTP id y19sf30193wgg.3
        for <gcvm-msysgit@m.gmane.org>; Fri, 16 Jan 2015 12:05:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=to:from:subject:date:organization:lines:message-id:references
         :mime-version:content-type:user-agent:cancel-lock:cc
         :x-original-sender:x-original-authentication-results:precedence
         :mailing-list:list-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe;
        bh=4aBf6yUNs0mb6x6RP0jXJsjvF9FycnwOYVHon/qDMpA=;
        b=kyx9ZgAMhSvNlw6feoV5/I1Jhy3kPlz5/tDb15kVJ7vZyoeaG9yzlD1J5rZB+tlivO
         qotpLtEC8IjCphoXYkcPElY56rpRj+berieDpW73sG5CsxgZvph5KiqaiM8zt+EPVh1X
         20B28QK2yYk9ji0K/TJ+Tm3CqJ0Txr3rrCMg+BXFVe1tXIqLZWQswWIwiIq469Ypw59T
         zLVub7Aiwmz/opwAh/fiNIAiVHZ60nuPWqs2R8iBYRXNkH2MFvAEsgYQ2m7TWLxZqLlH
         gbzcrNndEJaP3Foo5aBX2YDIozMkeraO4ARMT0RKrgtpdOgHS++DTvUe60Kq5gGWqUkb
         Sb5w==
X-Received: by 10.152.7.175 with SMTP id k15mr23379laa.39.1421438727999;
        Fri, 16 Jan 2015 12:05:27 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.42.234 with SMTP id r10ls331811lal.17.gmail; Fri, 16 Jan
 2015 12:05:26 -0800 (PST)
X-Received: by 10.152.87.38 with SMTP id u6mr3355laz.3.1421438726494;
        Fri, 16 Jan 2015 12:05:26 -0800 (PST)
Received: from plane.gmane.org (plane.gmane.org. [80.91.229.3])
        by gmr-mx.google.com with ESMTPS id oi7si354770lbb.1.2015.01.16.12.05.26
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 16 Jan 2015 12:05:26 -0800 (PST)
Received-SPF: pass (google.com: domain of gcvm-msysgit@m.gmane.org designates 80.91.229.3 as permitted sender) client-ip=80.91.229.3;
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvm-msysgit@m.gmane.org>)
	id 1YCD8z-0003nV-VZ
	for msysgit@googlegroups.com; Fri, 16 Jan 2015 21:05:22 +0100
Received: from p54b46cbb.dip0.t-ipconnect.de ([84.180.108.187])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <msysgit@googlegroups.com>; Fri, 16 Jan 2015 21:05:21 +0100
Received: from Stromeko by p54b46cbb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <msysgit@googlegroups.com>; Fri, 16 Jan 2015 21:05:21 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: p54b46cbb.dip0.t-ipconnect.de
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.0.50 (gnu/linux)
Cancel-Lock: sha1:wKHPuyntO7y75HOsiUSb5llztYc=
X-Original-Sender: gcvm-msysgit@m.gmane.org
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of gcvm-msysgit@m.gmane.org designates 80.91.229.3 as
 permitted sender) smtp.mail=gcvm-msysgit@m.gmane.org
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262572>

Kyle J. McKay writes:
>>> "id -u" works for me in MSYS and cygwin (each appears to have it's
>>> own id.exe).
>>
>> That's comforting. MSYS was the one I was most worried about. What UID
>> do they report? I.e., do they correctly tell us if we are root (or
>> more accurately, if we are not root)?

Checking for UID 0 won't work on Cygwin in the general case.  That fools
literally dozens of Perl module tests that find out the user can
actually do something they think (s)he should be unable to.

> It's funny, really.  The MSYS version gives a different answer than
> the cygwin version although both are non-zero.  The MSYS perl gives
> the same answer as the MSYS id and the cygwin perl gives the same
> answer as the cygwin id.

That result changes depending on the content /etc/passwd (which arguably
is a either a bug or a feature depending on which way you look at it).
But Windows itself doesn't have the notion of a root user at all, so
looking for one isn't going to be helpful.

> I'm not even sure what it would mean to "be root" on one of those
> systems.

It means you have the capabilities that a root user would be expected to
have.  For most intents and purposes on Windows this would mean the user
running the command is in group 544 ("Administrators" in an english
version of Windows).

> The closest I can think of would be to run as the "SYSTEM" user.  And
> that's not nearly as simple as just "sudo -s". [1].

The SYSTEM user isn't a good approximation of root under UN*X for
reasonably modern Windows versions.

http://support.microsoft.com/kb/120929

For more discussion on the UID 0 topic from a Cygwin perspective, see

http://thread.gmane.org/gmane.os.cygwin.applications/28129
http://thread.gmane.org/gmane.os.cygwin.applications/28203


Regards,
Achim.
-- 
+<[Q+ Matrix-12 WAVE#46+305 Neuron microQkb Andromeda XTk Blofeld]>+

SD adaptation for Waldorf microQ V2.22R2:
http://Synth.Stromeko.net/Downloads.html#WaldorfSDada

-- 
-- 
*** Please reply-to-all at all times ***
*** (do not pretend to know who is subscribed and who is not) ***
*** Please avoid top-posting. ***
The msysGit Wiki is here: https://github.com/msysgit/msysgit/wiki - Github accounts are free.

You received this message because you are subscribed to the Google
Groups "msysGit" group.
To post to this group, send email to msysgit@googlegroups.com
To unsubscribe from this group, send email to
msysgit+unsubscribe@googlegroups.com
For more options, and view previous threads, visit this group at
http://groups.google.com/group/msysgit?hl=en_US?hl=en

--- 
You received this message because you are subscribed to the Google Groups "Git for Windows" group.
To unsubscribe from this group and stop receiving emails from it, send an email to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
