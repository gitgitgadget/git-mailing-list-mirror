From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t0110/MinGW: skip tests that pass arbitrary
 bytes on the command line
Date: Mon, 21 Jul 2014 09:41:09 -0700
Message-ID: <xmqqzjg2k6l6.fsf@gitster.dls.corp.google.com>
References: <20140716092959.GA378@ucw.cz>
	<1405611425-10009-1-git-send-email-kasal@ucw.cz>
	<1405611425-10009-3-git-send-email-kasal@ucw.cz>
	<53C813D2.8070701@gmail.com>
	<xmqqd2d2mskv.fsf@gitster.dls.corp.google.com>
	<53CAC8EF.6020707@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Stepan Kasal <kasal@ucw.cz>,  Johannes Sixt <j6t@kdbg.org>,  GIT Mailing-list <git@vger.kernel.org>,  msysGit <msysgit@googlegroups.com>,  Johannes Schindelin <johannes.schindelin@gmx.de>
To: Karsten Blees <karsten.blees@gmail.com>
X-From: msysgit+bncBCG77UMM3EJRBLUFWWPAKGQEALK2RRA@googlegroups.com Mon Jul 21 18:41:29 2014
Return-path: <msysgit+bncBCG77UMM3EJRBLUFWWPAKGQEALK2RRA@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-qa0-f56.google.com ([209.85.216.56])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCG77UMM3EJRBLUFWWPAKGQEALK2RRA@googlegroups.com>)
	id 1X9GeN-0006bl-N1
	for gcvm-msysgit@m.gmane.org; Mon, 21 Jul 2014 18:41:19 +0200
Received: by mail-qa0-f56.google.com with SMTP id dc16sf2139511qab.1
        for <gcvm-msysgit@m.gmane.org>; Mon, 21 Jul 2014 09:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=A2zANF2vYu037lQkjmMCr+h9Dr2tAQWQA0NlO35h4Ho=;
        b=Gn3F1GtSGcjHsC22nb3CKLFUZ8n2n/e+4Ys55PO1i/fChYvc11Bh3Pg1m3rgiffRam
         NdVKRPcEb5RxQX+har/NsiHyc3BjCHBilbNl/WifKxVUIPsieWnj/zJwumx8NcP0grnh
         Wxxz5ku98uwpVq7Q3q15IA+5WHnOFbqpmkok4ZX/S1fzi62UtQoJmg+2rJHI0To+VILn
         IgEry7C7iWcQNN74YUytpVsZN1+3H1+hXC4NBo/5OFs4QAtsC/wd8H8StVPtvX9LR6UN
         +QVcWU+zjCrOCXY7QH4JciSFxG1klh4FVTcvZIp/Ii0W60HIzdFQkTyPLh804c6Gg2LO
         7Ecg==
X-Received: by 10.50.50.169 with SMTP id d9mr101247igo.2.1405960878800;
        Mon, 21 Jul 2014 09:41:18 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.50.129.99 with SMTP id nv3ls1747990igb.24.gmail; Mon, 21 Jul
 2014 09:41:18 -0700 (PDT)
X-Received: by 10.50.28.15 with SMTP id x15mr2008196igg.5.1405960878186;
        Mon, 21 Jul 2014 09:41:18 -0700 (PDT)
Received: from smtp.pobox.com (smtp.pobox.com. [208.72.237.35])
        by gmr-mx.google.com with ESMTP id v44si1055676yhv.0.2014.07.21.09.41.18
        for <msysgit@googlegroups.com>;
        Mon, 21 Jul 2014 09:41:18 -0700 (PDT)
Received-SPF: pass (google.com: domain of junio@pobox.com designates 208.72.237.35 as permitted sender) client-ip=208.72.237.35;
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id DC56529C16;
	Mon, 21 Jul 2014 12:41:17 -0400 (EDT)
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id CFBF129C14;
	Mon, 21 Jul 2014 12:41:17 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id D41FA29C0D;
	Mon, 21 Jul 2014 12:41:11 -0400 (EDT)
In-Reply-To: <53CAC8EF.6020707@gmail.com> (Karsten Blees's message of "Sat, 19
	Jul 2014 21:37:19 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: D2DFB09C-10F5-11E4-B136-9903E9FBB39C-77302942!pb-smtp0.pobox.com
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253975>

Karsten Blees <karsten.blees@gmail.com> writes:

> On Windows, the command line is a Unicode string, it is not possible to
> pass arbitrary bytes to a program. Disable tests that try to do so.
>
> Signed-off-by: Karsten Blees <blees@dcon.de>
> ---

Thanks; will replace.

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
