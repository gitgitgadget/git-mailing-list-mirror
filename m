From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v7 11/16] trace: add 'file:line' to all trace output
Date: Wed, 02 Jul 2014 12:12:22 -0700
Message-ID: <xmqqegy3h8x5.fsf@gitster.dls.corp.google.com>
References: <53B33C05.5090900@gmail.com> <53B33DED.3030809@gmail.com>
	<xmqqionfh9lp.fsf@gitster.dls.corp.google.com>
	<53B45810.9000806@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>,  msysGit <msysgit@googlegroups.com>
To: Karsten Blees <karsten.blees@gmail.com>
X-From: msysgit+bncBCG77UMM3EJRBHNT2GOQKGQEDIAGSWQ@googlegroups.com Wed Jul 02 21:12:32 2014
Return-path: <msysgit+bncBCG77UMM3EJRBHNT2GOQKGQEDIAGSWQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-qa0-f55.google.com ([209.85.216.55])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCG77UMM3EJRBHNT2GOQKGQEDIAGSWQ@googlegroups.com>)
	id 1X2PxG-0008L4-Tn
	for gcvm-msysgit@m.gmane.org; Wed, 02 Jul 2014 21:12:31 +0200
Received: by mail-qa0-f55.google.com with SMTP id m5sf2504312qaj.20
        for <gcvm-msysgit@m.gmane.org>; Wed, 02 Jul 2014 12:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=aUu7l48P3WJOe7iN4L6ebT45G4rcaCVlPEncFydFae8=;
        b=HGS5N8E52mSqjH+3P5UgXVemdY+wME9g8iDu45CFf2keQ9KHza9A5xFFgiEfG/0E8G
         5mz2gDabQmB3Dk0iCzFLVssWcwRVmMWT24a1gvVshz2sczPdDaRSvyMvaz+afevyKfDw
         6XTLhG1Zrjk9A61TZqfruAktPQk4I/QM17d/OqzfQGmDN2CxNTfs6OZOtAsRN3pbPJxx
         WHyV59dX9FTIuMZHYvKEnsYJrm2x0CpMk+KzjArd43UN+7VIrEnctY7U+Xb13IvRy6+G
         e+zKRKPMPI8CIz0VXGom2BN93KxCCmaWAmLUQylMm+2noOisiCbAYBA8NMUm+nVdpS6d
         To0g==
X-Received: by 10.182.71.107 with SMTP id t11mr121099obu.11.1404328350141;
        Wed, 02 Jul 2014 12:12:30 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.182.111.193 with SMTP id ik1ls127637obb.12.gmail; Wed, 02 Jul
 2014 12:12:29 -0700 (PDT)
X-Received: by 10.182.105.230 with SMTP id gp6mr31314501obb.18.1404328349213;
        Wed, 02 Jul 2014 12:12:29 -0700 (PDT)
Received: from smtp.pobox.com (smtp.pobox.com. [208.72.237.35])
        by gmr-mx.google.com with ESMTP id w4si723828qcd.3.2014.07.02.12.12.29
        for <msysgit@googlegroups.com>;
        Wed, 02 Jul 2014 12:12:29 -0700 (PDT)
Received-SPF: pass (google.com: domain of junio@pobox.com designates 208.72.237.35 as permitted sender) client-ip=208.72.237.35;
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 27F2D232A7;
	Wed,  2 Jul 2014 15:12:18 -0400 (EDT)
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1E96C232A6;
	Wed,  2 Jul 2014 15:12:18 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id E37122329D;
	Wed,  2 Jul 2014 15:12:12 -0400 (EDT)
In-Reply-To: <53B45810.9000806@gmail.com> (Karsten Blees's message of "Wed, 02
	Jul 2014 21:05:52 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: C5D5C63A-021C-11E4-9212-9903E9FBB39C-77302942!pb-smtp0.pobox.com
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
List-Archive: <http://groups.google.com/group/msysgit>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252833>

Karsten Blees <karsten.blees@gmail.com> writes:

>> Also, can it be set to something like __FILE__ ":" __FUNCTION__
>> which may alleviate the alleged problem of "not necessarily unique"
>> perhaps?
>
> Should work with MSVC. With GCC, however, __FUNCTION__ is a string constant
> supplied by the compiler, so string literal concatenation doesn't work.

Shucks, but not too big a deal, I guess ;-)

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
