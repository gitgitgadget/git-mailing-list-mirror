From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Remove the line length limit for graft files
Date: Fri, 27 Dec 2013 13:59:19 -0800
Message-ID: <20131227215919.GF20443@google.com>
References: <alpine.DEB.1.00.1312272146590.1191@s15462909.onlinehome-server.info>
 <20131227210447.GE20443@google.com>
 <alpine.DEB.1.00.1312272208070.1191@s15462909.onlinehome-server.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, msysgit@googlegroups.com, gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: msysgit+bncBD6LRKOE4AIRBOXQ66KQKGQEZIFLD7I@googlegroups.com Fri Dec 27 22:59:24 2013
Return-path: <msysgit+bncBD6LRKOE4AIRBOXQ66KQKGQEZIFLD7I@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-vb0-f61.google.com ([209.85.212.61])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBD6LRKOE4AIRBOXQ66KQKGQEZIFLD7I@googlegroups.com>)
	id 1VwfRD-0007RE-Oj
	for gcvm-msysgit@m.gmane.org; Fri, 27 Dec 2013 22:59:23 +0100
Received: by mail-vb0-f61.google.com with SMTP id w20sf2121242vbb.16
        for <gcvm-msysgit@m.gmane.org>; Fri, 27 Dec 2013 13:59:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :in-reply-to:user-agent:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type:content-disposition;
        bh=PYJ40uGVXDArn1EUvaoM9cHMJLg9ZRKDonwz5zV0JQc=;
        b=BNK4NUTJHn7A1PqaXMDtbdu7tcRBIllHvJlxiyVSywK8VcWYOXM7ZbJUX44W6FtO6i
         76XVsmD4gLBB+UUEeQEFuF8C6kFEuf9kTjAbFxd6D5vsgVr8ziaPZEwmmDjy7LNaHil5
         MeE6jNfj6xhFAep888ntby35nniU7aKkA6KLX5laHM9oX2qTwnUNZEaaBsqGq4sdpx1z
         InZFbmK2eeG+X+/F7Uosyxk32q2N/JgrQ87IyFRzErI5CFtqdbkgVqQDznqzsOB0pp8L
         rsX5S8ahtZYwXM10WnJPsoZChYAX5z5kuNzGCxEBpLxcnF6ztjUiSxpgEAPsW12dmEV2
         VqRg==
X-Received: by 10.50.79.228 with SMTP id m4mr768170igx.9.1388181562962;
        Fri, 27 Dec 2013 13:59:22 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.50.79.193 with SMTP id l1ls2522199igx.8.canary; Fri, 27 Dec
 2013 13:59:22 -0800 (PST)
X-Received: by 10.66.240.4 with SMTP id vw4mr20028540pac.10.1388181562424;
        Fri, 27 Dec 2013 13:59:22 -0800 (PST)
Received: from mail-gg0-x234.google.com (mail-gg0-x234.google.com [2607:f8b0:4002:c02::234])
        by gmr-mx.google.com with ESMTPS id o30si11276186yhn.1.2013.12.27.13.59.22
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 27 Dec 2013 13:59:22 -0800 (PST)
Received-SPF: pass (google.com: domain of jrnieder@gmail.com designates 2607:f8b0:4002:c02::234 as permitted sender) client-ip=2607:f8b0:4002:c02::234;
Received: by mail-gg0-x234.google.com with SMTP id k1so1954651gga.25
        for <msysgit@googlegroups.com>; Fri, 27 Dec 2013 13:59:22 -0800 (PST)
X-Received: by 10.236.135.172 with SMTP id u32mr9734160yhi.107.1388181562229;
        Fri, 27 Dec 2013 13:59:22 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id m29sm48374651yho.14.2013.12.27.13.59.21
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 27 Dec 2013 13:59:21 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.1312272208070.1191@s15462909.onlinehome-server.info>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Original-Sender: jrnieder@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of jrnieder@gmail.com designates 2607:f8b0:4002:c02::234
 as permitted sender) smtp.mail=jrnieder@gmail.com;       dkim=pass
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
Content-Disposition: inline
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239750>

Johannes Schindelin wrote:

> it returns EOF only if ch == EOF *and* sb->len == 0, i.e. if no characters
> have been read before hitting EOF.

Yep.  api-strbuf.txt even says so.  Sorry for the nonsense.

For what it's worth,
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

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
