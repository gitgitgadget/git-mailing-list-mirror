From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH 04/17] Makefile: a dry-run can error out if no
 perl. Document the issue
Date: Fri, 26 Jun 2015 00:34:38 +0100
Organization: OPDS
Message-ID: <45344004B4CA4B16BD7FB174B4849D77@PhilipOakley>
References: <1435190633-2208-1-git-send-email-philipoakley@iee.org><1435190633-2208-5-git-send-email-philipoakley@iee.org><xmqq8ub724ls.fsf@gitster.dls.corp.google.com><DBFC4D88D6F34023BA43F5F10134331E@PhilipOakley> <xmqqmvzny1xe.fsf@gitster.dls.corp.google.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=UTF-8; reply-type=original
Cc: "GitList" <git@vger.kernel.org>,
	"MsysGitList" <msysgit@googlegroups.com>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: msysgit+bncBDSOTWHYX4PBBAU7WKWAKGQEYIO3YIA@googlegroups.com Fri Jun 26 01:32:20 2015
Return-path: <msysgit+bncBDSOTWHYX4PBBAU7WKWAKGQEYIO3YIA@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-la0-f63.google.com ([209.85.215.63])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDSOTWHYX4PBBAU7WKWAKGQEYIO3YIA@googlegroups.com>)
	id 1Z8Gd1-0005en-FB
	for gcvm-msysgit@m.gmane.org; Fri, 26 Jun 2015 01:32:19 +0200
Received: by lams18 with SMTP id s18sf25270772lam.0
        for <gcvm-msysgit@m.gmane.org>; Thu, 25 Jun 2015 16:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:reply-to:from:to:cc:references:subject:date:organization
         :mime-version:content-type:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-spam-checked-in-group:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe;
        bh=6yE+81e45z5fB70DDbZZBIgMq7tYPqS36MleGq67b0U=;
        b=c2kivi/xQigM8dM7RioDqxe7We0B46oyKwQBr/CfbFkf+blQdSYjb1Xz1M6odVEbuH
         AwpHRJn2if5fKbgv+qrVfhNMONNOqQo2L4oDllE0F/vSAeeLRL5Z5kfj7zyPpwVokDbj
         SO/6INqaChZBIVKNbXGlHdw3B0z3T+L3om8oNLAhi3OLiyuHIElRoWy6rOVLj+UQhT4e
         +AiWYHXzG9O7yVaGh1L0ED1X/yjGmm8fPXEcXwQIomIzvA+H2ylLhnAJcgO90ScR5luA
         6furEs2Li2w4BUws0IUoLjyW98rXmL7LqMPFEgHvKgKYyGgrhhWghvRd8s/yHeH4VnTh
         C9+w==
X-Received: by 10.180.75.82 with SMTP id a18mr53036wiw.15.1435275139149;
        Thu, 25 Jun 2015 16:32:19 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.83.41 with SMTP id n9ls1557617wiy.47.canary; Thu, 25 Jun
 2015 16:32:17 -0700 (PDT)
X-Received: by 10.180.97.9 with SMTP id dw9mr120290wib.2.1435275137963;
        Thu, 25 Jun 2015 16:32:17 -0700 (PDT)
Received: from out1.ip03ir2.opaltelecom.net (out1.ip03ir2.opaltelecom.net. [62.24.128.239])
        by gmr-mx.google.com with ESMTP id t6si222234wiz.0.2015.06.25.16.32.17
        for <msysgit@googlegroups.com>;
        Thu, 25 Jun 2015 16:32:17 -0700 (PDT)
Received-SPF: softfail (google.com: domain of transitioning philipoakley@iee.org does not designate 62.24.128.239 as permitted sender) client-ip=62.24.128.239;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: A2DlJAAWj4xVPHK/BlxVBoMRgTOGTG2xMIwIBAQCgTpNAQEBAQEBBwEBAQFAASQbQQODWQYBAQQIAQEuHgEBIQsCAwUCAQMVDCUUAQQaBgcDFAYTCAIBAgMBCogYvxOQAgEri0qEQ0ODHoEUBYxLhzsBgQOMCIcdjAaDXIEJgVqBPj0xgkgBAQE
X-IPAS-Result: A2DlJAAWj4xVPHK/BlxVBoMRgTOGTG2xMIwIBAQCgTpNAQEBAQEBBwEBAQFAASQbQQODWQYBAQQIAQEuHgEBIQsCAwUCAQMVDCUUAQQaBgcDFAYTCAIBAgMBCogYvxOQAgEri0qEQ0ODHoEUBYxLhzsBgQOMCIcdjAaDXIEJgVqBPj0xgkgBAQE
X-IronPort-AV: E=Sophos;i="5.13,680,1427756400"; 
   d="scan'208";a="554809490"
Received: from host-92-6-191-114.as43234.net (HELO PhilipOakley) ([92.6.191.114])
  by out1.ip03ir2.opaltelecom.net with ESMTP; 26 Jun 2015 00:31:53 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-Original-Sender: philipoakley@iee.org
X-Original-Authentication-Results: gmr-mx.google.com;       spf=softfail
 (google.com: domain of transitioning philipoakley@iee.org does not designate
 62.24.128.239 as permitted sender) smtp.mail=philipoakley@iee.org
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Spam-Checked-In-Group: msysgit@googlegroups.com
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/msysgit/subscribe>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272745>

From: "Junio C Hamano" <gitster@pobox.com>
> "Philip Oakley" <philipoakley@iee.org> writes:
>
>> From: "Junio C Hamano" <gitster@pobox.com>
>>>
>>> I am not sure what this patch is trying to achieve.
>>
>> It was probably a bit of 'don't mess with working code', given that
>> I'd used the NO_PERL solution, rather 'document the issue'....
>
> Then this part applies, I think.
>
>>> If you are not touching what this Makefile actually does, then I
>>> would imagine that you are running the "buildsystems code" that
>>> actually drives 'make -n' with some "available solution" (perhaps
>>> you are running 'make -n NO_PERL=NoThanks' or something like that)?
>>> Then instead of a command like this that nobody would read in this
>>> file, the same command can instead go there to explain what the
>>> "workaround" (e.g. unusual-looking 'make -n NO_PERL=NoThanks') is
>>> doing?
>
I was more of the view that this was about prevention (here), rather
than retrospective explanation of the code (there).

In my case the errors were showing problems with the PM.stamp in the
makefile (I didn't have the solution at that point).

So either a short comment "#  consider using 'NO_PERL=YesPlease' for dry
run invocations" (beware your double negative ;-), or the addition of
the '+recipe', would still be my preferred change, rather than leaving
the open manhole for others to fall into.

The thread on my difficulties is at $gmane/263656 (2015-02-10 22:51)
"
    At the moment I'm getting (on my old WinXP machine, using Msysgit
    1.9.5 as a basis)

    $ make -n MSVC=1 V=1 1>makedry.txt
    make[1]: *** No rule to make target `PM.stamp', needed by 
`perl.mak'.
    Stop.
    make: *** [perl/perl.mak] Error 2
"
As you can see, at that time the place to look would be the makefile,
so I would do think a 'fix' there would still be appropriate.

Do you have a preference among the three options (comment, +recipe, 
drop)?
--
Philip

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
