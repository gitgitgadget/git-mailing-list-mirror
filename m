From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 10/12] MINGW: compat/poll/poll.c: undef NOGDI
Date: Mon, 05 May 2014 02:32:11 -0500
Message-ID: <53673e7b65c4d_78fd70f2ec46@nysa.notmuch>
References: <1398762726-22825-1-git-send-email-marat@slonopotamus.org>
 <1398762726-22825-11-git-send-email-marat@slonopotamus.org>
 <20140430114125.GA23046@camelia.ucw.cz>
 <20140503070050.GA8580@seldon>
 <20140504185244.GA17183@camelia.ucw.cz>
 <20140504205552.GA15590@seldon>
 <20140505073547.GB20599@camelia.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	msysGit <msysgit@googlegroups.com>
To: Stepan Kasal <kasal@ucw.cz>,
	Marat Radchenko <marat@slonopotamus.org>
X-From: git-owner@vger.kernel.org Tue May 06 18:12:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Whhts-0005Yp-24
	for gcvg-git-2@plane.gmane.org; Tue, 06 May 2014 18:07:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754806AbaEEHmy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 May 2014 03:42:54 -0400
Received: from mail-ob0-f177.google.com ([209.85.214.177]:45396 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754635AbaEEHmx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 May 2014 03:42:53 -0400
Received: by mail-ob0-f177.google.com with SMTP id gq1so383746obb.8
        for <git@vger.kernel.org>; Mon, 05 May 2014 00:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=ZfFZ1zFxL0sFkmf4kPlHN/BlNadlTW05WFQp4DI3gTQ=;
        b=tOSOQ9HhbBl+PwPF0MLaY5ERwwVKcRY/cxFFyF7V/CJRvhGzPZTf3MDFYiMGFl+ECf
         G2/EqQq0JhK14a+pLUn59pU4pPAOtsqXNutBMRLSWdrBCWichgJIAlr2i9sGWI0jcJoJ
         ihpGu4ur1Pv1jpho847nsaHkVC2y7wrfAvgMn6xa02m24NpMnNC51s4MZi4CA77rhmS5
         gsLjrvdI3hwPEfZ6uge1yPki7H0y0GQpsGqe+XUHDbZem76QcWSkDTZoPE7mQBpBVWrJ
         2AulUvaS1u1g+cJll4KCd4/zWKyOI1ePIhZMpadd08yUWerEawgSaXBeSzQOjyLJqpsn
         nYkA==
X-Received: by 10.182.66.170 with SMTP id g10mr1215428obt.49.1399275772970;
        Mon, 05 May 2014 00:42:52 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id zm8sm17578371obc.16.2014.05.05.00.42.50
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 May 2014 00:42:51 -0700 (PDT)
In-Reply-To: <20140505073547.GB20599@camelia.ucw.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248120>

Stepan Kasal wrote:
> diff --git a/config.mak.uname b/config.mak.uname
> index 82b8dff..446dd41 100644
> --- a/config.mak.uname
> +++ b/config.mak.uname
> @@ -508,7 +508,11 @@ ifneq (,$(findstring MINGW,$(uname_S)))
>  	NO_POSIX_GOODIES = UnfortunatelyYes
>  	DEFAULT_HELP_FORMAT = html
>  	NO_D_INO_IN_DIRENT = YesPlease
> -	COMPAT_CFLAGS += -D__USE_MINGW_ACCESS -D_USE_32BIT_TIME_T -DNOGDI -Icompat -Icompat/win32
> +	COMPAT_CFLAGS += -D__USE_MINGW_ACCESS -D_USE_32BIT_TIME_T -Icompat -Icompat/win32
> +ifneq ($(uname_M),x86_64)
> +	# MinGW-W64 < x.y headers do not provide MsgWaitForMultipleObjects with NOGDI

MinGW-w64 != x86_64; it provides a i686 compiler as well.

-- 
Felipe Contreras
