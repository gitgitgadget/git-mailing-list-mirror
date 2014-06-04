From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] Add a Windows-specific fallback to getenv("HOME");
Date: Wed, 4 Jun 2014 20:47:58 +0700
Message-ID: <CACsJy8BDk4gdRzjp_XpQXXMW1sEnS4DoedanFLONODuJXdeeRA@mail.gmail.com>
References: <20140604114730.GB22250@camelia.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: GIT Mailing-list <git@vger.kernel.org>, Thomas Braun <thomas.braun@virtuell-zuhause.de>, 
	msysGit <msysgit@googlegroups.com>
To: Stepan Kasal <kasal@ucw.cz>
X-From: msysgit+bncBC2ZN5PHQUMBBLOHXSOAKGQEBYORY2Y@googlegroups.com Wed Jun 04 15:48:32 2014
Return-path: <msysgit+bncBC2ZN5PHQUMBBLOHXSOAKGQEBYORY2Y@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-qa0-f59.google.com ([209.85.216.59])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBC2ZN5PHQUMBBLOHXSOAKGQEBYORY2Y@googlegroups.com>)
	id 1WsBYM-0000PV-Ac
	for gcvm-msysgit@m.gmane.org; Wed, 04 Jun 2014 15:48:30 +0200
Received: by mail-qa0-f59.google.com with SMTP id hw13sf1363620qab.24
        for <gcvm-msysgit@m.gmane.org>; Wed, 04 Jun 2014 06:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:x-original-sender:x-original-authentication-results:precedence
         :mailing-list:list-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type;
        bh=aymzTHWi6IIaSrOuxCRMxFFwidqiV45dcVkXPbgPL+0=;
        b=VTJpV9VDwDabhlev1GkvJZgACYbvgmoW7ZPVMyIwdCG2bAMu5T5dM6bA/2DbG149U9
         JvHjD8NDE0/cMAcsvOedhCjaU6WZCt77kH/xZJCXRc4n6Lw73XL+5xw75qqcpFl+gZRE
         vpjLrKJaq9TH4u6wGLYDasVUjqGOS+kr43K8Jk48IdXzoc1U4rdKKimW0uOAcqxXNhm+
         eC0eFt6ygCz/1s/K9p3zVTuimbs5jgGab+t4Y57Nhz/Toujw4nKXTUILtBngwIL4KxFC
         1QCCv6CtJkKSGM/wPIq4QPsgS9Dsgv2AiKmKsdPHCGCl6r7LrS6+4a3a/zSp9dx4DksF
         h/7A==
X-Received: by 10.140.100.204 with SMTP id s70mr326934qge.9.1401889709555;
        Wed, 04 Jun 2014 06:48:29 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.140.108.4 with SMTP id i4ls3015903qgf.78.gmail; Wed, 04 Jun
 2014 06:48:28 -0700 (PDT)
X-Received: by 10.236.138.113 with SMTP id z77mr17983548yhi.25.1401889708910;
        Wed, 04 Jun 2014 06:48:28 -0700 (PDT)
Received: from mail-qa0-x22c.google.com (mail-qa0-x22c.google.com [2607:f8b0:400d:c00::22c])
        by gmr-mx.google.com with ESMTPS id x7si751844qcd.3.2014.06.04.06.48.28
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 04 Jun 2014 06:48:28 -0700 (PDT)
Received-SPF: pass (google.com: domain of pclouds@gmail.com designates 2607:f8b0:400d:c00::22c as permitted sender) client-ip=2607:f8b0:400d:c00::22c;
Received: by mail-qa0-f44.google.com with SMTP id j7so7020674qaq.31
        for <msysgit@googlegroups.com>; Wed, 04 Jun 2014 06:48:28 -0700 (PDT)
X-Received: by 10.140.92.200 with SMTP id b66mr66429172qge.41.1401889708792;
 Wed, 04 Jun 2014 06:48:28 -0700 (PDT)
Received: by 10.96.66.129 with HTTP; Wed, 4 Jun 2014 06:47:58 -0700 (PDT)
In-Reply-To: <20140604114730.GB22250@camelia.ucw.cz>
X-Original-Sender: pclouds@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of pclouds@gmail.com designates 2607:f8b0:400d:c00::22c
 as permitted sender) smtp.mail=pclouds@gmail.com;       dkim=pass
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250727>

On Wed, Jun 4, 2014 at 6:47 PM, Stepan Kasal <kasal@ucw.cz> wrote:
> @@ -133,7 +133,7 @@ char *git_path(const char *fmt, ...)
>  void home_config_paths(char **global, char **xdg, char *file)
>  {
>         char *xdg_home = getenv("XDG_CONFIG_HOME");
> -       char *home = getenv("HOME");
> +       const char *home = get_home_directory();
>         char *to_free = NULL;
>
>         if (!home) {

Just checking. Instead of replace the call sites, can we check and
setenv("HOME") if it's missing instead? MinGW port already replaces
main(). Extra initialization should not be a problem. I feel
"getenv("HOME")" a tiny bit more familiar than get_home_directory(),
but that's really weak argument as the number of call sites has not
increased in 4 years.
-- 
Duy

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
