From: Karsten Blees <karsten.blees@gmail.com>
Subject: Re: [PATCH v5 00/11] add performance tracing facility
Date: Wed, 18 Jun 2014 17:14:47 +0200
Message-ID: <53A1ACE7.2070601@gmail.com>
References: <53980B83.9050409@gmail.com> <xmqqvbs656bu.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>, msysGit <msysgit@googlegroups.com>, 
 Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: msysgit+bncBCH3XYXLXQDBB2GZQ2OQKGQE7RMIVMI@googlegroups.com Wed Jun 18 17:14:54 2014
Return-path: <msysgit+bncBCH3XYXLXQDBB2GZQ2OQKGQE7RMIVMI@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wi0-f185.google.com ([209.85.212.185])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCH3XYXLXQDBB2GZQ2OQKGQE7RMIVMI@googlegroups.com>)
	id 1WxHZZ-0000Cm-FP
	for gcvm-msysgit@m.gmane.org; Wed, 18 Jun 2014 17:14:49 +0200
Received: by mail-wi0-f185.google.com with SMTP id cc10sf139736wib.2
        for <gcvm-msysgit@m.gmane.org>; Wed, 18 Jun 2014 08:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=KBkXhvMENDmbo6jGDPX78ypjVtIUT7Ypcl4E+zHCYnk=;
        b=i6pVA/nRmbO1HpK+hc4QURBZRGFKXEzDImTgmsRPnhNna65ZaGezIjUUoY8yAy/2x4
         Xdub+5ZtDX0ITLh8A46xDanML0g7M0EPwBhNHTxYcDEJUY9G6KRUIJ8EkoEzF4RydEHK
         7T2BP0GqYHLbN8UZH3/BAE3oa1/j+rMZPkR2BEB8Q0U3exKpcK11r294jKjQHiqvvlbm
         SDlW5R3jwhvEANBNoow2AybtuTX2qDnmdtz9iLG28noKlbEH3+DLiDngpU8PvtPCYOsH
         jzNGV/7L0fh8suN9qrgvZ2FvxpcVSYP8TUCaEzzzXjJ83ZzvJtB3UmCj2A9zP8dfYvRx
         yp6w==
X-Received: by 10.152.8.17 with SMTP id n17mr2529laa.42.1403104489205;
        Wed, 18 Jun 2014 08:14:49 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.116.48 with SMTP id jt16ls35173lab.50.gmail; Wed, 18 Jun
 2014 08:14:47 -0700 (PDT)
X-Received: by 10.152.8.194 with SMTP id t2mr314360laa.7.1403104487907;
        Wed, 18 Jun 2014 08:14:47 -0700 (PDT)
Received: from mail-wi0-x22c.google.com (mail-wi0-x22c.google.com [2a00:1450:400c:c05::22c])
        by gmr-mx.google.com with ESMTPS id s1si187662wiw.3.2014.06.18.08.14.47
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 18 Jun 2014 08:14:47 -0700 (PDT)
Received-SPF: pass (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:400c:c05::22c as permitted sender) client-ip=2a00:1450:400c:c05::22c;
Received: by mail-wi0-f172.google.com with SMTP id hi2so7854131wib.5
        for <msysgit@googlegroups.com>; Wed, 18 Jun 2014 08:14:47 -0700 (PDT)
X-Received: by 10.180.73.106 with SMTP id k10mr6283290wiv.11.1403104487740;
        Wed, 18 Jun 2014 08:14:47 -0700 (PDT)
Received: from [10.1.116.52] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id m1sm5816325eep.24.2014.06.18.08.14.46
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 18 Jun 2014 08:14:47 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <xmqqvbs656bu.fsf@gitster.dls.corp.google.com>
X-Original-Sender: karsten.blees@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:400c:c05::22c
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251988>

Am 12.06.2014 20:30, schrieb Junio C Hamano:
> Karsten Blees <karsten.blees@gmail.com> writes:
> 
>> Here's v5 of the performance tracing patch series, now including a bunch of cleanups and adding timestamp, file and line to all trace output.
>>
>> I'm particularly interested in feedback for the output format. As file names have different lengths, printing file:line as prefix results in unaligned output:
>>
>>  > GIT_TRACE=1 git stash list
>>  00:12:10.544266 git.c:512 trace: exec: 'git-stash' 'list'
>>  00:12:10.544266 run-command.c:337 trace: run_command: 'git-stash' 'list'
>>  00:12:10.649779 git.c:312 trace: built-in: git 'rev-parse' '--git-dir'
>>
>> We could add separators to make it easier to parse, e.g.:
>>
>>  > GIT_TRACE=1 git stash list
>>  [00:12:10.544266 git.c:512] trace: exec: 'git-stash' 'list'
>>  [00:12:10.544266 run-command.c:337] trace: run_command: 'git-stash' 'list'
>>  [00:12:10.649779 git.c:312] trace: built-in: git 'rev-parse' '--git-dir'
> 
> This is easier to parse if " " and ":" are found in the names of
> _our_ source files and "]" isn't, but is that really the case?
> 

By "parsing" I actually meant the HumanEye (tm) parser, not lex/yacc and
friends ("[]" just make nice recognizable separators).

However, I think it shouldn't be too complicated to properly align the output,
at least for the majority of 'short' file names in the git code base. E.g.:

00:12:10.544266 git.c:512                trace: exec: 'git-stash' 'list'
00:12:10.544266 run-command.c:337        trace: run_command: 'git-stash' 'list'
00:12:10.649779 git.c:312                trace: built-in: git 'rev-parse' '--git-dir'

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
