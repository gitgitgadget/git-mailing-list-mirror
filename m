From: Karsten Blees <karsten.blees@gmail.com>
Subject: Re: [PATCH 2/2] dir: remove PATH_MAX limitation
Date: Fri, 11 Jul 2014 21:10:59 +0200
Message-ID: <53C036C3.10103@gmail.com>
References: <53B72DAA.5050007@gmail.com> <53B72DD5.6020603@gmail.com> <CACsJy8AXAusNHb5GJgrcbgzXY-1_ER2CNmah=vkJzOgPHMHudA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, msysGit <msysgit@googlegroups.com>, 
 Jeff King <peff@peff.net>
To: Duy Nguyen <pclouds@gmail.com>
X-From: msysgit+bncBCH3XYXLXQDBBQXNQCPAKGQEPIUPTSA@googlegroups.com Fri Jul 11 21:11:02 2014
Return-path: <msysgit+bncBCH3XYXLXQDBBQXNQCPAKGQEPIUPTSA@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wg0-f64.google.com ([74.125.82.64])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCH3XYXLXQDBBQXNQCPAKGQEPIUPTSA@googlegroups.com>)
	id 1X5gDl-00049y-5w
	for gcvm-msysgit@m.gmane.org; Fri, 11 Jul 2014 21:11:01 +0200
Received: by mail-wg0-f64.google.com with SMTP id m15sf139662wgh.29
        for <gcvm-msysgit@m.gmane.org>; Fri, 11 Jul 2014 12:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=DEkc+ZTTl/LhZWm6cpVEkr236ZHu13RKtnebUS1nbbM=;
        b=eHGRF8uZLFdsoi++ku+GAi/ImflC5n77xQJ8Qemn2bBepg9UsnViade8bg3RspQf9i
         xfAA1Y489HTyMIrQ+iL1wwxXj8ndIM5+1zUm8XxvwYL8jnGl3h1jmSzdA/tNoAD8yYm3
         MkwOPv7fBPIF6ctOrsySSESdLOjhmt7VAVCvB0WqLRcwox7XuIKQQeXfOQYE3LNr0kuw
         Bn/3mUQUPJ5vLvi8OsWHq167dv6z4n3XnaqU7IfH9Guasqx/yGmI9CtdSrHe0L8WAzsT
         X5TXagAF0LqSbJxIr3NJwWktR/l7J6dVPcxDgRoCIrJ3g85jnO6H8U2oJJe15FKlAq2g
         iXOA==
X-Received: by 10.180.8.231 with SMTP id u7mr23841wia.10.1405105859037;
        Fri, 11 Jul 2014 12:10:59 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.99.137 with SMTP id eq9ls142272wib.37.gmail; Fri, 11 Jul
 2014 12:10:58 -0700 (PDT)
X-Received: by 10.180.90.13 with SMTP id bs13mr679143wib.6.1405105858064;
        Fri, 11 Jul 2014 12:10:58 -0700 (PDT)
Received: from mail-wi0-x22b.google.com (mail-wi0-x22b.google.com [2a00:1450:400c:c05::22b])
        by gmr-mx.google.com with ESMTPS id cj4si249646wid.0.2014.07.11.12.10.58
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 11 Jul 2014 12:10:58 -0700 (PDT)
Received-SPF: pass (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:400c:c05::22b as permitted sender) client-ip=2a00:1450:400c:c05::22b;
Received: by mail-wi0-f171.google.com with SMTP id f8so174433wiw.4
        for <msysgit@googlegroups.com>; Fri, 11 Jul 2014 12:10:58 -0700 (PDT)
X-Received: by 10.194.219.225 with SMTP id pr1mr1154670wjc.34.1405105857959;
        Fri, 11 Jul 2014 12:10:57 -0700 (PDT)
Received: from [10.1.116.52] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id jy8sm6906700wjc.7.2014.07.11.12.10.56
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 11 Jul 2014 12:10:57 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <CACsJy8AXAusNHb5GJgrcbgzXY-1_ER2CNmah=vkJzOgPHMHudA@mail.gmail.com>
X-Original-Sender: karsten.blees@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:400c:c05::22b
 as permitted sender) smtp.mail=karsten.blees@gmail.com;       dkim=pass
 header.i=@gmail.com;       dmarc=pass (p=NONE dis=NONE) header.from=gmail.com
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253315>

Am 05.07.2014 12:48, schrieb Duy Nguyen:
> On Sat, Jul 5, 2014 at 5:42 AM, Karsten Blees <karsten.blees@gmail.com> wrote:
>> 'git status' segfaults if a directory is longer than PATH_MAX, because
>> processing .gitignore files in prep_exclude() writes past the end of a
>> PATH_MAX-bounded buffer.
>>
>> Remove the limitation by using strbuf instead.
>>
>> Note: this fix just 'abuses' strbuf as string allocator, len is always 0.
>> prep_exclude() can probably be simplified using more strbuf APIs.
> 
> FYI I had a similar patch [1] that attempted to lazily strbuf_init()
> instead so that strbuf_ API could be used.
> 
> [1] http://article.gmane.org/gmane.comp.version-control.git/248310
> 

Sorry, I missed that one.

In my version, strbuf_grow() does the lazy initialization (in fact, many
strbuf_* functions can handle memset(0) strbufs just fine).

I was simply too lazy to understand (again) how prep_exclude works exactly, and
as string calculations like that have the tendency to be just 1 char off, I went
for the obviously correct solution (i.e. s/dir->basebuf/dir->base.buf/ plus
strbuf_grow() before we write the buffer).

But IMO your version is much cleaner already.

However, api-strbuf.txt says that buf != NULL is invariant after init, and
alloc is "somehow private" :-) , so perhaps you should

-	if (!dir->basebuf.alloc)
+	if (!dir->basebuf.buf)
		strbuf_init(&dir->basebuf, PATH_MAX);

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
