From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t/lib-httpd: switch SANITY check for NOT_ROOT
Date: Thu, 22 Jan 2015 14:07:26 -0800
Message-ID: <xmqqlhkusc4h.fsf@gitster.dls.corp.google.com>
References: <20150114211712.GE1155@peff.net>
	<064010B3-BC58-42F2-B5C0-DAADAA59B87D@gmail.com>
	<xmqqwq4n6b4c.fsf@gitster.dls.corp.google.com>
	<20150115222719.GA19021@peff.net>
	<xmqqa91j6537.fsf@gitster.dls.corp.google.com>
	<20150115235752.GB25120@peff.net>
	<xmqqh9vr4mlz.fsf@gitster.dls.corp.google.com>
	<20150116013256.GA25894@peff.net>
	<BEFF558C-774D-4891-96A0-BE962F8070E7@gmail.com>
	<20150116033445.GA29572@peff.net> <20150116091648.GA2450@peff.net>
	<xmqqfvba37bq.fsf@gitster.dls.corp.google.com>
	<xmqqzj9i1rci.fsf@gitster.dls.corp.google.com> <54BAF1C2.60103@web.de>
	<xmqq61bzwyqp.fsf@gitster.dls.corp.google.com>
	<54C170E9.4010401@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Cc: Jeff King <peff@peff.net>,  "Kyle J. McKay" <mackyle@gmail.com>,  msysgit@googlegroups.com,  Git Mailing List <git@vger.kernel.org>
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: msysgit+bncBCG77UMM3EJRBIPJQWTAKGQEMK5YVRA@googlegroups.com Thu Jan 22 23:07:31 2015
Return-path: <msysgit+bncBCG77UMM3EJRBIPJQWTAKGQEMK5YVRA@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-pa0-f60.google.com ([209.85.220.60])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCG77UMM3EJRBIPJQWTAKGQEMK5YVRA@googlegroups.com>)
	id 1YEPuU-0001eR-ML
	for gcvm-msysgit@m.gmane.org; Thu, 22 Jan 2015 23:07:30 +0100
Received: by mail-pa0-f60.google.com with SMTP id kq14sf566278pab.5
        for <gcvm-msysgit@m.gmane.org>; Thu, 22 Jan 2015 14:07:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:content-transfer-encoding
         :x-original-sender:x-original-authentication-results:precedence
         :mailing-list:list-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe;
        bh=jMxHEbqMTjC73dgjUwjAW0fiX45CCHP+WHg63Mpi6as=;
        b=TaTeAhQTeX6U+Ld84PVZdNc00JzHfYnj4wIWakli5tchA7vBbUKxDu1T9Okflz7MDL
         D6BXm/HNqHouDUEV5s/4yfnlpCMks9Tu3NZWXeqbFiY8mlLF1x0AB3yizUUnJ+3HBuQu
         4Wx+HgYspYDeKUvD8Wh/pHjXZ9HmzpWOxwuSk/MCSaY0qmKvXD6LzltmnsLrZB7/RO8K
         jc2JXQP2W4SRGtkyTznyPgw+t7A8vLo4D9gOYlbeS6cliWIiHXnuAPbfcmLp2hUjVSNM
         4QyNa8XGhtyDwEoJSnZ/R+pIt6zuqzPtDku8APLxYHL7H/Q2r22rpusRZ7ZM5jxn7g6B
         oaMw==
X-Received: by 10.140.36.134 with SMTP id p6mr57485qgp.16.1421964449619;
        Thu, 22 Jan 2015 14:07:29 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.140.107.199 with SMTP id h65ls913800qgf.85.gmail; Thu, 22 Jan
 2015 14:07:29 -0800 (PST)
X-Received: by 10.236.222.9 with SMTP id s9mr2969431yhp.55.1421964449032;
        Thu, 22 Jan 2015 14:07:29 -0800 (PST)
Received: from sasl.smtp.pobox.com (pb-smtp1.int.icgroup.com. [208.72.237.35])
        by gmr-mx.google.com with ESMTP id b3si762727qco.0.2015.01.22.14.07.28
        for <msysgit@googlegroups.com>;
        Thu, 22 Jan 2015 14:07:29 -0800 (PST)
Received-SPF: pass (google.com: domain of junio@pobox.com designates 208.72.237.35 as permitted sender) client-ip=208.72.237.35;
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 64C0D323A2;
	Thu, 22 Jan 2015 17:07:28 -0500 (EST)
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5B87E323A1;
	Thu, 22 Jan 2015 17:07:28 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C17DD323A0;
	Thu, 22 Jan 2015 17:07:27 -0500 (EST)
In-Reply-To: <54C170E9.4010401@web.de> ("Torsten =?utf-8?Q?B=C3=B6gershaus?=
 =?utf-8?Q?en=22's?= message of
	"Thu, 22 Jan 2015 22:51:37 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 0D81B9B0-A283-11E4-B6E9-7BA29F42C9D4-77302942!pb-smtp1.pobox.com
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262877>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> If I run that sequence manually:
> chmod 755 .
> touch x
> chmod a-w .
> rm x
> touch y
>
> x is gone, (but shoudn't according to POSIX)
> y is not created, "access denied"

Good (or is that Sad?).

> diff --git a/t/test-lib.sh b/t/test-lib.sh
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -1039,7 +1039,17 @@ test_lazy_prereq NOT_ROOT '
>  # When the tests are run as root, permission tests will report that
>  # things are writable when they shouldn't be.
>  test_lazy_prereq SANITY '
> -       test_have_prereq POSIXPERM,NOT_ROOT
> +       mkdir ds &&
> +       touch ds/x &&
> +       chmod -w ds &&
> +       if rm ds/x
> +       then
> +               chmod +w ds
> +               false
> +       else
> +               chmod +w ds
> +               true
> +       fi
>  '

It looks like a better approach overall.

Because we cannot know where $(pwd) is when lazy prereq is evaluated
(it typically is at the root of the trash hierarchy, but not always)
and we would not want to add, leave or remove random files in the
working tree that are not expected by the tests proper (e.g. a test
that counts untracked paths are not expecting ds/ to be there), your
actual "fix" may need to be a bit more careful, though.

Thanks.

--=20
--=20
*** Please reply-to-all at all times ***
*** (do not pretend to know who is subscribed and who is not) ***
*** Please avoid top-posting. ***
The msysGit Wiki is here: https://github.com/msysgit/msysgit/wiki - Github =
accounts are free.

You received this message because you are subscribed to the Google
Groups "msysGit" group.
To post to this group, send email to msysgit@googlegroups.com
To unsubscribe from this group, send email to
msysgit+unsubscribe@googlegroups.com
For more options, and view previous threads, visit this group at
http://groups.google.com/group/msysgit?hl=3Den_US?hl=3Den

---=20
You received this message because you are subscribed to the Google Groups "=
Git for Windows" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
