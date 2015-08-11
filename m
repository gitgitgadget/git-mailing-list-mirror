From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH ee/clean-remove-dirs] t7300-clean: require
 POSIXPERM for chmod 0 test
Date: Tue, 11 Aug 2015 15:17:17 -0700
Message-ID: <xmqqpp2to4gi.fsf@gitster.dls.corp.google.com>
References: <55CA5B3C.3010903@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,  msysGit <msysgit@googlegroups.com>
To: Johannes Sixt <j6t@kdbg.org>
X-From: msysgit+bncBCG77UMM3EJRB37IVGXAKGQE3GPGP3Y@googlegroups.com Wed Aug 12 00:17:21 2015
Return-path: <msysgit+bncBCG77UMM3EJRB37IVGXAKGQE3GPGP3Y@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-qg0-f57.google.com ([209.85.192.57])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCG77UMM3EJRB37IVGXAKGQE3GPGP3Y@googlegroups.com>)
	id 1ZPHrE-00045k-LO
	for gcvm-msysgit@m.gmane.org; Wed, 12 Aug 2015 00:17:20 +0200
Received: by qgdf45 with SMTP id f45sf49647556qgd.1
        for <gcvm-msysgit@m.gmane.org>; Tue, 11 Aug 2015 15:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-spam-checked-in-group:list-post:list-help:list-archive
         :list-subscribe:list-unsubscribe;
        bh=a/7XQ6G8PPw4KNcVGg9DK7CAamQsBCHPM+impTZZZco=;
        b=KFHjMhjOoBF5ib5pOeJX2WOseSRzFsqK+kNNrSTfpbK9xgkxNFG88jywrTF6gVlQ1i
         g8uAOGOyhSJQLuPv5qSI48bxFZL1YdXcasLoNtnYKzSWL7wpi4NYSZJk/zRHIXHhJC+X
         RTGssY5aC2aA1xdiCejkqwdRKtxeTKXaKsYNNpU2QJO0005lZiCeN707NdvEK93uhVzK
         JFVlbVs0OCRxvrcxHIAg309V820tMkOg99zXkf09OsbDtd+fkVE+WkqiuB/XRbVA5CPa
         FPoBAucjiDYgrEYms+NMj9VDGKkbQPAZpmbGVGCT22U5B256Xef4pywttdNi7pWmV62h
         OZgw==
X-Received: by 10.182.81.72 with SMTP id y8mr136968obx.15.1439331439579;
        Tue, 11 Aug 2015 15:17:19 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.182.99.197 with SMTP id es5ls1476703obb.80.gmail; Tue, 11 Aug
 2015 15:17:19 -0700 (PDT)
X-Received: by 10.182.240.202 with SMTP id wc10mr28092153obc.9.1439331439090;
        Tue, 11 Aug 2015 15:17:19 -0700 (PDT)
Received: from mail-pa0-x231.google.com (mail-pa0-x231.google.com. [2607:f8b0:400e:c03::231])
        by gmr-mx.google.com with ESMTPS id zt8si378609pbc.0.2015.08.11.15.17.19
        for <msysgit@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Aug 2015 15:17:19 -0700 (PDT)
Received-SPF: pass (google.com: domain of jch2355@gmail.com designates 2607:f8b0:400e:c03::231 as permitted sender) client-ip=2607:f8b0:400e:c03::231;
Received: by mail-pa0-x231.google.com with SMTP id u10so172990224paw.1
        for <msysgit@googlegroups.com>; Tue, 11 Aug 2015 15:17:19 -0700 (PDT)
X-Received: by 10.68.184.197 with SMTP id ew5mr61095166pbc.145.1439331438972;
        Tue, 11 Aug 2015 15:17:18 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:894d:5945:d51a:995b])
        by smtp.gmail.com with ESMTPSA id pe3sm3892688pdb.55.2015.08.11.15.17.18
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 11 Aug 2015 15:17:18 -0700 (PDT)
Sender: msysgit@googlegroups.com
In-Reply-To: <55CA5B3C.3010903@kdbg.org> (Johannes Sixt's message of "Tue, 11
	Aug 2015 22:29:48 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Original-Sender: gitster@pobox.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of jch2355@gmail.com designates 2607:f8b0:400e:c03::231
 as permitted sender) smtp.mailfrom=jch2355@gmail.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Spam-Checked-In-Group: msysgit@googlegroups.com
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/msysgit/subscribe>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275736>

Thanks.

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
You received this message because you are subscribed to the Google Groups "Git for Windows" group.
To unsubscribe from this group and stop receiving emails from it, send an email to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
