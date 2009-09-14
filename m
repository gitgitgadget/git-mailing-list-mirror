From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 07/17] Fix __stdcall/WINAPI placement and
 function prototype
Date: Mon, 14 Sep 2009 22:00:52 +0200
Message-ID: <200909142200.52174.j6t@kdbg.org>
References: <cover.1252925290.git.mstormo@gmail.com> <160ceafba5f58cfcadb13380e3d8ef724009b700.1252925290.git.mstormo@gmail.com> <1d699897d4163224ce22db9400569fab20547e9d.1252925290.git.mstormo@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: msysgit@googlegroups.com, Johannes.Schindelin@gmx.de, git@vger.kernel.org, lznuaa@gmail.com
To: "Marius Storm-Olsen" <mstormo@gmail.com>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Mon Sep 14 22:01:13 2009
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-yw0-f140.google.com ([209.85.211.140])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MnHjc-0000YR-DO
	for gcvm-msysgit@m.gmane.org; Mon, 14 Sep 2009 22:01:12 +0200
Received: by ywh4 with SMTP id 4so9786256ywh.9
        for <gcvm-msysgit@m.gmane.org>; Mon, 14 Sep 2009 13:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received:received-spf:received:received:from:to
         :subject:date:user-agent:cc:references:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :message-id:sender:precedence:x-google-loop:mailing-list:list-id
         :list-post:list-help:list-unsubscribe:x-beenthere-env:x-beenthere;
        bh=/OMvNjUPgPSd5Pe/SJGMRvpe7d4piXFP1pl/suAxOds=;
        b=tA1cTYswbBrJxHvZyt+hytdTXMhi6bn9a47cMxBoWnH+4rSJJUXkE9A5f8opcehDEn
         Ku0H2HqErlr3mHBmSPYAPZ5LYie+/YpAA54HmZ64TdeOlbE0NQxKcwmAACEIWqqFRZSm
         ww2Ezfm1EfVG5l22JIBV/l1Cw3GqMGhJmqkZo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results:from
         :to:subject:date:user-agent:cc:references:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :message-id:sender:precedence:x-google-loop:mailing-list:list-id
         :list-post:list-help:list-unsubscribe:x-beenthere-env:x-beenthere;
        b=xEpJMKB5ZlBbf9rRxGo8+GiKapZ+rJbPl8sla4+DZGB8sY3QdVc2FMFj1WNnXGYSP2
         0yxU4UZgyq2lhFc6z6FCXTXOKsgF1uZ6cUqPK9vy3JEws/3gbSAQrjPwigWeLPPUioe6
         4pgYG/yDp/SEC9IGAA2PK5vGQDhYxZk/AoHbY=
Received: by 10.101.90.16 with SMTP id s16mr1578747anl.9.1252958465221;
        Mon, 14 Sep 2009 13:01:05 -0700 (PDT)
Received: by 10.176.233.14 with SMTP id f14gr7001yqh.0;
	Mon, 14 Sep 2009 13:00:55 -0700 (PDT)
X-Sender: j6t@kdbg.org
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.210.3.25 with SMTP id 25mr1219597ebc.14.1252958453531; Mon, 14 Sep 2009 13:00:53 -0700 (PDT)
Received: by 10.210.3.25 with SMTP id 25mr1219595ebc.14.1252958453297; Mon, 14 Sep 2009 13:00:53 -0700 (PDT)
Received: from bsmtp.bon.at (bsmtp.bon.at [213.33.87.14]) by gmr-mx.google.com with ESMTP id 16si1381164ewy.7.2009.09.14.13.00.53; Mon, 14 Sep 2009 13:00:53 -0700 (PDT)
Received-SPF: neutral (google.com: 213.33.87.14 is neither permitted nor denied by best guess record for domain of j6t@kdbg.org) client-ip=213.33.87.14;
Authentication-Results: gmr-mx.google.com; spf=neutral (google.com: 213.33.87.14 is neither permitted nor denied by best guess record for domain of j6t@kdbg.org) smtp.mail=j6t@kdbg.org
Received: from dx.sixt.local (unknown [93.83.142.38]) by bsmtp.bon.at (Postfix) with ESMTP id 8242ACDF88; Mon, 14 Sep 2009 22:00:52 +0200 (CEST)
Received: from localhost (localhost [IPv6:::1]) by dx.sixt.local (Postfix) with ESMTP id 465885BA98; Mon, 14 Sep 2009 22:00:52 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <1d699897d4163224ce22db9400569fab20547e9d.1252925290.git.mstormo@gmail.com>
Content-Disposition: inline
Sender: msysgit@googlegroups.com
Precedence: bulk
X-Google-Loop: groups
Mailing-List: list msysgit@googlegroups.com;
	contact msysgit+owner@googlegroups.com
List-Id: <msysgit.googlegroups.com>
List-Post: <mailto:msysgit@googlegroups.com>
List-Help: <mailto:msysgit+help@googlegroups.com>
List-Unsubscribe: <http://googlegroups.com/group/msysgit/subscribe>,
	<mailto:msysgit+unsubscribe@googlegroups.com>
X-BeenThere-Env: msysgit@googlegroups.com
X-BeenThere: msysgit@googlegroups.com
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128497>


On Montag, 14. September 2009, Marius Storm-Olsen wrote:
> WINAPI is a macro which translates into the proper calling convention, so
> replace __stdcall with that.

I've already pointed out elsewhere that the documentation of _beginthreadex 
explicitly says that the calling convention of the function pointer must be 
__stdcall. It does not mention WINAPI. Therefore, I think that these two 
changes are not correct:

> -static __stdcall unsigned ticktack(void *dummy)
> +static unsigned WINAPI ticktack(void *dummy)

> -static __stdcall unsigned run_thread(void *data)
> +static unsigned WINAPI run_thread(void *data)

You should s/WINAPI/__stdcall/.

-- Hannes
