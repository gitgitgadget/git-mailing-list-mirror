From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 2/3] Windows: a test_cmp that is agnostic to
 random LF <> CRLF conversions
Date: Sun, 03 Nov 2013 09:32:00 +0100
Message-ID: <52760A00.4080208@kdbg.org>
References: <cover.1382814437.git.j6t@kdbg.org>	<e64878fec3f026802e8d3958a1e6213428cab778.1382814437.git.j6t@kdbg.org>	<52756198.2070900@gmail.com>	<52756332.50404@kdbg.org> <CAHGBnuOHHAZUD_1WWu+WrAYKB1f0BonztbAFzVqhxP0bjAkyfw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git Mailing List <git@vger.kernel.org>, 
 msysGit Mailinglist <msysgit@googlegroups.com>
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: msysgit+bncBCJYV6HBKQIIHFGYSMCRUBA53QEJQ@googlegroups.com Sun Nov 03 09:32:05 2013
Return-path: <msysgit+bncBCJYV6HBKQIIHFGYSMCRUBA53QEJQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wi0-f184.google.com ([209.85.212.184])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCJYV6HBKQIIHFGYSMCRUBA53QEJQ@googlegroups.com>)
	id 1Vct6K-0001qW-Ee
	for gcvm-msysgit@m.gmane.org; Sun, 03 Nov 2013 09:32:04 +0100
Received: by mail-wi0-f184.google.com with SMTP id ez12sf308533wid.21
        for <gcvm-msysgit@m.gmane.org>; Sun, 03 Nov 2013 01:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=ldEPOfQuBlJWrbZAJ65PxapMbUkNvXqkn2L+GPR+mUA=;
        b=My6yQfue4DNqRk7lzGQtSnm9m724yOxIEliiMqEr3Eyks5cJ6vnFlDiU8wpmmeIJ89
         c7dbPXLnoa0lxBR16Uml4nu6YdliV43iDbHoOBNpwbAVJpKsF95F8GaHaNXz3VB6FQAs
         Bmad73IQql0zJbv3dchI7XCbGjagePZyKY7IFEXmD4iRWxzI8QNwLLJ+SbB5RaFUVHN+
         dC8wCLsIIMgrcTNwFlzzaFDF1XgD9IYIz6vyHpPJODDTVgrsCkxplX61BBH60Kggd5LY
         OPJPSf7t5hLJkm/Y8T3Ry2BhVgndlLhmEahLRnJJllDm82TIFhoZ9HeZGrF960qarbyb
         75Vg==
X-Received: by 10.152.120.129 with SMTP id lc1mr610lab.7.1383467524039;
        Sun, 03 Nov 2013 01:32:04 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.9.68 with SMTP id x4ls313707laa.106.gmail; Sun, 03 Nov
 2013 01:32:03 -0700 (PDT)
X-Received: by 10.152.3.97 with SMTP id b1mr324030lab.6.1383467523241;
        Sun, 03 Nov 2013 01:32:03 -0700 (PDT)
Received: from bsmtp.bon.at (bsmtp5.bon.at. [195.3.86.187])
        by gmr-mx.google.com with ESMTPS id a1si1735200ees.1.2013.11.03.01.32.03
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 03 Nov 2013 01:32:03 -0700 (PDT)
Received-SPF: neutral (google.com: 195.3.86.187 is neither permitted nor denied by best guess record for domain of j6t@kdbg.org) client-ip=195.3.86.187;
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 865C11000B;
	Sun,  3 Nov 2013 09:32:02 +0100 (CET)
Received: from dx.sixt.local (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 428CC19F60F;
	Sun,  3 Nov 2013 09:32:01 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.0
In-Reply-To: <CAHGBnuOHHAZUD_1WWu+WrAYKB1f0BonztbAFzVqhxP0bjAkyfw@mail.gmail.com>
X-Original-Sender: j6t@kdbg.org
X-Original-Authentication-Results: gmr-mx.google.com;       spf=neutral
 (google.com: 195.3.86.187 is neither permitted nor denied by best guess
 record for domain of j6t@kdbg.org) smtp.mail=j6t@kdbg.org
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237257>

Am 02.11.2013 21:47, schrieb Sebastian Schuberth:
> So maybe it's a good point now to also change the MINGW prerequisite
> name to MSYS as part of your patch, and then name the functions more
> appropriately?

It's too late. The series is already in master, and I see no point in a
follow-up patch of this kind as long as there is no additional benefit.

-- Hannes

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
For more options, visit https://groups.google.com/groups/opt_out.
