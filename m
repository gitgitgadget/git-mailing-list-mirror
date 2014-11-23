From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC 3/4] engine.pl: split the .o and .obj processing
Date: Sun, 23 Nov 2014 16:28:48 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1411231624230.13845@s15462909.onlinehome-server.info>
References: <1416526682-6024-1-git-send-email-philipoakley@iee.org> <1416526682-6024-4-git-send-email-philipoakley@iee.org> <alpine.DEB.1.00.1411211043050.13845@s15462909.onlinehome-server.info> <622F65684C63407184D58ED19385AFD4@PhilipOakley>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: GitList <git@vger.kernel.org>, Marius Storm-Olsen <mstormo@gmail.com>, 
    Ramsay Jones <ramsay@ramsay1.demon.co.uk>, 
    Jonathan Nieder <jrnieder@gmail.com>, 
    Michael Wookey <michaelwookey@gmail.com>, 
    Msysgit <msysgit@googlegroups.com>
To: Philip Oakley <philipoakley@iee.org>
X-From: msysgit+bncBCZPH74Q5YNRBOH2Y6RQKGQE4SU4JOY@googlegroups.com Sun Nov 23 16:28:57 2014
Return-path: <msysgit+bncBCZPH74Q5YNRBOH2Y6RQKGQE4SU4JOY@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-qc0-f187.google.com ([209.85.216.187])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCZPH74Q5YNRBOH2Y6RQKGQE4SU4JOY@googlegroups.com>)
	id 1XsZ5t-0002je-7o
	for gcvm-msysgit@m.gmane.org; Sun, 23 Nov 2014 16:28:57 +0100
Received: by mail-qc0-f187.google.com with SMTP id r5sf1167820qcx.14
        for <gcvm-msysgit@m.gmane.org>; Sun, 23 Nov 2014 07:28:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version:content-type:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe;
        bh=TA26FiCREdr086VGyq6GTI5S52oUNt4sQziytj5jkPw=;
        b=tAM0No01pghfi6I6bYDQxKhMp0YuQvTMQusK/25v7XKfZ21m4xpN+OQrLfkZo/fSVq
         Lis5h1XOE2Icz761lH2ZeGwM4lezAOVx2YIjidJEBBEEQhSVKnvtkfZeVjluj9/HodWE
         mBWsU43vO6kuJdPb0pc/pkoTD8fd6PTA3NQWt4B5ClHEq2uGbKMt4CSWoh0YDgSTzjlR
         esZV3GWHizhzaa6VDv+4w/hSpAHB9CIL9ij25vpLu0JPIExmpzX9YKguaBx5JFpYVwtJ
         ZDCRJBXppY/rZRpwRwwStBpS1tm9FOHigdz2Z45w67ssuhKudwVQcxjhAzorKJhRVvq2
         R5Jg==
X-Received: by 10.50.36.9 with SMTP id m9mr89244igj.2.1416756536715;
        Sun, 23 Nov 2014 07:28:56 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.107.134.157 with SMTP id q29ls976455ioi.18.gmail; Sun, 23 Nov
 2014 07:28:56 -0800 (PST)
X-Received: by 10.68.180.101 with SMTP id dn5mr5710093pbc.5.1416756536201;
        Sun, 23 Nov 2014 07:28:56 -0800 (PST)
Received: from mout.gmx.net (mout.gmx.net. [212.227.15.19])
        by gmr-mx.google.com with ESMTPS id u15si377452igr.3.2014.11.23.07.28.55
        for <msysgit@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 23 Nov 2014 07:28:56 -0800 (PST)
Received-SPF: pass (google.com: domain of Johannes.Schindelin@gmx.de designates 212.227.15.19 as permitted sender) client-ip=212.227.15.19;
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx002) with ESMTPSA (Nemesis) id 0MgLMU-1XY81f215i-00NkqN;
 Sun, 23 Nov 2014 16:28:49 +0100
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <622F65684C63407184D58ED19385AFD4@PhilipOakley>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:SaEnOa4P/PXDBFT/ya8aVtNIGhc3ASBaO8zMGHsl+kR5icPURNQ
 81pnFApF+aOWiBYLdsryDTGfySDiumUeQdWkIY+oLfsFselw+PrIPSraYggf3USGWyx/Q+9
 gUG/jIv8fubCWu6GmjVAfTL7qgNUvPmRyi9wrpgU2wpRotW2QrNoQoTt+Qdgagz50vJXEio
 92oKlwYpVeG61P1xxbBZQ==
X-UI-Out-Filterresults: notjunk:1;
X-Original-Sender: johannes.schindelin@gmx.de
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of Johannes.Schindelin@gmx.de designates 212.227.15.19 as
 permitted sender) smtp.mail=Johannes.Schindelin@gmx.de
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/msysgit/subscribe>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260088>

Hi,

On Fri, 21 Nov 2014, Philip Oakley wrote:

> From: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
>
> > On Thu, 20 Nov 2014, Philip Oakley wrote:
> >
> > > @@ -343,8 +346,10 @@ sub handleLinkLine
> > >          } elsif ($part =~ /\.(a|lib)$/) {
> > >              $part =~ s/\.a$/.lib/;
> > >              push(@libs, $part);
> > > -        } elsif ($part =~ /\.(o|obj)$/) {
> > > +        } elsif ($part =~ /\.o$/) { # was '/\.(o|obj)$'
> > >              push(@objfiles, $part);
> > > +        } elsif ($part =~ /\.obj$/) { # was '/\.(o|obj)$'
> > > +            # push(@objfiles, $part); # do nothing
> >
> > How about the following instead?
> >
> > + } elsif ($part eq 'invalidcontinue.obj') {
> > + # ignore
> >  } elsif ($part =~ /\.(o|obj)$/) {
> 
> Looks good, I'll use that (after deciding whether .obj files should be
> expected in a 'make' output anyway)

My idea to hardcode invalidcontinue.obj was that I'd rather see a failure
if an unexpected .obj is seen there. But I realize that my suggested
change does not exactly accomplish that.

Ciao,
Johannes
