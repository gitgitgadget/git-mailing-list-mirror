From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/2] improve-wincred-compatibility
Date: Mon, 25 Feb 2013 15:51:49 -0800
Message-ID: <7vip5gne96.fsf@alter.siamese.dyndns.org>
References: <50E73B80.4070105@gmail.com>
 <CABPQNSYcOrOZJd0vK=4ESC4qPpcj7RRdhVt3R0dAE-ouhOb5YA@mail.gmail.com>
 <50EC473A.6060203@gmail.com>
 <CABPQNSb7MjTKgmeB9TcUV0+-FfjPZ1sgKPsfVDg6+uaw2f_azQ@mail.gmail.com>
 <50EEAF9A.6020302@gmail.com>
 <CABPQNSaUizZPVOeeuEyb=o-Qmm4mYCRxV27qkmp62cSpFkinqA@mail.gmail.com>
 <7vsj4k3nbu.fsf@alter.siamese.dyndns.org> <512BF61B.4020708@dcon.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: kusmabite@gmail.com,  git@vger.kernel.org,  msysgit@googlegroups.com, 
 Jeff King <peff@peff.net>,  patthoyts@gmail.com,  Johannes.Schindelin@gmx.de
To: Karsten Blees <karsten.blees@gmail.com>
X-From: msysgit+bncBCG77UMM3EJRBGHSV6EQKGQEXLURXHA@googlegroups.com Tue Feb 26 00:52:17 2013
Return-path: <msysgit+bncBCG77UMM3EJRBGHSV6EQKGQEXLURXHA@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-gh0-f187.google.com ([209.85.160.187])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCG77UMM3EJRBGHSV6EQKGQEXLURXHA@googlegroups.com>)
	id 1UA7qB-0000Xv-3S
	for gcvm-msysgit@m.gmane.org; Tue, 26 Feb 2013 00:52:15 +0100
Received: by mail-gh0-f187.google.com with SMTP id 16sf1661349ghy.14
        for <gcvm-msysgit@m.gmane.org>; Mon, 25 Feb 2013 15:51:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=x-received:x-beenthere:x-received:x-received:received-spf:from:to
         :cc:subject:references:date:in-reply-to:message-id:user-agent
         :mime-version:x-pobox-relay-id:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type;
        bh=nvF+8PmgJkAvVE+6KMKeuH0eOTxjS4H1L8z3tCr7rN8=;
        b=Dbsyl2YTM0C7xxE2uzEuMiRVH2PADhD5g6DEHav4YD8iiND6Dq0FEiphdV5kO4NACG
         L7jgTC6HMcdiWr77YVgyJJ1Kd0mhgPvTGOkGTC04rNYPLEheyy1iFZsutsLfOA/lbBeB
         f7g40daUpJREAK4+ZK03Qg52y56t9Gau/+WPnffQVL8CMqKnWqCoksPeLLaf14hp+eI4
         CKAv90TBdgxQMtm3vwj1PV0Z5QG9mGFAMBJ7QAc4bp7zhzYE1PIrP6kHKJrfhx+yEIZE
         LpRnqWa8pl7sYBqk1iEjTdCQ 
X-Received: by 10.49.70.195 with SMTP id o3mr1217509qeu.3.1361836313799;
        Mon, 25 Feb 2013 15:51:53 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.49.24.19 with SMTP id q19ls1373330qef.84.gmail; Mon, 25 Feb
 2013 15:51:52 -0800 (PST)
X-Received: by 10.224.185.201 with SMTP id cp9mr9980212qab.6.1361836312419;
        Mon, 25 Feb 2013 15:51:52 -0800 (PST)
X-Received: by 10.224.185.201 with SMTP id cp9mr9980210qab.6.1361836312405;
        Mon, 25 Feb 2013 15:51:52 -0800 (PST)
Received: from smtp.pobox.com (b-pb-sasl-quonix.pobox.com. [208.72.237.35])
        by gmr-mx.google.com with ESMTP id x1si2078071qci.2.2013.02.25.15.51.52;
        Mon, 25 Feb 2013 15:51:52 -0800 (PST)
Received-SPF: pass (google.com: best guess record for domain of junio@b-sasl-quonix.pobox.com designates 208.72.237.35 as permitted sender) client-ip=208.72.237.35;
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DAE75B464;
	Mon, 25 Feb 2013 18:51:51 -0500 (EST)
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CE464B461;
	Mon, 25 Feb 2013 18:51:51 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4C84FB45C; Mon, 25 Feb 2013
 18:51:51 -0500 (EST)
In-Reply-To: <512BF61B.4020708@dcon.de> (Karsten Blees's message of "Tue, 26
 Feb 2013 00:39:07 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 534D8AA2-7FA6-11E2-8362-F3C82E706CDE-77302942!b-pb-sasl-quonix.pobox.com
X-Original-Sender: gitster@pobox.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: best guess record for domain of junio@b-sasl-quonix.pobox.com
 designates 208.72.237.35 as permitted sender) smtp.mail=junio@b-sasl-quonix.pobox.com;
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217121>

Karsten Blees <karsten.blees@gmail.com> writes:

> Am 25.02.2013 07:43, schrieb Junio C Hamano:
>> Erik Faye-Lund <kusmabite@gmail.com> writes:
> ...
>> I'm in the "marking leftover bits" mode today, and noticed that
>> nothing happened for this topic in my tree. Did msysgit folks expect
>> me to pick this up directly, or did you guys want to feed this series
>> to me (with possibly other changes you worked on outside this list)?
>
> The second patch changes the credential format in a
> backward-incompatible way, so I think this should be in git.git,
> too (better than having two incompatible versions around).

I am a bit confused by that comment, as it was my understanding that
the "credential format" only refers to what is stored in the Windows
specific credential storage and relevant only to users of msysgit
(and I expected folks who are using Git natively on Windows to be
using msysgit, not git.git), but in any case, of course we would
want a single version and format.  My question was if msysgit folks
want me to take your patch (which I cannot test myself) and then
merge my tree to the msysgit tree as part of their regular updates
to catch up with 1.8.2 (and future releases), or they want to test
your patches in their tree first, and then either throw me a pull
request or send me a patch series with Acked-by:.

I can obviously go either way, but if they expect the former (i.e. I
first apply and they pull) while I expect the latter (i.e. they
first apply and I pull), then nothing will happen, and if we go the
other way around, we would end up getting two copies of the same
series. The question was primarily to avoid these possibilities.

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
