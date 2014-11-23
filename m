From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: Re: [RFC 3/4] engine.pl: split the .o and .obj processing
Date: Sun, 23 Nov 2014 22:50:55 -0000
Organization: OPDS
Message-ID: <0DE9992936544B43BD4B7FC2CC4388AD@PhilipOakley>
References: <1416526682-6024-1-git-send-email-philipoakley@iee.org> <1416526682-6024-4-git-send-email-philipoakley@iee.org> <alpine.DEB.1.00.1411211043050.13845@s15462909.onlinehome-server.info> <622F65684C63407184D58ED19385AFD4@PhilipOakley> <alpine.DEB.1.00.1411231624230.13845@s15462909.onlinehome-server.info>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=UTF-8; reply-type=original
Cc: "GitList" <git@vger.kernel.org>,
	"Marius Storm-Olsen" <mstormo@gmail.com>,
	"Ramsay Jones" <ramsay@ramsay1.demon.co.uk>,
	"Jonathan Nieder" <jrnieder@gmail.com>,
	"Michael Wookey" <michaelwookey@gmail.com>,
	"Msysgit" <msysgit@googlegroups.com>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: msysgit+bncBDSOTWHYX4PBBUWJZGRQKGQEXLSSKJY@googlegroups.com Sun Nov 23 23:51:01 2014
Return-path: <msysgit+bncBDSOTWHYX4PBBUWJZGRQKGQEXLSSKJY@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wi0-f185.google.com ([209.85.212.185])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDSOTWHYX4PBBUWJZGRQKGQEXLSSKJY@googlegroups.com>)
	id 1Xsfzf-0005x1-Rz
	for gcvm-msysgit@m.gmane.org; Sun, 23 Nov 2014 23:50:59 +0100
Received: by mail-wi0-f185.google.com with SMTP id ex7sf227826wid.22
        for <gcvm-msysgit@m.gmane.org>; Sun, 23 Nov 2014 14:50:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:reply-to:from:to:cc:references:subject:date:organization
         :mime-version:content-type:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe;
        bh=SBGdqCQ2wXFJU3UmXxjel9loRgsQ7ZamZSdRrYvG9vI=;
        b=nCR/p30kE3fhgUHwmGLam+SQBIZ1DOO1Z5kMZI3mWYpWWZ3hES7GJhbulZFxJouF/+
         GSUtdLlGqN+GoYiGVXOhbOdH4dk8ajfNcM9rNxU4PogUPBU6GzLGw/1at3KjbOr9MYW0
         LVcfwgmfXZwTW/ygZCT9GyMwXnbULyViDVevRJFL7Ot9SHUgWDl0n8noVttYyMAWW3lD
         unJYvXq0dsGUY8UnOCDfavQZ54D0dznlsUD2Nio1JGN3QveCS57Pc0pyRhPuufOaPcrC
         Lz61Y05t+7OdmCXox9ChFTi0NTlbXwt1VbnVEmCj/dZjQhq/ISOx8cKC5I8RZojzQoOC
         eMmw==
X-Received: by 10.152.7.143 with SMTP id j15mr279510laa.0.1416783059535;
        Sun, 23 Nov 2014 14:50:59 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.88.1 with SMTP id bc1ls404069lab.24.gmail; Sun, 23 Nov
 2014 14:50:57 -0800 (PST)
X-Received: by 10.112.14.2 with SMTP id l2mr507341lbc.5.1416783057288;
        Sun, 23 Nov 2014 14:50:57 -0800 (PST)
Received: from out1.ip02ir2.opaltelecom.net (out1.ip02ir2.opaltelecom.net. [62.24.128.238])
        by gmr-mx.google.com with ESMTP id d5si322858wib.2.2014.11.23.14.50.57
        for <msysgit@googlegroups.com>;
        Sun, 23 Nov 2014 14:50:57 -0800 (PST)
Received-SPF: softfail (google.com: domain of transitioning philipoakley@iee.org does not designate 62.24.128.238 as permitted sender) client-ip=62.24.128.238;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AvQQALRjclRZ8Yh/PGdsb2JhbABbgw5VWYgNw0kfCoZkAQMBAYEKFwEBAQEBAQUBAQEBOCAbg30GAQEBAwECBQEBLh4BASELAgMFAgEDFQwlFAEEDwsGBwMUBhMIAgECAwGIGwMWCb5ijmKOToI9gzaBHwWLaYZ/a4ZMgVWeJEgwAYJKAQEB
X-IPAS-Result: AvQQALRjclRZ8Yh/PGdsb2JhbABbgw5VWYgNw0kfCoZkAQMBAYEKFwEBAQEBAQUBAQEBOCAbg30GAQEBAwECBQEBLh4BASELAgMFAgEDFQwlFAEEDwsGBwMUBhMIAgECAwGIGwMWCb5ijmKOToI9gzaBHwWLaYZ/a4ZMgVWeJEgwAYJKAQEB
X-IronPort-AV: E=Sophos;i="5.07,445,1413241200"; 
   d="scan'208";a="17226524"
Received: from host-89-241-136-127.as13285.net (HELO PhilipOakley) ([89.241.136.127])
  by out1.ip02ir2.opaltelecom.net with SMTP; 23 Nov 2014 22:50:57 +0000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-Original-Sender: philipoakley@iee.org
X-Original-Authentication-Results: gmr-mx.google.com;       spf=softfail
 (google.com: domain of transitioning philipoakley@iee.org does not designate
 62.24.128.238 as permitted sender) smtp.mail=philipoakley@iee.org
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260106>

From: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
>> > How about the following instead?
>> >
>> > + } elsif ($part eq 'invalidcontinue.obj') {
>> > + # ignore
>> >  } elsif ($part =~ /\.(o|obj)$/) {
>>
>> Looks good, I'll use that (after deciding whether .obj files should
>> be
>> expected in a 'make' output anyway)
>
> My idea to hardcode invalidcontinue.obj was that I'd rather see a
> failure
> if an unexpected .obj is seen there. But I realize that my suggested
> change does not exactly accomplish that.
>
I've decided to include the hard code suggested, and after a few tests
decided it was probably worth keeping the .obj processing, even though
we don't expect any.

At least I've now managed to generate a .sln project, though it won't
compile because of a number of other changes, and I haven't got to the
bottom of them all.

Notes:
Revert "Windows: correct detection of EISDIR in mingw_open()"
git\compat\mingw.c(315) : error C2065: 'O_ACCMODE' : undeclared
identifier (neither VS2008 nor VS2010 declare 'O_ACCMODE'). add an 
#ifdef
_MSC_VER to define this if we are in MSVC.

Revert "mingw.h: add dummy functions for sigset_t operations" commit
4e6d207c45. the Additional Note: to
http://www.spinics.net/lists/git/msg240248.html indicates that this
breaks MSVC. I think it will also need an #ifdef to see if we are in 
MSVC.

I've also found a problem with my setup (msysgit 1.7.9 for make) barfing
on the commit/ee9be06 "perl: detect new files in MakeMaker builds" which
'make -n' says 'No rule to make target `PM.stamp', needed by `perl.mak'.

There was also LINK : warning LNK4098: defaultlib 'MSVCRT' conflicts
with use of other libs; use /NODEFAULTLIB:library.

I've also got notes from way back that there was build order problem
with 'vcs-svn_lib.lib' - probably a sort order issue. IIRC at that time,
I had to compile the project twice so that the lib was visible the
second time.

So there's plenty to go at ;-) I'm going to be away this coming week, So
at least I have the whole next cycle to make some progress.

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
