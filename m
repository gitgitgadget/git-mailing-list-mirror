From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/6] t4210: skip command-line encoding tests on mingw
Date: Mon, 21 Jul 2014 15:39:39 -0700
Message-ID: <xmqqsilugwus.fsf@gitster.dls.corp.google.com>
References: <20140716092959.GA378@ucw.cz>
	<1405611425-10009-1-git-send-email-kasal@ucw.cz>
	<1405611425-10009-5-git-send-email-kasal@ucw.cz>
	<CABPQNSaiogqGryK8YOzQXs_z_syvXMBqvOpvGfMNdbLkNzRq_w@mail.gmail.com>
	<xmqqvbqqk5qu.fsf@gitster.dls.corp.google.com>
	<xmqqoawiiigz.fsf@gitster.dls.corp.google.com>
	<xmqq1tteibwa.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Stepan Kasal <kasal@ucw.cz>,  Karsten Blees <karsten.blees@gmail.com>,  Johannes Sixt <j6t@kdbg.org>,  GIT Mailing-list <git@vger.kernel.org>,  msysGit <msysgit@googlegroups.com>,  Pat Thoyts <patthoyts@users.sourceforge.net>
To: kusmabite@gmail.com
X-From: msysgit+bncBCG77UMM3EJRBNVNW2PAKGQE2Z66IWQ@googlegroups.com Tue Jul 22 00:39:53 2014
Return-path: <msysgit+bncBCG77UMM3EJRBNVNW2PAKGQE2Z66IWQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-pd0-f189.google.com ([209.85.192.189])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCG77UMM3EJRBNVNW2PAKGQE2Z66IWQ@googlegroups.com>)
	id 1X9MFM-0008Og-9o
	for gcvm-msysgit@m.gmane.org; Tue, 22 Jul 2014 00:39:52 +0200
Received: by mail-pd0-f189.google.com with SMTP id fp1sf2331365pdb.6
        for <gcvm-msysgit@m.gmane.org>; Mon, 21 Jul 2014 15:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=MSqJST4S7/5FyQQYlnP6NtKkHZ/Yq2Vax3RcJArUcgw=;
        b=Z1BzxxqIiUCuUadHnWl6V0H3hpyxBn9pDpLFl79eRZOuFpuqj2Dyq8lxNE3kDbVRxe
         YPmNaF2k303MHxP6F/fvQFRjddSw7Da+1v568UPLmoEmyKhICyBf7orHkT9KKvJ70fbr
         C+s89yqMTM9wJvq6e+WVpviqgyjbJmzKWKaDivyeLysen51/EvYIoYrIohni7seLmMqx
         O4ouXT40qNQ6KcFofXHafT0Ij8CUubOZvbCwSi0T0cuVKgLDic38VRQ4LbKHMQFnvFVY
         xPdpxOWhCemFDcK8S7CQZCU3ey2tbCQEh6pGa9Wbgjeg7j9kUHzVC/ZFV/CavUxSERqW
         9apA==
X-Received: by 10.50.55.6 with SMTP id n6mr147521igp.1.1405982390527;
        Mon, 21 Jul 2014 15:39:50 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.50.115.35 with SMTP id jl3ls1936245igb.44.gmail; Mon, 21 Jul
 2014 15:39:49 -0700 (PDT)
X-Received: by 10.50.73.5 with SMTP id h5mr3043502igv.2.1405982389983;
        Mon, 21 Jul 2014 15:39:49 -0700 (PDT)
Received: from smtp.pobox.com (smtp.pobox.com. [208.72.237.35])
        by gmr-mx.google.com with ESMTP id y50si1154133yhk.4.2014.07.21.15.39.49
        for <msysgit@googlegroups.com>;
        Mon, 21 Jul 2014 15:39:49 -0700 (PDT)
Received-SPF: pass (google.com: domain of junio@pobox.com designates 208.72.237.35 as permitted sender) client-ip=208.72.237.35;
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A365E2BFBB;
	Mon, 21 Jul 2014 18:39:49 -0400 (EDT)
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 96F7E2BFBA;
	Mon, 21 Jul 2014 18:39:49 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 6B06F2BFA8;
	Mon, 21 Jul 2014 18:39:41 -0400 (EDT)
In-Reply-To: <xmqq1tteibwa.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Mon, 21 Jul 2014 15:29:25 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: E79E892C-1127-11E4-A803-9903E9FBB39C-77302942!pb-smtp0.pobox.com
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254000>

Junio C Hamano <gitster@pobox.com> writes:

> So here is the first of the two small/trivial patch series. 
>
> To prepare the first one, I did "git grep -e '\<NOT_' t/" to the
> result of applying Stepan's series and edited the hits manually.
> And then compared the result with running
>
>  $ perl -p -i -e 'if (!/\btest_set_prereq\s/) {
>        s/\bNOT_([A-Z]*)\b/!$1/g
>    }' t/t*.sh
>
> on Stepan's series to see if I missed anything.
>
> The second one was discovered while doing the manual fix mentioned
> above.
> ...
>  t/t1402-check-ref-format.sh   | 32 ++++++++++++++++----------------
>  t/test-lib.sh                 |  4 ----
>  15 files changed, 52 insertions(+), 56 deletions(-)

Unfortunately, t1402 needs more work X-<.

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
