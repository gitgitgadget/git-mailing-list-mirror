From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] mingw_rmdir: do not prompt for retry when non-empty
Date: Wed, 05 Dec 2012 09:00:38 -0800
Message-ID: <7v624gl9hl.fsf@alter.siamese.dyndns.org>
References: <1354617713-7436-1-git-send-email-kusmabite@gmail.com>
 <alpine.DEB.1.00.1212041728210.31987@s15462909.onlinehome-server.info>
 <CABPQNSbcSEKApDBWWt7z67DvV6=JwTGebdk6hjgR1OppPyOQwg@mail.gmail.com>
 <alpine.DEB.1.00.1212051657131.31987@s15462909.onlinehome-server.info>
 <CABPQNSbsp_V7o8jQrwjSE_x3z3cAf7T3evK+Xq9kVZF0HrGwpg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,  git@vger.kernel.org, 
 msysgit@googlegroups.com
To: kusmabite@gmail.com
X-From: msysgit+bncBCG77UMM3EJRBOP37WCQKGQETUZTMZA@googlegroups.com Wed Dec 05 18:00:57 2012
Return-path: <msysgit+bncBCG77UMM3EJRBOP37WCQKGQETUZTMZA@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-gg0-f186.google.com ([209.85.161.186])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCG77UMM3EJRBOP37WCQKGQETUZTMZA@googlegroups.com>)
	id 1TgIL8-0002yb-Nu
	for gcvm-msysgit@m.gmane.org; Wed, 05 Dec 2012 18:00:55 +0100
Received: by mail-gg0-f186.google.com with SMTP id y6sf4000129ggc.3
        for <gcvm-msysgit@m.gmane.org>; Wed, 05 Dec 2012 09:00:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=x-beenthere:received-spf:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version:x-pobox-relay-id
         :x-original-sender:x-original-authentication-results:precedence
         :mailing-list:list-id:x-google-group-id:list-post:list-help
         :list-archive:sender:list-subscribe:list-unsubscribe:content-type;
        bh=JeDaGLCH6PpR+bwO27orDNVoTSxqdgSeQ0u3ZNTj98M=;
        b=bqRi0wkTokZkl71LjtgfgmML0ji6b4Q00NWXhYxRxqWetLjAr2CbUsKGGZoVRcDj8S
         rNO3YbM+Kw0+sYHe7zysLSH//nwUl0CvwAuq/4f932vQjF6CFXpz8DbcmVqQ/bFJAT7T
         k+GcL5XzsKSoWJvyunlLtn4eiXVkx5Hb+q8oTDAUi3SmU7DFpgOdXYFdNexPawXFrMVs
         +P0GsuCd+IPgVOLUIRor0fcweY5bRghT7iCDwJzPSVS1fZDFSAQ4NyYInyr5ycm00Ebd
         yWeZLOxxcSBARwRVlgF7mAwWB8XfJ6Bi4ycGnJIer7YJNbUabqg+CL+qwFrlAcuynrE 
Received: by 10.49.63.164 with SMTP id h4mr3801678qes.39.1354726842245;
        Wed, 05 Dec 2012 09:00:42 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.49.35.73 with SMTP id f9ls1081483qej.27.gmail; Wed, 05 Dec
 2012 09:00:41 -0800 (PST)
Received: by 10.224.105.205 with SMTP id u13mr10230675qao.6.1354726841088;
        Wed, 05 Dec 2012 09:00:41 -0800 (PST)
Received: by 10.224.105.205 with SMTP id u13mr10230673qao.6.1354726841077;
        Wed, 05 Dec 2012 09:00:41 -0800 (PST)
Received: from smtp.pobox.com (b-pb-sasl-quonix.pobox.com. [208.72.237.35])
        by gmr-mx.google.com with ESMTP id eb7si598906qcb.3.2012.12.05.09.00.40;
        Wed, 05 Dec 2012 09:00:41 -0800 (PST)
Received-SPF: pass (google.com: best guess record for domain of junio@b-sasl-quonix.pobox.com designates 208.72.237.35 as permitted sender) client-ip=208.72.237.35;
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CD6E49E28;
	Wed,  5 Dec 2012 12:00:40 -0500 (EST)
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BA5189E27;
	Wed,  5 Dec 2012 12:00:40 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 296439E25; Wed,  5 Dec 2012
 12:00:40 -0500 (EST)
In-Reply-To: <CABPQNSbsp_V7o8jQrwjSE_x3z3cAf7T3evK+Xq9kVZF0HrGwpg@mail.gmail.com> (Erik
 Faye-Lund's message of "Wed, 5 Dec 2012 17:23:57 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4C4514D0-3EFD-11E2-BCFB-995F2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
X-Original-Sender: gitster@pobox.com
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com:
 best guess record for domain of junio@b-sasl-quonix.pobox.com designates
 208.72.237.35 as permitted sender) smtp.mail=junio@b-sasl-quonix.pobox.com;
 dkim=pass header.i=@pobox.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post?hl=en>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/?hl=en>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit?hl=en>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en>, <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211133>

Erik Faye-Lund <kusmabite@gmail.com> writes:

> On Wed, Dec 5, 2012 at 5:02 PM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> ...
> Since we're justifying the approaches, I'd like to explain why I
> preferred the return approach: it performs less tests. While this
> might sound like premature optimizations, performance is not why I
> think it's a good idea. It makes the fix easier to verify; you don't
> need to validate that the conditions of the second loop won't happen,
> because the code exits quickly.
>
> If we added something that required cleanup, we could change the
> return to a goto with a cleanup-label, and it would still be
> relatively easy to see what's going on.
>
>> However, I have no strong opinion on this, so please apply the version you
>> like better.
>
> Since the issue is present in mainline Git as well, I'd prefer if
> Junio merged whatever he prefers. I can produce a proper patch out of
> your suggesting, if needed.

Thanks; what you and Dscho agreed in this discussion sounds good to
me, too.

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
