From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2 06/14] mingw: use real pid
Date: Sat, 16 Jan 2010 09:03:25 +0100
Message-ID: <201001160903.25162.j6t@kdbg.org>
References: <1263591033-4992-1-git-send-email-kusmabite@gmail.com> <201001152330.06083.j6t@kdbg.org> <40aa078e1001151453i3576a345k217944c38887b61f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Cc: msysgit@googlegroups.com,
 git@vger.kernel.org
To: kusmabite@gmail.com
X-From: 3CXNRSwMIBxk8VI9205.DG5BHNH57I5DD5A35GDJEH.1DB@listserv.bounces.google.com Sat Jan 16 09:04:44 2010
Return-path: <3CXNRSwMIBxk8VI9205.DG5BHNH57I5DD5A35GDJEH.1DB@listserv.bounces.google.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-gx0-f204.google.com ([209.85.217.204])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NW3eF-0008UF-Tx
	for gcvm-msysgit@m.gmane.org; Sat, 16 Jan 2010 09:04:44 +0100
Received: by gxk28 with SMTP id 28sf2793872gxk.6
        for <gcvm-msysgit@m.gmane.org>; Sat, 16 Jan 2010 00:04:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:x-beenthere:received:received:received
         :received:received-spf:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:message-id
         :x-original-authentication-results:x-original-sender:precedence
         :mailing-list:list-id:list-post:list-help:list-archive:x-thread-url
         :x-message-url:sender:list-unsubscribe:list-subscribe:content-type
         :content-transfer-encoding:content-disposition;
        bh=XN9uL0g616pQcQxwUBAgI28baCxR7pbiTzXYrv74t5s=;
        b=5qiEjCWofR1XgoXRPzaIwdgMGhe/3IF5Ddawfs3z3ZoyvSNpdklyLlATgfS1d0kL0L
         yB0jl64Ime92SGE/pcgVSVDCLW4grW/IG+DP8jrKmrh9VzqYiLe2xiL3bg5mYvbbvmTA
         fhggPlf6Lzuav8NVyFd4c0R2MCYINHg0RVnbg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-beenthere:received-spf:from:to:subject:date:user-agent:cc
         :references:in-reply-to:mime-version:message-id
         :x-original-authentication-results:x-original-sender:precedence
         :mailing-list:list-id:list-post:list-help:list-archive:x-thread-url
         :x-message-url:sender:list-unsubscribe:list-subscribe:content-type
         :content-transfer-encoding:content-disposition;
        b=s1OVnScdc8N9tF5I0vWVrJNXyEVowvxCy+Z7hBW0L8n/XDhw5lbyxwie07CG81JJgj
         hV3Rx6aF/sOH5kbhDpSMx3gjFVsLbqudBFV3NN3LgUzZzX+on1Ax6Fub4QQjFqHW6G2S
         Ig1/ltfiOBIcSJdOffWZNufXXWedXuEq+MfI8=
Received: by 10.101.165.32 with SMTP id s32mr260358ano.8.1263629065698;
        Sat, 16 Jan 2010 00:04:25 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.204.13.214 with SMTP id d22ls839478bka.0.p; Sat, 16 Jan 2010 
	00:04:24 -0800 (PST)
Received: by 10.204.155.87 with SMTP id r23mr108355bkw.25.1263629064036;
        Sat, 16 Jan 2010 00:04:24 -0800 (PST)
Received: by 10.204.155.87 with SMTP id r23mr108354bkw.25.1263629064018;
        Sat, 16 Jan 2010 00:04:24 -0800 (PST)
Received: from bsmtp.bon.at (bsmtp4.bon.at [195.3.86.186])
        by gmr-mx.google.com with ESMTP id 18si172640bwz.5.2010.01.16.00.04.23;
        Sat, 16 Jan 2010 00:04:23 -0800 (PST)
Received-SPF: neutral (google.com: 195.3.86.186 is neither permitted nor denied by best guess record for domain of j6t@kdbg.org) client-ip=195.3.86.186;
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 7832CA7EBA;
	Sat, 16 Jan 2010 09:04:22 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 4B22B19F5EC;
	Sat, 16 Jan 2010 09:03:25 +0100 (CET)
User-Agent: KMail/1.9.10
In-Reply-To: <40aa078e1001151453i3576a345k217944c38887b61f@mail.gmail.com>
X-Original-Authentication-Results: gmr-mx.google.com; spf=neutral (google.com: 
	195.3.86.186 is neither permitted nor denied by best guess record for domain 
	of j6t@kdbg.org) smtp.mail=j6t@kdbg.org
X-Original-Sender: j6t@kdbg.org
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
List-Post: <http://groups.google.com/group/msysgit/post?hl=>, 
	<mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/?hl=>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit?hl=>
X-Thread-Url: http://groups.google.com/group/msysgit/t/43ea563cecdc45de
X-Message-Url: http://groups.google.com/group/msysgit/msg/965a0475c3ff4bb7
Sender: msysgit@googlegroups.com
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe?hl=>, 
	<mailto:msysgit+unsubscribe@googlegroups.com>
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe?hl=>, 
	<mailto:msysgit+subscribe@googlegroups.com>
Content-Disposition: inline
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137206>

On Freitag, 15. Januar 2010, Erik Faye-Lund wrote:
> On Fri, Jan 15, 2010 at 11:30 PM, Johannes Sixt <j6t@kdbg.org> wrote:
> > On Freitag, 15. Januar 2010, Erik Faye-Lund wrote:
> >> @@ -729,7 +729,7 @@ static pid_t mingw_spawnve(const char *cmd, const
> >> char **argv, char **env, return -1;
> >>       }
> >>       CloseHandle(pi.hThread);
> >> -     return (pid_t)pi.hProcess;
> >> +     return (pid_t)pi.dwProcessId;
> >>  }
> >
> > You are not using the pi.hProcess anymore, so you must close it.
>
> No. If I do, the pid becomes invalid after the process is finished,
> and waitpid won't work. I couldn't find anywhere were we actually were
> closing the handle, even after it was finished. So I don't think we
> leak any more than we already did (for non-daemon purposes).

Previously, this handle was closed by _cwait() (it was the "pid"), so we 
didn't leak it.

I somehow thought that you need the process ID instead of the handle for 
TerminateProcess, but now I see that this is not the case (it takes the 
handle). So I don't see the point of this change anymore. You say the process 
handle "does not work consistently with getpid", but I don't know what you 
mean. Please explain.

-- Hannes
