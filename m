From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/6] t9902: mingw-specific fix for gitfile link files
Date: Thu, 17 Jul 2014 13:42:28 -0700
Message-ID: <xmqqtx6fogy3.fsf@gitster.dls.corp.google.com>
References: <20140716092959.GA378@ucw.cz>
	<1405611425-10009-1-git-send-email-kasal@ucw.cz>
	<1405611425-10009-6-git-send-email-kasal@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Karsten Blees <karsten.blees@gmail.com>,  Johannes Sixt <j6t@kdbg.org>,  GIT Mailing-list <git@vger.kernel.org>,  msysGit <msysgit@googlegroups.com>,  Pat Thoyts <patthoyts@users.sourceforge.net>
To: Stepan Kasal <kasal@ucw.cz>
X-From: msysgit+bncBCG77UMM3EJRBPPKUCPAKGQEKLX2PGY@googlegroups.com Thu Jul 17 22:42:38 2014
Return-path: <msysgit+bncBCG77UMM3EJRBPPKUCPAKGQEKLX2PGY@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wi0-f192.google.com ([209.85.212.192])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCG77UMM3EJRBPPKUCPAKGQEKLX2PGY@googlegroups.com>)
	id 1X7sVi-0005lf-6Q
	for gcvm-msysgit@m.gmane.org; Thu, 17 Jul 2014 22:42:38 +0200
Received: by mail-wi0-f192.google.com with SMTP id e4sf355182wiv.19
        for <gcvm-msysgit@m.gmane.org>; Thu, 17 Jul 2014 13:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=whMRCigHNQRMKZphreS8ckbVpjeh4RCVYP/GE+r7X/o=;
        b=AxfyT45mydpXyepBYynDdZTRRYZW7CJSoGdncSmp8qpKGLmyPW521rzsyv+ShSjKe0
         +v6HDbVbRhya5HDwRdtgVtMpEuYFiU/SaHuAoLM1PHrromdXr6qEQZlA2IpEMs++KaYu
         D5DEV/7fZSEIgchti1tmL6NOMB2ZaFCBwiwU3eDabH2kDsxwP5WfXdnyEy7bhR/3UVFu
         nRC/hWxSYmnW+vUGAeOdKf2K/YlBJtBewBTROwd3CqA/zwoB/EvPo2mWRjdjYoAzwkyD
         NG3jpx8hbFlfFVlO61RPr+0t7+pRrlIahOKjzSLNehSCP1BhKSKijcQ2qlV9T9dPkLBh
         v7DQ==
X-Received: by 10.152.88.3 with SMTP id bc3mr39352lab.1.1405629757900;
        Thu, 17 Jul 2014 13:42:37 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.44.227 with SMTP id h3ls264038lam.49.gmail; Thu, 17 Jul
 2014 13:42:36 -0700 (PDT)
X-Received: by 10.152.7.71 with SMTP id h7mr3945848laa.2.1405629756579;
        Thu, 17 Jul 2014 13:42:36 -0700 (PDT)
Received: from smtp.pobox.com (smtp.pobox.com. [208.72.237.35])
        by gmr-mx.google.com with ESMTP id he4si458808qcb.0.2014.07.17.13.42.36
        for <msysgit@googlegroups.com>;
        Thu, 17 Jul 2014 13:42:36 -0700 (PDT)
Received-SPF: pass (google.com: domain of junio@pobox.com designates 208.72.237.35 as permitted sender) client-ip=208.72.237.35;
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 363272ADBA;
	Thu, 17 Jul 2014 16:42:36 -0400 (EDT)
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2A4B32ADB9;
	Thu, 17 Jul 2014 16:42:36 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id EF6642ADB1;
	Thu, 17 Jul 2014 16:42:29 -0400 (EDT)
In-Reply-To: <1405611425-10009-6-git-send-email-kasal@ucw.cz> (Stepan Kasal's
	message of "Thu, 17 Jul 2014 17:37:04 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: DEE2826C-0DF2-11E4-BE4F-9903E9FBB39C-77302942!pb-smtp0.pobox.com
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253781>

Stepan Kasal <kasal@ucw.cz> writes:

> From: Pat Thoyts <patthoyts@users.sourceforge.net>
>
> The path in a .git platform independent link file needs to be absolute
> and under mingw we need it to be a windows type path, not a unix style
> path so it should start with a drive letter and not a /.

OK.   We seem to have uses of "pwd -P" in other tests; don't they
need a similar treatment, and if not why not?

>
> Signed-off-by: Pat Thoyts <patthoyts@users.sourceforge.net>
> Signed-off-by: Stepan Kasal <kasal@ucw.cz>
> ---
>  t/t9902-completion.sh | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
>
> diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
> index 1d1c106..f10a752 100755
> --- a/t/t9902-completion.sh
> +++ b/t/t9902-completion.sh
> @@ -212,9 +212,18 @@ test_expect_success '__gitdir - non-existing $GIT_DIR' '
>  	)
>  '
>  
> +function pwd_P_W () {
> +	if test_have_prereq MINGW
> +	then
> +		pwd -W
> +	else
> +		pwd -P
> +	fi
> +}
> +
>  test_expect_success '__gitdir - gitfile in cwd' '
> -	echo "$(pwd -P)/otherrepo/.git" >expected &&
> -	echo "gitdir: $TRASH_DIRECTORY/otherrepo/.git" >subdir/.git &&
> +	echo "$(pwd_P_W)/otherrepo/.git" >expected &&
> +	echo "gitdir: $(pwd_P_W)/otherrepo/.git" >subdir/.git &&
>  	test_when_finished "rm -f subdir/.git" &&
>  	(
>  		cd subdir &&
> @@ -224,8 +233,8 @@ test_expect_success '__gitdir - gitfile in cwd' '
>  '
>  
>  test_expect_success '__gitdir - gitfile in parent' '
> -	echo "$(pwd -P)/otherrepo/.git" >expected &&
> -	echo "gitdir: $TRASH_DIRECTORY/otherrepo/.git" >subdir/.git &&
> +	echo "$(pwd_P_W)/otherrepo/.git" >expected &&
> +	echo "gitdir: $(pwd_P_W)/otherrepo/.git" >subdir/.git &&
>  	test_when_finished "rm -f subdir/.git" &&
>  	(
>  		cd subdir/subsubdir &&
> -- 
> 2.0.0.9635.g0be03cb
>
> -- 

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
