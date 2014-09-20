From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: [slightly OT?] TOTP gateway for any service on any server
Date: Sat, 20 Sep 2014 19:20:02 +0530
Message-ID: <541D860A.9040203@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Gitolite Google Groups <gitolite@googlegroups.com>, 
 "git@vger.kernel.org" <git@vger.kernel.org>
X-From: gitolite+bncBDXO5VUV4AFBBEEM62QAKGQEQJVBEDQ@googlegroups.com Sat Sep 20 15:50:11 2014
Return-path: <gitolite+bncBDXO5VUV4AFBBEEM62QAKGQEQJVBEDQ@googlegroups.com>
Envelope-to: gcvg-gitolite@m.gmane.org
Received: from mail-ie0-f185.google.com ([209.85.223.185])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <gitolite+bncBDXO5VUV4AFBBEEM62QAKGQEQJVBEDQ@googlegroups.com>)
	id 1XVL3C-0007Cx-CK
	for gcvg-gitolite@m.gmane.org; Sat, 20 Sep 2014 15:50:10 +0200
Received: by mail-ie0-f185.google.com with SMTP id tr6sf692239ieb.22
        for <gcvg-gitolite@m.gmane.org>; Sat, 20 Sep 2014 06:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :x-original-sender:x-original-authentication-results:precedence
         :mailing-list:list-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type;
        bh=2yrJbllcrFrpxJDcEcYAQtgJ+Zy4b+rEBWUCpf21Q70=;
        b=DN4MwuQF4hL1sCVc4saASaEvNbkKGiLvSaTCjPgQws34hrNOZ2R06Uxf7Z/+/PK6cr
         AWGSl/XpLw+vsE5H9r94g0V/1hv+KKey92/4dLDB6lbHDIWU7VssUBk52r4xJ1Tp9HKg
         /JXlFmz59aNnnu6zmbqlC8hkvLVxBPUBAKZ4BsXJC+JtLL3xCq3ScUwgT5PEc/DZDHam
         NVDjtfm7iDMGogDve1jirEe9qzkZeX6e+Hs+RBeVHqAtvm7rwGqlEuDWkYiF9OQFQlf2
         5avyCxlBHoxgZk8DnSThN1GxwioJGtUCuiWYLNZuL1KqzZa43ziVsE/kUXndiqGhuJ8j
         LaXQ==
X-Received: by 10.183.1.34 with SMTP id bd2mr5712obd.6.1411221009468;
        Sat, 20 Sep 2014 06:50:09 -0700 (PDT)
X-BeenThere: gitolite@googlegroups.com
Received: by 10.182.27.179 with SMTP id u19ls216719obg.63.gmail; Sat, 20 Sep
 2014 06:50:07 -0700 (PDT)
X-Received: by 10.182.45.197 with SMTP id p5mr10011699obm.2.1411221007931;
        Sat, 20 Sep 2014 06:50:07 -0700 (PDT)
Received: from mail-pa0-x22c.google.com (mail-pa0-x22c.google.com [2607:f8b0:400e:c03::22c])
        by gmr-mx.google.com with ESMTPS id e16si535193pdf.2.2014.09.20.06.50.07
        for <gitolite@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 20 Sep 2014 06:50:07 -0700 (PDT)
Received-SPF: pass (google.com: domain of sitaramc@gmail.com designates 2607:f8b0:400e:c03::22c as permitted sender) client-ip=2607:f8b0:400e:c03::22c;
Received: by mail-pa0-x22c.google.com with SMTP id eu11so871733pac.3
        for <gitolite@googlegroups.com>; Sat, 20 Sep 2014 06:50:07 -0700 (PDT)
X-Received: by 10.70.118.68 with SMTP id kk4mr10682328pdb.21.1411221007800;
        Sat, 20 Sep 2014 06:50:07 -0700 (PDT)
Received: from sita-lt.atc.tcs.com ([117.195.177.205])
        by mx.google.com with ESMTPSA id qz2sm4660283pab.27.2014.09.20.06.50.05
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 20 Sep 2014 06:50:06 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 Thunderbird/24.7.0
X-Original-Sender: sitaramc@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of sitaramc@gmail.com designates 2607:f8b0:400e:c03::22c
 as permitted sender) smtp.mail=sitaramc@gmail.com;       dkim=pass
 header.i=@gmail.com;       dmarc=pass (p=NONE dis=NONE) header.from=gmail.com
Precedence: list
Mailing-list: list gitolite@googlegroups.com; contact gitolite+owners@googlegroups.com
List-ID: <gitolite.googlegroups.com>
X-Google-Group-Id: 373658679585
List-Post: <http://groups.google.com/group/gitolite/post>, <mailto:gitolite@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:gitolite+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/gitolite
Sender: gitolite@googlegroups.com
List-Subscribe: <http://groups.google.com/group/gitolite/subscribe>, <mailto:gitolite+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+373658679585+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/gitolite/subscribe>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257324>

Hi all,

I've just created a general purpose TOTP "gatekeeper" that is designed
to gate access to any service on any server/OS (as long as traffic can
only go *through* the TOTP gatekeeper).

The inspiration was Konstantin Ryabitsev's implementation of two-factor
authentication for kernel.org -- from which I got the idea of "use TOTP
to whitelist an IP for some time".

I then extended it to protect any TCP port on any server behind the
gatekeeper.  http://gitolite.com/totport/ is the documentation, and the
source is linked there.

I'd welcome any feedback but please be mindful of the fact that deep
discussion may veer way off-topic for the git or gitolite mailing lists,
although I hope I won't get flak for *this* email :-)

sitaram

-- 
You received this message because you are subscribed to the Google Groups "gitolite" group.
To unsubscribe from this group and stop receiving emails from it, send an email to gitolite+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
