From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t/lib-httpd: switch SANITY check for NOT_ROOT
Date: Thu, 12 Feb 2015 14:36:45 -0800
Message-ID: <xmqqzj8ipxj6.fsf@gitster.dls.corp.google.com>
References: <20150114211712.GE1155@peff.net>
	<064010B3-BC58-42F2-B5C0-DAADAA59B87D@gmail.com>
	<xmqqwq4n6b4c.fsf@gitster.dls.corp.google.com>
	<20150115222719.GA19021@peff.net>
	<xmqqa91j6537.fsf@gitster.dls.corp.google.com>
	<20150115235752.GB25120@peff.net>
	<xmqqh9vr4mlz.fsf@gitster.dls.corp.google.com>
	<20150116013256.GA25894@peff.net>
	<BEFF558C-774D-4891-96A0-BE962F8070E7@gmail.com>
	<20150116033445.GA29572@peff.net> <20150116091648.GA2450@peff.net>
	<xmqqfvba37bq.fsf@gitster.dls.corp.google.com>
	<xmqqzj9i1rci.fsf@gitster.dls.corp.google.com> <54BAF1C2.60103@web.de>
	<xmqq61bzwyqp.fsf@gitster.dls.corp.google.com>
	<54C170E9.4010401@web.de>
	<xmqqlhkusc4h.fsf@gitster.dls.corp.google.com> <54C1E395.30003@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>,  "Kyle J. McKay" <mackyle@gmail.com>,  msysgit@googlegroups.com,  Git Mailing List <git@vger.kernel.org>
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: msysgit+bncBCG77UMM3EJRB76V6STAKGQEOM2JZBY@googlegroups.com Thu Feb 12 23:36:49 2015
Return-path: <msysgit+bncBCG77UMM3EJRB76V6STAKGQEOM2JZBY@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-ie0-f189.google.com ([209.85.223.189])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCG77UMM3EJRB76V6STAKGQEOM2JZBY@googlegroups.com>)
	id 1YM2NM-0001RW-Qs
	for gcvm-msysgit@m.gmane.org; Thu, 12 Feb 2015 23:36:48 +0100
Received: by iecvy18 with SMTP id vy18sf3401875iec.0
        for <gcvm-msysgit@m.gmane.org>; Thu, 12 Feb 2015 14:36:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe;
        bh=B2jlSXSLouXwXvoaPu2URRRGg54+3sMqdHYnvEGTF84=;
        b=pcRwIPreOeu5WAe5d2apQPlXFZsfZEevAUZw81m5PEZxJoc+p7Zhj0rQSKeo26TVMB
         nw3inZmrXc/mra8OZ08FDfYV4upN8L2r7IhNFns2yIp7jIIlKQi9jbomLVQxRS6e05sM
         kzP/xAv+rY46xD6D80DGU6BMJRfgyuVQSgYvc26RRVhACbLCT/YiOpofOrhcUzbJnblC
         Uy7c4WPF2Qnt7q1DuS0mogQML550jqY6Quxlz8X1Vgyd0jp1oJrwNVZrnV4UCjTdALf/
         rz05SjJTBTX16+nOXhEoyqF/zypQQgXLnPx/nnSgikO6mELy3hs5/EblTF7WBW3Ncl6G
         hOhg==
X-Received: by 10.50.3.42 with SMTP id 10mr134649igz.3.1423780607997;
        Thu, 12 Feb 2015 14:36:47 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.50.20.137 with SMTP id n9ls350572ige.33.gmail; Thu, 12 Feb
 2015 14:36:47 -0800 (PST)
X-Received: by 10.50.26.40 with SMTP id i8mr5352753igg.8.1423780607329;
        Thu, 12 Feb 2015 14:36:47 -0800 (PST)
Received: from sasl.smtp.pobox.com (pb-smtp1.int.icgroup.com. [208.72.237.35])
        by gmr-mx.google.com with ESMTP id q2si966510qcn.2.2015.02.12.14.36.47
        for <msysgit@googlegroups.com>;
        Thu, 12 Feb 2015 14:36:47 -0800 (PST)
Received-SPF: pass (google.com: domain of junio@pobox.com designates 208.72.237.35 as permitted sender) client-ip=208.72.237.35;
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DB7D437640;
	Thu, 12 Feb 2015 17:36:46 -0500 (EST)
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D168B3763E;
	Thu, 12 Feb 2015 17:36:46 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 598493763D;
	Thu, 12 Feb 2015 17:36:46 -0500 (EST)
In-Reply-To: <54C1E395.30003@web.de> ("Torsten =?utf-8?Q?B=C3=B6gershausen?=
 =?utf-8?Q?=22's?= message of
	"Fri, 23 Jan 2015 07:00:53 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A05105E0-B307-11E4-B09B-A4119F42C9D4-77302942!pb-smtp1.pobox.com
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263777>

So after discussing this one and queuing the resulting three-patch
series jk/sanity that consists of the three patches:

    * jk/sanity (2015-01-27) 3 commits
     - test-lib.sh: set prerequisite SANITY by testing what we really need
     - tests: correct misuses of POSIXPERM
     - t/lib-httpd: switch SANITY check for NOT_ROOT

     Waiting for ack or counter-proposal from Torsten.
     Otherwise looking good.

Do we want to proceed with these, or do we want any more work done
on them?

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
You received this message because you are subscribed to the Google Groups "Git for Windows" group.
To unsubscribe from this group and stop receiving emails from it, send an email to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
