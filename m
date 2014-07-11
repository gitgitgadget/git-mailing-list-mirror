From: Karsten Blees <karsten.blees@gmail.com>
Subject: Re: [PATCH 1/2] symlinks: remove PATH_MAX limitation
Date: Fri, 11 Jul 2014 21:11:23 +0200
Message-ID: <53C036DB.7000505@gmail.com>
References: <53B72DAA.5050007@gmail.com> <xmqqsimdc988.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>, msysGit <msysgit@googlegroups.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: msysgit+bncBCH3XYXLXQDBBW7NQCPAKGQEAHLU3CQ@googlegroups.com Fri Jul 11 21:11:28 2014
Return-path: <msysgit+bncBCH3XYXLXQDBBW7NQCPAKGQEAHLU3CQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wg0-f63.google.com ([74.125.82.63])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCH3XYXLXQDBBW7NQCPAKGQEAHLU3CQ@googlegroups.com>)
	id 1X5gEC-0004bU-2W
	for gcvm-msysgit@m.gmane.org; Fri, 11 Jul 2014 21:11:28 +0200
Received: by mail-wg0-f63.google.com with SMTP id y10sf142427wgg.8
        for <gcvm-msysgit@m.gmane.org>; Fri, 11 Jul 2014 12:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=XKHmikQtFnMp9N13vc8E5M65tnCFqjdsBPXtjK6Mvo8=;
        b=Wfrpub2E6kGLtf32dwtL1n0vN4TkqQAi7uPvxollaIrIJv81UShOGqf5ZzVW7TRkwe
         TZuvYMuEBN91Qv6gEEKzSSNA6ggeiw/frrUNKYTuthKUlj09JbUO+G5OeUOKI3XAhEoc
         x7w6Np4Mxilbe+gUXVmR74wufo/e0DiL1ertMY5mOJJIMC5t7jYvuKGux/HAehXFEhgJ
         9i7meDoTWA/b61iO+LZpLI9NmxjDtscM382DzyNTy3SAzWkygEvGwhykKFFxWsINtPK1
         82bCk+RtldN6leggJAbCf3O4qiRtwTD92eH4vL/Jv7qwFzGsxfB/IyLh1DbDiQJHnlWl
         tJuA==
X-Received: by 10.180.77.225 with SMTP id v1mr23489wiw.19.1405105883708;
        Fri, 11 Jul 2014 12:11:23 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.105.169 with SMTP id gn9ls134975wib.10.gmail; Fri, 11 Jul
 2014 12:11:22 -0700 (PDT)
X-Received: by 10.194.103.133 with SMTP id fw5mr82343wjb.3.1405105882722;
        Fri, 11 Jul 2014 12:11:22 -0700 (PDT)
Received: from mail-wg0-x231.google.com (mail-wg0-x231.google.com [2a00:1450:400c:c00::231])
        by gmr-mx.google.com with ESMTPS id r13si251829wib.0.2014.07.11.12.11.22
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 11 Jul 2014 12:11:22 -0700 (PDT)
Received-SPF: pass (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:400c:c00::231 as permitted sender) client-ip=2a00:1450:400c:c00::231;
Received: by mail-wg0-f49.google.com with SMTP id k14so816495wgh.20
        for <msysgit@googlegroups.com>; Fri, 11 Jul 2014 12:11:22 -0700 (PDT)
X-Received: by 10.180.75.197 with SMTP id e5mr7382205wiw.76.1405105882666;
        Fri, 11 Jul 2014 12:11:22 -0700 (PDT)
Received: from [10.1.116.52] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id ey16sm10434812wid.14.2014.07.11.12.11.21
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 11 Jul 2014 12:11:22 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <xmqqsimdc988.fsf@gitster.dls.corp.google.com>
X-Original-Sender: karsten.blees@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:400c:c00::231
 as permitted sender) smtp.mail=karsten.blees@gmail.com;       dkim=pass
 header.i=@gmail.com;       dmarc=pass (p=NONE dis=NONE) header.from=gmail.com
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253317>

Am 07.07.2014 20:30, schrieb Junio C Hamano:
> Karsten Blees <karsten.blees@gmail.com> writes:
> 
> The above cache_def_free(cache) does not free the cache itself, but
> only its associated data, so the name cache_def_free() is somewhat
> misleading.
> 

You already merged this to master ("kb/path-max-must-go" lol), should
I send a fixup! s/cache_def_free/cache_def_clear/ or is it OK as is?

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
