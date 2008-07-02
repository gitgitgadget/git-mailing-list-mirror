From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [PATCH 11/12] verify_path(): do not allow absolute
 paths
Date: Wed, 2 Jul 2008 19:20:25 +0200
Message-ID: <6F445BD9-CE59-435A-AAF3-F380A7BCE29E@zib.de>
References: <15FB2EE9-298D-41D1-B66A-DDC786282ECB@zib.de> <1214987532-23640-1-git-send-email-prohaska@zib.de> <1214987532-23640-2-git-send-email-prohaska@zib.de> <1214987532-23640-3-git-send-email-prohaska@zib.de> <1214987532-23640-4-git-send-email-prohaska@zib.de> <1214987532-23640-5-git-send-email-prohaska@zib.de> <1214987532-23640-6-git-send-email-prohaska@zib.de> <1214987532-23640-7-git-send-email-prohaska@zib.de> <1214987532-23640-8-git-send-email-prohaska@zib.de> <1214987532-23640-9-git-send-email-prohaska@zib.de> <1214987532-23640-10-git-send-email-prohaska@zib.de> <1214987532-23640-11-git-send-email-prohaska@zib.de> <7vvdzobq0k.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0807021713290.9925@racer>
Reply-To: prohaska@zib.de
Mime-Version: 1.0 (Apple Message framework v924)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junio@pobox.com>, Johannes Sixt <johannes.sixt@telecom.at>, git@vger.kernel.org, msysgit@googlegroups.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Wed Jul 02 19:21:29 2008
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from wa-out-0708.google.com ([209.85.146.244])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KE61B-0002Pa-7B
	for gcvm-msysgit@m.gmane.org; Wed, 02 Jul 2008 19:21:21 +0200
Received: by wa-out-0708.google.com with SMTP id n36so369941wag.21
        for <gcvm-msysgit@m.gmane.org>; Wed, 02 Jul 2008 10:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received-spf:authentication-results:received
         :received:from:to:in-reply-to:subject:references:message-id
         :content-type:content-transfer-encoding:mime-version:date:cc
         :x-mailer:reply-to:sender:precedence:x-google-loop:mailing-list
         :list-id:list-post:list-help:list-unsubscribe:x-beenthere;
        bh=N0TUxd68jXeqNukZk25GUrefDj1Haz1k6an4yEvNLcs=;
        b=VR6/1uqi+UEDBQ0khnniuYppiu2h0ndClOALoMnmOfLFLxgAwojWLmbrJbXGj358uD
         taYyFsIfcbAkHaga1bHH8z/+sgipIJ7LPjE1ZaVGXsFiaeW7/2Gn9lq0rh8RmT/kXlVq
         HLpGTBPKa2i6SwrMgDavtZ+fAps6dWgdxlASA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results:from
         :to:in-reply-to:subject:references:message-id:content-type
         :content-transfer-encoding:mime-version:date:cc:x-mailer:reply-to
         :sender:precedence:x-google-loop:mailing-list:list-id:list-post
         :list-help:list-unsubscribe:x-beenthere;
        b=4e5RtgfMT6GmW6pR4Nn66hoMPoJxTnD2XCUjfSWJvyN/9vvKSXFuRgmSu91CkTyBTm
         ryjvHhgIoXflqzzxSBvRT8yi6jdeEzCG4uJ2wljAsxGKAw0l7oG42pcNVgwTxbQgUzkd
         Oj7+AfrvuMWYkUjcqeT117Luk6vLtgW4tOqR4=
Received: by 10.114.199.1 with SMTP id w1mr579379waf.6.1215019221470;
        Wed, 02 Jul 2008 10:20:21 -0700 (PDT)
Received: by 10.107.117.4 with SMTP id u4gr2574prm.0;
	Wed, 02 Jul 2008 10:20:21 -0700 (PDT)
X-Sender: prohaska@zib.de
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.100.34.16 with SMTP id h16mr1390515anh.22.1215019220999; Wed, 02 Jul 2008 10:20:20 -0700 (PDT)
Received: from mailer.zib.de (mailer.zib.de [130.73.108.11]) by mx.google.com with ESMTP id 22si8438643yxr.2.2008.07.02.10.20.20; Wed, 02 Jul 2008 10:20:21 -0700 (PDT)
Received-SPF: pass (google.com: best guess record for domain of prohaska@zib.de designates 130.73.108.11 as permitted sender) client-ip=130.73.108.11;
Authentication-Results: mx.google.com; spf=pass (google.com: best guess record for domain of prohaska@zib.de designates 130.73.108.11 as permitted sender) smtp.mail=prohaska@zib.de
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31]) by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id m62HKDEQ020007; Wed, 2 Jul 2008 19:20:18 +0200 (CEST)
Received: from [192.168.178.21] (brln-4db94382.pool.einsundeins.de [77.185.67.130]) (authenticated bits=0) by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id m62HK0G2008676 (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO); Wed, 2 Jul 2008 19:20:00 +0200 (MEST)
In-Reply-To: <alpine.DEB.1.00.0807021713290.9925@racer>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87165>



On Jul 2, 2008, at 6:15 PM, Johannes Schindelin wrote:

> Hi,
>
> On Wed, 2 Jul 2008, Junio C Hamano wrote:
>
>> Steffen Prohaska <prohaska@zib.de> writes:
>>
>>> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>>> Signed-off-by: Steffen Prohaska <prohaska@zib.de>
>>
>> No commit log message?  Justification?
>
> Justification: adding absolute paths was not caught properly on  
> Windows,
> and this was the easiest patch.
>
> However, IIRC, in the meantime we are nice to the user, and allow  
> absolute
> paths (which we turn into a relative path, or error out if it is not  
> under
> the current working directory).
>
> Steffen, can you revert the patch and verify that my memory does not  
> fail
> me?

Is

    git add /c/msysgit/git/read-cache.c

an appropriate test?

It fails with

    error: 'c:/msysgit/git/read-cache.c' is outside repository

no matter if the commit is reverted or not.

	Steffen
