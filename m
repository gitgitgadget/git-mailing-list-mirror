From: Karsten Blees <karsten.blees@gmail.com>
Subject: [PATCH v5 00/11] add performance tracing facility
Date: Wed, 11 Jun 2014 09:55:47 +0200
Message-ID: <53980B83.9050409@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git List <git@vger.kernel.org>, msysGit <msysgit@googlegroups.com>, 
 Jeff King <peff@peff.net>
X-From: msysgit+bncBCH3XYXLXQDBBBEX4COAKGQELIFLCDQ@googlegroups.com Wed Jun 11 09:55:50 2014
Return-path: <msysgit+bncBCH3XYXLXQDBBBEX4COAKGQELIFLCDQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-la0-f55.google.com ([209.85.215.55])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCH3XYXLXQDBBBEX4COAKGQELIFLCDQ@googlegroups.com>)
	id 1WudNu-0003lI-0v
	for gcvm-msysgit@m.gmane.org; Wed, 11 Jun 2014 09:55:50 +0200
Received: by mail-la0-f55.google.com with SMTP id el20sf926226lab.20
        for <gcvm-msysgit@m.gmane.org>; Wed, 11 Jun 2014 00:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :x-original-sender:x-original-authentication-results:precedence
         :mailing-list:list-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type;
        bh=c9R5I5J3vh837KsvRqYH2LGqx7FlbPtai760pWdLIsM=;
        b=ij0RYUIeIlhNyuvhJvs5JMQrWFqQNjsEWmd2LSQtxRnirrmpR2hWt8fhrKm2M7XMNn
         jYaaboadWRg418F+dhuE1oYNLxIQiTqBJXrtv4w8bzDR/Qzg2FQ4O4ZtiDssoMAwgVL8
         z/ti7cqcRN6aaEjavKAG9HVKBUs1w0ZcwCB34ln7XnidZ3N3IdnASx9XW3VzhcSmqq3Y
         vil/7S1gZUir5ssAVQciXzmTI6p9wLgMW5r2Y4gxynaJz23CnxEiyKvV2kenGFeugh9q
         iLWwX7PoemMA096anuL+Uhq49C726A5WEIUmSiPTYm0+aIsLsSAAX8N0AvmJUkqxHbKe
         5VLg==
X-Received: by 10.152.88.65 with SMTP id be1mr1433lab.35.1402473349835;
        Wed, 11 Jun 2014 00:55:49 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.3.67 with SMTP id a3ls419655laa.21.gmail; Wed, 11 Jun 2014
 00:55:48 -0700 (PDT)
X-Received: by 10.152.21.133 with SMTP id v5mr27627lae.9.1402473348166;
        Wed, 11 Jun 2014 00:55:48 -0700 (PDT)
Received: from mail-wi0-x22e.google.com (mail-wi0-x22e.google.com [2a00:1450:400c:c05::22e])
        by gmr-mx.google.com with ESMTPS id e12si1260695wiv.1.2014.06.11.00.55.48
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 11 Jun 2014 00:55:48 -0700 (PDT)
Received-SPF: pass (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:400c:c05::22e as permitted sender) client-ip=2a00:1450:400c:c05::22e;
Received: by mail-wi0-f174.google.com with SMTP id bs8so1059797wib.7
        for <msysgit@googlegroups.com>; Wed, 11 Jun 2014 00:55:48 -0700 (PDT)
X-Received: by 10.180.212.77 with SMTP id ni13mr47028183wic.5.1402473348049;
        Wed, 11 Jun 2014 00:55:48 -0700 (PDT)
Received: from [10.1.116.52] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id z44sm57929263eep.39.2014.06.11.00.55.46
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 11 Jun 2014 00:55:47 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
X-Original-Sender: karsten.blees@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:400c:c05::22e
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251329>

Here's v5 of the performance tracing patch series, now including a bunch of cleanups and adding timestamp, file and line to all trace output.

I'm particularly interested in feedback for the output format. As file names have different lengths, printing file:line as prefix results in unaligned output:

 > GIT_TRACE=1 git stash list
 00:12:10.544266 git.c:512 trace: exec: 'git-stash' 'list'
 00:12:10.544266 run-command.c:337 trace: run_command: 'git-stash' 'list'
 00:12:10.649779 git.c:312 trace: built-in: git 'rev-parse' '--git-dir'

We could add separators to make it easier to parse, e.g.:

 > GIT_TRACE=1 git stash list
 [00:12:10.544266 git.c:512] trace: exec: 'git-stash' 'list'
 [00:12:10.544266 run-command.c:337] trace: run_command: 'git-stash' 'list'
 [00:12:10.649779 git.c:312] trace: built-in: git 'rev-parse' '--git-dir'

Or print file:line at the end (but what about multi-line messages, such as packet-trace?):

 > GIT_TRACE=1 git stash list
 00:12:10.544266 trace: exec: 'git-stash' 'list' (git.c:512)
 00:12:10.544266 trace: run_command: 'git-stash' 'list' (run-command.c:337)
 00:12:10.649779 trace: built-in: git 'rev-parse' '--git-dir' (git.c:312)


Karsten Blees (11):
  trace: move trace declarations from cache.h to new trace.h
  trace: consistently name the format parameter
  trace: remove redundant printf format attribute
  trace: factor out printing to the trace file
  trace: add infrastructure to augment trace output with additional info
  trace: add current timestamp to all trace output
  trace: move code around, in preparation to file:line output
  trace: add 'file:line' to all trace output
  trace: add high resolution timer function to debug performance issues
  trace: add trace_performance facility to debug performance issues
  git: add performance tracing for git's main() function to debug
    scripts

 Makefile          |   7 ++
 cache.h           |  13 +--
 config.mak.uname  |   1 +
 git-compat-util.h |   4 +
 git.c             |   2 +
 trace.c           | 304 +++++++++++++++++++++++++++++++++++++++++++++++-------
 trace.h           |  96 +++++++++++++++++
 7 files changed, 379 insertions(+), 48 deletions(-)
 create mode 100644 trace.h

-- 
1.9.2.msysgit.0.501.gaeecf09

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
