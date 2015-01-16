From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: Re: [PATCH] t/lib-httpd: switch SANITY check for NOT_ROOT
Date: Fri, 16 Jan 2015 10:38:39 -0800
Message-ID: <E986F3A9-0FFD-4653-8B1C-67C79FFB607B@gmail.com>
References: <20150114211712.GE1155@peff.net> <064010B3-BC58-42F2-B5C0-DAADAA59B87D@gmail.com> <xmqqwq4n6b4c.fsf@gitster.dls.corp.google.com> <20150115222719.GA19021@peff.net> <xmqqa91j6537.fsf@gitster.dls.corp.google.com> <20150115235752.GB25120@peff.net> <xmqqh9vr4mlz.fsf@gitster.dls.corp.google.com> <20150116013256.GA25894@peff.net> <BEFF558C-774D-4891-96A0-BE962F8070E7@gmail.com> <20150116033445.GA29572@peff.net> <20150116091648.GA2450@peff.net>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: Junio C Hamano <gitster@pobox.com>,
 msysgit@googlegroups.com,
 =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>,
 Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: msysgit+bncBCA2HLOB7YGRBM5V4WSQKGQEE4PBTMI@googlegroups.com Fri Jan 16 19:38:45 2015
Return-path: <msysgit+bncBCA2HLOB7YGRBM5V4WSQKGQEE4PBTMI@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-vc0-f188.google.com ([209.85.220.188])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCA2HLOB7YGRBM5V4WSQKGQEE4PBTMI@googlegroups.com>)
	id 1YCBnA-0001cK-SV
	for gcvm-msysgit@m.gmane.org; Fri, 16 Jan 2015 19:38:45 +0100
Received: by mail-vc0-f188.google.com with SMTP id id10sf2955254vcb.5
        for <gcvm-msysgit@m.gmane.org>; Fri, 16 Jan 2015 10:38:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=from:to:in-reply-to:subject:references:message-id:content-type
         :mime-version:date:cc:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe;
        bh=SiV2GWt0DSkZhFq5bFfL5rDsyaG7zTNEVlkzhG99m80=;
        b=glI+u4xkNGUzO5Sogmoq5MDUoKHiuw1e3feXJl8ckXuJ4EtZfQwAVc76FDN2SNWe46
         4T1MbTbNiFI/9Ys/0EsU5pRQqarrEXBGV0Zd7Xwbnj/J8OlfHrz3krxCYG7G0X71X83d
         dvlExSTivSgy0mbm49mFtE26ZpOtMSG8XpDmoD7gmYUTqFBcLA5IEZ4mKHUu9cYl1H3T
         +c1U69YzxjfAOyGsRfZjSZjzfHp9O/+SXxkD8T4N7gEqEQjRI7r8C3z0ni8DOQWoqxiT
         9JKX0uOr7gQXUb35EQTYndmxSJikji8GqvpfL9aktWvVJwIg1saLr7WVGYZPoepBPFKE
         R34A==
X-Received: by 10.50.129.98 with SMTP id nv2mr78688igb.1.1421433524063;
        Fri, 16 Jan 2015 10:38:44 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.107.157.194 with SMTP id g185ls1189607ioe.25.gmail; Fri, 16
 Jan 2015 10:38:43 -0800 (PST)
X-Received: by 10.50.225.7 with SMTP id rg7mr3482767igc.5.1421433523734;
        Fri, 16 Jan 2015 10:38:43 -0800 (PST)
Received: from mail-pa0-x22e.google.com (mail-pa0-x22e.google.com. [2607:f8b0:400e:c03::22e])
        by gmr-mx.google.com with ESMTPS id q14si590723pdj.0.2015.01.16.10.38.43
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 16 Jan 2015 10:38:43 -0800 (PST)
Received-SPF: pass (google.com: domain of mackyle@gmail.com designates 2607:f8b0:400e:c03::22e as permitted sender) client-ip=2607:f8b0:400e:c03::22e;
Received: by mail-pa0-f46.google.com with SMTP id lf10so25801652pab.5
        for <msysgit@googlegroups.com>; Fri, 16 Jan 2015 10:38:43 -0800 (PST)
X-Received: by 10.70.128.15 with SMTP id nk15mr24172184pdb.121.1421433523618;
        Fri, 16 Jan 2015 10:38:43 -0800 (PST)
Received: from [172.16.16.105] (ip72-192-173-141.sd.sd.cox.net. [72.192.173.141])
        by mx.google.com with ESMTPSA id kl7sm4738123pdb.10.2015.01.16.10.38.42
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 16 Jan 2015 10:38:43 -0800 (PST)
In-Reply-To: <20150116091648.GA2450@peff.net>
X-Mauler: Craptastic (2.936)
X-Original-Sender: mackyle@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of mackyle@gmail.com designates 2607:f8b0:400e:c03::22e
 as permitted sender) smtp.mail=mackyle@gmail.com;       dkim=pass
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262557>

On Jan 16, 2015, at 01:16, Jeff King wrote:

> Subject: [PATCH] t/lib-httpd: switch SANITY check for NOT_ROOT
[...]
> We implement NOT_ROOT by checking `id -u`, which is in POSIX
> and seems to be available even on MSYS.  Note that we cannot
> just call this "ROOT" and ask for "!ROOT". The possible
> outcomes are:
>
>  1. we know we are root
>
>  2. we know we are not root
>
>  3. we could not tell, because `id` was not available
>
> We should conservatively treat (3) as "does not have the
> prerequisite", which means that a naive negation would not
> work.
[...]
> +
> +test_lazy_prereq NOT_ROOT '
> +	uid=$(id -u) &&
> +	test "$uid" != 0
> +'

That looks good to me and worked as expected when I tried it.

-Kyle

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
