From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH 2/3] Windows: a test_cmp that is agnostic to
 random LF <> CRLF conversions
Date: Sat, 02 Nov 2013 21:33:28 +0100
Message-ID: <52756198.2070900@gmail.com>
References: <cover.1382814437.git.j6t@kdbg.org> <e64878fec3f026802e8d3958a1e6213428cab778.1382814437.git.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: msysgit@googlegroups.com
To: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
X-From: msysgit+bncBDZMLEGXWQLBBIOD2WJQKGQER3JPB5I@googlegroups.com Sat Nov 02 21:33:38 2013
Return-path: <msysgit+bncBDZMLEGXWQLBBIOD2WJQKGQER3JPB5I@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-la0-f60.google.com ([209.85.215.60])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDZMLEGXWQLBBIOD2WJQKGQER3JPB5I@googlegroups.com>)
	id 1Vcht4-0005xK-MW
	for gcvm-msysgit@m.gmane.org; Sat, 02 Nov 2013 21:33:38 +0100
Received: by mail-la0-f60.google.com with SMTP id hp15sf568356lab.15
        for <gcvm-msysgit@m.gmane.org>; Sat, 02 Nov 2013 13:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:date:from:user-agent:mime-version:newsgroups:to:cc
         :subject:references:in-reply-to:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=7/IAQchDq/wzO3FB52ynO8pOvD4VJNMre9kWUe5Ogxw=;
        b=RtIWa3Dt0ujnZrsC5ycgeOdbEdUIDiiE8UO1e1Vsyxa/vH8tDMvtqOe19PsZYn0ucE
         ULNXbzvSFAAFmZKFeeoKM4RiPua/m+EGt3ZGUAVz04wXUq66Yc4xTTREZuw2HOJ5FvWN
         75AYq070SGAmP5M3HTKTXJCjFudWR5U4NwA0lmLM2+QLA871WU2lEyoT0AXfyhG8EfGK
         x1wkxApJR8pCe79FU2RwYH6A8UeW0SHGP+FB756h+lsdKzgtHvEamRE2/peKDnr+4UXA
         gfSw/CuH/hgziYQZOGfYl7jsmMF9np+T3dP5a9dotNgPrcrLWCtX4AsG+DTAmqaD16ii
         b1jw==
X-Received: by 10.152.121.3 with SMTP id lg3mr124888lab.2.1383424418402;
        Sat, 02 Nov 2013 13:33:38 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.120.199 with SMTP id le7ls345419lab.77.gmail; Sat, 02 Nov
 2013 13:33:37 -0700 (PDT)
X-Received: by 10.112.205.38 with SMTP id ld6mr3389354lbc.10.1383424417014;
        Sat, 02 Nov 2013 13:33:37 -0700 (PDT)
Received: from mail-ea0-x231.google.com (mail-ea0-x231.google.com [2a00:1450:4013:c01::231])
        by gmr-mx.google.com with ESMTPS id z4si1449587eel.0.2013.11.02.13.33.36
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 02 Nov 2013 13:33:36 -0700 (PDT)
Received-SPF: pass (google.com: domain of sschuberth@gmail.com designates 2a00:1450:4013:c01::231 as permitted sender) client-ip=2a00:1450:4013:c01::231;
Received: by mail-ea0-f177.google.com with SMTP id f15so2652245eak.22
        for <msysgit@googlegroups.com>; Sat, 02 Nov 2013 13:33:36 -0700 (PDT)
X-Received: by 10.14.179.66 with SMTP id g42mr984646eem.104.1383424416857;
        Sat, 02 Nov 2013 13:33:36 -0700 (PDT)
Received: from [192.168.188.20] (p4FC96A61.dip0.t-ipconnect.de. [79.201.106.97])
        by mx.google.com with ESMTPSA id e13sm24725046eeu.4.2013.11.02.13.33.35
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 02 Nov 2013 13:33:36 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.12) Gecko/20080213 Thunderbird/2.0.0.12 Mnenhy/0.7.5.0
Newsgroups: gmane.comp.version-control.msysgit,gmane.comp.version-control.git
In-Reply-To: <e64878fec3f026802e8d3958a1e6213428cab778.1382814437.git.j6t@kdbg.org>
X-Original-Sender: sschuberth@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of sschuberth@gmail.com designates 2a00:1450:4013:c01::231
 as permitted sender) smtp.mail=sschuberth@gmail.com;       dkim=pass
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237250>

On 26.10.2013 21:17, Johannes Sixt wrote:

> In a number of tests, output that was produced by a shell script is
> compared to expected output using test_cmp. Unfortunately, the MSYS bash--
> when invoked via git, such as in hooks--converts LF to CRLF on output
> (as produced by echo and printf), which leads to many false positives.

As you correctly point out the LF vs. CRLF issues are caused by MSYS 
bash. Then why are the functions called mingw_* instead of msys_*? I'd 
prefer to make very clear that not MinGW but MSYS is the culprit 
concerning the LF vs. CRLF issues (and also the path mangling issues).

-- 
Sebastian Schuberth

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
For more options, visit https://groups.google.com/groups/opt_out.
