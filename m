From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 02/11] Fix declare variable at mid of   
 function
Date: Wed, 19 Aug 2009 15:15:01 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0908191514020.5594@intel-tinevez-2-302>
References: <1250524872-5148-1-git-send-email-lznuaa@gmail.com>  <1250524872-5148-2-git-send-email-lznuaa@gmail.com>  <alpine.DEB.1.00.0908171827040.4991@intel-tinevez-2-302>  <3f4fd2640908170934w4c48ada1o66745f845ecb7d49@mail.gmail.com>  <alpine.DEB.1.00.0908172134150.8306@pacific.mpi-cbg.de>  <4A8A3ADE.9010703@gmail.com>  <alpine.DEB.1.00.0908181132470.4680@intel-tinevez-2-302> <1976ea660908180911m7469ac20w48a28b90262d25f6@mail.gmail.com> <alpine.DEB.1.00.0908191158310.5594@intel-tinevez-2-302> <4A8BDA2A.9030105@viscovery.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Frank Li <lznuaa@gmail.com>, Marius Storm-Olsen <mstormo@gmail.com>,  Reece Dunn <msclrhd@googlemail.com>, git@vger.kernel.org,  msysgit@googlegroups.com
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Wed Aug 19 15:15:26 2009
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-qy0-f149.google.com ([209.85.221.149])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mdl0Z-00064o-Ff
	for gcvm-msysgit@m.gmane.org; Wed, 19 Aug 2009 15:15:19 +0200
Received: by qyk13 with SMTP id 13so4744606qyk.24
        for <gcvm-msysgit@m.gmane.org>; Wed, 19 Aug 2009 06:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received:received-spf:authentication-results
         :received:received:x-authenticated:x-provags-id:date:from:x-x-sender
         :to:cc:subject:in-reply-to:message-id:references:user-agent
         :mime-version:content-type:x-y-gmx-trusted:x-fuhafi:sender
         :precedence:x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        bh=E6yZfDCP+KmGUNCT/82jsTy+ijpXxNNz6BWYf5IlQxc=;
        b=PqxxMU23d6IDjWyuSEmG7pib8WyEOO7LhYtmi1i6OT/8qtjjMMwzik3SIOoEa0goWo
         qdF22ZE6uvz+SriBSJWXwety8jrSdbB6Np1jwNqmsNLYUeMe6VQVfznKQs/CSOa3sm9L
         ecubGtuYGOUGISflCkKg8S7GEtNPn2mpwFneY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results
         :x-authenticated:x-provags-id:date:from:x-x-sender:to:cc:subject
         :in-reply-to:message-id:references:user-agent:mime-version
         :content-type:x-y-gmx-trusted:x-fuhafi:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        b=P9eOxcaj5HIo91NncqYk0EU5mqLRNyYKPNSH+s4O0K4ruKTe4k6/w+xJCa5o5mA7fs
         og5nyTPFFEsCHHN4Xtm0/MfFRu6ItcqvNzkEQtZCSXQ2MX8KakzXHNvPNAoo0LLlS/eA
         o69znf7kc87vcsuTFdqR1PlTrRcjV5zWbui4Q=
Received: by 10.224.66.152 with SMTP id n24mr500236qai.17.1250687713244;
        Wed, 19 Aug 2009 06:15:13 -0700 (PDT)
Received: by 10.176.146.3 with SMTP id t3gr6541yqd.0;
	Wed, 19 Aug 2009 06:15:04 -0700 (PDT)
X-Sender: Johannes.Schindelin@gmx.de
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.210.116.3 with SMTP id o3mr322398ebc.11.1250687702905; Wed, 19 Aug 2009 06:15:02 -0700 (PDT)
Received: by 10.210.116.3 with SMTP id o3mr322397ebc.11.1250687702886; Wed, 19 Aug 2009 06:15:02 -0700 (PDT)
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20]) by gmr-mx.google.com with SMTP id 15si26324ewy.0.2009.08.19.06.15.02; Wed, 19 Aug 2009 06:15:02 -0700 (PDT)
Received-SPF: pass (google.com: domain of Johannes.Schindelin@gmx.de designates 213.165.64.20 as permitted sender) client-ip=213.165.64.20;
Authentication-Results: gmr-mx.google.com; spf=pass (google.com: domain of Johannes.Schindelin@gmx.de designates 213.165.64.20 as permitted sender) smtp.mail=Johannes.Schindelin@gmx.de
Received: (qmail invoked by alias); 19 Aug 2009 13:15:02 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5] by mail.gmx.net (mp049) with SMTP; 19 Aug 2009 15:15:02 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+vWr44Lamvos6tZPF7Q0qvpBn7vngWMA2Dbq2shu 5JC5gt1YOPWKuF
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <4A8BDA2A.9030105@viscovery.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.61
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126543>


Hi,

On Wed, 19 Aug 2009, Johannes Sixt wrote:

> Johannes Schindelin schrieb:
> > On Wed, 19 Aug 2009, Frank Li wrote:
> >> I have push my change to tgit
> >> git://repo.or.cz/tgit.git
> >> branch vcpatch2
> >>
> >> How do I know if patch has been applied main line?
> > 
> > I applied them to 4msysgit.git's devel.  Note that I had a strange 
> > merge conflict in pager.c: you replaced and #ifndef __MINGW32__ with 
> > an #ifndef WIN32, but I don't have that #ifndef at all.
> 
> 4msysgit has my "Windows: Better support PAGER settings with spaces in 
> the path", which removes the #ifndefs, Frank's version doesn't have it. 
> Therefore, you should not rebase Frank's patches on top of 4msysgit's 
> master or devel before they are merged into git.git.

Well, I wanted to give them a little bit more visibility by putting them 
into 4msysgit.git, as I think the best way to get Microsoft Visual C++ 
support into git.git _is_ via 4msysgit.git.

Ciao,
Dscho
