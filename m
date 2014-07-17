From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 00/13] mingw unicode environment
Date: Thu, 17 Jul 2014 11:20:38 -0700
Message-ID: <xmqqfvhzq22x.fsf@gitster.dls.corp.google.com>
References: <1405611486-10176-1-git-send-email-kasal@ucw.cz>
	<53C8115D.8040505@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Stepan Kasal <kasal@ucw.cz>,  GIT Mailing-list <git@vger.kernel.org>,  msysGit <msysgit@googlegroups.com>
To: Karsten Blees <karsten.blees@gmail.com>
X-From: msysgit+bncBCG77UMM3EJRBOVKUCPAKGQEKGBWXJQ@googlegroups.com Thu Jul 17 20:26:06 2014
Return-path: <msysgit+bncBCG77UMM3EJRBOVKUCPAKGQEKGBWXJQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-pa0-f56.google.com ([209.85.220.56])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCG77UMM3EJRBOVKUCPAKGQEKGBWXJQ@googlegroups.com>)
	id 1X7qNY-0002HN-KE
	for gcvm-msysgit@m.gmane.org; Thu, 17 Jul 2014 20:26:04 +0200
Received: by mail-pa0-f56.google.com with SMTP id kq14sf785477pab.1
        for <gcvm-msysgit@m.gmane.org>; Thu, 17 Jul 2014 11:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=CvNwrbl/wN2IJ8JmhLRJMEve8gIjr3Bv41cWY+m3mp4=;
        b=eWbC4RW45kH4x7ULRei6ftkZynW/x9bLAxFEhu0g9Smaon62kQnffU9Beittf/x8be
         Zu7itx/9q29wUdJ8KHICQzPhE6NwG1o8CgqOd4T4aij73fAQrcOpkqslO/jRwwvsFhTL
         iUNxtp25kL07vPXImd29mi4R3u0UTDU5wUA/gU530XEkFyZlxPtvQ57uQa57HL9hP3HR
         IN9/Qv8ekqVtrzpVQH66QFSWQNeTnuM9j7imrcBE+KaD+8yfbSJEMEvgeZd4pQg7CVdT
         Vne/hJWoRENXYGMNMAUYykfdxMYSg9rIsVmPV1+7hW3+tfYNTRH66KQSFYm7DbkExMW3
         oucQ==
X-Received: by 10.50.254.1 with SMTP id ae1mr4783igd.2.1405621563259;
        Thu, 17 Jul 2014 11:26:03 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.50.20.5 with SMTP id j5ls1938417ige.25.gmail; Thu, 17 Jul 2014
 11:26:02 -0700 (PDT)
X-Received: by 10.42.40.148 with SMTP id l20mr73587ice.12.1405621562550;
        Thu, 17 Jul 2014 11:26:02 -0700 (PDT)
Received: from smtp.pobox.com (smtp.pobox.com. [208.72.237.35])
        by gmr-mx.google.com with ESMTP id jx1si419428qcb.1.2014.07.17.11.26.02
        for <msysgit@googlegroups.com>;
        Thu, 17 Jul 2014 11:26:02 -0700 (PDT)
Received-SPF: pass (google.com: domain of junio@pobox.com designates 208.72.237.35 as permitted sender) client-ip=208.72.237.35;
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 32A0129952;
	Thu, 17 Jul 2014 14:26:02 -0400 (EDT)
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2925A29950;
	Thu, 17 Jul 2014 14:26:02 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 2EB7129718;
	Thu, 17 Jul 2014 14:20:40 -0400 (EDT)
In-Reply-To: <53C8115D.8040505@gmail.com> (Karsten Blees's message of "Thu, 17
	Jul 2014 20:09:33 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 0E9DCAD4-0DDF-11E4-A892-9903E9FBB39C-77302942!pb-smtp0.pobox.com
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253768>

Karsten Blees <karsten.blees@gmail.com> writes:

> Am 17.07.2014 17:37, schrieb Stepan Kasal:
>
> I believe we prefer moving code to the right place over forward
> declarations (IIRC I got bashed for the latter in one of the first rounds
> of this patch series). If only to justify 'git-blame -M' :-D
>
>> One of the patches differs from the original version: "Enable color..."
>> Following Karsten's suggestion, I have changed the value of env. var.
>> TERM from "winterm" to "cygwin".  This is because the subprocesses see
>> the variable and may try to find it in (their copy of) termcap.
>
> Good! One more step towards getting rid of the git-wrapper.

OK, so the series may need further re-polishing of the polishing
done by Stepan last-minute before sending them out.  I'll still
queue but will hold in 'pu' while Windows folks can agree all is
well.

Thanks.

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
