From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Re: [PATCH] t/lib-httpd: switch SANITY check for NOT_ROOT
Date: Sun, 15 Feb 2015 15:48:32 -0800
Message-ID: <xmqqwq3i7n3j.fsf@gitster.dls.corp.google.com>
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
	<xmqqzj8ipxj6.fsf@gitster.dls.corp.google.com>
	<54DF091B.9070903@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Cc: Jeff King <peff@peff.net>,  "Kyle J. McKay" <mackyle@gmail.com>,  msysgit@googlegroups.com,  Git Mailing List <git@vger.kernel.org>
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: msysgit+bncBCG77UMM3EJRBU7AQSTQKGQEZL42KBQ@googlegroups.com Mon Feb 16 00:48:39 2015
Return-path: <msysgit+bncBCG77UMM3EJRBU7AQSTQKGQEZL42KBQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-qc0-f186.google.com ([209.85.216.186])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCG77UMM3EJRBU7AQSTQKGQEZL42KBQ@googlegroups.com>)
	id 1YN8vU-0007kW-Qi
	for gcvm-msysgit@m.gmane.org; Mon, 16 Feb 2015 00:48:36 +0100
Received: by mail-qc0-f186.google.com with SMTP id l6sf6789613qcy.3
        for <gcvm-msysgit@m.gmane.org>; Sun, 15 Feb 2015 15:48:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:content-transfer-encoding
         :x-original-sender:x-original-authentication-results:precedence
         :mailing-list:list-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe;
        bh=ySHRnc+JfeXAysZAWW0Kb9BFthr9gL4rFEfcmZ4TlfY=;
        b=YPnEwxOswTWDghy0YDGZKxEDsIWQBCTHuutv4Vtog+irw0IQyom6V9+u2vKA3TI6wo
         dMsX4NndZxvmZXizOWxJfWmhDpRvT3ciMCB2Rlzgdrln5NX5MbuQsUd/TKQAcG3wIvVd
         sws6jf9fZAxNYGZccSdFkG44aFtjgESAmpO5Im69MTrqA7SYYb6FSUpEwmh1rrgPE2QN
         UqQd59fQXIpq6JvpW1Tx5Nuk9xutbRfHhf9g9Jv2KgPzqheq+Mzl9y9cln808aA8/xvv
         nD8Q7zFxfU6CaN5f/BjHyvnstrwdJ4VioDeKSf5QfnBPNrwBaMB0MTHeE8Bt4uEZnCNH
         NYUA==
X-Received: by 10.50.253.1 with SMTP id zw1mr332984igc.11.1424044116154;
        Sun, 15 Feb 2015 15:48:36 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.50.33.10 with SMTP id n10ls579188igi.25.gmail; Sun, 15 Feb
 2015 15:48:35 -0800 (PST)
X-Received: by 10.50.2.71 with SMTP id 7mr18283592igs.4.1424044115498;
        Sun, 15 Feb 2015 15:48:35 -0800 (PST)
Received: from sasl.smtp.pobox.com (pb-smtp1.int.icgroup.com. [208.72.237.35])
        by gmr-mx.google.com with ESMTP id u2si942769igh.0.2015.02.15.15.48.35
        for <msysgit@googlegroups.com>;
        Sun, 15 Feb 2015 15:48:35 -0800 (PST)
Received-SPF: pass (google.com: domain of junio@pobox.com designates 208.72.237.35 as permitted sender) client-ip=208.72.237.35;
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 52CB639DB9;
	Sun, 15 Feb 2015 18:48:34 -0500 (EST)
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 49BDB39DB8;
	Sun, 15 Feb 2015 18:48:34 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C358439DB7;
	Sun, 15 Feb 2015 18:48:33 -0500 (EST)
In-Reply-To: <54DF091B.9070903@web.de> ("Torsten =?utf-8?Q?B=C3=B6gershaus?=
 =?utf-8?Q?en=22's?= message of
	"Sat, 14 Feb 2015 09:36:43 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 26FCFA4C-B56D-11E4-9E75-A4119F42C9D4-77302942!pb-smtp1.pobox.com
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263862>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> The work to "be done", what I can see: please amend the commit message:=
=20
>  s/more exotic//

Thanks for reminding; I thought this was excised already but
apparently hasn't (yet).

--=20
--=20
*** Please reply-to-all at all times ***
*** (do not pretend to know who is subscribed and who is not) ***
*** Please avoid top-posting. ***
The msysGit Wiki is here: https://github.com/msysgit/msysgit/wiki - Github =
accounts are free.

You received this message because you are subscribed to the Google
Groups "msysGit" group.
To post to this group, send email to msysgit@googlegroups.com
To unsubscribe from this group, send email to
msysgit+unsubscribe@googlegroups.com
For more options, and view previous threads, visit this group at
http://groups.google.com/group/msysgit?hl=3Den_US?hl=3Den

---=20
You received this message because you are subscribed to the Google Groups "=
Git for Windows" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
