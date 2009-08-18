From: Johan 't Hart <johanthart@gmail.com>
Subject: Re: [RFC] Enable compilation by Makefile for the MSVC
 toolchain
Date: Tue, 18 Aug 2009 18:22:57 +0200
Message-ID: <4A8AD561.1020303@gmail.com>
References: <alpine.DEB.1.00.0908172149480.8306@pacific.mpi-cbg.de> <1250600335-8642-1-git-send-email-mstormo@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes.Schindelin@gmx.de, msysgit@googlegroups.com,  git@vger.kernel.org, lznuaa@gmail.com, bonzini@gnu.org,  kusmabite@googlemail.com
To: Marius Storm-Olsen <mstormo@gmail.com>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Tue Aug 18 18:23:17 2009
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-yw0-f140.google.com ([209.85.211.140])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdRSu-0006WM-Qc
	for gcvm-msysgit@m.gmane.org; Tue, 18 Aug 2009 18:23:17 +0200
Received: by ywh4 with SMTP id 4so6315079ywh.22
        for <gcvm-msysgit@m.gmane.org>; Tue, 18 Aug 2009 09:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received:received-spf:authentication-results
         :received:dkim-signature:domainkey-signature:received:received
         :message-id:date:from:user-agent:mime-version:newsgroups:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding:sender:precedence:x-google-loop
         :mailing-list:list-id:list-post:list-help:list-unsubscribe
         :x-beenthere-env:x-beenthere;
        bh=xVnhPmbtZP8Y8muhiguZmCJHYWv5F8GbauoxuS4dMtQ=;
        b=4dwhqwC2yxgqKokpw0uxyDn8h9DA/hHoFUtH59Mt79D10SLHnGvg5KJ0plQ7jdxekX
         vggK5H/oLLd1FQ2CgvFMbEiuahACqiZlut6J74Bz1jGrFpC9Lek0RKAosHXLbIBUS/jL
         IZyXgJ3KB8G+EbBC1cDUX/V72SxeGyNgyNpwc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results
         :dkim-signature:domainkey-signature:message-id:date:from:user-agent
         :mime-version:newsgroups:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        b=TVYSFnSXGpqFpsVpvDpj3W1tCCrE1EknyMg/abV0pnRj3e+PNduo9hafMVRUVBEFeG
         a9DFOOrN4g0WuiDeLe9Isf6+yzgdTxJcd6Mh2peCm8ZDlCBlXYq3606somDgp4Ykub0Z
         2Fxk7JCed9ez1xwzFB/0evggF7bcph7fjfSRY=
Received: by 10.150.75.13 with SMTP id x13mr1689576yba.26.1250612590710;
        Tue, 18 Aug 2009 09:23:10 -0700 (PDT)
Received: by 10.177.154.18 with SMTP id g18gr6480yqo.0;
	Tue, 18 Aug 2009 09:23:06 -0700 (PDT)
X-Sender: jopie64@gmail.com
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.210.28.4 with SMTP id b4mr452688ebb.0.1250612584881; Tue, 18 Aug 2009 09:23:04 -0700 (PDT)
Received: by 10.210.28.4 with SMTP id b4mr452687ebb.0.1250612584859; Tue, 18 Aug 2009 09:23:04 -0700 (PDT)
Received: from ey-out-1920.google.com (ey-out-1920.google.com [74.125.78.147]) by gmr-mx.google.com with ESMTP id 16si1239205ewy.3.2009.08.18.09.23.03; Tue, 18 Aug 2009 09:23:03 -0700 (PDT)
Received-SPF: pass (google.com: domain of jopie64@gmail.com designates 74.125.78.147 as permitted sender) client-ip=74.125.78.147;
Authentication-Results: gmr-mx.google.com; spf=pass (google.com: domain of jopie64@gmail.com designates 74.125.78.147 as permitted sender) smtp.mail=jopie64@gmail.com; dkim=pass (test mode) header.i=@gmail.com
Received: by ey-out-1920.google.com with SMTP id 5so971849eyb.0 for <msysgit@googlegroups.com>; Tue, 18 Aug 2009 09:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma; h=domainkey-signature:received:received:sender:message-id:date:from :user-agent:mime-version:newsgroups:to:cc:subject:references :in-reply-to:content-type:content-transfer-encoding; bh=9auwfpLTbjrI/Yg217rFJyZOAx4hO1yomxo6gy6X8uo=; b=Nmov39K+e/ZgdjIyUn/FagbgmtGnqPXe1qL6sZ4BdByHz89g7oeYVOS1/XiIhCoyB5 jGUabSL0myozF7763kU2XILcTan0QDFvxv36000BWhSZqYIF0Tp+yJuNrkmMtfoP0AZb EmBTjuU/TTSKBA7I8Dky5GFCpImKHsd21bpDI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=gmail.com; s=gamma; h=sender:message-id:date:from:user-agent:mime-version:newsgroups:to :cc:subject:references:in-reply-to:content-type :content-transfer-encoding; b=K93pGS54JNGtK8M49kXOH5vH2vSZQ22QBGNhJurqEzjSMuPa1Zv8kmpftsOHCCjXkI qaZgCBQSFG56Pwfc29MOCpXzy3Uz+qfR1T8judEA3+pH3OJDayLqvmEjwIUyUZXTdt8v eKbR10gvHFuoxnV5wYMHkTZyRAU3Juiv8Lox8=
Received: by 10.210.38.5 with SMTP id l5mr4680242ebl.64.1250612583656; Tue, 18 Aug 2009 09:23:03 -0700 (PDT)
Received: from ?192.168.2.100? (dsl-083-247-086-199.solcon.nl [83.247.86.199]) by mx.google.com with ESMTPS id 28sm326094eyg.32.2009.08.18.09.23.01 (version=TLSv1/SSLv3 cipher=RC4-MD5); Tue, 18 Aug 2009 09:23:02 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.22 (Windows/20090605)
Newsgroups: gmane.comp.version-control.git,gmane.comp.version-control.msysgit
In-Reply-To: <1250600335-8642-1-git-send-email-mstormo@gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126408>


Marius Storm-Olsen schreef:
> From: Marius Storm-Olsen <mstormo@gmail.com>
> 
> By using GNU Make we can also compile with the MSVC toolchain.
> This is a rudementary patch, only meant as an RFC for now!!
> 

Would this mean that only the MSVC toolchain is used to build git in 
batch? Or does GNU Make create a .vcproj file like CMake? Because that 
ofcource is the whole purpose of using CMake. One can use the Visual 
Studio IDE to hack on git.
