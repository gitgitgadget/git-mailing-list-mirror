From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Re* [PATCH] send-email: recognize absolute path on Windows
Date: Tue, 15 Apr 2014 14:06:37 -0700
Message-ID: <xmqqsipejo9u.fsf@gitster.dls.corp.google.com>
References: <1397551465-10968-1-git-send-email-kusmabite@gmail.com>
	<534D0ADB.7070702@viscovery.net>
	<CABPQNSafmC-7zNJZJSZm598pF37_xUMUopgZ3c=ttL_wRDYsfQ@mail.gmail.com>
	<xmqq61maledq.fsf_-_@gitster.dls.corp.google.com>
	<xmqq1twyl46z.fsf@gitster.dls.corp.google.com>
	<CABPQNSbZvJQY-yYRf5ee_jjiqrVk5GYK-rZJ2ApH=t7c4V-nMA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Johannes Sixt <j.sixt@viscovery.net>,  GIT Mailing-list <git@vger.kernel.org>,  msysGit <msysgit@googlegroups.com>,  Johannes Schindelin <johannes.schindelin@gmx.de>
To: kusmabite@gmail.com
X-From: msysgit+bncBCG77UMM3EJRBYN6W2NAKGQEMWGSCWQ@googlegroups.com Tue Apr 15 23:06:51 2014
Return-path: <msysgit+bncBCG77UMM3EJRBYN6W2NAKGQEMWGSCWQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-ie0-f192.google.com ([209.85.223.192])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCG77UMM3EJRBYN6W2NAKGQEMWGSCWQ@googlegroups.com>)
	id 1WaAZ0-0002M4-Qt
	for gcvm-msysgit@m.gmane.org; Tue, 15 Apr 2014 23:06:42 +0200
Received: by mail-ie0-f192.google.com with SMTP id to1sf2156476ieb.29
        for <gcvm-msysgit@m.gmane.org>; Tue, 15 Apr 2014 14:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=ZcBhyOwOmXoLxLt6/GN0wQcnKv6S38Wut2+c5XtYo/E=;
        b=s5mSfwqN6IiDgu3NaGpud250kFfw7QgibBuKTCbXP+S8H01HdGTVLtgKBhSB3U56Dw
         OUIQ7Zxo+3IcY+sMeEkMrCZ+bbWqTqVb5KBLblqlkdkwjdoehbN4+UyZK5hARzX5z+br
         i5mloLAdSUabKV7U/2XcLZ8gVQlHak4zW2kXRss3CLQ1Gc+OHPuYxqYL1dqt0D8smN+4
         nLKBAYAfMeK5oICSWbx2hm+ovEVkC/hKwl3r1otHuCp/kda9R1G0nsT+k7FJP6fDgbjX
         if8laedjlSehgrPChVY30JiNnPKryn6sK8BAPVD/FvKlnH17Zs48jNCIMwpNetKpuMUG
         OrpQ==
X-Received: by 10.50.73.69 with SMTP id j5mr15945igv.14.1397596001814;
        Tue, 15 Apr 2014 14:06:41 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.50.143.5 with SMTP id sa5ls680669igb.41.gmail; Tue, 15 Apr
 2014 14:06:41 -0700 (PDT)
X-Received: by 10.68.253.66 with SMTP id zy2mr1925230pbc.1.1397596001229;
        Tue, 15 Apr 2014 14:06:41 -0700 (PDT)
Received: from smtp.pobox.com (b-pb-sasl-quonix.pobox.com. [208.72.237.35])
        by gmr-mx.google.com with ESMTP id h5si1842661qce.1.2014.04.15.14.06.41
        for <msysgit@googlegroups.com>;
        Tue, 15 Apr 2014 14:06:41 -0700 (PDT)
Received-SPF: pass (google.com: domain of junio@pobox.com designates 208.72.237.35 as permitted sender) client-ip=208.72.237.35;
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D9EFA7DDC8;
	Tue, 15 Apr 2014 17:06:40 -0400 (EDT)
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B49607DDC6;
	Tue, 15 Apr 2014 17:06:40 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CAA927DDC0;
	Tue, 15 Apr 2014 17:06:38 -0400 (EDT)
In-Reply-To: <CABPQNSbZvJQY-yYRf5ee_jjiqrVk5GYK-rZJ2ApH=t7c4V-nMA@mail.gmail.com>
	(Erik Faye-Lund's message of "Tue, 15 Apr 2014 22:49:53 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: D60501F6-C4E1-11E3-8C35-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246301>

Erik Faye-Lund <kusmabite@gmail.com> writes:

> ... But, ugh.
> Modifying File::Spec into thinking msys is Win32 doesn't seems to
> work,

OK, I'll drop the tentative version and wait for a proper reroll.

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
