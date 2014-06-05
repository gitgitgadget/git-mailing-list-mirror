From: Michael Geddes <michael@frog.wheelycreek.net>
Subject: Re: Re: [PATCH v2] t5000, t5003: do not use test_cmp to
 compare binary files
Date: Thu, 05 Jun 2014 10:01:50 +0800
Message-ID: <5268585.VtKVR75oeq@majorie>
References: <20140604114252.GA22250@camelia.ucw.cz> <20140604155752.GA23226@camelia.ucw.cz> <xmqq8upcv8jj.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, Stepan Kasal <kasal@ucw.cz>, GIT Mailing-list <git@vger.kernel.org>, Thomas Braun <thomas.braun@virtuell-zuhause.de>
To: msysgit@googlegroups.com
X-From: msysgit+bncBCLZXZ4RRAEBBGM7X6OAKGQEP4MN2BQ@googlegroups.com Thu Jun 05 04:02:05 2014
Return-path: <msysgit+bncBCLZXZ4RRAEBBGM7X6OAKGQEP4MN2BQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-qa0-f64.google.com ([209.85.216.64])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCLZXZ4RRAEBBGM7X6OAKGQEP4MN2BQ@googlegroups.com>)
	id 1WsN0E-0000qK-KD
	for gcvm-msysgit@m.gmane.org; Thu, 05 Jun 2014 04:02:02 +0200
Received: by mail-qa0-f64.google.com with SMTP id i13sf65825qae.29
        for <gcvm-msysgit@m.gmane.org>; Wed, 04 Jun 2014 19:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=from:to:cc:subject:date:message-id:user-agent:in-reply-to
         :references:mime-version:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=NA2Y0iuMj7tAJNrzmquYmEw3Nyk3lGAaqSW8fPWX2tQ=;
        b=W6BJyE8O0UGsI0adRKSBc1Unc8QLCyaj0BMPR/5WD3ENLQC7c5+STCKAturH0tzeOk
         tp3Gycr8YKL5j2xMRubQemXRtGUiuDkIwQfSG14iEy27jY3PGhebOFDbicCaolZ2QXX/
         Ql0Vg9cABkloT9X9kzlE6GlInqDfawcpd/XmYqu92PbeAqS/soch/RbuKE4zpQuGG4Py
         pvFw2RMrhFdNU1AZGmHbp9r4V9AT+1ZHfVaPFJvJ81rp/tF4orCQXLLd8Mub06jGS5lT
         5jQiGWyEk+hGgnF9Mv0Sv3xVrJ7EY3NrYhTT13yIxhqsW9pjtj5o8vwOY0XxedKM0TuF
         08Eg==
X-Received: by 10.182.125.67 with SMTP id mo3mr73483obb.26.1401933721828;
        Wed, 04 Jun 2014 19:02:01 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.182.33.39 with SMTP id o7ls1298208obi.31.gmail; Wed, 04 Jun
 2014 19:02:00 -0700 (PDT)
X-Received: by 10.182.191.73 with SMTP id gw9mr12401098obc.50.1401933720902;
        Wed, 04 Jun 2014 19:02:00 -0700 (PDT)
Received: from smtpauth.rollernet.us (smtpauth.rollernet.us. [2607:fe70:0:3::d])
        by gmr-mx.google.com with ESMTPS id zs4si595931pbc.1.2014.06.04.19.02.00
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 04 Jun 2014 19:02:00 -0700 (PDT)
Received-SPF: pass (google.com: domain of michael@frog.wheelycreek.net designates 2607:fe70:0:3::d as permitted sender) client-ip=2607:fe70:0:3::d;
Received: from smtpauth.rollernet.us (localhost [127.0.0.1])
	by smtpauth.rollernet.us (Postfix) with ESMTP id 0065D594038
	for <msysgit@googlegroups.com>; Wed,  4 Jun 2014 19:01:57 -0700 (PDT)
Received: from wheelycreek.net (unknown [203.59.141.93])
	by smtpauth.rollernet.us (Postfix) with ESMTPA
	for <msysgit@googlegroups.com>; Wed,  4 Jun 2014 19:01:56 -0700 (PDT)
Received: from majorie.localnet ([192.168.22.205]:40578)
	by wheelycreek.net with [XMail 1.26 ESMTP Server]
	id <S34AC> for <msysgit@googlegroups.com> from <michael@frog.wheelycreek.net>;
	Thu, 5 Jun 2014 02:01:52 -0000
User-Agent: KMail/4.13 (Linux/3.13.0-24-lowlatency; KDE/4.13.0; x86_64; ; )
In-Reply-To: <xmqq8upcv8jj.fsf@gitster.dls.corp.google.com>
X-Rollernet-Abuse: Processed by Roller Network Mail Services. Contact abuse@rollernet.us to report violations. Abuse policy: http://www.rollernet.us/policy
X-Rollernet-Submit: Submit ID 76f0.538fcf94.21c10.0
X-Original-Sender: michael@frog.wheelycreek.net
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of michael@frog.wheelycreek.net designates
 2607:fe70:0:3::d as permitted sender) smtp.mail=michael@frog.wheelycreek.net
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250802>

I have the problem that the overridden test_cmp crashes on a couple of places 
where it is doing a binary compare, so this is definitely needed.

I actually used cmp -q   in my override as it's the return code that is most 
important.

//.

On Wed, 4 Jun 2014 11:22:56 AM Junio C Hamano wrote:
> Stepan Kasal <kasal@ucw.cz> writes:
> > test_cmp() is primarily meant to compare text files (and display the
> > difference for debug purposes).
> > 
> > Raw "cmp" is better suited to compare binary files (tar, zip, etc.).
> > 
> > On MinGW, test_cmp is a shell function mingw_test_cmp that tries to
> > read both files into environment, stripping CR characters (introduced
> > in commit 4d715ac0).
> > 
> > This function usually speeds things up, as fork is extremly slow on
> > Windows.  But no wonder that this function is extremely slow and
> > sometimes even crashes when comparing large tar or zip files.
> > 
> > Signed-off-by: Stepan Kasal <kasal@ucw.cz>
> > ---
> > 
> > Hi Thomas,
> > 
> > On Wed, Jun 04, 2014 at 02:59:44PM +0200, Thomas Braun wrote:
> >> Using test_cmp_bin instead of cmp would result in then four assertions
> >> for comparing arbitrary data
> >> test_cmp
> >> test_i18ncmp
> >> test_cmp_text
> >> test_cmp_bin
> >> where I think the purpose of each function is clear from its name.
> > 
> > [test_cmp_text does not exist (yet)]
> > 
> > OK, I agree, hence this modified version of the patch.
> 
> Yeah, I think the above reasoning is sound.  And I do not think we
> ever need to have test_cmp_text -- our payload and our messages
> compared by tests to make sure our expectations hold are text by
> default.
> 
> Will queue; thanks.

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
You received this message because you are subscribed to the Google Groups "msysGit" group.
To unsubscribe from this group and stop receiving emails from it, send an email to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
