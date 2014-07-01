From: Karsten Blees <karsten.blees@gmail.com>
Subject: [PATCH v7 00/16] add performance tracing facility
Date: Wed, 02 Jul 2014 00:53:57 +0200
Message-ID: <53B33C05.5090900@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Karsten Blees <karsten.blees@gmail.com>
To: Git List <git@vger.kernel.org>, msysGit <msysgit@googlegroups.com>
X-From: msysgit+bncBCH3XYXLXQDBBBPYZSOQKGQE2WJVYFI@googlegroups.com Wed Jul 02 00:53:59 2014
Return-path: <msysgit+bncBCH3XYXLXQDBBBPYZSOQKGQE2WJVYFI@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-la0-f55.google.com ([209.85.215.55])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCH3XYXLXQDBBBPYZSOQKGQE2WJVYFI@googlegroups.com>)
	id 1X26w2-000870-Pk
	for gcvm-msysgit@m.gmane.org; Wed, 02 Jul 2014 00:53:58 +0200
Received: by mail-la0-f55.google.com with SMTP id pn19sf976161lab.0
        for <gcvm-msysgit@m.gmane.org>; Tue, 01 Jul 2014 15:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :x-original-sender:x-original-authentication-results:precedence
         :mailing-list:list-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type;
        bh=VxMliY9Hj396vkvRCHQArFdLLC9H+fz8Vybwc3G88h8=;
        b=Y5OwRJ9K+Vxpa5QVYKcHLU/PkP1XomTSsbgRXsuZJooihi2rfV8DIEvhA4SMBlpsQl
         q0qcwt3+Z7t+Nbv/W3Ycvk8VkHy/Qz1St0n04aKVBEJu03E8MbBicrKdZQJt4LmrDTEw
         TYZKz1z8fgfhkRc6/xgiXN+e959aKfr4AKsK1V9vib+6tc4QVp5cDUXZ+G9tVWbOM3W9
         zacFA30H6vkQwBwaNYsbORsoQhjwq23E6dXBH2mBPvaLGFpltPrZJy3C6dqjrXsPJVSR
         VOex1hynTzJkEnImbGZwUH1b/zKxN+Chg3J+nnEwjRq+l121tvF7sg6CrKc0rbsLpUcC
         b5fA==
X-Received: by 10.180.7.199 with SMTP id l7mr2014wia.21.1404255238582;
        Tue, 01 Jul 2014 15:53:58 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.74.100 with SMTP id s4ls684773wiv.18.canary; Tue, 01 Jul
 2014 15:53:57 -0700 (PDT)
X-Received: by 10.180.89.199 with SMTP id bq7mr3856587wib.3.1404255237556;
        Tue, 01 Jul 2014 15:53:57 -0700 (PDT)
Received: from mail-wg0-x234.google.com (mail-wg0-x234.google.com [2a00:1450:400c:c00::234])
        by gmr-mx.google.com with ESMTPS id mx7si808114wic.1.2014.07.01.15.53.57
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 01 Jul 2014 15:53:57 -0700 (PDT)
Received-SPF: pass (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:400c:c00::234 as permitted sender) client-ip=2a00:1450:400c:c00::234;
Received: by mail-wg0-f52.google.com with SMTP id x13so1501706wgg.35
        for <msysgit@googlegroups.com>; Tue, 01 Jul 2014 15:53:57 -0700 (PDT)
X-Received: by 10.180.39.144 with SMTP id p16mr501983wik.4.1404255237447;
        Tue, 01 Jul 2014 15:53:57 -0700 (PDT)
Received: from [10.1.116.52] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id i6sm48156961wiy.17.2014.07.01.15.53.56
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 01 Jul 2014 15:53:56 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
X-Original-Sender: karsten.blees@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:400c:c00::234
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252748>

...slowly turning into a full-fledged trace overhaul...

When working on the documentation, I discovered GIT_TRACE_PACK_ACCESS,
which uses a completely separate trace implementation that is 3 times
faster by keeping the file open...so this round includes a performance
patch that brings the trace API up to speed.

Changes since v6:
[04-06]: New.
[07-08]: Separated the 'disable for test' aspect into a separate patch.
         GIT_TRACE_BARE=1 is set in test-lib.sh rather than individual
         tests. Moved static trace_bare variable from global scope into
         prepare_trace_line().
[09]:    Cast timeval.tv_usec to long to prevent compiler warning.
[11,13]: Factor out '#define TRACE_CONTEXT __FILE__' so that it can
         be easily changed to __FUNCTION__.
[14]:    Added GIT_TRACE_PERFORMANCE to Documentation/git.txt
[15-16]: New.

[01-03,10,12] are unchanged save resolving conflicts.


Karsten Blees (16):
  trace: move trace declarations from cache.h to new trace.h
  trace: consistently name the format parameter
  trace: remove redundant printf format attribute
  trace: improve trace performance
  Documentation/git.txt: improve documentation of 'GIT_TRACE*' variables
  sha1_file: change GIT_TRACE_PACK_ACCESS logging to use trace API
  trace: add infrastructure to augment trace output with additional info
  trace: disable additional trace output for unit tests
  trace: add current timestamp to all trace output
  trace: move code around, in preparation to file:line output
  trace: add 'file:line' to all trace output
  trace: add high resolution timer function to debug performance issues
  trace: add trace_performance facility to debug performance issues
  git: add performance tracing for git's main() function to debug
    scripts
  wt-status: simplify performance measurement by using getnanotime()
  progress: simplify performance measurement by using getnanotime()

 Documentation/git.txt  |  59 +++++---
 Makefile               |   7 +
 builtin/receive-pack.c |   2 +-
 cache.h                |  13 +-
 commit.h               |   1 +
 config.mak.uname       |   1 +
 git-compat-util.h      |   4 +
 git.c                  |   2 +
 pkt-line.c             |   8 +-
 progress.c             |  71 +++++-----
 sha1_file.c            |  30 +---
 shallow.c              |  10 +-
 t/test-lib.sh          |   4 +
 trace.c                | 369 ++++++++++++++++++++++++++++++++++++++++---------
 trace.h                | 105 ++++++++++++++
 wt-status.c            |  14 +-
 16 files changed, 524 insertions(+), 176 deletions(-)
 create mode 100644 trace.h

-- 
2.0.0.406.ge74f8ff

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
