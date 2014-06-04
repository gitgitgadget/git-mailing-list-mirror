From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: Re: [PATCH] Add a Windows-specific fallback to getenv("HOME");
Date: Wed, 4 Jun 2014 16:05:58 +0200
Message-ID: <CABPQNSYXsu1muRTVUg6ybB9_MJP_wJi-4PmSec+8EwrvsCHMRw@mail.gmail.com>
References: <20140604114730.GB22250@camelia.ucw.cz> <CACsJy8BDk4gdRzjp_XpQXXMW1sEnS4DoedanFLONODuJXdeeRA@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Stepan Kasal <kasal@ucw.cz>, GIT Mailing-list <git@vger.kernel.org>, 
	Thomas Braun <thomas.braun@virtuell-zuhause.de>, msysGit <msysgit@googlegroups.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: msysgit+bncBDR53PPJ7YHRB3WPXSOAKGQE3S2EWVQ@googlegroups.com Wed Jun 04 16:06:41 2014
Return-path: <msysgit+bncBDR53PPJ7YHRB3WPXSOAKGQE3S2EWVQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-pb0-f58.google.com ([209.85.160.58])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDR53PPJ7YHRB3WPXSOAKGQE3S2EWVQ@googlegroups.com>)
	id 1WsBpw-0004iv-H8
	for gcvm-msysgit@m.gmane.org; Wed, 04 Jun 2014 16:06:40 +0200
Received: by mail-pb0-f58.google.com with SMTP id jt11sf2099001pbb.13
        for <gcvm-msysgit@m.gmane.org>; Wed, 04 Jun 2014 07:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=FuGPO/gyCEqCN9pINy53/+8/RDFn4lDvt50cl8MISzg=;
        b=OCh/l6mocxLBj2mei0zIDJiBpWkPLMtcL/lnJDRQzAaNYHiDFKeI63o6L2BhBW6Vv8
         1AsSxpiEngKXlcNP9RN/u1fN7dBxGCA/xv6cwx0hfD+fARVPJdByImU6ioiZHLO6f4+H
         3HHODhIlFl+h6TUJYNFSFNzz3zWI+TGoYVdW9MMMvTG9B9jjd4HDODxhZjYUtI/4mM75
         IPIGDHra4v+S+TGZOiXdAsY7YSIPcW4J63O8bns4//gVb5e9ZoBblZY4U4LrE8YRhSOr
         ywLfoFvo9PrrMtCMyoTv1k3IqYkBOoyinchJA372wNkL05KQReSMWS+vePll/LzX0K8T
         MS2A==
X-Received: by 10.140.109.71 with SMTP id k65mr15432qgf.30.1401890799233;
        Wed, 04 Jun 2014 07:06:39 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.140.19.173 with SMTP id 42ls3010739qgh.27.gmail; Wed, 04 Jun
 2014 07:06:38 -0700 (PDT)
X-Received: by 10.236.123.68 with SMTP id u44mr18516038yhh.19.1401890798687;
        Wed, 04 Jun 2014 07:06:38 -0700 (PDT)
Received: from mail-ie0-x233.google.com (mail-ie0-x233.google.com [2607:f8b0:4001:c03::233])
        by gmr-mx.google.com with ESMTPS id kx2si1534676igb.0.2014.06.04.07.06.38
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 04 Jun 2014 07:06:38 -0700 (PDT)
Received-SPF: pass (google.com: domain of kusmabite@gmail.com designates 2607:f8b0:4001:c03::233 as permitted sender) client-ip=2607:f8b0:4001:c03::233;
Received: by mail-ie0-x233.google.com with SMTP id rd18so7298043iec.38
        for <msysgit@googlegroups.com>; Wed, 04 Jun 2014 07:06:38 -0700 (PDT)
X-Received: by 10.50.78.8 with SMTP id x8mr7509604igw.45.1401890798256; Wed,
 04 Jun 2014 07:06:38 -0700 (PDT)
Received: by 10.64.227.43 with HTTP; Wed, 4 Jun 2014 07:05:58 -0700 (PDT)
In-Reply-To: <CACsJy8BDk4gdRzjp_XpQXXMW1sEnS4DoedanFLONODuJXdeeRA@mail.gmail.com>
X-Original-Sender: kusmabite@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of kusmabite@gmail.com designates 2607:f8b0:4001:c03::233
 as permitted sender) smtp.mail=kusmabite@gmail.com;       dkim=pass
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250729>

On Wed, Jun 4, 2014 at 3:47 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Wed, Jun 4, 2014 at 6:47 PM, Stepan Kasal <kasal@ucw.cz> wrote:
>> @@ -133,7 +133,7 @@ char *git_path(const char *fmt, ...)
>>  void home_config_paths(char **global, char **xdg, char *file)
>>  {
>>         char *xdg_home = getenv("XDG_CONFIG_HOME");
>> -       char *home = getenv("HOME");
>> +       const char *home = get_home_directory();
>>         char *to_free = NULL;
>>
>>         if (!home) {
>
> Just checking. Instead of replace the call sites, can we check and
> setenv("HOME") if it's missing instead? MinGW port already replaces
> main(). Extra initialization should not be a problem. I feel
> "getenv("HOME")" a tiny bit more familiar than get_home_directory(),
> but that's really weak argument as the number of call sites has not
> increased in 4 years.

Yeah. But we already set %HOME% to %HOMEDRIVE%%HOMEPATH% in
/etc/profile, git-cmd.bat, gitk.cmd *and* git-wrapper... Do we really
need one more place?

It seems some of these could be dropped...

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
