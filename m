From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: CC in git cover letter vs patches (was Re: [PATCH 0/19] get rid of
 superfluous __GFP_REPORT)
Date: Wed, 13 Apr 2016 16:51:37 +0530
Message-ID: <570E2BC1.8050809@synopsys.com>
References: <1460372892-8157-1-git-send-email-mhocko@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Cc: lkml <linux-kernel@vger.kernel.org>, "linux-mm@kvack.org"
	<linux-mm@kvack.org>, <git@vger.kernel.org>
To: Michal Hocko <mhocko@suse.cz>
X-From: owner-linux-mm@kvack.org Wed Apr 13 13:21:53 2016
Return-path: <owner-linux-mm@kvack.org>
Envelope-to: glkm-linux-mm-2@m.gmane.org
Received: from kanga.kvack.org ([205.233.56.17])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <owner-linux-mm@kvack.org>)
	id 1aqIro-0002Dx-OE
	for glkm-linux-mm-2@m.gmane.org; Wed, 13 Apr 2016 13:21:53 +0200
Received: by kanga.kvack.org (Postfix)
	id DFC53828E2; Wed, 13 Apr 2016 07:21:51 -0400 (EDT)
Delivered-To: linux-mm-outgoing@kvack.org
Received: by kanga.kvack.org (Postfix, from userid 40)
	id DD368828DF; Wed, 13 Apr 2016 07:21:51 -0400 (EDT)
X-Original-To: int-list-linux-mm@kvack.org
X-Delivered-To: int-list-linux-mm@kvack.org
Received: by kanga.kvack.org (Postfix, from userid 63042)
	id CC207828E2; Wed, 13 Apr 2016 07:21:51 -0400 (EDT)
X-Original-To: linux-mm@kvack.org
X-Delivered-To: linux-mm@kvack.org
Received: from mail-pa0-f45.google.com (mail-pa0-f45.google.com [209.85.220.45])
	by kanga.kvack.org (Postfix) with ESMTP id 9BA5B828DF
	for <linux-mm@kvack.org>; Wed, 13 Apr 2016 07:21:51 -0400 (EDT)
Received: by mail-pa0-f45.google.com with SMTP id fs9so13200296pac.2
        for <linux-mm@kvack.org>; Wed, 13 Apr 2016 04:21:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-original-authentication-results:x-gm-message-state:subject
         :references:to:cc:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding;
        bh=oU2IssV9Jl/ER0yTmEFNlBya2kZeSjIhS7HH8lvl4EQ=;
        b=OQr5NarClehQqKlw3ULo0EKIduVMqeLhR05yyQAZLlwJYLhOmyqWZ14J5p4fZ6qzz2
         zd2LzXz4TwDEXgCpenBFDu8skdr+ZyBsXsCI6Mc41CLttMq6m2n4zT8yEDb0I4WixwpO
         GRRWGMwSkGggI35kM9S/hEObKmMoVP1xu9upR6YdbEnDas6v/SeDLUKcB2lxe7B7jfpa
         Dh96sm1WZPWPNZKBDhzHCA53iIyjXlHpY2jVOuazL/7dXMkSCMn6lr4sk6pKEpgcADq+
         E+wicfti5+5MPh4Sv/eDwFP6jG0S7DfDmJB7dOY1wCCJO1QvYn7Guo9Md9h1vL1qpPER
         ioNw==
X-Original-Authentication-Results: mx.google.com;       spf=pass (google.com: best guess record for domain of Vineet.Gupta1@synopsys.com designates 198.182.47.9 as permitted sender) smtp.mailfrom=Vineet.Gupta1@synopsys.com
X-Gm-Message-State: AOPr4FXBgvBLpqKu4L8AHg1VbtRLtvA6hD7QFS240WiX0s6laNARl5HH4NMtqtNBg0aUv8PSVZem3eAhHJ4LcrL2Glxcy5oc5OQOMDwscn39WzyaOHOWvaqlO6lIkHvf/j91JroJH10IHLA+kxhV1O7v1HmzKSQOrRjTDHUaWmNOsyMApr57I1ehPsKS
X-Received: by 10.66.101.35 with SMTP id fd3mr12008482pab.7.1460546511309;
        Wed, 13 Apr 2016 04:21:51 -0700 (PDT)
X-Received: by 10.66.101.35 with SMTP id fd3mr12008448pab.7.1460546510912;
        Wed, 13 Apr 2016 04:21:50 -0700 (PDT)
Received: from smtprelay.synopsys.com (us01smtprelay-2.synopsys.com. [198.182.47.9])
        by mx.google.com with ESMTPS id y19si869473pfa.62.2016.04.13.04.21.50
        for <linux-mm@kvack.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Apr 2016 04:21:50 -0700 (PDT)
Received-SPF: pass (google.com: best guess record for domain of Vineet.Gupta1@synopsys.com designates 198.182.47.9 as permitted sender) client-ip=198.182.47.9;
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of Vineet.Gupta1@synopsys.com designates 198.182.47.9 as permitted sender) smtp.mailfrom=Vineet.Gupta1@synopsys.com
Received: from dc8secmta1.synopsys.com (dc8secmta1.synopsys.com [10.13.218.200])
	by smtprelay.synopsys.com (Postfix) with ESMTP id 3533124E0D97;
	Wed, 13 Apr 2016 04:21:50 -0700 (PDT)
Received: from dc8secmta1.internal.synopsys.com (dc8secmta1.internal.synopsys.com [127.0.0.1])
	by dc8secmta1.internal.synopsys.com (Service) with ESMTP id 104D627113;
	Wed, 13 Apr 2016 04:21:50 -0700 (PDT)
Received: from mailhost.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
	by dc8secmta1.internal.synopsys.com (Service) with ESMTP id DDA4227102;
	Wed, 13 Apr 2016 04:21:49 -0700 (PDT)
Received: from mailhost.synopsys.com (localhost [127.0.0.1])
	by mailhost.synopsys.com (Postfix) with ESMTP id CCAFE740;
	Wed, 13 Apr 2016 04:21:49 -0700 (PDT)
Received: from US01WEHTC2.internal.synopsys.com (us01wehtc2.internal.synopsys.com [10.12.239.237])
	by mailhost.synopsys.com (Postfix) with ESMTP id 821A273D;
	Wed, 13 Apr 2016 04:21:49 -0700 (PDT)
Received: from IN01WEHTCA.internal.synopsys.com (10.144.199.104) by
 US01WEHTC2.internal.synopsys.com (10.12.239.237) with Microsoft SMTP Server
 (TLS) id 14.3.195.1; Wed, 13 Apr 2016 04:21:49 -0700
Received: from IN01WEHTCB.internal.synopsys.com (10.144.199.105) by
 IN01WEHTCA.internal.synopsys.com (10.144.199.103) with Microsoft SMTP Server
 (TLS) id 14.3.195.1; Wed, 13 Apr 2016 16:51:47 +0530
Received: from [10.12.197.158] (10.12.197.158) by
 IN01WEHTCB.internal.synopsys.com (10.144.199.243) with Microsoft SMTP Server
 (TLS) id 14.3.195.1; Wed, 13 Apr 2016 16:51:46 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
In-Reply-To: <1460372892-8157-1-git-send-email-mhocko@kernel.org>
X-Originating-IP: [10.12.197.158]
X-Bogosity: Ham, tests=bogofilter, spamicity=0.000000, version=1.2.4
Sender: owner-linux-mm@kvack.org
Precedence: bulk
X-Loop: owner-majordomo@kvack.org
List-ID: <linux-mm.kvack.org>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291389>

Trimming CC list + CC git folks

Hi Michal,

On Monday 11 April 2016 04:37 PM, Michal Hocko wrote:
> Hi,
> this is the second version of the patchset previously sent [1]

I have a git question if you didn't mind w.r.t. this series. Maybe there's an
obvious answer... I'm using git 2.5.0

I was wondering how you manage to union the individual patch CC in just the cover
letter w/o bombarding everyone with everything.

Thx,
-Vineet

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
