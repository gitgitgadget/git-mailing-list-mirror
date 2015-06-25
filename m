From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 01/17] .gitignore: improve MSVC ignore patterns
Date: Thu, 25 Jun 2015 13:22:55 -0700
Message-ID: <xmqqioaby1uo.fsf@gitster.dls.corp.google.com>
References: <1435190633-2208-1-git-send-email-philipoakley@iee.org>
	<1435190633-2208-2-git-send-email-philipoakley@iee.org>
	<xmqqd20j253w.fsf@gitster.dls.corp.google.com>
	<DDC36A35EBC548718762478AA7B80F67@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "GitList" <git@vger.kernel.org>,  "MsysGitList" <msysgit@googlegroups.com>
To: "Philip Oakley" <philipoakley@iee.org>
X-From: msysgit+bncBCG77UMM3EJRBIOGWGWAKGQEHHLMLWQ@googlegroups.com Thu Jun 25 22:22:59 2015
Return-path: <msysgit+bncBCG77UMM3EJRBIOGWGWAKGQEHHLMLWQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-qc0-f191.google.com ([209.85.216.191])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCG77UMM3EJRBIOGWGWAKGQEHHLMLWQ@googlegroups.com>)
	id 1Z8Dfm-0003c0-MS
	for gcvm-msysgit@m.gmane.org; Thu, 25 Jun 2015 22:22:58 +0200
Received: by qcrw7 with SMTP id w7sf20158776qcr.1
        for <gcvm-msysgit@m.gmane.org>; Thu, 25 Jun 2015 13:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-spam-checked-in-group:list-post:list-help:list-archive
         :list-subscribe:list-unsubscribe;
        bh=kcmkjvA6DzmygaOmom5niZOfJ13tV+Oa8X6mfr8QE9w=;
        b=rf5px3av22jM1owDqioTzdEv2IiPfOw0vBggErIcPOvTdQLHiwqp2FNOgutyIY3FmX
         7pkMLBp0WzK/2QF4dVvM0yaYWK+FoUyA42vaaN6jIsM2mfguP6KQBnAoDM191QhQ8YHL
         iN/B2z/k3YwomcWuLQ7NGL/zufAyTu9URol057l3qAE7Huc4vgrwMFf7sRiEsuRL224q
         oCbaUcm8NYrwGd8PM4bT2NS+dXC4nfbSqX1cfMipia2GcKaB/Xx7kqJU1ltpGkxzc6uU
         3YQr5vArm4Tw/cp3y4Gmeab+rQJawY2wO9uZIOsO4vD2KC+CZR42s4nQQRLv9Ibjt8QA
         ZFJw==
X-Received: by 10.50.82.8 with SMTP id e8mr125600igy.7.1435263778010;
        Thu, 25 Jun 2015 13:22:58 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.107.16.81 with SMTP id y78ls844685ioi.57.gmail; Thu, 25 Jun
 2015 13:22:57 -0700 (PDT)
X-Received: by 10.50.66.193 with SMTP id h1mr5873502igt.3.1435263777521;
        Thu, 25 Jun 2015 13:22:57 -0700 (PDT)
Received: from mail-ig0-x236.google.com (mail-ig0-x236.google.com. [2607:f8b0:4001:c05::236])
        by gmr-mx.google.com with ESMTPS id x1si630313igb.2.2015.06.25.13.22.57
        for <msysgit@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Jun 2015 13:22:57 -0700 (PDT)
Received-SPF: pass (google.com: domain of jch2355@gmail.com designates 2607:f8b0:4001:c05::236 as permitted sender) client-ip=2607:f8b0:4001:c05::236;
Received: by mail-ig0-x236.google.com with SMTP id n14so75473igi.1
        for <msysgit@googlegroups.com>; Thu, 25 Jun 2015 13:22:57 -0700 (PDT)
X-Received: by 10.50.43.196 with SMTP id y4mr6507033igl.14.1435263777452;
        Thu, 25 Jun 2015 13:22:57 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:3512:3582:e5d3:22a9])
        by mx.google.com with ESMTPSA id p4sm4005233igg.20.2015.06.25.13.22.56
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 25 Jun 2015 13:22:57 -0700 (PDT)
Sender: msysgit@googlegroups.com
In-Reply-To: <DDC36A35EBC548718762478AA7B80F67@PhilipOakley> (Philip Oakley's
	message of "Thu, 25 Jun 2015 20:32:10 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Original-Sender: gitster@pobox.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of jch2355@gmail.com designates 2607:f8b0:4001:c05::236
 as permitted sender) smtp.mail=jch2355@gmail.com;       dkim=pass header.i=@gmail.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Spam-Checked-In-Group: msysgit@googlegroups.com
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/msysgit/subscribe>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272721>

"Philip Oakley" <philipoakley@iee.org> writes:

>> Debug/
>> Release/
>>
>> suffice?
>>
> Probably. I was thinking of the 'at any level' aspect...

Yeah, that is exactly the difference between rooted "/Debug/" and
"Debug/" ;-).

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
