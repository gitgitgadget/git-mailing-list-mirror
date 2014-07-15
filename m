From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/3] fix test suite with mingw-unicode patches
Date: Tue, 15 Jul 2014 11:20:14 -0700
Message-ID: <xmqq38e2wkkh.fsf@gitster.dls.corp.google.com>
References: <20140712075035.GA12400@ucw.cz>
	<1405431797-20899-1-git-send-email-kasal@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Karsten Blees <karsten.blees@gmail.com>,  Johannes Sixt <j6t@kdbg.org>,  GIT Mailing-list <git@vger.kernel.org>,  msysGit <msysgit@googlegroups.com>
To: Stepan Kasal <kasal@ucw.cz>
X-From: msysgit+bncBCG77UMM3EJRBZXBSWPAKGQEV37L2LY@googlegroups.com Tue Jul 15 20:20:24 2014
Return-path: <msysgit+bncBCG77UMM3EJRBZXBSWPAKGQEV37L2LY@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-ob0-f186.google.com ([209.85.214.186])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCG77UMM3EJRBZXBSWPAKGQEV37L2LY@googlegroups.com>)
	id 1X77Ky-0000zs-2M
	for gcvm-msysgit@m.gmane.org; Tue, 15 Jul 2014 20:20:24 +0200
Received: by mail-ob0-f186.google.com with SMTP id wn1sf1649048obc.3
        for <gcvm-msysgit@m.gmane.org>; Tue, 15 Jul 2014 11:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=KrkCIxImZ3n6psqSgjfiL/Y05xWJqH6GdliJbzo06Po=;
        b=AR9ZUS9r8UqBkEAwbYaGK4Z/DoZeZES+Cj4UhSVb6ozWNennkvg6Hh/IicTUBJJDn+
         JLk6NDEEZFdIw3VLB3NoxckqeJpNhU3VoCPfTfh6bW5JLlo7RBpNxCnBnVcrDvSZI1tO
         WGrqhu/HD6xnpIDBAHy25QKNa0tkcqugucXbnLphPyeoviGR+Up6HIdCtcnfUqLvL5VS
         dFHUFFVH99qngEjzffGVzzsljbj5fjJC/ytV4SYFXylitw2v2r436T3aDVf025DHA+ws
         sOxWG6jEpYuepcbAdT1WFNeBLGEGgpqYjmvl3zu5p+ZdaJyoVdDw0mKXSXvoDAKpFu4X
         fLeA==
X-Received: by 10.50.79.230 with SMTP id m6mr158133igx.6.1405448423179;
        Tue, 15 Jul 2014 11:20:23 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.50.66.243 with SMTP id i19ls558482igt.3.gmail; Tue, 15 Jul
 2014 11:20:22 -0700 (PDT)
X-Received: by 10.66.220.129 with SMTP id pw1mr11759040pac.10.1405448422370;
        Tue, 15 Jul 2014 11:20:22 -0700 (PDT)
Received: from smtp.pobox.com (smtp.pobox.com. [208.72.237.35])
        by gmr-mx.google.com with ESMTP id y4si854026igf.1.2014.07.15.11.20.22
        for <msysgit@googlegroups.com>;
        Tue, 15 Jul 2014 11:20:22 -0700 (PDT)
Received-SPF: pass (google.com: domain of junio@pobox.com designates 208.72.237.35 as permitted sender) client-ip=208.72.237.35;
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 497E128C9A;
	Tue, 15 Jul 2014 14:20:04 -0400 (EDT)
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3E07328C99;
	Tue, 15 Jul 2014 14:20:04 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 087CA28C8B;
	Tue, 15 Jul 2014 14:19:58 -0400 (EDT)
In-Reply-To: <1405431797-20899-1-git-send-email-kasal@ucw.cz> (Stepan Kasal's
	message of "Tue, 15 Jul 2014 15:43:14 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: A0B2CE0E-0C4C-11E4-A868-9903E9FBB39C-77302942!pb-smtp0.pobox.com
X-Original-Sender: gitster@pobox.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of junio@pobox.com designates 208.72.237.35 as permitted
 sender) smtp.mail=junio@pobox.com;       dkim=pass header.i=@pobox.com
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253579>

Stepan Kasal <kasal@ucw.cz> writes:

> Hello Hannes,
> attached please find the patches that Karsten pointed out:
>
> 1) The unicode file name support was omitted from his unicode patch
> series; my mistake, sorry.  There is still big part missing: support
> for unicode environment; I can only hope the tests would choke on
> that.
>
> 2) Windows cannot pass non-UTF parameters (commit messages in this
> case): original patch by Pat Thoyts was extended to apply to other
> similar cases: the commit msg is passed through stdin.
>
> If there are still problems remaining, please tell us.
>
> Thanks,
> 	Stepan
>
> Karsten Blees (2):
>   Win32: Unicode file name support (except dirent)
>   Win32: Unicode file name support (dirent)
>
> Pat Thoyts and Stepan Kasal(1):
>   tests: do not pass iso8859-1 encoded parameter

Thanks.  I'll queue these and wait for Windows folks to respond.
With favourable feedback they can go directly from pu to master, I
would think.

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
