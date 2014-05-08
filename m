From: Stepan Kasal <kasal@ucw.cz>
Subject: [PATCH] Revert "submodules: fix ambiguous absolute paths
 under Windows"
Date: Thu, 8 May 2014 22:36:57 +0200
Organization: <)><
Message-ID: <20140508203657.GA6203@camelia.ucw.cz>
References: <20140428083931.GA10257@camelia.ucw.cz> <CABPQNSaC30p7TEOvc85u=+skjrFj17182vWWSL=QNVuvzVFE=w@mail.gmail.com> <20140428113815.GA10559@camelia.ucw.cz> <20140428114224.GA11186@camelia.ucw.cz> <CABPQNSbDkE+Vff=4MmPO9oMfjRay6Oin51zZRoZ8mOEhGoaD3Q@mail.gmail.com> <20140428142931.GA12056@camelia.ucw.cz> <20140507184444.GB4013@sandbox-ub> <xmqqmwet8gre.fsf@gitster.dls.corp.google.com> <20140508101115.GC4511@camelia.ucw.cz> <xmqqd2fo2fmi.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Heiko Voigt <hvoigt@hvoigt.net>, GIT Mailing-list <git@vger.kernel.org>,
        Johannes Sixt <j6t@kdbg.org>, msysgit@googlegroups.com
To: Junio C Hamano <gitster@pobox.com>
X-From: msysgit+bncBCU63DXMWULRB2WVV6NQKGQE5IJMUTI@googlegroups.com Thu May 08 22:37:04 2014
Return-path: <msysgit+bncBCU63DXMWULRB2WVV6NQKGQE5IJMUTI@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wg0-f59.google.com ([74.125.82.59])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCU63DXMWULRB2WVV6NQKGQE5IJMUTI@googlegroups.com>)
	id 1WiV3r-0001Oy-VE
	for gcvm-msysgit@m.gmane.org; Thu, 08 May 2014 22:37:00 +0200
Received: by mail-wg0-f59.google.com with SMTP id x12sf323709wgg.4
        for <gcvm-msysgit@m.gmane.org>; Thu, 08 May 2014 13:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :in-reply-to:organization:user-agent:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type:content-disposition;
        bh=Y7ZPiCj0cE2QVdf8i+juVUtm3ANDRYTeCj1nAiGFu20=;
        b=OP5DQKM/Z3EbFMcZRyrUis8tNGjcEcWjr2iMGsqVxJEHYUpWmm1fKzn/kptTkCtahh
         vBKZkBGBdFR2xIzWfJ8i+c5y+Ur7Quxh91pH9tiqZABVj6EgsSfXZv6ZSVjOoyUd3PPc
         6ZlRP6jrPxgpOXaDaQiAUm1hV8RDjSZN7D+IyTWONXzXN5AWhDF9qEtAqD1juJiiW9/m
         fvLp2+MdUrreOGs/a17DDQ1ewp6x0yg+Ovx7q7MDssc+WgCy/Tn63Uk3s3om1c0x6a+y
         y44SMiZoTmK8nBi50FxDiMiOrzoo1uxteECP6kEpbz3ojl0kaLdtJCYy9K7igKyqsrJI
         NYmw==
X-Received: by 10.180.211.168 with SMTP id nd8mr79412wic.11.1399581419630;
        Thu, 08 May 2014 13:36:59 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.103.10 with SMTP id fs10ls254974wib.33.canary; Thu, 08 May
 2014 13:36:58 -0700 (PDT)
X-Received: by 10.112.136.229 with SMTP id qd5mr88156lbb.21.1399581418316;
        Thu, 08 May 2014 13:36:58 -0700 (PDT)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz. [46.255.230.98])
        by gmr-mx.google.com with ESMTP id u49si82924eeo.1.2014.05.08.13.36.58
        for <msysgit@googlegroups.com>;
        Thu, 08 May 2014 13:36:58 -0700 (PDT)
Received-SPF: none (google.com: kasal@ucw.cz does not designate permitted sender hosts) client-ip=46.255.230.98;
Received: from 49-117-207-85.strcechy.adsl-llu.static.bluetone.cz (84.64.broadband3.iol.cz [85.70.64.84])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	(Authenticated sender: kasal)
	by jabberwock.ucw.cz (Postfix) with ESMTPSA id 018B81C00F0;
	Thu,  8 May 2014 22:36:57 +0200 (CEST)
Received: from camelia.ucw.cz (camelia.ucw.cz [127.0.0.1])
	by 49-117-207-85.strcechy.adsl-llu.static.bluetone.cz (8.14.3/8.14.3) with ESMTP id s48Kav1F006214;
	Thu, 8 May 2014 22:36:57 +0200
Received: (from kasal@localhost)
	by camelia.ucw.cz (8.14.3/8.14.3/Submit) id s48Kava0006213;
	Thu, 8 May 2014 22:36:57 +0200
In-Reply-To: <xmqqd2fo2fmi.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
X-Original-Sender: kasal@ucw.cz
X-Original-Authentication-Results: gmr-mx.google.com;       spf=neutral
 (google.com: kasal@ucw.cz does not designate permitted sender hosts) smtp.mail=kasal@ucw.cz
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
Content-Disposition: inline
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248442>

This reverts commit 4dce7d9b408b2935b85721b54a2010eda7ec1be9,
which was originally done to help Windows but was almost
immediately reverted in msysGit, and the codebase kept this
unnecessary divergence for almost two years.

Signed-off-by: Stepan Kasal <kasal@ucw.cz>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
On Thu, May 08, 2014 at 01:13:25PM -0700, Junio C Hamano wrote:
> OK, let's do this.  I'd like you to take the authorship of it (and

ok; thank you for the nice description, no need for any correction.

 git-submodule.sh | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 66f5f75..821e6d4 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -285,9 +285,6 @@ module_clone()
 	# resolve any symlinks that might be present in $PWD
 	a=$(cd_to_toplevel && cd "$gitdir" && pwd)/
 	b=$(cd_to_toplevel && cd "$sm_path" && pwd)/
-	# normalize Windows-style absolute paths to POSIX-style absolute paths
-	case $a in [a-zA-Z]:/*) a=/${a%%:*}${a#*:} ;; esac
-	case $b in [a-zA-Z]:/*) b=/${b%%:*}${b#*:} ;; esac
 	# Remove all common leading directories after a sanity check
 	if test "${a#$b}" != "$a" || test "${b#$a}" != "$b"; then
 		die "$(eval_gettext "Gitdir '\$a' is part of the submodule path '\$b' or vice versa")"
-- 
2.0.0-rc2-397-ga0fd1fc

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
