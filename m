From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] dir: remove PATH_MAX limitation
Date: Fri, 11 Jul 2014 15:29:23 -0700
Message-ID: <xmqq4myn34xo.fsf@gitster.dls.corp.google.com>
References: <53B72DAA.5050007@gmail.com> <53B72DD5.6020603@gmail.com>
	<xmqqa98i7aqt.fsf@gitster.dls.corp.google.com>
	<53C036CD.902@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>,  msysGit <msysgit@googlegroups.com>
To: Karsten Blees <karsten.blees@gmail.com>
X-From: msysgit+bncBCG77UMM3EJRBSWKQGPAKGQE2E465SA@googlegroups.com Sat Jul 12 00:29:34 2014
Return-path: <msysgit+bncBCG77UMM3EJRBSWKQGPAKGQE2E465SA@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-qa0-f56.google.com ([209.85.216.56])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCG77UMM3EJRBSWKQGPAKGQE2E465SA@googlegroups.com>)
	id 1X5jJr-0000BT-Td
	for gcvm-msysgit@m.gmane.org; Sat, 12 Jul 2014 00:29:32 +0200
Received: by mail-qa0-f56.google.com with SMTP id dc16sf403225qab.21
        for <gcvm-msysgit@m.gmane.org>; Fri, 11 Jul 2014 15:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=QgFZypn7BkEPqYdRXciee5mp4IFXaJ9K5dVmiCgx07s=;
        b=M2f3r1CfcjwOImQaE1T1r2S88zngPBWHoF/hyzmFCTdpJmnN6RCIPSv9ljv3oTxNDu
         drTKP+u4jhh7egj6pvwDqkjR+vBD5wfkXycLqMLQ2xhdU6GY4aBHJ8U3egRtz3GkghlW
         agXcORSlgiE3vW+NS3lxhazitvm0p/a2hn2kZAOwOYDB31fREDBDSVuh4sAdh+fzBwas
         I779poQT/HN1lSSYR+XfqiaILUtq8f84Y+nIGaRi5ui39DiLtKFuSnnzPo4kgekI667Y
         PpeNucDVKA0wW+A+DdiYrRSOzrFNwlQpJV74e9gOb6wNxt8fPjCjR8G8QnAysYqG/Y9B
         X5mQ==
X-Received: by 10.182.40.233 with SMTP id a9mr373obl.36.1405117771175;
        Fri, 11 Jul 2014 15:29:31 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.182.119.163 with SMTP id kv3ls567303obb.94.gmail; Fri, 11 Jul
 2014 15:29:30 -0700 (PDT)
X-Received: by 10.182.209.37 with SMTP id mj5mr906751obc.7.1405117770270;
        Fri, 11 Jul 2014 15:29:30 -0700 (PDT)
Received: from smtp.pobox.com (smtp.pobox.com. [208.72.237.35])
        by gmr-mx.google.com with ESMTP id nv5si286963igb.3.2014.07.11.15.29.30
        for <msysgit@googlegroups.com>;
        Fri, 11 Jul 2014 15:29:30 -0700 (PDT)
Received-SPF: pass (google.com: domain of junio@pobox.com designates 208.72.237.35 as permitted sender) client-ip=208.72.237.35;
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8556428893;
	Fri, 11 Jul 2014 18:29:14 -0400 (EDT)
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7C7AC28892;
	Fri, 11 Jul 2014 18:29:14 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 26F4628886;
	Fri, 11 Jul 2014 18:29:09 -0400 (EDT)
In-Reply-To: <53C036CD.902@gmail.com> (Karsten Blees's message of "Fri, 11 Jul
	2014 21:11:09 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: C693B354-094A-11E4-BB6E-9903E9FBB39C-77302942!pb-smtp0.pobox.com
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253338>

Karsten Blees <karsten.blees@gmail.com> writes:

> Anyways, I'd like to kindly withdraw this patch in favor of Duy's version.
>
> http://article.gmane.org/gmane.comp.version-control.git/248310

Thanks; I've already reverted it from 'next'.

Is Duy's patch still viable?

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
