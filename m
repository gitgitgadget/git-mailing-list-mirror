From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2 06/14] mingw: use real pid
Date: Tue, 19 Jan 2010 19:19:15 +0100
Message-ID: <201001191919.16070.j6t@kdbg.org>
References: <1263591033-4992-1-git-send-email-kusmabite@gmail.com> <40aa078e1001160112k68c0daafnd6abcb715e1176fe@mail.gmail.com> <40aa078e1001181433v3c86f147wf3e6aace4501c1a8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: msysgit@googlegroups.com,
 git@vger.kernel.org
To: kusmabite@gmail.com
X-From: 34vdVSwMIB3si5sjcaf.nqflrxrfhsfnnfkdfqntor.bnl@listserv.bounces.google.com Tue Jan 19 19:20:36 2010
Return-path: <34vdVSwMIB3si5sjcaf.nqflrxrfhsfnnfkdfqntor.bnl@listserv.bounces.google.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-yw0-f150.google.com ([209.85.211.150])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXIgt-0007Ur-Na
	for gcvm-msysgit@m.gmane.org; Tue, 19 Jan 2010 19:20:36 +0100
Received: by ywh14 with SMTP id 14sf6978813ywh.21
        for <gcvm-msysgit@m.gmane.org>; Tue, 19 Jan 2010 10:20:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:x-beenthere:received:received:received
         :received:received-spf:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:message-id
         :x-original-authentication-results:x-original-sender:precedence
         :mailing-list:list-id:list-post:list-help:list-archive:x-thread-url
         :x-message-url:sender:list-unsubscribe:list-subscribe:content-type
         :content-transfer-encoding:content-disposition;
        bh=HUxBxucTZ0n5orwqAS1eXr5iBRQ6ifkIVU0dvG5xXL0=;
        b=N2SFdkWd5IWH2dqLAyZ8fE+NFuIkCoUBbWlCsiPqcASYp7hpNX1tJapxArSNNt1xdh
         FL1VvtRJ/S0NJc0MrFrYXIy45T7KnXJqypy+uJ4LQp0KPhzhPPKb+YPRSlYKArcb2pOp
         wtoasMPBqBszzXXkTVtkl++Im423NR3hNPElM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-beenthere:received-spf:from:to:subject:date:user-agent:cc
         :references:in-reply-to:mime-version:message-id
         :x-original-authentication-results:x-original-sender:precedence
         :mailing-list:list-id:list-post:list-help:list-archive:x-thread-url
         :x-message-url:sender:list-unsubscribe:list-subscribe:content-type
         :content-transfer-encoding:content-disposition;
        b=kUAkvGIRdXwXjfzd+WippPpgGEACmL1l+d7W0ZDnNTKYMo673zTtfjuuf4B1fKF/vQ
         tFJ+vHqctYcqDyNs8AfD+pjv71Y1w66MXvScuL12ooA8WioMRQVs0zmJIR6JFZwe+862
         bvil5fFoVjAXNMA7hnPjbZSK0U1qK/LOwRCIA=
Received: by 10.101.6.11 with SMTP id j11mr579859ani.30.1263925218714;
        Tue, 19 Jan 2010 10:20:18 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.213.44.133 with SMTP id a5ls1344302ebf.1.p; Tue, 19 Jan 2010 
	10:20:17 -0800 (PST)
Received: by 10.213.50.137 with SMTP id z9mr539968ebf.3.1263925217060;
        Tue, 19 Jan 2010 10:20:17 -0800 (PST)
Received: by 10.213.50.137 with SMTP id z9mr539967ebf.3.1263925216930;
        Tue, 19 Jan 2010 10:20:16 -0800 (PST)
Received: from bsmtp.bon.at (bsmtp4.bon.at [195.3.86.186])
        by gmr-mx.google.com with ESMTP id 17si527793ewy.3.2010.01.19.10.20.16;
        Tue, 19 Jan 2010 10:20:16 -0800 (PST)
Received-SPF: neutral (google.com: 195.3.86.186 is neither permitted nor denied by best guess record for domain of j6t@kdbg.org) client-ip=195.3.86.186;
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id CDEA72C401F;
	Tue, 19 Jan 2010 19:20:15 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 4F17019F587;
	Tue, 19 Jan 2010 19:19:16 +0100 (CET)
User-Agent: KMail/1.9.10
In-Reply-To: <40aa078e1001181433v3c86f147wf3e6aace4501c1a8@mail.gmail.com>
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
X-Message-Url: http://groups.google.com/group/msysgit/msg/f2e89acb08057233
Sender: msysgit@googlegroups.com
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe?hl=>, 
	<mailto:msysgit+unsubscribe@googlegroups.com>
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe?hl=>, 
	<mailto:msysgit+subscribe@googlegroups.com>
Content-Disposition: inline
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137481>

On Montag, 18. Januar 2010, Erik Faye-Lund wrote:
> On Sat, Jan 16, 2010 at 10:12 AM, Erik Faye-Lund wrote:
> > On Sat, Jan 16, 2010 at 9:03 AM, Johannes Sixt <j6t@kdbg.org> wrote:
> >> On Freitag, 15. Januar 2010, Erik Faye-Lund wrote:
> >>> No. If I do, the pid becomes invalid after the process is finished,
> >>> and waitpid won't work. I couldn't find anywhere were we actually were
> >>> closing the handle, even after it was finished. So I don't think we
> >>> leak any more than we already did (for non-daemon purposes).
> >>
> >> Previously, this handle was closed by _cwait() (it was the "pid"), so we
> >> didn't leak it.
> >
> > Oh, I see. My planned route with this (before I looked for where the
> > handle was closed), was to maintain some sort of list of each started
> > PID and their handle, and lookup in that list instead of using
> > OpenProcess. I guess that would solve the problem here, but it feels a
> > bit nasty. Not as nasty as introducing a leak, though.
>
> What I had in mind was something along these lines:

Given that that the process ID is the user-visible (and system-wide unique) 
identifier of a process, this looks like the only reasonable way to go. Your 
implementation looks good as well.

> +	/* store process handle */

	/*
	 * The process ID is the human-readable identifier of the process
	 * that we want to present in log and error messages. The handle
	 * is not useful for this purpose. But we cannot close it, either,
	 * because it is not possible to turn a process ID into a process
	 * handle after the process terminated.
	 * Keep the handle in a list for waitpid.
	 */

> +	num_pinfo++;
> +	pinfo = xrealloc(pinfo, sizeof(struct pid_info) * num_pinfo);
> +	pinfo[num_pinfo - 1].pid = pi.dwProcessId;
> +	pinfo[num_pinfo - 1].proc = pi.hProcess;
> +
>  	return (pid_t)pi.dwProcessId;

-- Hannes
