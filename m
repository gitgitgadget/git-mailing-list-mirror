From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Windows: Allow using UNC path for git repository
Date: Tue, 20 May 2014 12:33:19 -0700
Message-ID: <xmqqppj8xn28.fsf@gitster.dls.corp.google.com>
References: <20140519132334.GA1435@camelia.ucw.cz>
	<xmqqy4xwxop7.fsf@gitster.dls.corp.google.com>
	<20140520192132.GA7355@camelia.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: GIT Mailing-list <git@vger.kernel.org>,  Erik Faye-Lund <kusmabite@gmail.com>,  msysGit <msysgit@googlegroups.com>,  Cezary Zawadka <czawadka@gmail.com>,  Eric Sunshine <sunshine@sunshineco.com>
To: Stepan Kasal <kasal@ucw.cz>
X-From: msysgit+bncBCG77UMM3EJRBBG452NQKGQEXXZ6T2Y@googlegroups.com Tue May 20 21:33:29 2014
Return-path: <msysgit+bncBCG77UMM3EJRBBG452NQKGQEXXZ6T2Y@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-qc0-f186.google.com ([209.85.216.186])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCG77UMM3EJRBBG452NQKGQEXXZ6T2Y@googlegroups.com>)
	id 1Wmpmw-0006Ye-8D
	for gcvm-msysgit@m.gmane.org; Tue, 20 May 2014 21:33:26 +0200
Received: by mail-qc0-f186.google.com with SMTP id x3sf229284qcv.13
        for <gcvm-msysgit@m.gmane.org>; Tue, 20 May 2014 12:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=njoS7isxLVlmFBXSAJG84HYkoD5ZmArt+xLb5CotDRo=;
        b=iQ8LbAYJypvN007+1jdlkYFTUFcrMGq5Mh4+k9CQFKS9se/ncpYZn+yEBnfrU+iC39
         ZYsnIJIEQQYp5/JMGpdWc96NHavTkh3xVR2WG+6v371d4tE141fAdS1xy98W+dp+ZSaI
         qySE0L2HPQXQMA1/l+KOI77uf2OEZi5sue7yPjulTA4NooGDx1ryh/20Og301v3k0vWc
         hTtqeWGV0ElKWOmZd+x1pytKOPTaDbPJpbWEucvbXp+Lv064I9f9QSdoPKC2EwrqH2l/
         3HJOc2DWvU5u31AH77d3SThGGOcB9Vme3B0kSH1t+ukvwQ39zWENiW27kJ6twWtKtX6b
         woxA==
X-Received: by 10.182.213.41 with SMTP id np9mr272816obc.3.1400614405498;
        Tue, 20 May 2014 12:33:25 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.182.66.104 with SMTP id e8ls134447obt.44.gmail; Tue, 20 May
 2014 12:33:24 -0700 (PDT)
X-Received: by 10.183.11.102 with SMTP id eh6mr20675499obd.37.1400614404634;
        Tue, 20 May 2014 12:33:24 -0700 (PDT)
Received: from smtp.pobox.com (smtp.pobox.com. [208.72.237.35])
        by gmr-mx.google.com with ESMTP id k3si410792qcn.2.2014.05.20.12.33.24
        for <msysgit@googlegroups.com>;
        Tue, 20 May 2014 12:33:24 -0700 (PDT)
Received-SPF: pass (google.com: domain of junio@pobox.com designates 208.72.237.35 as permitted sender) client-ip=208.72.237.35;
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 57D2F19077;
	Tue, 20 May 2014 15:33:24 -0400 (EDT)
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4E05319076;
	Tue, 20 May 2014 15:33:24 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id F0EEB19071;
	Tue, 20 May 2014 15:33:20 -0400 (EDT)
In-Reply-To: <20140520192132.GA7355@camelia.ucw.cz> (Stepan Kasal's message of
	"Tue, 20 May 2014 21:21:32 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 99E45E9E-E055-11E3-9EDF-B784E8FBB39C-77302942!pb-smtp0.pobox.com
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249736>

Stepan Kasal <kasal@ucw.cz> writes:

> Hello,
>
> On Tue, May 20, 2014 at 11:57:56AM -0700, Junio C Hamano wrote:
>> It would be nice if somebody in the S-o-b chain can double-check
>> that the "combined" version is sane.  [...]
>
> "Combined" was an unfortunate word.  There was a pair of successive
> commits in msysgit all the time.  I just decided to submit them
> squashed together.  I haven't changed the code, just created a new
> commit message.
>
> That said, reviewing the function is always useful, of course.

I did mis-read your message.  As the patch shows the current state
that exists in msysgit that people are happy about, the function has
already been reviewed by stakeholders, and I would be happy to apply
it.

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
