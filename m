From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 04/15] Set _O_BINARY as default fmode for both
 MinGW  and MSVC
Date: Wed, 16 Sep 2009 18:14:57 +0200
Message-ID: <4AB10F01.9010703@viscovery.net>
References: <cover.1253088099.git.mstormo@gmail.com> <213f3c7799721c3f42ffa689498175f0495048eb.1253088099.git.mstormo@gmail.com> <26c067500d8adf17a2d75e2956e4d4a6cef27fc1.1253088099.git.mstormo@gmail.com> <6e6345fb3fbc19b1a2467e33e1633fe9025e547b.1253088099.git.mstormo@gmail.com> <929c5a34cd2621af24bcda7e47ff2e76b51c2e09.1253088099.git.mstormo@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Johannes.Schindelin@gmx.de, msysgit@googlegroups.com, gitster@pobox.com, j6t@kdbg.org, lznuaa@gmail.com, raa.lkml@gmail.com, snaury@gmail.com, Marius Storm-Olsen <marius.storm-olsen@nokia.com>
To: Marius Storm-Olsen <mstormo@gmail.com>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Wed Sep 16 18:15:16 2009
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-yx0-f137.google.com ([209.85.210.137])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MnxA4-0003ID-Ov
	for gcvm-msysgit@m.gmane.org; Wed, 16 Sep 2009 18:15:16 +0200
Received: by yxe1 with SMTP id 1so9352509yxe.21
        for <gcvm-msysgit@m.gmane.org>; Wed, 16 Sep 2009 09:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received:received-spf:received:received
         :message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding
         :x-spam-score:sender:precedence:x-google-loop:mailing-list:list-id
         :list-post:list-help:list-unsubscribe:x-beenthere-env:x-beenthere;
        bh=Pq9gYO9Lj0x8Nt8JiaADovHyD8MvvzKJY2SP0Up5qFo=;
        b=W1ic83UotGCPZtH8WVUlbX49k1O/drHqDqOa7lE6GEyiLlKxU3o2BSLRfpj9CPJaCc
         bHiLjNa+/mZqP9kDEP8tmk9dKl+2uQcPkuz9mmV+EWLaKF9yYlEzgtA6Lg1nbUoHUoyn
         JFpneMZgtP8FKiZyLrAGk9wu+ds57X9SwvqiA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results
         :message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding
         :x-spam-score:sender:precedence:x-google-loop:mailing-list:list-id
         :list-post:list-help:list-unsubscribe:x-beenthere-env:x-beenthere;
        b=ufPkufmrkxd5ecQgBbUWClPmncaG85HhZ+s3pZNgD/e/AHlb2SWZD1PLbC+E7cyOAa
         TZm2zthoAtZceoJ/6dWWW29j5FyQSA8rT+agN8VRTxuoGTToc0EcML/nj3QOiv2DelE/
         ReHkzW6dvUNU913Jk8JHvKDPQZiuGTjAkTXLc=
Received: by 10.90.233.6 with SMTP id f6mr1337570agh.23.1253117709765;
        Wed, 16 Sep 2009 09:15:09 -0700 (PDT)
Received: by 10.176.133.2 with SMTP id g2gr7053yqd.0;
	Wed, 16 Sep 2009 09:15:07 -0700 (PDT)
X-Sender: j.sixt@viscovery.net
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.204.161.203 with SMTP id s11mr176946bkx.17.1253117705285; Wed, 16 Sep 2009 09:15:05 -0700 (PDT)
Received: by 10.204.161.203 with SMTP id s11mr176945bkx.17.1253117705191; Wed, 16 Sep 2009 09:15:05 -0700 (PDT)
Received: from lilzmailso02.liwest.at (lilzmailso02.liwest.at [212.33.55.13]) by gmr-mx.google.com with ESMTP id 13si843051bwz.7.2009.09.16.09.15.04; Wed, 16 Sep 2009 09:15:05 -0700 (PDT)
Received-SPF: neutral (google.com: 212.33.55.13 is neither permitted nor denied by best guess record for domain of j.sixt@viscovery.net) client-ip=212.33.55.13;
Authentication-Results: gmr-mx.google.com; spf=neutral (google.com: 212.33.55.13 is neither permitted nor denied by best guess record for domain of j.sixt@viscovery.net) smtp.mail=j.sixt@viscovery.net
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=linz.eudaptics.com) by lilzmailso02.liwest.at with esmtpa (Exim 4.69) (envelope-from <j.sixt@viscovery.net>) id 1Mnx9n-0000bO-49; Wed, 16 Sep 2009 18:14:59 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95]) by linz.eudaptics.com (Postfix) with ESMTP id 0F456A4A1; Wed, 16 Sep 2009 18:14:58 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <929c5a34cd2621af24bcda7e47ff2e76b51c2e09.1253088099.git.mstormo@gmail.com>
X-Spam-Score: -0.0 (/)
Sender: msysgit@googlegroups.com
Precedence: bulk
X-Google-Loop: groups
Mailing-List: list msysgit@googlegroups.com;
	contact msysgit+owner@googlegroups.com
List-Id: <msysgit.googlegroups.com>
List-Post: <mailto:msysgit@googlegroups.com>
List-Help: <mailto:msysgit+help@googlegroups.com>
List-Unsubscribe: <http://googlegroups.com/group/msysgit/subscribe>,
	<mailto:msysgit+unsubscribe@googlegroups.com>
X-BeenThere-Env: msysgit@googlegroups.com
X-BeenThere: msysgit@googlegroups.com
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128660>


Marius Storm-Olsen schrieb:
> From: Marius Storm-Olsen <marius.storm-olsen@nokia.com>
> 
> MinGW set the _CRT_fmode to set both the default fmode and
> _O_BINARY on stdin/stdout/stderr. Rather use the main()
> define in mingw.h to set this for both MinGW and MSVC.
> 
> This will ensure that a MinGW and MSVC build will handle
> input and output identically.

This one breaks t5302-pack-index.sh (test 15, "[index v1] 2) create a
stealth corruption in a delta base reference") in my MinGW build. I have
yet to find out what exactly goes wrong and how it could be fixed.

-- Hannes
