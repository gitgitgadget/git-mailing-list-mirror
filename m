From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH] Do not call built-in aliases from scripts
Date: Fri, 28 Jun 2013 22:18:27 +0200
Message-ID: <CAHGBnuPcXaRgtq_LDBHWRXuBHRWsiy4YHy1NjsW5hXe1AyVqCg@mail.gmail.com>
References: <CAHGBnuNUjaWH2UDsa6jGjf32M+b8-iezw4pKXR985mROFSLOKQ@mail.gmail.com>
	<7vzjubtty7.fsf@alter.siamese.dyndns.org>
	<CAHGBnuPc+vDwejFOF_o+jr+L_mgrVo=Uxs2vC6C-Feg_uxWPpA@mail.gmail.com>
	<7v8v1vtqfa.fsf@alter.siamese.dyndns.org>
	<CAEBDL5VL+C7yKMBq1g4vSrSSsvrKE+FCeoS66mkWQqJJvf0sWA@mail.gmail.com>
	<7vmwqbsa3u.fsf@alter.siamese.dyndns.org>
	<7vehbns9vq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: John Szakmeister <john@szakmeister.net>, Git Mailing List <git@vger.kernel.org>, 
	msysGit Mailinglist <msysgit@googlegroups.com>, Thomas Braun <thomas.braun@virtuell-zuhause.de>, 
	Pat Thoyts <patthoyts@users.sourceforge.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: msysgit+bncBDZMLEGXWQLBBFO7W6HAKGQEZ2COZDA@googlegroups.com Fri Jun 28 22:18:30 2013
Return-path: <msysgit+bncBDZMLEGXWQLBBFO7W6HAKGQEZ2COZDA@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-fa0-f59.google.com ([209.85.161.59])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDZMLEGXWQLBBFO7W6HAKGQEZ2COZDA@googlegroups.com>)
	id 1Usf7m-0001x5-GJ
	for gcvm-msysgit@m.gmane.org; Fri, 28 Jun 2013 22:18:30 +0200
Received: by mail-fa0-f59.google.com with SMTP id p1sf540970fap.14
        for <gcvm-msysgit@m.gmane.org>; Fri, 28 Jun 2013 13:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=x-beenthere:mime-version:in-reply-to:references:date:message-id
         :subject:from:to:cc:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type;
        bh=wCSlvzZKj0Tx4LZf3SdcItGb/unvCwGc7DPtGaz8VJc=;
        b=br/Ed3McIQRz+OZSKN7BRAgeB+wsZ15g1hUlP/aV0eZ2DoUfGCNXVmw3MX3ehg8ta4
         KgpB1RGCWwy0b2tpOhUf+rXfAoqOmN+9r+hG6FIsGD+8SJ6VPwzMivjsNmOOJwkol9Bd
         Kz6kFmCfJmSl5SD82brQ7xwEULE4AnlJ6I/qmqfMTSZMwsFIMH4iw9fIRcyMgDiQ9RI3
         nVvgUE6GUCEKLFdQLcLHe274wy4GLjcwOQ028aBq/OB0L2+2SxqDxcwnO1NbUONcHoRV
         i8xA43vRGqaE6ifqZY519Ve3WkiEy5bYDSBM8Yz3pDJ/6KZQKbgWk1Mi1LXStZhfuBsm
         N+lA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-beenthere:mime-version:in-reply-to:references:date:message-id
         :subject:from:to:cc:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type;
        bh=wCSlvzZKj0Tx4LZf3SdcItGb/unvCwGc7DPtGaz8VJc=;
        b=U6BK8tBjrjG7Ht2VIAHsu8ikTGfxHIeNCUNb/ZJPy5a5BAPK6eYMF8J7J54ZDJ1oR9
         AU13DMal5os19kT+EinPdDyJmEPDiNCmpEBboTiiVgZ6F6IGzVg3Hk69rYvjKOeK1b0r
         d9EJmaw9/QspZZNNv3HjTF/Y744OP9GPR+hBa1Sq5ByZVQO2ONAsqJmi7nOQhvIhjvE/
         HDFVPA/3AEqsL0d9sgfEmd0JwPPYuxoL/GigMo7xuXPfwsqah88U6dGYkHIMq5nINEDh
         ZN81mJDel74+EyxPv11Nknn4aq+UDBCCGN1lVbHZVXviGj+UAxPIYimajOICg35BOmDm
         dPYA==
X-Received: by 10.180.160.229 with SMTP id xn5mr188877wib.14.1372450710001;
        Fri, 28 Jun 2013 13:18:30 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.98.166 with SMTP id ej6ls277039wib.41.canary; Fri, 28 Jun
 2013 13:18:28 -0700 (PDT)
X-Received: by 10.204.224.8 with SMTP id im8mr1285973bkb.5.1372450708882;
        Fri, 28 Jun 2013 13:18:28 -0700 (PDT)
Received: from mail-la0-x236.google.com (mail-la0-x236.google.com [2a00:1450:4010:c03::236])
        by gmr-mx.google.com with ESMTPS id b9si379738bkc.1.2013.06.28.13.18.28
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 28 Jun 2013 13:18:28 -0700 (PDT)
Received-SPF: pass (google.com: domain of sschuberth@gmail.com designates 2a00:1450:4010:c03::236 as permitted sender) client-ip=2a00:1450:4010:c03::236;
Received: by mail-la0-f54.google.com with SMTP id ec20so2589898lab.13
        for <msysgit@googlegroups.com>; Fri, 28 Jun 2013 13:18:28 -0700 (PDT)
X-Received: by 10.152.29.41 with SMTP id g9mr7237396lah.44.1372450708565; Fri,
 28 Jun 2013 13:18:28 -0700 (PDT)
Received: by 10.114.16.161 with HTTP; Fri, 28 Jun 2013 13:18:27 -0700 (PDT)
In-Reply-To: <7vehbns9vq.fsf@alter.siamese.dyndns.org>
X-Original-Sender: sschuberth@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of sschuberth@gmail.com designates 2a00:1450:4010:c03::236
 as permitted sender) smtp.mail=sschuberth@gmail.com;       dkim=pass header.i=@gmail.com
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229232>

On Thu, Jun 27, 2013 at 8:10 PM, Junio C Hamano <gitster@pobox.com> wrote:

>>>  Now that I look at it more, I see that
>>> `git-mailinfo` was missed and there's a `git-apply` towards the
>>> bottom.  So I'm not sure it's helping the consistency argument.
>>
>> Hmph, true.
>
> Having said that, I'd still prefer to see documentation changes in a
> patch separate from a "do not call git-foo form" patch.

I'll send a new version of the patch next week to address this and
also use quotes when replacing a hyphenated form in prose.

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
