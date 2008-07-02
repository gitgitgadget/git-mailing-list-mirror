From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [PATCH 11/12] verify_path(): do not allow absolute
 paths
Date: Wed, 2 Jul 2008 16:24:40 +0200
Message-ID: <A0293E2B-5EED-4D4C-BAF1-AC3A149EF094@zib.de>
References: <15FB2EE9-298D-41D1-B66A-DDC786282ECB@zib.de> <1214987532-23640-1-git-send-email-prohaska@zib.de> <1214987532-23640-2-git-send-email-prohaska@zib.de> <1214987532-23640-3-git-send-email-prohaska@zib.de> <1214987532-23640-4-git-send-email-prohaska@zib.de> <1214987532-23640-5-git-send-email-prohaska@zib.de> <1214987532-23640-6-git-send-email-prohaska@zib.de> <1214987532-23640-7-git-send-email-prohaska@zib.de> <1214987532-23640-8-git-send-email-prohaska@zib.de> <1214987532-23640-9-git-send-email-prohaska@zib.de> <1214987532-23640-10-git-send-email-prohaska@zib.de> <1214987532-23640-11-git-send-email-prohaska@zib.de> <7vvdzobq0k.fsf@gitster.siamese.dyndns.org>
Reply-To: prohaska@zib.de
Mime-Version: 1.0 (Apple Message framework v924)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>, msysGit <msysgit@googlegroups.com>, Junio C Hamano <junio@pobox.com>, Johannes Schindelin <johannes.schindelin@gmx.de>
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Wed Jul 02 16:25:30 2008
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from wr-out-0708.google.com ([64.233.184.243])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KE3Gt-0003gq-3G
	for gcvm-msysgit@m.gmane.org; Wed, 02 Jul 2008 16:25:23 +0200
Received: by wr-out-0708.google.com with SMTP id b72so100013wra.6
        for <gcvm-msysgit@m.gmane.org>; Wed, 02 Jul 2008 07:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received-spf:authentication-results:received
         :received:from:to:in-reply-to:subject:references:message-id
         :content-type:content-transfer-encoding:mime-version:date:cc
         :x-mailer:reply-to:sender:precedence:x-google-loop:mailing-list
         :list-id:list-post:list-help:list-unsubscribe:x-beenthere;
        bh=bUbDs2TBvu+eCMAY6hskDsHTSyRALNN7b8myTSxegrE=;
        b=niLBrAnU6yd7om43M0iQdDlFrbb47MK7JqYjDKXM4YtiHSOnZEO+2Nksqf7ZQBHIA1
         G8JFGdtfEhv1X6yusXVk1W4oT5c7M/xM/gwYqlVMeavZ7Cn2qkE9/9BQ5y0NXnaMcQva
         4qPwIL5Atw97u5/uH//DBI8nuzgWJcSqU7wHI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results:from
         :to:in-reply-to:subject:references:message-id:content-type
         :content-transfer-encoding:mime-version:date:cc:x-mailer:reply-to
         :sender:precedence:x-google-loop:mailing-list:list-id:list-post
         :list-help:list-unsubscribe:x-beenthere;
        b=YS24QFdWFNVVPk83pYqjQt5TvANm0HtkI5dU63tx2u3fy5laBp8ocp7nUNqbg5KsjD
         llTGjMWiHFxnap6jX2PRkotLJVNzu13ymDwtr3Q0/UOjy4lbicWakGrd++VHTaBY0G7i
         l8j4Vk3Xwv00Tw21/rAzTq+luldvn3VaxfTuY=
Received: by 10.150.230.15 with SMTP id c15mr154645ybh.5.1215008663953;
        Wed, 02 Jul 2008 07:24:23 -0700 (PDT)
Received: by 10.107.117.4 with SMTP id u4gr2567prm.0;
	Wed, 02 Jul 2008 07:24:23 -0700 (PDT)
X-Sender: prohaska@zib.de
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.114.77.1 with SMTP id z1mr4579390waa.15.1215008663377; Wed, 02 Jul 2008 07:24:23 -0700 (PDT)
Received: from mailer.zib.de (mailer.zib.de [130.73.108.11]) by mx.google.com with ESMTP id 39si8219971yxd.0.2008.07.02.07.24.22; Wed, 02 Jul 2008 07:24:23 -0700 (PDT)
Received-SPF: pass (google.com: best guess record for domain of prohaska@zib.de designates 130.73.108.11 as permitted sender) client-ip=130.73.108.11;
Authentication-Results: mx.google.com; spf=pass (google.com: best guess record for domain of prohaska@zib.de designates 130.73.108.11 as permitted sender) smtp.mail=prohaska@zib.de
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31]) by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id m62EOGDV002469; Wed, 2 Jul 2008 16:24:21 +0200 (CEST)
Received: from [192.168.178.21] (brln-4db94382.pool.einsundeins.de [77.185.67.130]) (authenticated bits=0) by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id m62EOFcu024675 (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO); Wed, 2 Jul 2008 16:24:15 +0200 (MEST)
In-Reply-To: <7vvdzobq0k.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.924)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87142>



On Jul 2, 2008, at 11:21 AM, Junio C Hamano wrote:

> Steffen Prohaska <prohaska@zib.de> writes:
>
>> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>> Signed-off-by: Steffen Prohaska <prohaska@zib.de>
>
> No commit log message?  Justification?

Hannes,
Do we still need this change in verify_path().  I am not sure.
Maybe it should be reverted in 4msysgit?

	Steffen
