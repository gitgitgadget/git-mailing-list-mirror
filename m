From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH] Do not call built-in aliases from scripts
Date: Fri, 28 Jun 2013 22:23:14 +0200
Message-ID: <CAHGBnuOE6vYzM2bKs2SV1qJVoCOX=t-XWnd_Xbs1JRD+sY4dVQ@mail.gmail.com>
References: <CAHGBnuNUjaWH2UDsa6jGjf32M+b8-iezw4pKXR985mROFSLOKQ@mail.gmail.com>
	<alpine.DEB.1.00.1306272030291.28957@s15462909.onlinehome-server.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git Mailing List <git@vger.kernel.org>, msysGit Mailinglist <msysgit@googlegroups.com>, 
	Thomas Braun <thomas.braun@virtuell-zuhause.de>, 
	Pat Thoyts <patthoyts@users.sourceforge.net>, Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: msysgit+bncBDZMLEGXWQLBBM7BW6HAKGQEH7JRILQ@googlegroups.com Fri Jun 28 22:23:17 2013
Return-path: <msysgit+bncBDZMLEGXWQLBBM7BW6HAKGQEH7JRILQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-lb0-f188.google.com ([209.85.217.188])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDZMLEGXWQLBBM7BW6HAKGQEH7JRILQ@googlegroups.com>)
	id 1UsfCN-00065T-Uj
	for gcvm-msysgit@m.gmane.org; Fri, 28 Jun 2013 22:23:15 +0200
Received: by mail-lb0-f188.google.com with SMTP id x10sf288009lbi.25
        for <gcvm-msysgit@m.gmane.org>; Fri, 28 Jun 2013 13:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=x-beenthere:mime-version:in-reply-to:references:date:message-id
         :subject:from:to:cc:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type;
        bh=eDIlODcbI3iQn5PqoBnU6SXlI/eMrT7o19aGLSPEnMU=;
        b=H84dJmR9Mpn9ot9EePM1trBW0bRXiBmgCSwQ4m0Jxs7X3pOKVjAuE3Tu/LIwsvcTGQ
         drZMtw+2dyMkXcznbrRdVusvE+Th0YhRnV71RTmCqoYFHkM7xuWUkqcSjXBs2Cz27M7C
         M3XhuFIzaiH67LgIpv/kt9oYWwJXGxbtuTo0qsXPpWqz/FTIqSf6yQ7P7bp8hIY+k0yY
         24L7ZhK38rwsblqgcacrCD/PtF1HaGnmh8QxEQ2ACtDEdb8f8mNe6VtRCqU4xz01UzqK
         xIOQdgPIboDPg0hdX4ywvVHalCYlg91ce83epxH9MtYyboEZDD00z2Md5pjtDF8sZ6RR
         eCWQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-beenthere:mime-version:in-reply-to:references:date:message-id
         :subject:from:to:cc:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type;
        bh=eDIlODcbI3iQn5PqoBnU6SXlI/eMrT7o19aGLSPEnMU=;
        b=Yh1RCd4Al3Zbd8tyRuirBzccAucAz/UfAnX0kYgYt9BkXSW89qNoOQlCOZU1kvGhab
         TrIkw+OEbFQSimTfiF6PwSiYLflys3LmBRc7E7Bsc1i9IuIYujqtby3Y8dvT3WId4uHf
         1My0Wo72QNTje9BLJiNgGA0ywQpq6mCEE/1LViuzD/t3FgZ2DMb+IE3QGdd5CWTWYasu
         ff41yVeNN0bXGGZbM6mt3VXZIS0Nni4BDiUG3rSBemrZX+2Vg8jKMsZPZ5hs+BnZWPg5
         wvz6rISXMxcnq+9BT9XF1wh1xVMmIENdnT9iW8C6AKLG01mt1UUC23hT8cxShgPNTUSN
         2nxA==
X-Received: by 10.180.160.229 with SMTP id xn5mr189282wib.14.1372450995478;
        Fri, 28 Jun 2013 13:23:15 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.36.132 with SMTP id q4ls282084wij.2.canary; Fri, 28 Jun
 2013 13:23:14 -0700 (PDT)
X-Received: by 10.204.240.14 with SMTP id ky14mr1292897bkb.0.1372450994825;
        Fri, 28 Jun 2013 13:23:14 -0700 (PDT)
Received: from mail-la0-x235.google.com (mail-la0-x235.google.com [2a00:1450:4010:c03::235])
        by gmr-mx.google.com with ESMTPS id cx8si380633bkb.0.2013.06.28.13.23.14
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 28 Jun 2013 13:23:14 -0700 (PDT)
Received-SPF: pass (google.com: domain of sschuberth@gmail.com designates 2a00:1450:4010:c03::235 as permitted sender) client-ip=2a00:1450:4010:c03::235;
Received: by mail-la0-f53.google.com with SMTP id fs12so2567687lab.40
        for <msysgit@googlegroups.com>; Fri, 28 Jun 2013 13:23:14 -0700 (PDT)
X-Received: by 10.112.173.161 with SMTP id bl1mr4266661lbc.51.1372450994464;
 Fri, 28 Jun 2013 13:23:14 -0700 (PDT)
Received: by 10.114.16.161 with HTTP; Fri, 28 Jun 2013 13:23:14 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.1306272030291.28957@s15462909.onlinehome-server.info>
X-Original-Sender: sschuberth@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of sschuberth@gmail.com designates 2a00:1450:4010:c03::235
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229233>

On Thu, Jun 27, 2013 at 8:52 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:

>> --- a/git-merge-octopus.sh
>> +++ b/git-merge-octopus.sh
>> @@ -97,7 +97,7 @@ do
>>       if test $? -ne 0
>>       then
>>               echo "Simple merge did not work, trying automatic merge."
>> -             git-merge-index -o git-merge-one-file -a ||
>> +             git merge-index -o git-merge-one-file -a ||
>
> This is a problem. 'git-merge-one-file' cannot be split here AFAICT.
>
> Of course, we could teach merge-index to read *two* parameters instead of
> one when it encounters "git" as the <merge-program>. But that would be as
> hacky as the whole dashed-form business to begin with.

I agree to all of your comments except this one: I did not split
'git-merge-one-file' here ...

>> diff --git a/git-merge-resolve.sh b/git-merge-resolve.sh
>> index c9da747..343fe7b 100755
>> --- a/git-merge-resolve.sh
>> +++ b/git-merge-resolve.sh
>> @@ -45,7 +45,7 @@ then
>>       exit 0
>>  else
>>       echo "Simple merge failed, trying Automatic merge."
>> -     if git-merge-index -o git-merge-one-file -a
>> +     if git merge-index -o git-merge-one-file -a
>
> As above, with -octopus.

Sorry, I can't follow you here.

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
