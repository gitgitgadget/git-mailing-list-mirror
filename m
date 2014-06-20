From: Karsten Blees <karsten.blees@gmail.com>
Subject: Re: [PATCH v6 00/11] add performance tracing facility
Date: Sat, 21 Jun 2014 01:42:51 +0200
Message-ID: <53A4C6FB.5040005@gmail.com>
References: <53A4A195.1070502@gmail.com> <CEA564C177884D1D86D69200A9A43AC8@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Philip Oakley <philipoakley@iee.org>, Git List <git@vger.kernel.org>, 
 Junio C Hamano <gitster@pobox.com>,
 msysGit <msysgit@googlegroups.com>
X-From: msysgit+bncBCH3XYXLXQDBB6MNSOOQKGQE5JGPU3A@googlegroups.com Sat Jun 21 01:42:51 2014
Return-path: <msysgit+bncBCH3XYXLXQDBB6MNSOOQKGQE5JGPU3A@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wg0-f62.google.com ([74.125.82.62])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCH3XYXLXQDBB6MNSOOQKGQE5JGPU3A@googlegroups.com>)
	id 1Wy8SI-0001cG-VK
	for gcvm-msysgit@m.gmane.org; Sat, 21 Jun 2014 01:42:51 +0200
Received: by mail-wg0-f62.google.com with SMTP id y10sf472535wgg.7
        for <gcvm-msysgit@m.gmane.org>; Fri, 20 Jun 2014 16:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=HTjW0I8147YjeSew5Vfk8cFzeIFL/1clHbU1BS6KOqU=;
        b=BxOohDL1+nMzEoOVch7yktjwo64iv1e/AsXHzMnJeNiYzokyMGk1o/Zo0xKHH3qt+D
         BPCWKpwmH4xu0//bqJxoAposy77Mvaa0vQRC4/6ic4EtE9BcH2bMMoalQubSi8vYnH/w
         vsCgVCOtlIecgOIX10z01AnwOIMJjtiCO/0bHg4QG/Hk4FeSZkv7VbHAeR2mvcEMO95V
         wQ5TfrWMPHBXaVICLd0iNpMzqQno88471Ja0yWnhnX+KKRDb4UZBNGJmFpeoJLvvp9HX
         t9s4Jh9oYI+ACJIDICk3u4L0i5kgUk5jdaDnBRMboHsBdShTQVmoaeGyXKAhXzhPdfvI
         sccg==
X-Received: by 10.152.30.66 with SMTP id q2mr18620lah.2.1403307770492;
        Fri, 20 Jun 2014 16:42:50 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.242.130 with SMTP id wq2ls193760lac.85.gmail; Fri, 20 Jun
 2014 16:42:48 -0700 (PDT)
X-Received: by 10.112.14.5 with SMTP id l5mr591642lbc.6.1403307768924;
        Fri, 20 Jun 2014 16:42:48 -0700 (PDT)
Received: from mail-wi0-x22f.google.com (mail-wi0-x22f.google.com [2a00:1450:400c:c05::22f])
        by gmr-mx.google.com with ESMTPS id r13si246672wib.0.2014.06.20.16.42.48
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 20 Jun 2014 16:42:48 -0700 (PDT)
Received-SPF: pass (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:400c:c05::22f as permitted sender) client-ip=2a00:1450:400c:c05::22f;
Received: by mail-wi0-f175.google.com with SMTP id r20so1570406wiv.8
        for <msysgit@googlegroups.com>; Fri, 20 Jun 2014 16:42:48 -0700 (PDT)
X-Received: by 10.180.221.229 with SMTP id qh5mr7507133wic.33.1403307768849;
        Fri, 20 Jun 2014 16:42:48 -0700 (PDT)
Received: from [10.1.116.52] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id lk7sm17543223wjb.24.2014.06.20.16.42.47
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 20 Jun 2014 16:42:48 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <CEA564C177884D1D86D69200A9A43AC8@PhilipOakley>
X-Original-Sender: karsten.blees@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:400c:c05::22f
 as permitted sender) smtp.mail=karsten.blees@gmail.com;       dkim=pass
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252297>

Am 21.06.2014 00:49, schrieb Philip Oakley:
> Should there be some documentation as well? Perhaps in t/README, or in
> Documentation/howto.

I'll add Documentation/technical/api-trace.txt when I find the time.
But lets settle on the final API first.

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
