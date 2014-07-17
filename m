From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/6] MinGW: Skip test redirecting to fd 4
Date: Thu, 17 Jul 2014 22:06:41 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.1407172205390.3456@s15462909.onlinehome-server.info>
References: <20140716092959.GA378@ucw.cz> <1405611425-10009-1-git-send-email-kasal@ucw.cz> <1405611425-10009-2-git-send-email-kasal@ucw.cz> <xmqqbnsnq14j.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Cc: Stepan Kasal <kasal@ucw.cz>, Karsten Blees <karsten.blees@gmail.com>, 
    Johannes Sixt <j6t@kdbg.org>, GIT Mailing-list <git@vger.kernel.org>, 
    msysGit <msysgit@googlegroups.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: msysgit+bncBCZPH74Q5YNRBVOZUCPAKGQELFJJBPY@googlegroups.com Thu Jul 17 22:06:46 2014
Return-path: <msysgit+bncBCZPH74Q5YNRBVOZUCPAKGQELFJJBPY@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wg0-f59.google.com ([74.125.82.59])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCZPH74Q5YNRBVOZUCPAKGQELFJJBPY@googlegroups.com>)
	id 1X7rx0-0008Ty-GO
	for gcvm-msysgit@m.gmane.org; Thu, 17 Jul 2014 22:06:46 +0200
Received: by mail-wg0-f59.google.com with SMTP id a1sf307216wgh.14
        for <gcvm-msysgit@m.gmane.org>; Thu, 17 Jul 2014 13:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=DnCNPN4sVlIknKxwaXHGayKEcWmwqXM90/+XCcOPmZM=;
        b=rh+o/6tOmAEZb4f8Rq7zFlShv0k9G0s3FNBhUIke/N42B8iVmEs+tqGHQqHjEO8Wr5
         Wi8EkOrzkUlFHHMungV+DaosPUW7QH9DrB6qXmC4w1B5MgRDEiyLGM8W55yaWdbmLyTR
         4tgXpR5HeUatN5UbJqFjH6DznSCWMdyNzhcZwMalcVXu9Zl0Mz0/nO1goHWF9uMY8GCq
         XgLH9sAsu4Q/NRSRrKOGpIus/jUXdMS3LxhYEDuviV7f1Y8dNzIzEE66rT/ibqo5veGm
         zz13zmJEkLPo4jeg4rrw1w2ZuJxQaewLnK6bIakDcddo7RkklOekBfRrH+JXXU8CgC7f
         sPdw==
X-Received: by 10.152.37.8 with SMTP id u8mr24080laj.24.1405627606229;
        Thu, 17 Jul 2014 13:06:46 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.36.133 with SMTP id q5ls208587laj.77.gmail; Thu, 17 Jul
 2014 13:06:45 -0700 (PDT)
X-Received: by 10.112.144.131 with SMTP id sm3mr307340lbb.18.1405627605495;
        Thu, 17 Jul 2014 13:06:45 -0700 (PDT)
Received: from mout.gmx.net (mout.gmx.net. [212.227.17.21])
        by gmr-mx.google.com with ESMTPS id d9si415768wie.3.2014.07.17.13.06.45
        for <msysgit@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jul 2014 13:06:45 -0700 (PDT)
Received-SPF: pass (google.com: domain of Johannes.Schindelin@gmx.de designates 212.227.17.21 as permitted sender) client-ip=212.227.17.21;
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx102) with ESMTPSA (Nemesis) id 0MYtId-1X4LhK2pNb-00VjRC;
 Thu, 17 Jul 2014 22:06:41 +0200
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <xmqqbnsnq14j.fsf@gitster.dls.corp.google.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:ykQynSNIeiuzWf3hurX5FDwRo3n4N8Gr+/YDoyEw6ZGd347eAjd
 vIw11/zS7zKvvUro5EkmjWOpLaK0wMG4LivyVbgMJu7QJhUTbFqmb9tAq13VlB/VlhVuQyG
 kORg9QkIpWZF+EuAmAcRjQ+6xyrqJRiRCrS5QGU96ePAAsokHavVczMXBk6hMa5OYrZt6bv
 RuE9C+dARONS9iWz/68eQ==
X-Original-Sender: johannes.schindelin@gmx.de
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of Johannes.Schindelin@gmx.de designates 212.227.17.21 as
 permitted sender) smtp.mail=Johannes.Schindelin@gmx.de
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253777>

Hi Junio,

On Thu, 17 Jul 2014, Junio C Hamano wrote:

> Is what is broken on MinGW redirecting arbitrary file descrptors?

IIRC that was exactly the problem.

> diff --git a/t/t0081-line-buffer.sh b/t/t0081-line-buffer.sh
> index bd83ed3..881789a 100755
> --- a/t/t0081-line-buffer.sh
> +++ b/t/t0081-line-buffer.sh
> @@ -34,7 +34,6 @@ test_expect_success 'read from file descriptor' '
>  	echo hello >expect &&
>  	echo hello >input &&
> -	echo copy 6 |
> -	test-line-buffer "&4" 4<input >actual &&
> +	test-line-buffer "&0" <input >actual &&
>  	test_cmp expect actual
>  '

I will test this later, and also try to wrap my head around the details of
the problem.

Thank you so much!
Johannes

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
