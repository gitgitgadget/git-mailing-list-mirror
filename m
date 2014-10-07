From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4] MinGW(-W64) compilation
Date: Tue, 07 Oct 2014 12:01:55 -0700
Message-ID: <xmqqvbnvemak.fsf@gitster.dls.corp.google.com>
References: <1412060563-22041-1-git-send-email-marat@slonopotamus.org>
	<20141006051707.GA23305@seldon> <5432E45A.8000208@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Marat Radchenko <marat@slonopotamus.org>,  msysGit <msysgit@googlegroups.com>,  git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: msysgit+bncBCG77UMM3EJRBJXR2CQQKGQE4YPCNDY@googlegroups.com Tue Oct 07 21:02:00 2014
Return-path: <msysgit+bncBCG77UMM3EJRBJXR2CQQKGQE4YPCNDY@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-ig0-f184.google.com ([209.85.213.184])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCG77UMM3EJRBJXR2CQQKGQE4YPCNDY@googlegroups.com>)
	id 1Xba1I-0002fH-3F
	for gcvm-msysgit@m.gmane.org; Tue, 07 Oct 2014 21:02:00 +0200
Received: by mail-ig0-f184.google.com with SMTP id h15sf912637igd.1
        for <gcvm-msysgit@m.gmane.org>; Tue, 07 Oct 2014 12:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=+x3gVMvCbfAyoCBxkJlebypU19Y+5CVRMtZ8zKBDlyo=;
        b=V1ifJRLmv7Qg0c0Dedlg8x0UVpKUvJ5XrjzV5MvXsxZJxkzsByqLHEFEsqlhrMzyd7
         2UM3RNySXn3sy5vMleshWMZmWXnvhN/bP243AA/hipt2GbDGMlRXgx/HGaqupIn8QS+y
         cO6LDSLfH4LpqbFjKPupV3bPgDEjhfMrdUdZNuFa/sCzMkZzs+hElvCoosse43VrNGGT
         OW6/nropQmX8WPF7+IKMYaazNICc8SRth3xmu+kCKy3yTjaaJzkE15/yvPFqgIAcrHJS
         T7mcjeTHAUYc9DtCTvZ9ZCFBBKleXKYqMRJnjjzFcFw8qFk0wAqioaQleWVbM+wnAX1j
         49gg==
X-Received: by 10.182.158.68 with SMTP id ws4mr30435obb.10.1412708519227;
        Tue, 07 Oct 2014 12:01:59 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.182.33.104 with SMTP id q8ls1196591obi.51.gmail; Tue, 07 Oct
 2014 12:01:58 -0700 (PDT)
X-Received: by 10.182.252.231 with SMTP id zv7mr3493028obc.7.1412708518125;
        Tue, 07 Oct 2014 12:01:58 -0700 (PDT)
Received: from sasl.smtp.pobox.com (smtp.pobox.com. [208.72.237.35])
        by gmr-mx.google.com with ESMTP id g10si343542igg.0.2014.10.07.12.01.57
        for <msysgit@googlegroups.com>;
        Tue, 07 Oct 2014 12:01:58 -0700 (PDT)
Received-SPF: pass (google.com: domain of junio@pobox.com designates 208.72.237.35 as permitted sender) client-ip=208.72.237.35;
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3878014B5E;
	Tue,  7 Oct 2014 15:01:57 -0400 (EDT)
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2DC2E14B5D;
	Tue,  7 Oct 2014 15:01:57 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9B66814B5C;
	Tue,  7 Oct 2014 15:01:56 -0400 (EDT)
In-Reply-To: <5432E45A.8000208@kdbg.org> (Johannes Sixt's message of "Mon, 06
	Oct 2014 20:50:02 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 6890757C-4E54-11E4-8B68-855A93717476-77302942!pb-smtp1.pobox.com
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257945>

Johannes Sixt <j6t@kdbg.org> writes:

> Am 06.10.2014 um 07:17 schrieb Marat Radchenko:
>> On Tue, Sep 30, 2014 at 11:02:29AM +0400, Marat Radchenko wrote:
>>> This patch series fixes building on modern MinGW and MinGW-W64 (including x86_64!).
>> 
>> Junio, ping?
>> 
>
> Sorry, I forgot to report that this updated series works now for me.
>
> The patches all look reasonable. I don't have an opinion on the
> restriction that MSVC < 2010 can't be used anymore (path 08/14).

So, is that an Ack, or would you prefer to cook this first in
msysgit tree and then feed the result as part of "This series is to
shrink the difference between the mainline and msysgit" later?

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
