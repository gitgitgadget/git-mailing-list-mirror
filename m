From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] compat/mingw: stubs for getpgid() and tcgetpgrp()
Date: Thu, 16 Apr 2015 08:00:22 -0700
Message-ID: <xmqq1tjkjeyh.fsf@gitster.dls.corp.google.com>
References: <20150413134850.GC23475@mewburn.net>
	<alpine.LFD.2.11.1504130954420.5619@knanqh.ubzr>
	<20150413144039.GD23475@mewburn.net>
	<alpine.LFD.2.11.1504131052090.5619@knanqh.ubzr>
	<20150414110312.GE23475@mewburn.net> <552EAE0A.3040208@kdbg.org>
	<xmqq3841kz32.fsf@gitster.dls.corp.google.com>
	<02c7702c204914ddded4014f292a90bf@www.dscho.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes Sixt <j6t@kdbg.org>,  Luke Mewburn <luke@mewburn.net>,  Nicolas Pitre <nico@fluxnic.net>,  git@vger.kernel.org,  msysGit <msysgit@googlegroups.com>,  git-owner@vger.kernel.org
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: msysgit+bncBCG77UMM3EJRBC45X6UQKGQE2QJJDLY@googlegroups.com Thu Apr 16 17:00:36 2015
Return-path: <msysgit+bncBCG77UMM3EJRBC45X6UQKGQE2QJJDLY@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-la0-f62.google.com ([209.85.215.62])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCG77UMM3EJRBC45X6UQKGQE2QJJDLY@googlegroups.com>)
	id 1YilHJ-0004MR-1k
	for gcvm-msysgit@m.gmane.org; Thu, 16 Apr 2015 17:00:29 +0200
Received: by lamq1 with SMTP id q1sf25413357lam.1
        for <gcvm-msysgit@m.gmane.org>; Thu, 16 Apr 2015 08:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe;
        bh=LB7KyHzcjwCO+BPpPlQ2YMPWkFKjzUybhKebkS8DClM=;
        b=XTz/G77Xd6b5Mg1QzVTmfb3k8T8ZaQbbGIcLVVXCwBsO6MkGFFscCATjKYdGbSIDDu
         L/SoUpOgXZxYq/dQM4H833OnE+c2xVlNwNbFniRhPvwoxry6maqzupHswG4ynqsOCypw
         1sZtt9/jqo8WDXZ12HxZ6UAm8Jh7mODmkkCTP8ObRDock1SgJ+hZ6Qn7O1/BiwX/5Nt2
         CAR1lnQFzJVMIN5Y5HEQGxcmAQViUjQNodzfFkvXGsIgd2Q1Jj4KQzHuVI7UNJHx//gf
         SDKNdiMQbvJbJUm3HFZBMkWtZFC/mE6rvbGzPJat3xuxS1QreHbiK7cKiafT6HUgbHGJ
         OkTg==
X-Received: by 10.152.22.130 with SMTP id d2mr388403laf.7.1429196428715;
        Thu, 16 Apr 2015 08:00:28 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.27.103 with SMTP id s7ls288570lag.105.gmail; Thu, 16 Apr
 2015 08:00:27 -0700 (PDT)
X-Received: by 10.112.130.71 with SMTP id oc7mr7567175lbb.23.1429196427168;
        Thu, 16 Apr 2015 08:00:27 -0700 (PDT)
Received: from sasl.smtp.pobox.com (pb-smtp1.int.icgroup.com. [208.72.237.35])
        by gmr-mx.google.com with ESMTP id su3si688253lbb.1.2015.04.16.08.00.26
        for <msysgit@googlegroups.com>;
        Thu, 16 Apr 2015 08:00:26 -0700 (PDT)
Received-SPF: pass (google.com: domain of junio@pobox.com designates 208.72.237.35 as permitted sender) client-ip=208.72.237.35;
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D84FF474C2;
	Thu, 16 Apr 2015 11:00:25 -0400 (EDT)
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id BAD66474C0;
	Thu, 16 Apr 2015 11:00:25 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 21FB0474BE;
	Thu, 16 Apr 2015 11:00:24 -0400 (EDT)
In-Reply-To: <02c7702c204914ddded4014f292a90bf@www.dscho.org> (Johannes
	Schindelin's message of "Thu, 16 Apr 2015 14:48:54 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 4F4D4938-E449-11E4-854E-11859F42C9D4-77302942!pb-smtp1.pobox.com
X-Original-Sender: gitster@pobox.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of junio@pobox.com designates 208.72.237.35 as permitted
 sender) smtp.mail=junio@pobox.com;       dkim=pass header.i=@pobox.com
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267292>

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> On 2015-04-15 20:48, Junio C Hamano wrote:
>
>> The patch should do for now, but I suspect that it may give us a
>> better abstraction to make the "is_foreground_fd(int fd)" or even
>> "is_foreground(void)" the public API that would be implemented as
>> 
>> 	int we_are_in_the_foreground(void)
>>         {
>> 		return getpgid(0) == tcgetpgrp(fileno(stderr));
>> 	}
>> 
>> in POSIX and Windows can implement entirely differently.
> ...
> In general, I find it rewarding not only from a portability point of
> view, but *especially* from a readability one if the code contains
> functions that are named semantically, i.e. they describe *why* they
> are called, not *how* they answer the question.

Yeah, that was the rationale behind the suggestion (i.e. how may be
different depending on the platform, and the main code flow cares
more about why and not how).

I'll queue Luke's patch with J6t's compat/ for now, but if you find
more suitable implementation for the higher-level abstraction,
please do send a follow-up patch to update it.

Two Johannes'es may need to talk between themselves to agree what
the right level of abstraction is, though.  I trust two of you a lot
more than my gut feeling when it comes to POSIX vs Windows API
differences ;-)

Thanks.

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
