From: John Szakmeister <john@szakmeister.net>
Subject: Re: [PATCH] Do not call built-in aliases from scripts
Date: Thu, 27 Jun 2013 14:02:27 -0400
Message-ID: <CAEBDL5VL+C7yKMBq1g4vSrSSsvrKE+FCeoS66mkWQqJJvf0sWA@mail.gmail.com>
References: <CAHGBnuNUjaWH2UDsa6jGjf32M+b8-iezw4pKXR985mROFSLOKQ@mail.gmail.com>
	<7vzjubtty7.fsf@alter.siamese.dyndns.org>
	<CAHGBnuPc+vDwejFOF_o+jr+L_mgrVo=Uxs2vC6C-Feg_uxWPpA@mail.gmail.com>
	<7v8v1vtqfa.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Sebastian Schuberth <sschuberth@gmail.com>, Git Mailing List <git@vger.kernel.org>, 
	msysGit Mailinglist <msysgit@googlegroups.com>, Thomas Braun <thomas.braun@virtuell-zuhause.de>, 
	Pat Thoyts <patthoyts@users.sourceforge.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: msysgit+bncBDMK3Q7TZUGRBNH4WGHAKGQET4IJJCA@googlegroups.com Thu Jun 27 20:02:32 2013
Return-path: <msysgit+bncBDMK3Q7TZUGRBNH4WGHAKGQET4IJJCA@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-la0-f62.google.com ([209.85.215.62])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDMK3Q7TZUGRBNH4WGHAKGQET4IJJCA@googlegroups.com>)
	id 1UsGWd-0006KH-FY
	for gcvm-msysgit@m.gmane.org; Thu, 27 Jun 2013 20:02:31 +0200
Received: by mail-la0-f62.google.com with SMTP id ej20sf269938lab.17
        for <gcvm-msysgit@m.gmane.org>; Thu, 27 Jun 2013 11:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=x-beenthere:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-google-group-id:list-post:list-help:list-archive:list-subscribe
         :list-unsubscribe:content-type;
        bh=md9uNxyufEp1mUu7Mph+G1R05EGiNb9D8+qag26o/Pk=;
        b=ICtd8R3laTP3tmYC9kT7ozAdtxQtZutNsqXzEZmBo0FLqc5lpnu7ekNvJjBG+kfBMX
         8rg+GIYuI+peRx7PFozT3J1VMq2FSd5lOLEYBIk9n6Rk61JmrgGzWeskcjSEdXO6e0yr
         tUrTdm4bUsW83pZ2FMYhLZVTka3EXmZKus1USWoooNq9bb/EJ6icCoDuLWFruREB3wiR
         Ge+DCu7LT230wPFKjwBNzoY2/qU+jqDk8Qg+Pf+d79q0evJpqWMfAorC6bq0u1t/lmOU
         FSlczn5lqK/Lcl26nyfQQkGo/CixXJM5Xv7lfEG9nWk8asMLdXKrv3R6H+AJC+X6Flgb
         /4ZQ==
X-Received: by 10.180.105.73 with SMTP id gk9mr825394wib.15.1372356150920;
        Thu, 27 Jun 2013 11:02:30 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.98.233 with SMTP id el9ls1146wib.40.canary; Thu, 27 Jun
 2013 11:02:27 -0700 (PDT)
X-Received: by 10.180.187.229 with SMTP id fv5mr1054156wic.6.1372356147830;
        Thu, 27 Jun 2013 11:02:27 -0700 (PDT)
Received: from mail-wg0-x231.google.com (mail-wg0-x231.google.com [2a00:1450:400c:c00::231])
        by gmr-mx.google.com with ESMTPS id ct9si573483wib.1.2013.06.27.11.02.27
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 27 Jun 2013 11:02:27 -0700 (PDT)
Received-SPF: pass (google.com: domain of jszakmeister@gmail.com designates 2a00:1450:400c:c00::231 as permitted sender) client-ip=2a00:1450:400c:c00::231;
Received: by mail-wg0-x231.google.com with SMTP id a12so855562wgh.16
        for <msysgit@googlegroups.com>; Thu, 27 Jun 2013 11:02:27 -0700 (PDT)
X-Received: by 10.194.103.73 with SMTP id fu9mr7101532wjb.70.1372356147587;
 Thu, 27 Jun 2013 11:02:27 -0700 (PDT)
Sender: msysgit@googlegroups.com
Received: by 10.180.144.37 with HTTP; Thu, 27 Jun 2013 11:02:27 -0700 (PDT)
In-Reply-To: <7v8v1vtqfa.fsf@alter.siamese.dyndns.org>
X-Original-Sender: jszakmeister@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of jszakmeister@gmail.com designates 2a00:1450:400c:c00::231
 as permitted sender) smtp.mail=jszakmeister@gmail.com;       dkim=pass header.i=@gmail.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit>
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229136>

On Thu, Jun 27, 2013 at 1:27 PM, Junio C Hamano <gitster@pobox.com> wrote:
[snip]
>> diff --git a/git-am.sh b/git-am.sh
>> index 9f44509..ad67194 100755
>> --- a/git-am.sh
>> +++ b/git-am.sh
>> @@ -16,8 +16,8 @@ s,signoff       add a Signed-off-by line to the commit message
>>  u,utf8          recode into utf8 (default)
>>  k,keep          pass -k flag to git-mailinfo
>>  keep-non-patch  pass -b flag to git-mailinfo
>> -keep-cr         pass --keep-cr flag to git-mailsplit for mbox format
>> -no-keep-cr      do not pass --keep-cr flag to git-mailsplit
>> independent of am.keepcr
>> +keep-cr         pass --keep-cr flag to git mailsplit for mbox format
>> +no-keep-cr      do not pass --keep-cr flag to git mailsplit
>> independent of am.keepcr
>>  c,scissors      strip everything before a scissors line
>>  whitespace=     pass it through git-apply
>>  ignore-space-change pass it through git-apply
>
>> As you were saying yourself, we tell users to prefer the "git foo"
>> form, so we should also do so in the "git am" option help, IMHO.
>
> What does the above change to the options-help have anything to do
> with that theme?  It does not seem to say anything about "git foo"
> vs "git-foo"?

I initially missed it too, but `git-mailsplit` changed to `git
mailsplit` in the help.  Now that I look at it more, I see that
`git-mailinfo` was missed and there's a `git-apply` towards the
bottom.  So I'm not sure it's helping the consistency argument.

-John

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
