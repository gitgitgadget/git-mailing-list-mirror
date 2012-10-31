From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: pre-receive hook output invalid characters
Date: Wed, 31 Oct 2012 17:31:44 +0100
Message-ID: <CABPQNSb0pWAwwrZ5LvOY2agdEa+MXPMvg+kFa1vODhXf6efAZw@mail.gmail.com>
References: <1b3d3eb1-ed6c-4d03-8fdb-bf2ba2163647@googlegroups.com>
 <CABPQNSYj1-aaQieztkLxZjOhBQMqBJy+9POcmMcjGO4-a=EM9Q@mail.gmail.com> <CABPQNSZqNyKvFKoG6E0+JDaaNnUbWCaFH-WfKE1MicwDH-3TFA@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Michael Naumov <mnaoumov@gmail.com>, msysgit@googlegroups.com
To: GIT Mailing-list <git@vger.kernel.org>
X-From: msysgit+bncBDR53PPJ7YHRBGNFYWCAKGQEHKQ556I@googlegroups.com Wed Oct 31 17:32:39 2012
Return-path: <msysgit+bncBDR53PPJ7YHRBGNFYWCAKGQEHKQ556I@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-gh0-f186.google.com ([209.85.160.186])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDR53PPJ7YHRBGNFYWCAKGQEHKQ556I@googlegroups.com>)
	id 1TTbDW-0007cX-KE
	for gcvm-msysgit@m.gmane.org; Wed, 31 Oct 2012 17:32:34 +0100
Received: by mail-gh0-f186.google.com with SMTP id f18sf1036793ghb.3
        for <gcvm-msysgit@m.gmane.org>; Wed, 31 Oct 2012 09:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=x-beenthere:received-spf:mime-version:reply-to:in-reply-to
         :references:from:date:message-id:subject:to:cc:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type;
        bh=Dqt3p8ndz0AzhAT7lYMyk+VHMQ864D2097kiYYwjj/I=;
        b=sH4q2+dFR9j80Od8QSi2/0CuM2Mnor+DFwN9rhfso78/d9yv9hLaCKP/zKnAO2Q4bn
         PdacY5ed/bqJ0wOBsgE9iMH0rkioRDs22iIVZ3zxXtiG3LWxU3tpHZapsEkdUBJA95GE
         yA7mBuSf93YjXdA0+y418u+5Z+Uzo2gTtPRtKa8ur7ZmsyDTAIDItgzOsn0RZfJXBqZb
         mPCwyhPM5gcdEtrtEFjnUaN46DbM+6GbC/FHoJGjjINIM0kSjAlO13Rpxq/9WAfstqei
         PlkM4wzhRzMR2Exn1MfuarGnlaNgtHXPTgVnfd3b/B/SYnqlJosHCBM5sSAiLE5h5lh6
         b+4Q==
Received: by 10.52.34.205 with SMTP id b13mr6859527vdj.3.1351701145785;
        Wed, 31 Oct 2012 09:32:25 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.220.108.198 with SMTP id g6ls1216084vcp.1.gmail; Wed, 31 Oct
 2012 09:32:25 -0700 (PDT)
Received: by 10.52.72.100 with SMTP id c4mr11736648vdv.5.1351701145236;
        Wed, 31 Oct 2012 09:32:25 -0700 (PDT)
Received: by 10.52.72.100 with SMTP id c4mr11736647vdv.5.1351701145225;
        Wed, 31 Oct 2012 09:32:25 -0700 (PDT)
Received: from mail-vb0-f53.google.com (mail-vb0-f53.google.com [209.85.212.53])
        by gmr-mx.google.com with ESMTPS id q19si556210vds.3.2012.10.31.09.32.25
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 31 Oct 2012 09:32:25 -0700 (PDT)
Received-SPF: pass (google.com: domain of kusmabite@gmail.com designates 209.85.212.53 as permitted sender) client-ip=209.85.212.53;
Received: by mail-vb0-f53.google.com with SMTP id fc21so1949432vbb.12
        for <msysgit@googlegroups.com>; Wed, 31 Oct 2012 09:32:25 -0700 (PDT)
Received: by 10.58.162.130 with SMTP id ya2mr63890220veb.2.1351701144825; Wed,
 31 Oct 2012 09:32:24 -0700 (PDT)
Received: by 10.58.169.106 with HTTP; Wed, 31 Oct 2012 09:31:44 -0700 (PDT)
In-Reply-To: <CABPQNSZqNyKvFKoG6E0+JDaaNnUbWCaFH-WfKE1MicwDH-3TFA@mail.gmail.com>
X-Original-Sender: kusmabite@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com:
 domain of kusmabite@gmail.com designates 209.85.212.53 as permitted sender)
 smtp.mail=kusmabite@gmail.com; dkim=pass header.i=@gmail.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post?hl=en>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/?hl=en>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit?hl=en>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en>, <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208839>

Sorry for resending, but the previous version got dropped from the
main git mailing list due to a HTML-subpart. Converted to plain-text.

On Wed, Oct 31, 2012 at 4:45 PM, Erik Faye-Lund <kusmabite@gmail.com> wrote:
>
> On Wed, Oct 31, 2012 at 4:24 PM, <mnaoumov@gmail.com> wrote:
>>
>> If you add pre-receive hook in your git repository with the following
>> content
>>
>> #!/bin/sh
>>
>> echo Message
>> exit 1
>>
>> And then try to push you will get the following
>>
>> The bug is about these strange 3 last characters.
>>
>> Recently I raised a bug for GitExtensions but it seems to be msysgit
>> issue as I could reproduce it from PowerShell as well
>>
>> https://github.com/gitextensions/gitextensions/issues/1313



>
> What you're seeing is most likely a CR (a carriage return character).
> Windows has CRLF new-lines, and Unix uses only LF.
>
> My guess is that echo produces CRLF, and this gets carried through and
> incorrecly displayed.


OK, I can reproduce it in Git Bash now, and by doing "git push 2>&1 | od -c"
I can see that I'm getting "Message\033[K\n".

This looks a little bit puzzling, but the sequence matches ANSI_SUFFIX in
sideband.c. So it seems this is intentional. This dates back to ebe8fa73.

I wonder, shouldn't we check isatty also before assuming ANSI-sequences?

---8<---
diff --git a/sideband.c b/sideband.c
index d5ffa1c..bd3e5a8 100644
--- a/sideband.c
+++ b/sideband.c
@@ -29,7 +29,7 @@ int recv_sideband(const char *me, int in_stream, int out)

  memcpy(buf, PREFIX, pf);
  term = getenv("TERM");
- if (term && strcmp(term, "dumb"))
+ if (isatty(out) && term && strcmp(term, "dumb"))
  suffix = ANSI_SUFFIX;
  else
  suffix = DUMB_SUFFIX;
---8<---

Thoughts?

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
