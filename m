From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2 5/6] Win32: Thread-safe windows console output
Date: Fri, 13 Jun 2014 08:10:57 +0200
Message-ID: <539A95F1.9030900@kdbg.org>
References: <20140606183935.GA4197@camelia.ucw.cz> <1402127845-4862-1-git-send-email-kasal@ucw.cz> <1402127845-4862-6-git-send-email-kasal@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: GIT Mailing-list <git@vger.kernel.org>, 
 msysGit <msysgit@googlegroups.com>,
 Karsten Blees <blees@dcon.de>
To: Stepan Kasal <kasal@ucw.cz>
X-From: msysgit+bncBCJYV6HBKQIPJK7KTQCRUBBXS7Y2S@googlegroups.com Fri Jun 13 08:11:02 2014
Return-path: <msysgit+bncBCJYV6HBKQIPJK7KTQCRUBBXS7Y2S@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-we0-f191.google.com ([74.125.82.191])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCJYV6HBKQIPJK7KTQCRUBBXS7Y2S@googlegroups.com>)
	id 1WvKhZ-0000zL-GQ
	for gcvm-msysgit@m.gmane.org; Fri, 13 Jun 2014 08:11:01 +0200
Received: by mail-we0-f191.google.com with SMTP id q59sf206699wes.28
        for <gcvm-msysgit@m.gmane.org>; Thu, 12 Jun 2014 23:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=DpUKwLY9UDTrInBqFOVzhTLQLyZ87W9f8IIYWu8oW3g=;
        b=pY7quB6TuXzoPI4556FVpa/wisAoAf/DeeBVPXuGKMjRrANCN9qzbfUjMsfyck1eHP
         gWhrJXFlBVT0CYvu1OkfyXAwn4mYn7kEKl21VzPLXhV5BQ2gCIfPYS1vBh9yxemhFpsf
         MVdEFMEBR98ipZ44PcKlT8WFMn6kdhon6LV4kuFnTGWuFUlaARW+Ii7Q372F6XKzJrCe
         xdsOzSO6OGTOnk0FkFMnaUIigHiLqnD/o/+Ak+rT5oGhFhrqdYI6qQaMUxR8/4aOdR0w
         mnzDPbh/gEtORo0qJpeqQa0mKsnGfnHJJWBNYhitRgBSX8SSZozXlYIsseW+9nbFuT8W
         3LlA==
X-Received: by 10.180.188.105 with SMTP id fz9mr2673wic.0.1402639861241;
        Thu, 12 Jun 2014 23:11:01 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.88.226 with SMTP id bj2ls33730wib.12.canary; Thu, 12 Jun
 2014 23:11:00 -0700 (PDT)
X-Received: by 10.180.212.12 with SMTP id ng12mr108253wic.7.1402639860355;
        Thu, 12 Jun 2014 23:11:00 -0700 (PDT)
Received: from bsmtp.bon.at (bsmtp3.bon.at. [213.33.87.17])
        by gmr-mx.google.com with ESMTPS id gc5si32759wic.1.2014.06.12.23.11.00
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 12 Jun 2014 23:11:00 -0700 (PDT)
Received-SPF: none (google.com: j6t@kdbg.org does not designate permitted sender hosts) client-ip=213.33.87.17;
Received: from [192.168.0.200] (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 08F501001D;
	Fri, 13 Jun 2014 08:10:58 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:24.0) Gecko/20100101 Thunderbird/24.0.1
In-Reply-To: <1402127845-4862-6-git-send-email-kasal@ucw.cz>
X-Original-Sender: j6t@kdbg.org
X-Original-Authentication-Results: gmr-mx.google.com;       spf=neutral
 (google.com: j6t@kdbg.org does not designate permitted sender hosts) smtp.mail=j6t@kdbg.org
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251516>

Am 07.06.2014 09:57, schrieb Stepan Kasal:
> From: Karsten Blees <blees@dcon.de>
> Date: Sat, 14 Jan 2012 22:24:19 +0100
>
> Winansi.c has many static variables that are accessed and modified from
> the [v][f]printf / fputs functions overridden in the file. This may cause
> multi threaded git commands that print to the console to produce corrupted
> output or even crash.
>
> Additionally, winansi.c doesn't override all functions that can be used to
> print to the console (e.g. fwrite, write, fputc are missing), so that ANSI
> escapes don't work properly for some git commands (e.g. git-grep).
>
> Instead of doing ANSI emulation in just a few wrapped functions on top of
> the IO API, let's plug into the IO system and take advantage of the thread
> safety inherent to the IO system.
>
> Redirect stdout and stderr to a pipe if they point to the console. A
> background thread reads from the pipe, handles ANSI escape sequences and
> UTF-8 to UTF-16 conversion, then writes to the console.

There's something fishy with this patch. Please checkout and build 
eac14f8909d9. Then run t5000-tar-tree.sh like so from a CMD prompt:

   sh t5000-tar-tree.sh -v -i

Notice that in test 36 (invoke tar filter by extension) the tar file is 
written to the console instead of the file. Hit Ctrl-C to interrupt the 
test; do not remove the trash directory. You can verify the incorrect 
behavior like this:

   cd "t\trash directory.t5000-tar-tree"
   ..\..\git archive -o config-implicit.tar.foo HEAD

It writes the tar file to the console. When you build the parent commit, 
and repeat these two commands, there is no unexpected console output.

The patch fcd428f4a952 (Win32: fix broken pipe detection) does not fix the 
incorrect behavior.

I haven't dug (and won't dig) deeper than that.

-- Hannes

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
