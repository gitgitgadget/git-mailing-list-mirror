From: Marius Storm-Olsen <mstormo@gmail.com>
Subject: Re: [PATCH 01/17] Avoid declaration after statement
Date: Mon, 14 Sep 2009 16:01:32 +0200
Message-ID: <4AAE4CBC.6050307@gmail.com>
References: <cover.1252925290.git.mstormo@gmail.com>	 <1b36d8e041c9c1a6dc68f9cc3919fcf91b7a9ac6.1252925290.git.mstormo@gmail.com> <81b0412b0909140659p2472c026gaece8b9388fb21d6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes.Schindelin@gmx.de, msysgit@googlegroups.com,  git@vger.kernel.org, lznuaa@gmail.com
To: Alex Riesen <raa.lkml@gmail.com>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Mon Sep 14 16:02:12 2009
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-yx0-f137.google.com ([209.85.210.137])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MnC8C-0004Bo-4R
	for gcvm-msysgit@m.gmane.org; Mon, 14 Sep 2009 16:02:12 +0200
Received: by yxe1 with SMTP id 1so5738902yxe.21
        for <gcvm-msysgit@m.gmane.org>; Mon, 14 Sep 2009 07:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received:received-spf:received:dkim-signature
         :domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        bh=dfjzocBnZKSjGo97fDv5SvfP48Y5XmcuQqv7fR/HN3M=;
        b=1tD0CsP+keBLh6eyPQl7J9wiVNGP4mlTO3Hg3cl1nzS/1QTpfHhuCrdQ1Rqz0R7r70
         O7BnvZJKdeA+CxLxeVyT899IayP3na3nrdEWf9C+YyTP9BIKwklDLvk0kMLbgLuqY61M
         3dHyqCEK3FZ83q0fbGKjiQN3HyCtgMldQmueE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results
         :dkim-signature:domainkey-signature:message-id:date:from:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding:sender:precedence:x-google-loop
         :mailing-list:list-id:list-post:list-help:list-unsubscribe
         :x-beenthere-env:x-beenthere;
        b=njztYO9PqAd3+qS3YCOliOncnLAb0nuCM7C8gmDgDOBtOI9gt0Z30nrPh2kUUWYKxG
         BAt49UCUXbN5sj31tqMilVJlvkUWDkz7ClcJ/mUhgT6hpywELDhBRvMO+tRx9s9S4FMp
         pkXZaMzRxTcAOi9VPw0IY0SwfIhN1wd2//75U=
Received: by 10.100.202.3 with SMTP id z3mr1491320anf.12.1252936925231;
        Mon, 14 Sep 2009 07:02:05 -0700 (PDT)
Received: by 10.176.151.15 with SMTP id y15gr6978yqd.0;
	Mon, 14 Sep 2009 07:02:02 -0700 (PDT)
X-Sender: mstormo@gmail.com
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.211.184.3 with SMTP id l3mr798701ebp.9.1252936919964; Mon, 14 Sep 2009 07:01:59 -0700 (PDT)
Received: by 10.211.184.3 with SMTP id l3mr798700ebp.9.1252936919938; Mon, 14 Sep 2009 07:01:59 -0700 (PDT)
Received: from ey-out-2122.google.com (ey-out-2122.google.com [74.125.78.27]) by gmr-mx.google.com with ESMTP id 16si1300592ewy.7.2009.09.14.07.01.58; Mon, 14 Sep 2009 07:01:58 -0700 (PDT)
Received-SPF: pass (google.com: domain of mstormo@gmail.com designates 74.125.78.27 as permitted sender) client-ip=74.125.78.27;
Authentication-Results: gmr-mx.google.com; spf=pass (google.com: domain of mstormo@gmail.com designates 74.125.78.27 as permitted sender) smtp.mail=mstormo@gmail.com; dkim=pass (test mode) header.i=@gmail.com
Received: by ey-out-2122.google.com with SMTP id 22so573456eye.17 for <msysgit@googlegroups.com>; Mon, 14 Sep 2009 07:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma; h=domainkey-signature:received:received:message-id:date:from :user-agent:mime-version:to:cc:subject:references:in-reply-to :content-type:content-transfer-encoding; bh=Y3VU5oFMuhC4DBD3BILQIxCoe2prd1fyWZ3dTanpDtA=; b=EF/wQ7RyoTFKz2cyEU5L8KZgtYJOyTApOXaKytD3DicthHz4rYqg51ocaGunJ0Mkqc gTITYaM9/0fGAcjSm+R7PfabKf1gT0Q8JoWnWxbRzWYVvhgGCXbNNDmYkqxpbmVfv8Ia 3v6j/6awZJpgncUk72OqcJpIgP3V25pZjaGJA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=gmail.com; s=gamma; h=message-id:date:from:user-agent:mime-version:to:cc:subject :references:in-reply-to:content-type:content-transfer-encoding; b=TDz5ZLCdxZnQzvTCvZO94GB5a2xd1G2neoW1KSaVmyrQmnvkFaHXATD12SNsWPEa35 32v0e0HWQfbM9sOvIRHPWz+MZcMrlhBmB8eFwY/wxNddOdCtu+iFEGBM9Bsmzh0RtCdh lATzAP3SETS3OPqUMVOGgY0UGtT9wia9lGNTQ=
Received: by 10.211.146.2 with SMTP id y2mr3198564ebn.21.1252936918743; Mon, 14 Sep 2009 07:01:58 -0700 (PDT)
Received: from ?172.24.90.95? ([62.70.27.104]) by mx.google.com with ESMTPS id 10sm455769eyd.47.2009.09.14.07.01.57 (version=TLSv1/SSLv3 cipher=RC4-MD5); Mon, 14 Sep 2009 07:01:58 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.23) Gecko/20090812 Lightning/0.9 Thunderbird/2.0.0.23 ThunderGit/0.1a Mnenhy/0.7.6.666
In-Reply-To: <81b0412b0909140659p2472c026gaece8b9388fb21d6@mail.gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128482>


Alex Riesen said the following on 14.09.2009 15:59:
> On Mon, Sep 14, 2009 at 15:11, Marius Storm-Olsen <mstormo@gmail.com> wrote:
>> From: Frank Li <lznuaa@gmail.com>
>>
>> Microsoft Visual C++ does not understand this C99 style
> 
> But you don't use the C++ compiler (which does understand that syntax).

It doesn't change the name of the compiler which is called "Microsoft 
Visual C++". We're just using the C part of it :)

--
.marius
