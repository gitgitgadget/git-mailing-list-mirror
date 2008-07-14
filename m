From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] Allow add_path() to add non-existent
 directories to the path
Date: Mon, 14 Jul 2008 09:13:13 +0200
Message-ID: <487AFC89.8020009@viscovery.net>
References: <7v1w1yupn4.fsf@gitster.siamese.dyndns.org> <1215981083-10815-1-git-send-email-johannes.sixt@telecom.at> <1215981083-10815-2-git-send-email-johannes.sixt@telecom.at> <1215981083-10815-3-git-send-email-johannes.sixt@telecom.at> <1215981083-10815-4-git-send-email-johannes.sixt@telecom.at> <1215981083-10815-5-git-send-email-johannes.sixt@telecom.at> <1215981083-10815-6-git-send-email-johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, Johannes Schindelin <Johannes.Schindelin@gmx.de>, msysGit <msysgit@googlegroups.com>
To: Steffen Prohaska <prohaska@zib.de>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Mon Jul 14 09:14:22 2008
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from yx-out-2122.google.com ([74.125.44.25])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIIGJ-0002Fb-2a
	for gcvm-msysgit@m.gmane.org; Mon, 14 Jul 2008 09:14:19 +0200
Received: by yx-out-2122.google.com with SMTP id 22so1785036yxm.63
        for <gcvm-msysgit@m.gmane.org>; Mon, 14 Jul 2008 00:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received-spf:authentication-results:received
         :received:message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding
         :x-spam-score:x-spam-report:sender:precedence:x-google-loop
         :mailing-list:list-id:list-post:list-help:list-unsubscribe
         :x-beenthere;
        bh=nVEViMtjr0U371PlQ+YcPxbByXhCJwdHV9sQbaOI0fg=;
        b=TVSFKJbe30IVkKUmGa7ySWo3Md1jDotfDPF8qlH9BMq4Gdarrfq//5OuTTckR0SBed
         G/4zcbzkSVzmHoXNBTfIGUbe9SGiA8DlrIQBdtCVJhCPmgUaqmFKVYMkA/tqSIs2Ug68
         wMifHkr9MgStZz/aLJgV35AojEYQYGWtbPauw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results
         :message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding
         :x-spam-score:x-spam-report:sender:precedence:x-google-loop
         :mailing-list:list-id:list-post:list-help:list-unsubscribe
         :x-beenthere;
        b=Ku644CDheJa8OpKo5JdXVmVq/eIiuDEyTAyZ4R1QU6YKomnFmJ7MtMRnfnyAKJYwu1
         xZAQJs6/9HqiV02v9dCP3jG6nJ8hyH+3UuHmKP6LE4g62it7RE/CbZt8UwtpJpjxcoNC
         SghN+9YxZQetvLrwSroIFIaXKe+vjhpwxshio=
Received: by 10.114.25.3 with SMTP id 3mr937254way.22.1216019598698;
        Mon, 14 Jul 2008 00:13:18 -0700 (PDT)
Received: by 10.107.13.30 with SMTP id q30gr2703pri.0;
	Mon, 14 Jul 2008 00:13:18 -0700 (PDT)
X-Sender: j.sixt@viscovery.net
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.90.86.9 with SMTP id j9mr16532158agb.23.1216019597719; Mon, 14 Jul 2008 00:13:17 -0700 (PDT)
Received: from lilzmailso01.liwest.at (lilzmailso01.liwest.at [212.33.55.23]) by mx.google.com with ESMTP id 22si4228097yxr.2.2008.07.14.00.13.16; Mon, 14 Jul 2008 00:13:17 -0700 (PDT)
Received-SPF: neutral (google.com: 212.33.55.23 is neither permitted nor denied by best guess record for domain of j.sixt@viscovery.net) client-ip=212.33.55.23;
Authentication-Results: mx.google.com; spf=neutral (google.com: 212.33.55.23 is neither permitted nor denied by best guess record for domain of j.sixt@viscovery.net) smtp.mail=j.sixt@viscovery.net
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com) by lilzmailso01.liwest.at with esmtpa (Exim 4.66) (envelope-from <j.sixt@viscovery.net>) id 1KIIFG-00074N-C1; Mon, 14 Jul 2008 09:13:14 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42]) by linz.eudaptics.com (Postfix) with ESMTP id 1B5034FB; Mon, 14 Jul 2008 09:13:14 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <1215981083-10815-6-git-send-email-johannes.sixt@telecom.at>
X-Spam-Score: 1.2 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_95=3
Sender: msysgit@googlegroups.com
Precedence: bulk
X-Google-Loop: groups
Mailing-List: list msysgit@googlegroups.com;
	contact msysgit-owner@googlegroups.com
List-Id: <msysgit.googlegroups.com>
List-Post: <mailto:msysgit@googlegroups.com>
List-Help: <mailto:msysgit-help@googlegroups.com>
List-Unsubscribe: <http://googlegroups.com/group/msysgit/subscribe>,
	<mailto:msysgit-unsubscribe@googlegroups.com>
X-BeenThere: msysgit@googlegroups.com
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88392>


Johannes Sixt schrieb:
> +static const char *get_pwd_cwd(void)
> +{
> +	static char cwd[PATH_MAX + 1];
> +	char *pwd;
> +	struct stat cwd_stat, pwd_stat;
> +	if (getcwd(cwd, PATH_MAX) == NULL)
> +		return NULL;
> +	pwd = getenv("PWD");
> +	if (pwd && strcmp(pwd, cwd)) {
> +		stat(cwd, &cwd_stat);
> +		if (!stat(pwd, &pwd_stat) &&
> +		    pwd_stat.st_dev == cwd_stat.st_dev &&
> +		    pwd_stat.st_ino == cwd_stat.st_ino) {
> +			strlcpy(cwd, pwd, PATH_MAX);

git-bash users on Windows, please test this patch. The problem is that
with our custom stat implementation st_dev and st_ino are not reliable. It
 works in my setup because $PWD is not set and this branch is never
entered, but with bash it makes a difference.

-- Hannes
