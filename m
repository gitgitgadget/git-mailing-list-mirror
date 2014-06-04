From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] t5000, t5003: do not use test_cmp to compare
 binary files
Date: Wed, 04 Jun 2014 11:22:56 -0700
Message-ID: <xmqq8upcv8jj.fsf@gitster.dls.corp.google.com>
References: <20140604114252.GA22250@camelia.ucw.cz>
	<538F0D78.3020708@virtuell-zuhause.de>
	<20140604124257.GA22415@camelia.ucw.cz>
	<538F1840.7010803@virtuell-zuhause.de>
	<20140604155752.GA23226@camelia.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: GIT Mailing-list <git@vger.kernel.org>,  Thomas Braun <thomas.braun@virtuell-zuhause.de>,  msysgit@googlegroups.com
To: Stepan Kasal <kasal@ucw.cz>
X-From: msysgit+bncBCG77UMM3EJRBBWIXWOAKGQEKNK5KMY@googlegroups.com Wed Jun 04 20:23:07 2014
Return-path: <msysgit+bncBCG77UMM3EJRBBWIXWOAKGQEKNK5KMY@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-vc0-f191.google.com ([209.85.220.191])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCG77UMM3EJRBBWIXWOAKGQEKNK5KMY@googlegroups.com>)
	id 1WsFq3-0007Od-P7
	for gcvm-msysgit@m.gmane.org; Wed, 04 Jun 2014 20:23:04 +0200
Received: by mail-vc0-f191.google.com with SMTP id id10sf2092471vcb.8
        for <gcvm-msysgit@m.gmane.org>; Wed, 04 Jun 2014 11:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=SNv2gzlvkP1N7kahcAsMScNjIXLKiX2hC/KqBQO/JX4=;
        b=aMYcqxOHtGhwpqch3uEPMY675FRPFxXIyV7IK52gXFxU70C+VDvSabBh+UND2j4xvk
         /TexCftZNT369DiVVb4ZxpHCUcFpuoVApuiotwYmKhVHwp7yvQdoeNas9W96OE8WVPJf
         fEJOdD3YFhnUem90AU459R0Iu7wpmoJA8tK7s33B77j2IFt7cpSoLKUE4WgYxEc2e77f
         LNgh7mYDnRKtcTUB27Ew8j23sHGZ2i8KIGU9JMET9zuMj1zvx89UpeZ//YoSSpahXhFZ
         ySunektHdmDHlr/hWDG59/MVS2N8h0wVtKbtEs6O9dLPib7VEOJj4oka2kY8EzSY4zVS
         9D9A==
X-Received: by 10.50.60.7 with SMTP id d7mr27393igr.10.1401906182833;
        Wed, 04 Jun 2014 11:23:02 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.51.17.104 with SMTP id gd8ls823808igd.16.gmail; Wed, 04 Jun
 2014 11:23:02 -0700 (PDT)
X-Received: by 10.50.61.146 with SMTP id p18mr2818358igr.3.1401906182059;
        Wed, 04 Jun 2014 11:23:02 -0700 (PDT)
Received: from smtp.pobox.com (smtp.pobox.com. [208.72.237.35])
        by gmr-mx.google.com with ESMTP id x2si872850qch.0.2014.06.04.11.23.01
        for <msysgit@googlegroups.com>;
        Wed, 04 Jun 2014 11:23:01 -0700 (PDT)
Received-SPF: pass (google.com: domain of junio@pobox.com designates 208.72.237.35 as permitted sender) client-ip=208.72.237.35;
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B95491910B;
	Wed,  4 Jun 2014 14:23:01 -0400 (EDT)
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B03631910A;
	Wed,  4 Jun 2014 14:23:01 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 1505C19104;
	Wed,  4 Jun 2014 14:22:58 -0400 (EDT)
In-Reply-To: <20140604155752.GA23226@camelia.ucw.cz> (Stepan Kasal's message
	of "Wed, 4 Jun 2014 17:57:52 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 410B2E4E-EC15-11E3-A603-9903E9FBB39C-77302942!pb-smtp0.pobox.com
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250753>

Stepan Kasal <kasal@ucw.cz> writes:

> test_cmp() is primarily meant to compare text files (and display the
> difference for debug purposes).
>
> Raw "cmp" is better suited to compare binary files (tar, zip, etc.).
>
> On MinGW, test_cmp is a shell function mingw_test_cmp that tries to
> read both files into environment, stripping CR characters (introduced
> in commit 4d715ac0).
>
> This function usually speeds things up, as fork is extremly slow on
> Windows.  But no wonder that this function is extremely slow and
> sometimes even crashes when comparing large tar or zip files.
>
> Signed-off-by: Stepan Kasal <kasal@ucw.cz>
> ---
>
> Hi Thomas,
> On Wed, Jun 04, 2014 at 02:59:44PM +0200, Thomas Braun wrote:
>> Using test_cmp_bin instead of cmp would result in then four assertions
>> for comparing arbitrary data
>> test_cmp
>> test_i18ncmp
>> test_cmp_text
>> test_cmp_bin
>> where I think the purpose of each function is clear from its name.
>
> [test_cmp_text does not exist (yet)]
>
> OK, I agree, hence this modified version of the patch.

Yeah, I think the above reasoning is sound.  And I do not think we
ever need to have test_cmp_text -- our payload and our messages
compared by tests to make sure our expectations hold are text by
default.

Will queue; thanks.

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
