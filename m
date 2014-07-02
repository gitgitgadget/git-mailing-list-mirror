From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v7 11/16] trace: add 'file:line' to all trace output
Date: Wed, 02 Jul 2014 11:57:38 -0700
Message-ID: <xmqqionfh9lp.fsf@gitster.dls.corp.google.com>
References: <53B33C05.5090900@gmail.com> <53B33DED.3030809@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>,  msysGit <msysgit@googlegroups.com>
To: Karsten Blees <karsten.blees@gmail.com>
X-From: msysgit+bncBCG77UMM3EJRBKVM2GOQKGQEW66UKKI@googlegroups.com Wed Jul 02 20:57:48 2014
Return-path: <msysgit+bncBCG77UMM3EJRBKVM2GOQKGQEW66UKKI@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-pa0-f61.google.com ([209.85.220.61])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCG77UMM3EJRBKVM2GOQKGQEW66UKKI@googlegroups.com>)
	id 1X2Pj1-0004aB-OP
	for gcvm-msysgit@m.gmane.org; Wed, 02 Jul 2014 20:57:47 +0200
Received: by mail-pa0-f61.google.com with SMTP id hz1sf2604823pad.16
        for <gcvm-msysgit@m.gmane.org>; Wed, 02 Jul 2014 11:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=3HWdnvMJ10y1Ba5m3/MPfwBA0RGJ8QgVC1RVJ1Yx+qg=;
        b=tab98uaHb4rmahi2aoHlBCqhRfnJ3Yz7k+iPKWvr6qbR2DyZ1HpE6YaLtavEW5p5F4
         uUUUFuJl53L4/QFQwUYag9flqRsflLkIInwWixazeE29/FD9k7nKznuXNzvkdRQ+JtU+
         MyK/ml/xPc1eM0xELmNoxQ7KAOTgWtbjFYtn4DzXjKDgoEhR74Auu/8tMx0ZN1BBdZqr
         etRiudoki3+FE9iofhLEyfPRtpp/ggyOi4t8zBPBA2eq2KNDvhJnJLM0sCfKcXTMZYmi
         cU+BOh8DAQSgEAiFbVWqlUjkpMiickSf6AZu2u7G3JLioSGHhzyEpKfi4zcBMaD65uXh
         vW4Q==
X-Received: by 10.50.61.145 with SMTP id p17mr924777igr.16.1404327466692;
        Wed, 02 Jul 2014 11:57:46 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.50.66.193 with SMTP id h1ls232959igt.3.gmail; Wed, 02 Jul 2014
 11:57:45 -0700 (PDT)
X-Received: by 10.50.18.114 with SMTP id v18mr23320099igd.8.1404327465866;
        Wed, 02 Jul 2014 11:57:45 -0700 (PDT)
Received: from smtp.pobox.com (smtp.pobox.com. [208.72.237.35])
        by gmr-mx.google.com with ESMTP id o69si1396063yhp.6.2014.07.02.11.57.45
        for <msysgit@googlegroups.com>;
        Wed, 02 Jul 2014 11:57:45 -0700 (PDT)
Received-SPF: pass (google.com: domain of junio@pobox.com designates 208.72.237.35 as permitted sender) client-ip=208.72.237.35;
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id BCEE122E98;
	Wed,  2 Jul 2014 14:57:34 -0400 (EDT)
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B393122E97;
	Wed,  2 Jul 2014 14:57:34 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id CADA822E94;
	Wed,  2 Jul 2014 14:57:29 -0400 (EDT)
In-Reply-To: <53B33DED.3030809@gmail.com> (Karsten Blees's message of "Wed, 02
	Jul 2014 01:02:05 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: B77727A2-021A-11E4-BC9A-9903E9FBB39C-77302942!pb-smtp0.pobox.com
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
List-Archive: <http://groups.google.com/group/msysgit>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252828>

Karsten Blees <karsten.blees@gmail.com> writes:

> +#else
> +
> +/*
> + * Macros to add file:line - see above for C-style declarations of how these
> + * should be used.
> + *
> + * TRACE_CONTEXT may be set to __FUNCTION__ if the compiler supports it. The
> + * default is __FILE__, as it is consistent with assert(), and static function
> + * names are not necessarily unique.
> + */
> +#define TRACE_CONTEXT __FILE__

Hmph, seeing "may be set to" forces me to wonder how.  Perhaps #ifndef/#endif
around it?

Also, can it be set to something like __FILE__ ":" __FUNCTION__
which may alleviate the alleged problem of "not necessarily unique"
perhaps?

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
