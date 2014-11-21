From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC 2/4] Properly accept quoted space in filenames
Date: Fri, 21 Nov 2014 14:34:59 -0800
Message-ID: <xmqqegswyygc.fsf@gitster.dls.corp.google.com>
References: <1416526682-6024-1-git-send-email-philipoakley@iee.org>
	<1416526682-6024-3-git-send-email-philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: GitList <git@vger.kernel.org>,  Marius Storm-Olsen <mstormo@gmail.com>,  Ramsay Jones <ramsay@ramsay1.demon.co.uk>,  Jonathan Nieder <jrnieder@gmail.com>,  Michael Wookey <michaelwookey@gmail.com>,  Johannes Schindelin <Johannes.Schindelin@gmx.de>,  Msysgit <msysgit@googlegroups.com>
To: Philip Oakley <philipoakley@iee.org>
X-From: msysgit+bncBCG77UMM3EJRBF74X2RQKGQEUP2I7UA@googlegroups.com Fri Nov 21 23:35:06 2014
Return-path: <msysgit+bncBCG77UMM3EJRBF74X2RQKGQEUP2I7UA@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-yk0-f185.google.com ([209.85.160.185])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCG77UMM3EJRBF74X2RQKGQEUP2I7UA@googlegroups.com>)
	id 1XrwnA-0006Tz-Ja
	for gcvm-msysgit@m.gmane.org; Fri, 21 Nov 2014 23:35:04 +0100
Received: by mail-yk0-f185.google.com with SMTP id 142sf761477ykq.22
        for <gcvm-msysgit@m.gmane.org>; Fri, 21 Nov 2014 14:35:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe;
        bh=ieuJgO0K5eTHs/aU+zO9v8mA2GnZdPyDCzRzSOnYNCE=;
        b=xDKarocjsS8f8Tj/yaaHWGIFbB6/m8lwjzeWCMHIuBIm0r0VQszvNH1NIrNOKmZIU/
         TtxlyVX8DE6X6ecHxe5Pyd8yMXeJBtf1X2s0FcIdtLQyjsBQ1fnneBOFmrHjhtgSdEnv
         Yx3W6kBdC4NV3VF3kuIRQIOo+Cj1DXPhw9KGsA4O9lgY+WFrKf1iEHM9YMwvAeea2k+e
         IZv4Eyw29/Tt1Qb5QJI7Hx4wugfgImiYFCyodvDgURCvch9tZKpN+fCAv3p/OK/dmCvj
         PTJE9/MusQTSdcNzvtCVxrio7CG65Um7g1Tsm/G38AF4yme+P7h1gxPWKGtSHvMeweE1
         ZYow==
X-Received: by 10.140.21.49 with SMTP id 46mr32079qgk.30.1416609303938;
        Fri, 21 Nov 2014 14:35:03 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.140.89.149 with SMTP id v21ls983625qgd.77.gmail; Fri, 21 Nov
 2014 14:35:03 -0800 (PST)
X-Received: by 10.236.7.232 with SMTP id 68mr6511668yhp.49.1416609303493;
        Fri, 21 Nov 2014 14:35:03 -0800 (PST)
Received: from sasl.smtp.pobox.com (pb-smtp1.int.icgroup.com. [208.72.237.35])
        by gmr-mx.google.com with ESMTP id be1si67635igb.3.2014.11.21.14.35.03
        for <msysgit@googlegroups.com>;
        Fri, 21 Nov 2014 14:35:03 -0800 (PST)
Received-SPF: pass (google.com: domain of junio@pobox.com designates 208.72.237.35 as permitted sender) client-ip=208.72.237.35;
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id ABA052090C;
	Fri, 21 Nov 2014 17:35:02 -0500 (EST)
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9E9832090A;
	Fri, 21 Nov 2014 17:35:02 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id AD62920902;
	Fri, 21 Nov 2014 17:35:01 -0500 (EST)
In-Reply-To: <1416526682-6024-3-git-send-email-philipoakley@iee.org> (Philip
	Oakley's message of "Thu, 20 Nov 2014 23:38:00 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A1BA9240-71CE-11E4-861C-42529F42C9D4-77302942!pb-smtp1.pobox.com
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

Philip Oakley <philipoakley@iee.org> writes:

>  sub handleCompileLine
>  {
>      my ($line, $lineno) = @_;
> -    my @parts = split(' ', $line);
> +    # my @parts = split(' ', $line);
> +    my @parts = quotewords('\s+', 0, $line);

Can somebody enlighten me why/if quotewords is preferrable over
shellwords in the context of this patch?


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
