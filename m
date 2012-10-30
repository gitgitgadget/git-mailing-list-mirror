From: Albert Krawczyk <pro-logic@optusnet.com.au>
Subject: Re: [PATCH] update-index/diff-index: use core.preloadindex
 to improve performance
Date: Wed, 31 Oct 2012 09:50:34 +1100
Message-ID: <CALKo3jR1S924zwnRUG5df9cKXjFkKCtcUO+WzXzLXif+ee8AiQ@mail.gmail.com>
References: <OF831F4AE9.23F46743-ONC1257AA7.00353C1F-C1257AA7.00361535@dcon.de>
	<CABPQNSb6QzxxJpoackhzRz19UWwpxjJ6MPEeptTU9Z0bEaAB+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/alternative; boundary=e89a8fb2027821a51904cd4e9d96
Cc: karsten.blees@dcon.de, git@vger.kernel.org, msysgit@googlegroups.com
To: kusmabite@gmail.com
X-From: msysgit+bncBCNJBMNCRQBBBQ5TYGCAKGQE6VSMZMA@googlegroups.com Tue Oct 30 23:50:57 2012
Return-path: <msysgit+bncBCNJBMNCRQBBBQ5TYGCAKGQE6VSMZMA@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-ia0-f186.google.com ([209.85.210.186])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCNJBMNCRQBBBQ5TYGCAKGQE6VSMZMA@googlegroups.com>)
	id 1TTKe5-0001iw-It
	for gcvm-msysgit@m.gmane.org; Tue, 30 Oct 2012 23:50:53 +0100
Received: by mail-ia0-f186.google.com with SMTP id k10sf496986iag.3
        for <gcvm-msysgit@m.gmane.org>; Tue, 30 Oct 2012 15:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=x-beenthere:received-spf:mime-version:x-originating-ip:in-reply-to
         :references:date:message-id:subject:from:to:cc
         :x-optus-cloudmark-score:x-optus-cloudmark-analysis
         :x-original-sender:x-original-authentication-results:precedence
         :mailing-list:list-id:x-google-group-id:list-post:list-help
         :list-archive:sender:list-subscribe:list-unsubscribe:content-type;
        bh=JZYTjlIjKGSLDmciff4fw20ypkFNUfkeLhnDGMcE1A8=;
        b=gTUFI3WOWS+JXmU3MkVaa4jQrNdw2f4/M8zNYlF624ywWLfQLmCF5Ctzk09/VdaOlQ
         UiXOJNJOWuWYGmiT1DliJJ2qDihxtZEuFOCmaVZEUZtlsE6paYJSVjxvhk2bMA8G5iT/
         suZoJQ86qiywZU7m2mqkbAGxUtfK2V+9/Rpe1IMucE0YWivpRkL0R8idMJ6iNM0sI/pZ
         bJVm+POEdq/u4YjQVCESqcjGbl9uT/uNPiY4K/T3fxYi4le189Ao6ym+haTb/hF7jP6+
         ZlIabofEQnLeEikrW 
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-beenthere:received-spf:mime-version:x-originating-ip:in-reply-to
         :references:date:message-id:subject:from:to:cc:x-gm-message-state
         :x-optus-cloudmark-score:x-optus-cloudmark-analysis
         :x-original-sender:x-original-authentication-results:precedence
         :mailing-list:list-id:x-google-group-id:list-post:list-help
         :list-archive:sender:list-subscribe:list-unsubscribe:content-type;
        bh=JZYTjlIjKGSLDmciff4fw20ypkFNUfkeLhnDGMcE1A8=;
        b=fQSEXtuCImXWT7M4GRdq8cEBpGoWSgJ/J7XjoHMmLjI8wha4NVls00599sroWED47L
         YQOnavAcBvrww75+VbxFkdYRB1f8pfmk3tjBtTVPbXdxer+iEaY/mle9UfaTtboZATuF
         BbahU5R2azuhRMbTEAwC3A95IzEd0rhMMzVtQARaMeSjSmJyXHj8fk48pWd8w1ckkkKa
         twCbvvsoRhtqOj9YWbHl65CFCPShikifvWdEUudc/6yld3alviNsOYz6M/+5IlXVXL0f
     
Received: by 10.68.253.202 with SMTP id ac10mr6503987pbd.7.1351637444494;
        Tue, 30 Oct 2012 15:50:44 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.68.201.133 with SMTP id ka5ls3774898pbc.3.gmail; Tue, 30 Oct
 2012 15:50:43 -0700 (PDT)
Received: by 10.66.73.1 with SMTP id h1mr10513675pav.0.1351637443398;
        Tue, 30 Oct 2012 15:50:43 -0700 (PDT)
Received: by 10.66.73.1 with SMTP id h1mr10513673pav.0.1351637443381;
        Tue, 30 Oct 2012 15:50:43 -0700 (PDT)
Received: from mail36.syd.optusnet.com.au (mail36.syd.optusnet.com.au. [211.29.133.76])
        by gmr-mx.google.com with ESMTPS id q7si460834paz.0.2012.10.30.15.50.42
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 30 Oct 2012 15:50:43 -0700 (PDT)
Received-SPF: pass (google.com: domain of pro-logic@optusnet.com.au designates 211.29.133.76 as permitted sender) client-ip=211.29.133.76;
Received: from mail-oa0-f50.google.com (mail-oa0-f50.google.com [209.85.219.50])
	(authenticated sender pro-logic)
	by mail36.syd.optusnet.com.au (8.13.1/8.13.1) with ESMTP id q9UMoYwE032085
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=OK)
	for <msysgit@googlegroups.com>; Wed, 31 Oct 2012 09:50:39 +1100
Received: by mail-oa0-f50.google.com with SMTP id n16so1029739oag.23
        for <msysgit@googlegroups.com>; Tue, 30 Oct 2012 15:50:34 -0700 (PDT)
Received: by 10.60.29.3 with SMTP id f3mr29723465oeh.97.1351637434213; Tue, 30
 Oct 2012 15:50:34 -0700 (PDT)
Received: by 10.76.132.232 with HTTP; Tue, 30 Oct 2012 15:50:34 -0700 (PDT)
X-Originating-IP: [202.92.67.179]
In-Reply-To: <CABPQNSb6QzxxJpoackhzRz19UWwpxjJ6MPEeptTU9Z0bEaAB+A@mail.gmail.com>
X-Gm-Message-State: ALoCoQmRWPjmE3a3kPaRg3mFrdL8+J5eXjaLn+r4vF9Gav8T45MJ66D9q5zSWkNjwlG3vsxA7SwM
X-Optus-Cloudmark-Score: 0
X-Optus-Cloudmark-Analysis: v=2.0 cv=LJ8+2+q9 c=1 sm=1 a=XlB2eowVHYkA:10
	a=bxnZ4wh3uPQA:10 a=PO7r1zJSAAAA:8 a=pGLkceISAAAA:8 a=sRYh-EHDtu4A:10
	a=NEAV23lmAAAA:8 a=irRqLfKFBU0-4MFovxUA:9 a=wPNLvfGTeEIA:10
	a=jYof71I6T4OGe6I0UN8A:9 a=2teSjPhc_Eajo59p:21
	a=vwzXOsKPqX19DMMWTnMzaA==:117
X-Original-Sender: pro-logic@optusnet.com.au
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com:
 domain of pro-logic@optusnet.com.au designates 211.29.133.76 as permitted
 sender) smtp.mail=pro-logic@optusnet.com.au
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208764>

--e89a8fb2027821a51904cd4e9d96
Content-Type: text/plain; charset=ISO-8859-1

> Wow, awesome results :)

They get even better when used with scripted commands like git svn rebase:

                |  cold | warm | hot
----------------+-------+------+-----
msysgit-v1.8.0  | 7m29s | 36s  | 33s
this patch      | 28s   | 14s  | 14

https://github.com/pro-logic/git/commit/32c03dd8#commitcomment-2070415

Karsten's code is amazing. Now if only I could figure out a way to spread
the love through the rest of the source :)

Albert

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

--e89a8fb2027821a51904cd4e9d96
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

&gt;=A0Wow, awesome results :)<div><br></div><div>They get even better when=
 used with scripted commands like git svn rebase:</div><div><br></div><div>=
<div>=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0cold | warm | hot</div><div>-----=
-----------+-------+------+-----</div>
<div>msysgit-v1.8.0 =A0| 7m29s | 36s =A0| 33s</div><div>this patch =A0 =A0 =
=A0| 28s =A0 | 14s =A0| 14</div></div><div><br></div><div><a href=3D"https:=
//github.com/pro-logic/git/commit/32c03dd8#commitcomment-2070415">https://g=
ithub.com/pro-logic/git/commit/32c03dd8#commitcomment-2070415</a>=A0</div>
<div><br></div><div>Karsten&#39;s code is amazing. Now if only I could figu=
re out a way to spread the love through the rest of the source :)</div><div=
><br></div><div>Albert=A0</div>

<p></p>

-- <br />
*** Please reply-to-all at all times ***<br />
*** (do not pretend to know who is subscribed and who is not) ***<br />
*** Please avoid top-posting. ***<br />
The msysGit Wiki is here: <a href=3D"https://github.com/msysgit/msysgit/wik=
i">https://github.com/msysgit/msysgit/wiki</a> - Github accounts are free.<=
br />
&nbsp;<br />
You received this message because you are subscribed to the Google<br />
Groups &quot;msysGit&quot; group.<br />
To post to this group, send email to msysgit@googlegroups.com<br />
To unsubscribe from this group, send email to<br />
msysgit+unsubscribe@googlegroups.com<br />
For more options, and view previous threads, visit this group at<br />
<a href=3D"http://groups.google.com/group/msysgit?hl=3Den_US?hl=3Den">http:=
//groups.google.com/group/msysgit?hl=3Den_US?hl=3Den</a><br />

--e89a8fb2027821a51904cd4e9d96--
