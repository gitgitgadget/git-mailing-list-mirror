From: Junio C Hamano <gitster@pobox.com>
Subject: Re: http getpass function in msysgit
Date: Tue, 02 Feb 2010 21:32:06 -0800
Message-ID: <7vpr4mrijt.fsf@alter.siamese.dyndns.org>
References: <1976ea661002021918m19d9b37fx1872557d3c810e3a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,  msysGit <msysgit@googlegroups.com>
To: Frank Li <lznuaa@gmail.com>
X-From: 3YwppSwcJByIEGRQRCPNM9MV.AMKKQWQEGREMMEJCEPMSNQ.AMK@groups.bounces.google.com Wed Feb 03 06:32:41 2010
Return-path: <3YwppSwcJByIEGRQRCPNM9MV.AMKKQWQEGREMMEJCEPMSNQ.AMK@groups.bounces.google.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-qy0-f168.google.com ([209.85.221.168])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <3YwppSwcJByIEGRQRCPNM9MV.AMKKQWQEGREMMEJCEPMSNQ.AMK@groups.bounces.google.com>)
	id 1NcXqw-0003RJ-SP
	for gcvm-msysgit@m.gmane.org; Wed, 03 Feb 2010 06:32:39 +0100
Received: by qyk40 with SMTP id 40sf1566415qyk.13
        for <gcvm-msysgit@m.gmane.org>; Tue, 02 Feb 2010 21:32:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:x-beenthere:received:received:received
         :received:received-spf:received:received:received:to:cc:subject
         :references:from:date:in-reply-to:message-id:user-agent:mime-version
         :x-pobox-relay-id:x-original-authentication-results
         :x-original-sender:precedence:mailing-list:list-id:list-post
         :list-help:list-archive:x-thread-url:x-message-url:sender
         :list-subscribe:list-unsubscribe:content-type;
        bh=4MtopxYF63vENpuNaI4t92YHpe/w4I7khmgniLtCvn4=;
        b=P1yG6zqH2xpJWxyp+otwNXQEhrAoaQALk6b2lSLr9lxkMYUcQW2WW5CTAQvFv07NkH
         KTle/g/l742L0l0A0sT/z43nBV8xKaRJLddsYRANbjzjToa5bgrgh1Agk/izsvgint94
         ZrS1O0+jnoEcdPrWIdodAmiK+m8hY7G/zZUZA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-beenthere:received-spf:to:cc:subject:references:from:date
         :in-reply-to:message-id:user-agent:mime-version:x-pobox-relay-id
         :x-original-authentication-results:x-original-sender:precedence
         :mailing-list:list-id:list-post:list-help:list-archive:x-thread-url
         :x-message-url:sender:list-subscribe:list-unsubscribe:content-type;
        b=hLUQ0EIof+YBpkksCFLtkLvoYnTfbM+cT7eG03YeewpZSE0gAUIAItComjNbeQZR2E
         XHn9Bgj/3QLk/NkWRm6Nz0HMi2jhlgH+7QSNgarTnB0CV0bLRFKWfpyRxsnyDFxx11dW
         zYk0c+qJy4/RtKvIGXa2yHmGRdbAoslmjvV0I=
Received: by 10.229.111.83 with SMTP id r19mr56730qcp.40.1265175139765;
        Tue, 02 Feb 2010 21:32:19 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.229.106.21 with SMTP id v21ls881775qco.1.p; Tue, 02 Feb 2010 
	21:32:16 -0800 (PST)
Received: by 10.229.73.210 with SMTP id r18mr577257qcj.16.1265175136708;
        Tue, 02 Feb 2010 21:32:16 -0800 (PST)
Received: by 10.229.73.210 with SMTP id r18mr577256qcj.16.1265175136684;
        Tue, 02 Feb 2010 21:32:16 -0800 (PST)
Received: from sasl.smtp.pobox.com (a-pb-sasl-quonix.pobox.com [208.72.237.25])
        by gmr-mx.google.com with ESMTP id 25si1722069qyk.11.2010.02.02.21.32.15;
        Tue, 02 Feb 2010 21:32:15 -0800 (PST)
Received-SPF: pass (google.com: domain of gitster@pobox.com designates 208.72.237.25 as permitted sender) client-ip=208.72.237.25;
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1304F96FA5;
	Wed,  3 Feb 2010 00:32:15 -0500 (EST)
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D626796FA3;
	Wed,  3 Feb 2010 00:32:11 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 13ADE96F9F; Wed,  3 Feb
 2010 00:32:07 -0500 (EST)
In-Reply-To: <1976ea661002021918m19d9b37fx1872557d3c810e3a@mail.gmail.com>
 (Frank Li's message of "Wed\, 3 Feb 2010 11\:18\:23 +0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 7AA159C8-1085-11DF-AD26-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com: 
	domain of gitster@pobox.com designates 208.72.237.25 as permitted sender) 
	smtp.mail=gitster@pobox.com; dkim=pass header.i=@pobox.com
X-Original-Sender: gitster@pobox.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
List-Post: <http://groups.google.com/group/msysgit/post?hl=en_US>, 
	<mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/?hl=en_US>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit?hl=en_US>
X-Thread-Url: http://groups.google.com/group/msysgit/t/e0b9a84c84202f7d
X-Message-Url: http://groups.google.com/group/msysgit/msg/bb5efaa00593a5ac
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en_US>, 
	<mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en_US>, 
	<mailto:msysgit+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138806>

Frank Li <lznuaa@gmail.com> writes:

>         getpass at mingw.c is direct read character with function _getch().
>         GUI application, such tortoisegit will halt when http need
> password input because gui don't know git wait for inputing passwords.
>
>         To resolve this problem, I have two options.
>         Options 1:
>                 Check if terminal is exist, if exist, using old
> method. Otherwise launch internal password dialog.
>
>         Options 2:
>                 like openSSH,  Check if terminal is not exist and
> environment HTTP_ASKPASS exist, if true, run application which
> HTTP_ASKPASS point, otherwise using old ways.
>
>        Which one do you prefer,  I can implement it.

Is "Neither, at least not yet" an accepted answer?

 - If you look at an environment, why check terminal at all?  If the
   calling application wants to specify "here is the way to ask the user
   for a password" with it, why not use it unconditionally?

 - Why is it HTTP_ASKPASS?  If other codepaths (e.g. "ssh passphrase",
   "svn password") that do not have anything to do with HTTP transfer also
   wants that feature, wouldn't it be easier for the users to specify one
   single "password dialog" helper program, that is launched by various
   parts of git, and ask "I need the HTTP password to access li.org", "I
   need to unlock the ssh key for fl@li.org", etc?
