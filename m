From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 11/12] verify_path(): do not allow absolute
 paths
Date: Wed, 2 Jul 2008 18:31:19 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0807021830410.9925@racer>
References: <15FB2EE9-298D-41D1-B66A-DDC786282ECB@zib.de> <1214987532-23640-1-git-send-email-prohaska@zib.de> <1214987532-23640-2-git-send-email-prohaska@zib.de> <1214987532-23640-3-git-send-email-prohaska@zib.de> <1214987532-23640-4-git-send-email-prohaska@zib.de> <1214987532-23640-5-git-send-email-prohaska@zib.de> <1214987532-23640-6-git-send-email-prohaska@zib.de> <1214987532-23640-7-git-send-email-prohaska@zib.de> <1214987532-23640-8-git-send-email-prohaska@zib.de> <1214987532-23640-9-git-send-email-prohaska@zib.de> <1214987532-23640-10-git-send-email-prohaska@zib.de> <1214987532-23640-11-git-send-email-prohaska@zib.de> <7vvdzobq0k.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0807021713290.9925@racer> <6F445BD9-CE59-435A-AAF3-F380A7BCE29E@zib.de>
Reply-To: Johannes.Schindelin@gmx.de
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junio@pobox.com>, Johannes Sixt <johannes.sixt@telecom.at>,  git@vger.kernel.org, msysgit@googlegroups.com
To: Steffen Prohaska <prohaska@zib.de>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Wed Jul 02 19:34:29 2008
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from yw-out-2122.google.com ([74.125.46.26])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KE6Dd-0007fr-AJ
	for gcvm-msysgit@m.gmane.org; Wed, 02 Jul 2008 19:34:13 +0200
Received: by yw-out-2122.google.com with SMTP id 8so190638yws.63
        for <gcvm-msysgit@m.gmane.org>; Wed, 02 Jul 2008 10:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received-spf:authentication-results:received
         :received:x-authenticated:x-provags-id:date:from:x-x-sender:to:cc
         :subject:in-reply-to:message-id:references:user-agent:mime-version
         :content-type:x-y-gmx-trusted:x-fuhafi:reply-to:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere;
        bh=apkDTp83hIPNajFwogSMI1UhBDfsYvfPNzTdcSkAuWA=;
        b=gakCYUAFXXdFA5aDuoHNQiJrYkSwwkPOS30TXxhBHY0sEEkrOQwJNGEJTyZytK1Tcy
         ve+xk16HT/o1KnBeNN5SGH0VZDpedtKvD92GCar0dJ07488vLCt2VXPT1EGYvuskQ9Uk
         gOgD98YVhpD8V2mHoCL39J8RZJmPtRz4D9v6U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results
         :x-authenticated:x-provags-id:date:from:x-x-sender:to:cc:subject
         :in-reply-to:message-id:references:user-agent:mime-version
         :content-type:x-y-gmx-trusted:x-fuhafi:reply-to:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere;
        b=qd6j8JGcYQeqD7IYwYgdxYkq7ZtNWv5miyMuRvm7THQHNZJcPZINRS9+Qt5BDBDInf
         kUPOIx4WZ/4TRopuxilRGCw1N8zau/ZAeNeRwJdcUj/9fYhe1/1CSZMdgsh2aNzB0iMw
         evKpcJanhSohE5tKfyB5NygbbdLqIWz71iXiY=
Received: by 10.141.14.14 with SMTP id r14mr517961rvi.0.1215019993616;
        Wed, 02 Jul 2008 10:33:13 -0700 (PDT)
Received: by 10.106.234.8 with SMTP id g8gr2575prh.0;
	Wed, 02 Jul 2008 10:33:13 -0700 (PDT)
X-Sender: Johannes.Schindelin@gmx.de
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.140.203.9 with SMTP id a9mr318139rvg.27.1215019993136; Wed, 02 Jul 2008 10:33:13 -0700 (PDT)
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20]) by mx.google.com with SMTP id 39si8484692yxd.0.2008.07.02.10.33.12; Wed, 02 Jul 2008 10:33:13 -0700 (PDT)
Received-SPF: pass (google.com: domain of Johannes.Schindelin@gmx.de designates 213.165.64.20 as permitted sender) client-ip=213.165.64.20;
Authentication-Results: mx.google.com; spf=pass (google.com: domain of Johannes.Schindelin@gmx.de designates 213.165.64.20 as permitted sender) smtp.mail=Johannes.Schindelin@gmx.de
Received: (qmail invoked by alias); 02 Jul 2008 17:33:11 -0000
Received: from grape.st-and.ac.uk (EHLO grape.st-and.ac.uk) [138.251.155.28] by mail.gmx.net (mp032) with SMTP; 02 Jul 2008 19:33:11 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18cZUwG4tocMVdH/ULLBcVZp7nsiF4n+rAHyd4Ifo uXyK8L8UExwG5l
X-X-Sender: gene099@racer
In-Reply-To: <6F445BD9-CE59-435A-AAF3-F380A7BCE29E@zib.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.63
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87167>


Hi,

On Wed, 2 Jul 2008, Steffen Prohaska wrote:

> On Jul 2, 2008, at 6:15 PM, Johannes Schindelin wrote:
> 
> >On Wed, 2 Jul 2008, Junio C Hamano wrote:
> >
> > >Steffen Prohaska <prohaska@zib.de> writes:
> > >
> > > >Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de> 
> > > >Signed-off-by: Steffen Prohaska <prohaska@zib.de>
> > >
> > >No commit log message?  Justification?
> >
> >Justification: adding absolute paths was not caught properly on 
> >Windows, and this was the easiest patch.
> >
> >However, IIRC, in the meantime we are nice to the user, and allow 
> >absolute paths (which we turn into a relative path, or error out if it 
> >is not under the current working directory).
> >
> >Steffen, can you revert the patch and verify that my memory does not 
> >fail me?
> 
> Is
> 
>   git add /c/msysgit/git/read-cache.c
> 
> an appropriate test?
> 
> It fails with
> 
>   error: 'c:/msysgit/git/read-cache.c' is outside repository
> 
> no matter if the commit is reverted or not.

Yes, that is enough.  It proves that the patch 11/12 is unnecessary and 
should be removed from 4msysgit.git.

Thanks,
Dscho
