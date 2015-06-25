From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 04/17] Makefile: a dry-run can error out if no
 perl. Document the issue
Date: Thu, 25 Jun 2015 13:21:17 -0700
Message-ID: <xmqqmvzny1xe.fsf@gitster.dls.corp.google.com>
References: <1435190633-2208-1-git-send-email-philipoakley@iee.org>
	<1435190633-2208-5-git-send-email-philipoakley@iee.org>
	<xmqq8ub724ls.fsf@gitster.dls.corp.google.com>
	<DBFC4D88D6F34023BA43F5F10134331E@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "GitList" <git@vger.kernel.org>,  "MsysGitList" <msysgit@googlegroups.com>
To: "Philip Oakley" <philipoakley@iee.org>
X-From: msysgit+bncBCG77UMM3EJRBP6FWGWAKGQEHI5MRVI@googlegroups.com Thu Jun 25 22:21:22 2015
Return-path: <msysgit+bncBCG77UMM3EJRBP6FWGWAKGQEHI5MRVI@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-qk0-f192.google.com ([209.85.220.192])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCG77UMM3EJRBP6FWGWAKGQEHI5MRVI@googlegroups.com>)
	id 1Z8DeC-00028Z-FU
	for gcvm-msysgit@m.gmane.org; Thu, 25 Jun 2015 22:21:20 +0200
Received: by qkby64 with SMTP id y64sf20258992qkb.1
        for <gcvm-msysgit@m.gmane.org>; Thu, 25 Jun 2015 13:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-spam-checked-in-group:list-post:list-help:list-archive
         :list-subscribe:list-unsubscribe;
        bh=0mzwk0hs971CbBjCOxftOqfrhujZJ289WOAvk+B6Tzo=;
        b=F9FBO5lREq2Ml5FsXAtx5di8KRj5MLukT2Ppxdu74lS+wrWvoL8xyKr2KIa4+8tQBe
         pxeU1TtuGg4YrZ0pxP28ZXcL4vhWmnMbJtzeFEqYfNKH4Ryb9uwew4N9vznS2E43EqP/
         ChY9LKmen8D/CK8fzYKp7keye6+a8MxP3/CdW4Hl0xbdC+RbMtAG6ojDQgFHFWxAp5zz
         PfMIoG5nOuWrxQFqCkqykcKHLvZmJNVnMPOilD3Iz8yp1BPemH2hh9p0wc75vPlRHTG7
         Mm1mbVODnHeBcnd3mBe44aCizpUfVrcu9EixvXKTo4pY5qJcwCDGrW8jqIr65NNi4Wru
         IGRg==
X-Received: by 10.140.34.78 with SMTP id k72mr86583qgk.17.1435263679899;
        Thu, 25 Jun 2015 13:21:19 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.140.88.116 with SMTP id s107ls1722628qgd.65.gmail; Thu, 25 Jun
 2015 13:21:19 -0700 (PDT)
X-Received: by 10.140.232.88 with SMTP id d85mr61615585qhc.0.1435263679520;
        Thu, 25 Jun 2015 13:21:19 -0700 (PDT)
Received: from mail-ig0-x22d.google.com (mail-ig0-x22d.google.com. [2607:f8b0:4001:c05::22d])
        by gmr-mx.google.com with ESMTPS id x1si630310igb.2.2015.06.25.13.21.19
        for <msysgit@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Jun 2015 13:21:19 -0700 (PDT)
Received-SPF: pass (google.com: domain of jch2355@gmail.com designates 2607:f8b0:4001:c05::22d as permitted sender) client-ip=2607:f8b0:4001:c05::22d;
Received: by mail-ig0-x22d.google.com with SMTP id iq7so58043igb.1
        for <msysgit@googlegroups.com>; Thu, 25 Jun 2015 13:21:19 -0700 (PDT)
X-Received: by 10.42.110.75 with SMTP id o11mr2141830icp.14.1435263679431;
        Thu, 25 Jun 2015 13:21:19 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:3512:3582:e5d3:22a9])
        by mx.google.com with ESMTPSA id y6sm4004297igl.17.2015.06.25.13.21.18
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 25 Jun 2015 13:21:18 -0700 (PDT)
Sender: msysgit@googlegroups.com
In-Reply-To: <DBFC4D88D6F34023BA43F5F10134331E@PhilipOakley> (Philip Oakley's
	message of "Thu, 25 Jun 2015 20:33:04 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Original-Sender: gitster@pobox.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of jch2355@gmail.com designates 2607:f8b0:4001:c05::22d
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272720>

"Philip Oakley" <philipoakley@iee.org> writes:

> From: "Junio C Hamano" <gitster@pobox.com>
>>
>> I am not sure what this patch is trying to achieve.
>
> It was probably a bit of 'don't mess with working code', given that
> I'd used the NO_PERL solution, rather 'document the issue'....

Then this part applies, I think.

>> If you are not touching what this Makefile actually does, then I
>> would imagine that you are running the "buildsystems code" that
>> actually drives 'make -n' with some "available solution" (perhaps
>> you are running 'make -n NO_PERL=NoThanks' or something like that)?
>> Then instead of a command like this that nobody would read in this
>> file, the same command can instead go there to explain what the
>> "workaround" (e.g. unusual-looking 'make -n NO_PERL=NoThanks') is
>> doing?

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
