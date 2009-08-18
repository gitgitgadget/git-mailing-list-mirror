From: Frank Li <lznuaa@gmail.com>
Subject: Re: [PATCH 07/11] Add O_BINARY flag to open flag at mingw.c
Date: Tue, 18 Aug 2009 10:02:17 +0800
Message-ID: <1976ea660908171902ubf04991x7d6890d4d9accd9a@mail.gmail.com>
References: <1250525103-5184-1-git-send-email-lznuaa@gmail.com> <1250525103-5184-2-git-send-email-lznuaa@gmail.com> <alpine.DEB.1.00.0908171856290.4991@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Cc: git@vger.kernel.org, msysgit@googlegroups.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Tue Aug 18 04:02:34 2009
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-qy0-f158.google.com ([209.85.221.158])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdE1w-0000jR-SA
	for gcvm-msysgit@m.gmane.org; Tue, 18 Aug 2009 04:02:33 +0200
Received: by qyk30 with SMTP id 30so4287063qyk.3
        for <gcvm-msysgit@m.gmane.org>; Mon, 17 Aug 2009 19:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received:received-spf:authentication-results
         :received:dkim-signature:domainkey-signature:mime-version:received
         :in-reply-to:references:date:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        bh=G0FXXb8cg/x4thJHpj/RjRt986mluz4nfCPA/5FIp1g=;
        b=RU2ZSMyjbvYdzHflYOUoR8YCoEV9JS8jQmRezsijb/2CwOSGjmUCANU5RTFvd27YOA
         764tYmEUlJZH7pOLC+U3e027QpBAViGImz2KFigW9B64jTibr0cvOCPjZQj6Ft28C15j
         913wASZoMVhHc0bE2fK6EZfcRjXIQU8sJOqOc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results
         :dkim-signature:domainkey-signature:mime-version:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding:sender:precedence:x-google-loop
         :mailing-list:list-id:list-post:list-help:list-unsubscribe
         :x-beenthere-env:x-beenthere;
        b=rNpdMwmwd4UsMyoeAX6+1rENSKPdE+jG+00mUer5Q8ZnxlbENoBnPvI9i6FnU+Z5Ci
         vpIlICwZLpB2t8o7HPAFyA/JWG5tX6Gj6Zbwfbd50n8M/Svbhg6bVNsj4Wqs7KW5MDlp
         Te6mhV6xRoUtNSVcvuvDahohOAy14RDrlzvSE=
Received: by 10.220.112.136 with SMTP id w8mr886773vcp.19.1250560946302;
        Mon, 17 Aug 2009 19:02:26 -0700 (PDT)
Received: by 10.230.85.148 with SMTP id o20gr6436vbl.0;
	Mon, 17 Aug 2009 19:02:20 -0700 (PDT)
X-Sender: lznuaa@gmail.com
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.220.87.146 with SMTP id w18mr729504vcl.7.1250560938523; Mon, 17 Aug 2009 19:02:18 -0700 (PDT)
Received: by 10.220.87.146 with SMTP id w18mr729503vcl.7.1250560938482; Mon, 17 Aug 2009 19:02:18 -0700 (PDT)
Received: from qw-out-2122.google.com (qw-out-2122.google.com [74.125.92.27]) by gmr-mx.google.com with ESMTP id 24si352294vws.15.2009.08.17.19.02.17; Mon, 17 Aug 2009 19:02:17 -0700 (PDT)
Received-SPF: pass (google.com: domain of lznuaa@gmail.com designates 74.125.92.27 as permitted sender) client-ip=74.125.92.27;
Authentication-Results: gmr-mx.google.com; spf=pass (google.com: domain of lznuaa@gmail.com designates 74.125.92.27 as permitted sender) smtp.mail=lznuaa@gmail.com; dkim=pass (test mode) header.i=@gmail.com
Received: by qw-out-2122.google.com with SMTP id 9so1140630qwb.21 for <msysgit@googlegroups.com>; Mon, 17 Aug 2009 19:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma; h=domainkey-signature:mime-version:received:in-reply-to:references :date:message-id:subject:from:to:cc:content-type :content-transfer-encoding; bh=iqsgOlNBmkUkjJ900qKoLWQxiE31ucxvPUJYuehH3SE=; b=czLhrP0wo+iUANbUSDRAsMJAlFAQOD9t69twQzLbnz5CpXoh+U8Ba3/ORxYkfDwJDx Qw0CgHrbvOtkEG6dRiVnzPz6OwzCgljgnpYwPNR0hGHVx6s/B///IuhrglTey2v64VjL kUqBhgWGKll9cX8JWdqtfbD+pA2DpjJSSMQOo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=gmail.com; s=gamma; h=mime-version:in-reply-to:references:date:message-id:subject:from:to :cc:content-type:content-transfer-encoding; b=aFy8VOia08obvNtIsQBjCXooKWH/oUTRMd1GmyUtvQDXLvCJFCQiVS1AXteEJhp3cV Lt//D4dMmhYXNlI1lsr9AxVXiy5p8iQDytlnLf1S3cotviMKUi0lnpRaLZuUlilTBgWn 8ONhFiH2TYo23IIQik9m9Bejen3HTYFydK2og=
Received: by 10.224.101.79 with SMTP id b15mr4962456qao.66.1250560937142; Mon,  17 Aug 2009 19:02:17 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0908171856290.4991@intel-tinevez-2-302>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126339>


> How about this instead?
>
> =A0 =A0 =A0 =A0mingw.c: Use the O_BINARY flag to open files
>
> =A0 =A0 =A0 =A0On Windows, non-text files must be opened using the O_BINA=
RY flag.
> =A0 =A0 =A0 =A0MinGW does this for us automatically, but Microsoft Visual=
 C++
> =A0 =A0 =A0 =A0does not.
>
> =A0 =A0 =A0 =A0Also, Johannes said that this would be a nice cleanup.
>

Okay, Do you need me change commit comments to resubmit patch?

> BTW what about fopen()?

I never found problem at fopen, I will double check it.

>
> Patch is obviously good.
>
> Ciao,
> Dscho
>
