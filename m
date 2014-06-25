From: Karsten Blees <karsten.blees@gmail.com>
Subject: Re: [PATCH v5 00/11] add performance tracing facility
Date: Wed, 25 Jun 2014 16:49:30 +0200
Message-ID: <53AAE17A.7050500@gmail.com>
References: <53980B83.9050409@gmail.com> <CACsJy8AV5GhB+7iHL11vAMvp=X2yeHgO-ejrtMQqGNG3z_ekBw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, msysGit <msysgit@googlegroups.com>, 
 Jeff King <peff@peff.net>
To: Duy Nguyen <pclouds@gmail.com>
X-From: msysgit+bncBCH3XYXLXQDBB7OCVOOQKGQE4BCWLOY@googlegroups.com Wed Jun 25 16:49:39 2014
Return-path: <msysgit+bncBCH3XYXLXQDBB7OCVOOQKGQE4BCWLOY@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-lb0-f185.google.com ([209.85.217.185])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCH3XYXLXQDBB7OCVOOQKGQE4BCWLOY@googlegroups.com>)
	id 1WzoVz-0005XQ-HT
	for gcvm-msysgit@m.gmane.org; Wed, 25 Jun 2014 16:49:35 +0200
Received: by mail-lb0-f185.google.com with SMTP id 10sf235206lbg.12
        for <gcvm-msysgit@m.gmane.org>; Wed, 25 Jun 2014 07:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=whmOjgKqOY4n75BJO3x0Mx/qQW8EiiXEAEluC31lMMA=;
        b=ayqHxqP3OnC1/uKaG0S6++W8xAQPL5pV1W8Rx4oEslc6FLoBNTvfjLJnRlg1ZZs2Om
         g0IAMozNMPpSKflIdTnzJkh4sx3WiOemQ5OOTi/8/+EHh1Lk+NFBcjr/UMh25I0KR927
         QWdJMxmhC9kTTrFxY6U7ZcIctW6j82PzKJ2hu/OgQVF2uT7jTu6/f/9BJCR22p0cb6wp
         NkV/SojziDan6jpuXxGbKgM08z7qS+7mjO5sOWg3RheptPQNQV1XJ6AUWXt306GYwwgg
         5tseLxZprCY0wbIcYg+stP2KMjXSrcFH++AfTvAsvqgKF1EXxsfBDebS/nWGOU1//S/W
         4+hA==
X-Received: by 10.153.6.39 with SMTP id cr7mr92182lad.1.1403707775308;
        Wed, 25 Jun 2014 07:49:35 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.10.4 with SMTP id e4ls460492lab.84.gmail; Wed, 25 Jun 2014
 07:49:33 -0700 (PDT)
X-Received: by 10.112.200.164 with SMTP id jt4mr478045lbc.14.1403707773206;
        Wed, 25 Jun 2014 07:49:33 -0700 (PDT)
Received: from mail-wg0-x22b.google.com (mail-wg0-x22b.google.com [2a00:1450:400c:c00::22b])
        by gmr-mx.google.com with ESMTPS id s1si349966wiw.3.2014.06.25.07.49.33
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 25 Jun 2014 07:49:33 -0700 (PDT)
Received-SPF: pass (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:400c:c00::22b as permitted sender) client-ip=2a00:1450:400c:c00::22b;
Received: by mail-wg0-x22b.google.com with SMTP id b13so2101905wgh.26
        for <msysgit@googlegroups.com>; Wed, 25 Jun 2014 07:49:33 -0700 (PDT)
X-Received: by 10.194.86.225 with SMTP id s1mr10360662wjz.21.1403707773099;
        Wed, 25 Jun 2014 07:49:33 -0700 (PDT)
Received: from [10.1.116.52] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id fq2sm13156441wib.2.2014.06.25.07.49.31
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 25 Jun 2014 07:49:32 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <CACsJy8AV5GhB+7iHL11vAMvp=X2yeHgO-ejrtMQqGNG3z_ekBw@mail.gmail.com>
X-Original-Sender: karsten.blees@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:400c:c00::22b
 as permitted sender) smtp.mail=karsten.blees@gmail.com;       dkim=pass
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252447>

Am 25.06.2014 16:28, schrieb Duy Nguyen:
> On Wed, Jun 11, 2014 at 2:55 PM, Karsten Blees <karsten.blees@gmail.com> wrote:
>> Here's v5 of the performance tracing patch series, now including a bunch of cleanups and adding timestamp, file and line to all trace output.
>>
>> I'm particularly interested in feedback for the output format. As file names have different lengths, printing file:line as prefix results in unaligned output:
>>
>>  > GIT_TRACE=1 git stash list
>>  00:12:10.544266 git.c:512 trace: exec: 'git-stash' 'list'
>>  00:12:10.544266 run-command.c:337 trace: run_command: 'git-stash' 'list'
>>  00:12:10.649779 git.c:312 trace: built-in: git 'rev-parse' '--git-dir'
> 
> Can I have an (build-time) option to show <function>:<line> instead of
> <file>:<line>? I know it's not supported by all compilers, which may
> make support a bit cumbersome..
> 

Is this really useful? <file>:<line> is unique, but <function>:<line> is not. E.g. in case of "hash_name:47" you'd have to guess if its the one in attr.c or name-hash.c...

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
