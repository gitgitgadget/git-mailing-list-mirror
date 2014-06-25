From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v5 00/11] add performance tracing facility
Date: Wed, 25 Jun 2014 21:28:46 +0700
Message-ID: <CACsJy8AV5GhB+7iHL11vAMvp=X2yeHgO-ejrtMQqGNG3z_ekBw@mail.gmail.com>
References: <53980B83.9050409@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, msysGit <msysgit@googlegroups.com>, 
	Jeff King <peff@peff.net>
To: Karsten Blees <karsten.blees@gmail.com>
X-From: msysgit+bncBC2ZN5PHQUMBBPFZVOOQKGQETSLZCKQ@googlegroups.com Wed Jun 25 16:29:18 2014
Return-path: <msysgit+bncBC2ZN5PHQUMBBPFZVOOQKGQETSLZCKQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-qc0-f191.google.com ([209.85.216.191])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBC2ZN5PHQUMBBPFZVOOQKGQETSLZCKQ@googlegroups.com>)
	id 1WzoCM-0006zD-0R
	for gcvm-msysgit@m.gmane.org; Wed, 25 Jun 2014 16:29:18 +0200
Received: by mail-qc0-f191.google.com with SMTP id l6sf383714qcy.8
        for <gcvm-msysgit@m.gmane.org>; Wed, 25 Jun 2014 07:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:x-original-sender:x-original-authentication-results:precedence
         :mailing-list:list-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type;
        bh=eQoGOpJuTXw1PnqnKdZg8ka7QwHt6yZ01rGdX4F3MTA=;
        b=yWHyIvV65U+NnzxvqUW+Tnh4iqPRQR6IOA3bAG4fY5PnyP3OObD/zfhsLfYnGQ6KSQ
         q8xakG5ydZCP7zz33AZOQ5ALmuEGlM9J11uL2AyWT/sNMXFQi1ZdfuqN8XJDuShoBkoO
         d6qCYWLWP/R4mW/2SU/T2QX4J4CwREvdQNO5qZfWbdoJiOeW3IGYpCPUl5AbgVyLx4nX
         eKpDRjWbNcu10l26IQas+vqY40FVzDk2FHEtIUQyQd7WwPE5FnVGyJr0uIL5/YwCqTlt
         d/6HsPcBMgDCNDMjvaXpHhbQyKjr5exMQye4mLe/drCH8xVG6xgAM46IgXScRcEyE+90
         Cmuw==
X-Received: by 10.50.18.50 with SMTP id t18mr228517igd.10.1403706557083;
        Wed, 25 Jun 2014 07:29:17 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.50.33.51 with SMTP id o19ls1086873igi.8.canary; Wed, 25 Jun
 2014 07:29:16 -0700 (PDT)
X-Received: by 10.66.230.165 with SMTP id sz5mr4478815pac.33.1403706556439;
        Wed, 25 Jun 2014 07:29:16 -0700 (PDT)
Received: from mail-qg0-x22d.google.com (mail-qg0-x22d.google.com [2607:f8b0:400d:c04::22d])
        by gmr-mx.google.com with ESMTPS id he4si484440qcb.0.2014.06.25.07.29.16
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 25 Jun 2014 07:29:16 -0700 (PDT)
Received-SPF: pass (google.com: domain of pclouds@gmail.com designates 2607:f8b0:400d:c04::22d as permitted sender) client-ip=2607:f8b0:400d:c04::22d;
Received: by mail-qg0-f45.google.com with SMTP id 63so1729019qgz.32
        for <msysgit@googlegroups.com>; Wed, 25 Jun 2014 07:29:16 -0700 (PDT)
X-Received: by 10.140.92.144 with SMTP id b16mr11236771qge.41.1403706556284;
 Wed, 25 Jun 2014 07:29:16 -0700 (PDT)
Received: by 10.96.66.129 with HTTP; Wed, 25 Jun 2014 07:28:46 -0700 (PDT)
In-Reply-To: <53980B83.9050409@gmail.com>
X-Original-Sender: pclouds@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of pclouds@gmail.com designates 2607:f8b0:400d:c04::22d
 as permitted sender) smtp.mail=pclouds@gmail.com;       dkim=pass
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252445>

On Wed, Jun 11, 2014 at 2:55 PM, Karsten Blees <karsten.blees@gmail.com> wrote:
> Here's v5 of the performance tracing patch series, now including a bunch of cleanups and adding timestamp, file and line to all trace output.
>
> I'm particularly interested in feedback for the output format. As file names have different lengths, printing file:line as prefix results in unaligned output:
>
>  > GIT_TRACE=1 git stash list
>  00:12:10.544266 git.c:512 trace: exec: 'git-stash' 'list'
>  00:12:10.544266 run-command.c:337 trace: run_command: 'git-stash' 'list'
>  00:12:10.649779 git.c:312 trace: built-in: git 'rev-parse' '--git-dir'

Can I have an (build-time) option to show <function>:<line> instead of
<file>:<line>? I know it's not supported by all compilers, which may
make support a bit cumbersome..
-- 
Duy

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
