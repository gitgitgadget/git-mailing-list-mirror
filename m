From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/6] MinGW: Skip test redirecting to fd 4
Date: Thu, 17 Jul 2014 11:41:16 -0700
Message-ID: <xmqqbnsnq14j.fsf@gitster.dls.corp.google.com>
References: <20140716092959.GA378@ucw.cz>
	<1405611425-10009-1-git-send-email-kasal@ucw.cz>
	<1405611425-10009-2-git-send-email-kasal@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Karsten Blees <karsten.blees@gmail.com>,  Johannes Sixt <j6t@kdbg.org>,  GIT Mailing-list <git@vger.kernel.org>,  msysGit <msysgit@googlegroups.com>,  Johannes Schindelin <johannes.schindelin@gmx.de>
To: Stepan Kasal <kasal@ucw.cz>
X-From: msysgit+bncBCG77UMM3EJRBVFRUCPAKGQEIALNOBQ@googlegroups.com Thu Jul 17 20:41:26 2014
Return-path: <msysgit+bncBCG77UMM3EJRBVFRUCPAKGQEIALNOBQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-pa0-f58.google.com ([209.85.220.58])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCG77UMM3EJRBVFRUCPAKGQEIALNOBQ@googlegroups.com>)
	id 1X7qcP-00088S-Rr
	for gcvm-msysgit@m.gmane.org; Thu, 17 Jul 2014 20:41:26 +0200
Received: by mail-pa0-f58.google.com with SMTP id fa1sf817638pad.13
        for <gcvm-msysgit@m.gmane.org>; Thu, 17 Jul 2014 11:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=LCcxT7sgyaNbwMmIOoT73j8Olex5kvMfp962a0RrkOo=;
        b=rXS41xzgJJxRHqA9TK5FOBFfIoKir6ZgQnRRiFUl5TC3f1o2b5X5OS2t0agSpZkRVf
         8vZkscqEn9jmHJWtpS2dk9MWGgQoBjRM8qnctwWeEz0DQ7K6fviKxaKHDb3Uo17gtIqt
         7p03miGjAB1aSnx9/bq/oCJjn4vgKsAD2zd7nHHdg1+LWz7y3hK92g9mRMgG8mKMVNOQ
         7oiHG2KJkZWeAHQUEWaEP9sUqYb6p3gnTCTGv07WJmUuCaU6lO/cx0rRDF4RgPeG0WXO
         G6NloqMnqzbmHbqoPA6Q1ZZAqVlfcEZe1PlvQWtwptb5mZUzMSNn9jO0EF2o7jmF/pNx
         SpOA==
X-Received: by 10.140.89.5 with SMTP id u5mr28127qgd.24.1405622484765;
        Thu, 17 Jul 2014 11:41:24 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.140.85.40 with SMTP id m37ls757464qgd.18.gmail; Thu, 17 Jul
 2014 11:41:24 -0700 (PDT)
X-Received: by 10.236.126.103 with SMTP id a67mr7141257yhi.4.1405622484230;
        Thu, 17 Jul 2014 11:41:24 -0700 (PDT)
Received: from smtp.pobox.com (smtp.pobox.com. [208.72.237.35])
        by gmr-mx.google.com with ESMTP id m2si423284qcr.2.2014.07.17.11.41.24
        for <msysgit@googlegroups.com>;
        Thu, 17 Jul 2014 11:41:24 -0700 (PDT)
Received-SPF: pass (google.com: domain of junio@pobox.com designates 208.72.237.35 as permitted sender) client-ip=208.72.237.35;
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id EB0172A1A0;
	Thu, 17 Jul 2014 14:41:23 -0400 (EDT)
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E0E7C2A19F;
	Thu, 17 Jul 2014 14:41:23 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 0DB5B2A190;
	Thu, 17 Jul 2014 14:41:18 -0400 (EDT)
In-Reply-To: <1405611425-10009-2-git-send-email-kasal@ucw.cz> (Stepan Kasal's
	message of "Thu, 17 Jul 2014 17:37:00 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: F07A3A4E-0DE1-11E4-9893-9903E9FBB39C-77302942!pb-smtp0.pobox.com
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253769>

Stepan Kasal <kasal@ucw.cz> writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> ... because that does not work in MinGW.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> Signed-off-by: Stepan Kasal <kasal@ucw.cz>
> ---
>  t/t0081-line-buffer.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/t/t0081-line-buffer.sh b/t/t0081-line-buffer.sh
> index bd83ed3..25dba00 100755
> --- a/t/t0081-line-buffer.sh
> +++ b/t/t0081-line-buffer.sh
> @@ -29,7 +29,7 @@ test_expect_success '0-length read, send along greeting' '
>  	test_cmp expect actual
>  '
>  
> -test_expect_success 'read from file descriptor' '
> +test_expect_success NOT_MINGW 'read from file descriptor' '
>  	rm -f input &&
>  	echo hello >expect &&
>  	echo hello >input &&

Hmm, the point of this test seems to be to exercise buffer_fdinit(),
instead of buffer_init(), and the file descriptor does not have to
be "4" for the purpose of the test, no?

Is what is broken on MinGW redirecting arbitrary file descrptors?
If that is not the case, wouldn't the following a good enough (or
better) replacement, I wonder?

 t/t0081-line-buffer.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t0081-line-buffer.sh b/t/t0081-line-buffer.sh
index bd83ed3..881789a 100755
--- a/t/t0081-line-buffer.sh
+++ b/t/t0081-line-buffer.sh
@@ -34,7 +34,6 @@ test_expect_success 'read from file descriptor' '
 	echo hello >expect &&
 	echo hello >input &&
-	echo copy 6 |
-	test-line-buffer "&4" 4<input >actual &&
+	test-line-buffer "&0" <input >actual &&
 	test_cmp expect actual
 '
 

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
