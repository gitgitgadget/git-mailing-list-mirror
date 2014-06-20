From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH v6 00/11] add performance tracing facility
Date: Fri, 20 Jun 2014 23:49:56 +0100
Organization: OPDS
Message-ID: <CEA564C177884D1D86D69200A9A43AC8@PhilipOakley>
References: <53A4A195.1070502@gmail.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=ISO-8859-1; reply-type=original
To: "Karsten Blees" <karsten.blees@gmail.com>,
	"Git List" <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>,
	"msysGit" <msysgit@googlegroups.com>
X-From: msysgit+bncBDSOTWHYX4PBBJPVSKOQKGQEIYGA3LI@googlegroups.com Sat Jun 21 00:50:14 2014
Return-path: <msysgit+bncBDSOTWHYX4PBBJPVSKOQKGQEIYGA3LI@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-we0-f184.google.com ([74.125.82.184])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDSOTWHYX4PBBJPVSKOQKGQEIYGA3LI@googlegroups.com>)
	id 1Wy7dO-00051f-5q
	for gcvm-msysgit@m.gmane.org; Sat, 21 Jun 2014 00:50:14 +0200
Received: by mail-we0-f184.google.com with SMTP id u56sf473057wes.11
        for <gcvm-msysgit@m.gmane.org>; Fri, 20 Jun 2014 15:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:reply-to:from:to:references:subject:date:organization
         :mime-version:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=PTUJDXCQba3cvu5eEWrmHu4CEtjFS3wODxQahBpW6G4=;
        b=GJGmGxpetncdF2SYeaRH9rVP1kWPOd8sht/D28XIv1AGzCkGKQoP6GAk3xxzQ6lpzy
         Zuw9C+q/KRktruK47LT3IA1qKMtnF1IKMjDMMsxoe4Jnvwyww/XTeJkOAszmbLpeMIhV
         SMsE/CM2nAv323d2MFMDfs5lXAzW1ShkuXdTtSGhaFLpoIHCckjZ2PhNXyy9andphGAB
         w5CM9zyjrvMvdMjDqQMScXI76qwapQsFpNTcxri8GFPvHqYgykBfYw4mfJPgcJXNAb3D
         dbLtA4qixvoQdcLoJ+TE2vxPSwwPocUvnUSaNaU/Vsz6FG8nLSkBQkbeVBv1a5cLVPSZ
         Wp7w==
X-Received: by 10.180.12.3 with SMTP id u3mr26640wib.17.1403304613677;
        Fri, 20 Jun 2014 15:50:13 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.187.34 with SMTP id fp2ls113383wic.51.canary; Fri, 20 Jun
 2014 15:50:12 -0700 (PDT)
X-Received: by 10.194.2.130 with SMTP id 2mr489381wju.5.1403304612625;
        Fri, 20 Jun 2014 15:50:12 -0700 (PDT)
Received: from out1.ip02ir2.opaltelecom.net (out1.ip02ir2.opaltelecom.net. [62.24.128.238])
        by gmr-mx.google.com with ESMTP id iz18si232196wic.3.2014.06.20.15.50.12
        for <msysgit@googlegroups.com>;
        Fri, 20 Jun 2014 15:50:12 -0700 (PDT)
Received-SPF: softfail (google.com: domain of transitioning philipoakley@iee.org does not designate 62.24.128.238 as permitted sender) client-ip=62.24.128.238;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: ApMcAGS6pFMCYJeh/2dsb2JhbABZgw1SEQOIbrskBQECAQ2BARd1g34FAQEEAQgBAS4eAQEmBgIDBQIBAxUMJRQBBAgSBgcXBgESCAIBAgMBiB0DCQyyf5BmDYZijFOCWIJ/gRYEkGCHa49RhgKDQzw
X-IPAS-Result: ApMcAGS6pFMCYJeh/2dsb2JhbABZgw1SEQOIbrskBQECAQ2BARd1g34FAQEEAQgBAS4eAQEmBgIDBQIBAxUMJRQBBAgSBgcXBgESCAIBAgMBiB0DCQyyf5BmDYZijFOCWIJ/gRYEkGCHa49RhgKDQzw
X-IronPort-AV: E=Sophos;i="5.01,517,1400022000"; 
   d="scan'208";a="506287332"
Received: from host-2-96-151-161.as13285.net (HELO PhilipOakley) ([2.96.151.161])
  by out1.ip02ir2.opaltelecom.net with SMTP; 20 Jun 2014 23:49:55 +0100
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
List-Archive: <http://groups.google.com/group/msysgit>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252295>

From: "Karsten Blees" <karsten.blees@gmail.com>
> Changes since v5:
> [05/11]: GIT_TRACE_BARE=1 disables 'timestamp file:line' output for
>         unit tests that rely on trace output (t1510 and t5503)
> [08/11]: Align original trace output at col 40
> [09/11]: Dropped '(div 10e9)' from the commit message.
> [10/11]: Dropped trace_performance[_since]() return value and the
>         respective usage example. Renamed trace_performance_vfl to
>         trace_performance_vprintf_fl.
>
> The other patches are the versions from pu.
>
> Karsten Blees (11):
>  trace: move trace declarations from cache.h to new trace.h
>  trace: consistently name the format parameter
>  trace: remove redundant printf format attribute
>  trace: factor out printing to the trace file
>  trace: add infrastructure to augment trace output with additional 
> info
>  trace: add current timestamp to all trace output
>  trace: move code around, in preparation to file:line output
>  trace: add 'file:line' to all trace output
>  trace: add high resolution timer function to debug performance issues
>  trace: add trace_performance facility to debug performance issues
>  git: add performance tracing for git's main() function to debug
>    scripts
>
> Makefile              |   7 ++
> cache.h               |  13 +--
> config.mak.uname      |   1 +
> git-compat-util.h     |   4 +
> git.c                 |   2 +
> t/t1510-repo-setup.sh |   2 +-
> t/t5503-tagfollow.sh  |   8 +-
> trace.c               | 313 
> ++++++++++++++++++++++++++++++++++++++++++++------
> trace.h               |  90 +++++++++++++++
> 9 files changed, 387 insertions(+), 53 deletions(-)

Should there be some documentation as well? Perhaps in t/README, or in
Documentation/howto.


> create mode 100644 trace.h
>
> -- 
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
You received this message because you are subscribed to the Google Groups "msysGit" group.
To unsubscribe from this group and stop receiving emails from it, send an email to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
