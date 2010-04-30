From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] Fix checkout of large files to network shares 
	under Windows XP
Date: Fri, 30 Apr 2010 10:46:52 +0200
Message-ID: <4BDA98FC.1080007@viscovery.net>
References: <4BCC5083.30801@gmail.com> <4BCCC05E.4030206@lsrfire.ath.cx> <t2xbdca99241004200542ud4e8ea5azcad918c37bcacf1a@mail.gmail.com> <4BCE134C.8090802@lsrfire.ath.cx> <4BD9E58E.8020406@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Cc: Sebastian Schuberth <sschuberth@gmail.com>, git@vger.kernel.org, 
 msysgit@googlegroups.com, 
 Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
X-From: msysgit+bncCJOK-OFUEISy6t4EGgQtDkKA@googlegroups.com Fri Apr 30 10:47:23 2010
connect(): No such file or directory
Return-path: <msysgit+bncCJOK-OFUEISy6t4EGgQtDkKA@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-ww0-f58.google.com ([74.125.82.58])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncCJOK-OFUEISy6t4EGgQtDkKA@googlegroups.com>)
	id 1O7lsZ-0003Gn-2C
	for gcvm-msysgit@m.gmane.org; Fri, 30 Apr 2010 10:47:23 +0200
Received: by wwb18 with SMTP id 18sf4455879wwb.3
        for <gcvm-msysgit@m.gmane.org>; Fri, 30 Apr 2010 01:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:x-beenthere:received:received:received
         :received:received-spf:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :x-enigmail-version:x-spam-score:x-original-authentication-results
         :x-original-sender:precedence:mailing-list:list-id:list-post
         :list-help:list-archive:sender:list-subscribe:list-unsubscribe
         :content-type:content-transfer-encoding;
        bh=N/jb0pAsXwWx2Ycp0FUYFA42jD7uZk7xwZ+wyVUY6mQ=;
        b=ZuWcD84jA8ZsDIvqKLuFOCO75IpyVwZ5INl98sYaHMfD9su+JTm70jVMnPWCJ1zMwM
         S6RxSoxwkWWyIOos5iQMmv7igiKAluXJv7Y11wqRjTUjbHrGEgu3cPMDlDT1mq7fd0eD
         +Ro3h9ZN/pg+XuVizQidiv1q1b0o9vhb81JqA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-beenthere:received-spf:message-id:date:from:user-agent
         :mime-version:to:cc:subject:references:in-reply-to
         :x-enigmail-version:x-spam-score:x-original-authentication-results
         :x-original-sender:precedence:mailing-list:list-id:list-post
         :list-help:list-archive:sender:list-subscribe:list-unsubscribe
         :content-type:content-transfer-encoding;
        b=6XrRoBilHC3sUq2cYPLCQb/KZGRhMOW/UuQBONDiqTRdwD2Ia7pFsY+DXw44pxfhne
         7TqUPLE7C7Xt7iTZ20W5J/FGDEJEriE1f7YyL0Fk/chNiFuorno28dFmkbFdEPRTAL3N
         /THWtVgcXokTT2hU3PyjNdbp4TlmWPRDYJZTk=
Received: by 10.223.63.20 with SMTP id z20mr2868440fah.7.1272617221007;
        Fri, 30 Apr 2010 01:47:01 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.204.35.68 with SMTP id o4ls21631392bkd.1.p; Fri, 30 Apr 2010 
	01:46:59 -0700 (PDT)
Received: by 10.204.0.74 with SMTP id 10mr534740bka.21.1272617218775;
        Fri, 30 Apr 2010 01:46:58 -0700 (PDT)
Received: by 10.204.0.74 with SMTP id 10mr534739bka.21.1272617218736;
        Fri, 30 Apr 2010 01:46:58 -0700 (PDT)
Received: from lilzmailso01.liwest.at (lilzmailso01.liwest.at [212.33.55.23])
        by gmr-mx.google.com with ESMTP id 17si227490bwz.7.2010.04.30.01.46.58;
        Fri, 30 Apr 2010 01:46:58 -0700 (PDT)
Received-SPF: neutral (google.com: 212.33.55.23 is neither permitted nor denied by best guess record for domain of j.sixt@viscovery.net) client-ip=212.33.55.23;
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1O7ls7-0004g1-Jb; Fri, 30 Apr 2010 10:46:55 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 435151660F;
	Fri, 30 Apr 2010 10:46:53 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.1.9) Gecko/20100317 Thunderbird/3.0.4
In-Reply-To: <4BD9E58E.8020406@lsrfire.ath.cx>
X-Enigmail-Version: 1.0.1
X-Spam-Score: -1.4 (-)
X-Original-Authentication-Results: gmr-mx.google.com; spf=neutral (google.com: 
	212.33.55.23 is neither permitted nor denied by best guess record for domain 
	of j.sixt@viscovery.net) smtp.mail=j.sixt@viscovery.net
X-Original-Sender: j6t@kdbg.org
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
List-Post: <http://groups.google.com/group/msysgit/post?hl=en_US>, 
	<mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/?hl=en_US>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit?hl=en_US>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en_US>, 
	<mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en_US>, 
	<mailto:msysgit+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146029>

Am 4/29/2010 22:01, schrieb Ren=C3=A9 Scharfe:
> +#undef write
> +ssize_t mingw_write(int fd, const void *buf, size_t count)
> +{
> +	/*
> +	 * While write() calls to a file on a local disk are translated
> +	 * into WriteFile() calls with a maximum size of 64KB on Windows
> +	 * XP and 256KB on Vista, no such cap is placed on writes to
> +	 * files over the network on Windows XP.  Unfortunately, there
> +	 * seems to be a limit of 32MB-28KB on X64 and 64MB-32KB on x86;
> +	 * bigger writes fail on Windows XP.
> +	 * So we cap to a nice 31MB here to avoid write failures over
> +	 * the net without changing the number of WriteFile() calls in
> +	 * the local case.
> +	 */
> +	return write(fd, buf, min(count, 31 * 1024 * 1024));
> +}
> +

Thanks, I have verified that this fixes the problem in my setup as well.
I'll queue the patch with the below test case squashed in.

-- Hannes

diff --git a/t/t5705-clone-2gb.sh b/t/t5705-clone-2gb.sh
index adfaae8..8afbdd4 100755
--- a/t/t5705-clone-2gb.sh
+++ b/t/t5705-clone-2gb.sh
@@ -12,7 +12,7 @@ test_expect_success 'setup' '

 	git config pack.compression 0 &&
 	git config pack.depth 0 &&
-	blobsize=3D$((20*1024*1024)) &&
+	blobsize=3D$((100*1024*1024)) &&
 	blobcount=3D$((2*1024*1024*1024/$blobsize+1)) &&
 	i=3D1 &&
 	(while test $i -le $blobcount
@@ -36,9 +36,15 @@ test_expect_success 'setup' '

 '

-test_expect_success 'clone' '
+test_expect_success 'clone - bare' '

-	git clone --bare --no-hardlinks . clone
+	git clone --bare --no-hardlinks . clone-bare
+
+'
+
+test_expect_success 'clone - with worktree, file:// protocol' '
+
+	git clone file://. clone-wt

 '
