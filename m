From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5] MinGW(-W64) compilation
Date: Wed, 08 Oct 2014 12:23:30 -0700
Message-ID: <xmqqh9ze9xhp.fsf@gitster.dls.corp.google.com>
References: <1412791267-13356-1-git-send-email-marat@slonopotamus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org,  msysGit <msysgit@googlegroups.com>
To: Marat Radchenko <marat@slonopotamus.org>
X-From: msysgit+bncBCG77UMM3EJRBNE622QQKGQED6BKX4I@googlegroups.com Wed Oct 08 21:23:34 2014
Return-path: <msysgit+bncBCG77UMM3EJRBNE622QQKGQED6BKX4I@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-vc0-f192.google.com ([209.85.220.192])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCG77UMM3EJRBNE622QQKGQED6BKX4I@googlegroups.com>)
	id 1Xbwpi-00018M-48
	for gcvm-msysgit@m.gmane.org; Wed, 08 Oct 2014 21:23:34 +0200
Received: by mail-vc0-f192.google.com with SMTP id hq11sf1595536vcb.9
        for <gcvm-msysgit@m.gmane.org>; Wed, 08 Oct 2014 12:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=/EvUcMwpXvsc5i2NcNIpzTMdr6nHnRuJ5RjfsxBh9W4=;
        b=MEXSk8fMNKphllzYY2mHuxl/pg/5gXDgkfAp4463oZ2YPqnpje1LRyKA4sWHn1Mlqx
         t8fltVy6Uvx+qXB4t/Ve0K0pPuuSzg5ph1Zn+F6I5Ylvzy+3zZMe+PSiVFzOOu6xxdjN
         rqLKg35avY/3wgECVCtMmusuBIkexeRHloDC/Q0Yf1WPj5/xpsJi2hvfX4eIB+weU7UJ
         M+pN59qtctppxXEfEVivoq/qL3OjBSHdOWpbG92zAfEJA1rmdXuonXTu85yWbUwfRun5
         X0gU6nApNb3LcgKCgpCLfDIC8usBIw+XlVhZS424ca3ghUl6AHTP+bwy9FRWL/fMywHt
         noKg==
X-Received: by 10.182.158.68 with SMTP id ws4mr78419obb.10.1412796213366;
        Wed, 08 Oct 2014 12:23:33 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.182.176.39 with SMTP id cf7ls1278909obc.89.gmail; Wed, 08 Oct
 2014 12:23:32 -0700 (PDT)
X-Received: by 10.182.18.8 with SMTP id s8mr7602365obd.21.1412796212758;
        Wed, 08 Oct 2014 12:23:32 -0700 (PDT)
Received: from sasl.smtp.pobox.com (pb-smtp1.int.icgroup.com. [208.72.237.35])
        by gmr-mx.google.com with ESMTP id im4si391279qcb.1.2014.10.08.12.23.32
        for <msysgit@googlegroups.com>;
        Wed, 08 Oct 2014 12:23:32 -0700 (PDT)
Received-SPF: pass (google.com: domain of junio@pobox.com designates 208.72.237.35 as permitted sender) client-ip=208.72.237.35;
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 91A811474C;
	Wed,  8 Oct 2014 15:23:32 -0400 (EDT)
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 889781474B;
	Wed,  8 Oct 2014 15:23:32 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 072471474A;
	Wed,  8 Oct 2014 15:23:31 -0400 (EDT)
In-Reply-To: <1412791267-13356-1-git-send-email-marat@slonopotamus.org> (Marat
	Radchenko's message of "Wed, 8 Oct 2014 22:00:53 +0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 97175F74-4F20-11E4-BB2D-855A93717476-77302942!pb-smtp1.pobox.com
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

Marat Radchenko <marat@slonopotamus.org> writes:

> This patch series fixes building on modern MinGW and MinGW-W64 (including x86_64).

As Dscho explained in a sub-thread, I really do not want to bypass
msysgit folks when dealing with things that relate to Windows, for
at least two reasons:

 * I can be a patch monkey and apply them to my tree but then I
   would be pushing out changes that I didn't try out myself
   otherwise.  Granted, that is true for platforms other than
   Windows that I do not regularly build and test on, but when I
   know there are capable folks who have been working on Windows
   issues for a long time, not asking for their help does not make
   much sense.

 * They still have other changes that are yet to be fed to my tree,
   and I do not actively track and compare their tree.  A patch
   series prepared against my tree may collide with their ongoing
   effort to make Git on Windows platform better and risk making
   more work for them, not less.

The earlier part of your series (including the ones that were Acked
by EFL) looked sensible to me: 1-6, 9, 11, 12 (outside compat/ part
only).

I could take them directly to my tree, but that is still on "as long
as msysgit folks are OK with them" basis.

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
You received this message because you are subscribed to the Google Groups "Git for Windows" group.
To unsubscribe from this group and stop receiving emails from it, send an email to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
