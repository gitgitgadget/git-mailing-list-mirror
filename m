From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 08/12] fast-import: MinGW does not have
 getppid().  So do not print it.
Date: Wed, 2 Jul 2008 17:52:42 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0807021741210.9925@racer>
References: <15FB2EE9-298D-41D1-B66A-DDC786282ECB@zib.de> <1214987532-23640-1-git-send-email-prohaska@zib.de> <1214987532-23640-2-git-send-email-prohaska@zib.de> <1214987532-23640-3-git-send-email-prohaska@zib.de> <1214987532-23640-4-git-send-email-prohaska@zib.de> <1214987532-23640-5-git-send-email-prohaska@zib.de> <1214987532-23640-6-git-send-email-prohaska@zib.de> <1214987532-23640-7-git-send-email-prohaska@zib.de> <1214987532-23640-8-git-send-email-prohaska@zib.de> <7vzlp0bq2l.fsf@gitster.siamese.dyndns.org>
Reply-To: Johannes.Schindelin@gmx.de
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: prohaska@zib.de, Johannes Sixt <johannes.sixt@telecom.at>,  git@vger.kernel.org, msysgit@googlegroups.com
To: Junio C Hamano <junio@pobox.com>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Wed Jul 02 18:55:37 2008
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from yx-out-2122.google.com ([74.125.44.24])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KE5cG-0001Nj-Dl
	for gcvm-msysgit@m.gmane.org; Wed, 02 Jul 2008 18:55:36 +0200
Received: by yx-out-2122.google.com with SMTP id 22so108030yxm.63
        for <gcvm-msysgit@m.gmane.org>; Wed, 02 Jul 2008 09:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received-spf:authentication-results:received
         :received:x-authenticated:x-provags-id:date:from:x-x-sender:to:cc
         :subject:in-reply-to:message-id:references:user-agent:mime-version
         :content-type:x-y-gmx-trusted:x-fuhafi:reply-to:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere;
        bh=CvAsGkybnmsdIuNQ0ftGFatysn7zLMaTEq+5ZD+y94w=;
        b=qEJEEMeOTbcI037skkJg30X1sHhmjoM1bP/lT+VyoIMUfje824FRzcKngbDc4HBH7k
         Sjyd7bAIdKouXhwYr6fyyhVBUWb1VrtC7wT4a15i8uS/Q/dT38mhQ00vU2GKVZGnUpM0
         /vT0R1nru4RiAFKNHBGR7stMU9oQDMPl4O910=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results
         :x-authenticated:x-provags-id:date:from:x-x-sender:to:cc:subject
         :in-reply-to:message-id:references:user-agent:mime-version
         :content-type:x-y-gmx-trusted:x-fuhafi:reply-to:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere;
        b=HBzlYHwGo8f1OEtKv2rGnBsxH0VMdkTjMb21y74yH1kDldHMYWFMnHi+iHN9eGQZkh
         5XN8KcAhJjMQqO0hOElIXevSDJzjFYcmkCqwJ5WP/iPpkru3zn44/HY76Gy8ccADLUjq
         znvC2l39Klft4/f8PGs4L/aPWuvgevHzGXI3o=
Received: by 10.114.176.1 with SMTP id y1mr575611wae.4.1215017676600;
        Wed, 02 Jul 2008 09:54:36 -0700 (PDT)
Received: by 10.106.239.31 with SMTP id m31gr2571prh.0;
	Wed, 02 Jul 2008 09:54:36 -0700 (PDT)
X-Sender: Johannes.Schindelin@gmx.de
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.140.139.6 with SMTP id m6mr312255rvd.20.1215017676300; Wed, 02 Jul 2008 09:54:36 -0700 (PDT)
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20]) by mx.google.com with SMTP id 7si8435616yxg.1.2008.07.02.09.54.35; Wed, 02 Jul 2008 09:54:36 -0700 (PDT)
Received-SPF: pass (google.com: domain of Johannes.Schindelin@gmx.de designates 213.165.64.20 as permitted sender) client-ip=213.165.64.20;
Authentication-Results: mx.google.com; spf=pass (google.com: domain of Johannes.Schindelin@gmx.de designates 213.165.64.20 as permitted sender) smtp.mail=Johannes.Schindelin@gmx.de
Received: (qmail invoked by alias); 02 Jul 2008 16:54:35 -0000
Received: from grape.st-and.ac.uk (EHLO grape.st-and.ac.uk) [138.251.155.28] by mail.gmx.net (mp036) with SMTP; 02 Jul 2008 18:54:35 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+VM3AlZqWVv5Sy79Oav6jrdGkyD6B64ttG2rrKJq VfPIRu5QILIj1F
X-X-Sender: gene099@racer
In-Reply-To: <7vzlp0bq2l.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.51
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87160>


Hi,

On Wed, 2 Jul 2008, Junio C Hamano wrote:

> Steffen Prohaska <prohaska@zib.de> writes:
> 
> > diff --git a/fast-import.c b/fast-import.c
> > index e72b286..271b93c 100644
> > --- a/fast-import.c
> > +++ b/fast-import.c
> > @@ -391,7 +391,9 @@ static void write_crash_report(const char *err)
> >  
> >  	fprintf(rpt, "fast-import crash report:\n");
> >  	fprintf(rpt, "    fast-import process: %d\n", getpid());
> > +#ifndef __MINGW32__
> >  	fprintf(rpt, "    parent process     : %d\n", getppid());
> > +#endif
> >  	fprintf(rpt, "    at %s\n", show_date(time(NULL), 0, DATE_LOCAL));
> >  	fputc('\n', rpt);
> >  
> > -- 
> > 1.5.6.1.255.g32571
> 
> It does not matter too much for this part that writes crash report, but
> keeping the file format the same across platforms will make it easier for
> tools to read output, so as a general principle, I think this is a
> suboptimal solution to the issue.  How about throwing something like this
> in MinGW specific header files?
> 
>         #define getppid() 0

Of course, we could also implement it, using NtQueryInformationProcess() 
as suggested by Google.

Ciao,
Dscho

		
