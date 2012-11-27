From: Magnus =?iso-8859-1?Q?B=E4ck?= <baeck@google.com>
Subject: Re: Python extension commands in git - request for policy change
Date: Tue, 27 Nov 2012 09:35:11 -0500
Message-ID: <20121127143510.GA15831@google.com>
References: <20121125024451.1ADD14065F@snark.thyrsus.com>
 <CAMP44s18MzmWRNRiRjL6hvpK1cm=S-97fB2ep-_0RAhnfs5cvA@mail.gmail.com>
 <50B1F684.5020805@alum.mit.edu>
 <CAMP44s0WYiV3hTE7u28_Wd59FkGfu3o_psS0gocpnibzN4--Fg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	"Eric S. Raymond" <esr@thyrsus.com>, git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 27 15:35:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdMG3-0003je-CU
	for gcvg-git-2@plane.gmane.org; Tue, 27 Nov 2012 15:35:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753382Ab2K0OfO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 27 Nov 2012 09:35:14 -0500
Received: from mail-gh0-f202.google.com ([209.85.160.202]:63361 "EHLO
	mail-gh0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752712Ab2K0OfM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2012 09:35:12 -0500
Received: by mail-gh0-f202.google.com with SMTP id z10so1203055ghb.1
        for <git@vger.kernel.org>; Tue, 27 Nov 2012 06:35:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=PZZYgK7wlJ5SxYfR5wllf+rHr/TRO1tTR/4ohwjFFqI=;
        b=GcCreTtzKvHWBYB1iRsTUpI2kCAzcPRn2Gf/TZAtDbkCOaEX7UZ6ZdqrPqJBZ6OFNH
         YctmMZuQcb+tU6KV3ZEttTlCqycHryg62VL+SpFQ0fjE2yMyiftDJXeBN+qyZX6EsotR
         q93XNSJxZ7u9jWmqxGDL3gJiZTye5zrn4KvBd5DhqVqCp4G6tbCX8Dic1MKleQAYDnI0
         vBjfEOX1ENYes6XHdAw1WCnkHxFlSNg9zVywXb5/vGOFwtj98h3CJecbUDplvxWGDFRc
         Ga33yotPTPSN4GXj0cpkV4tnIo4rckGGVw80XK710LJsdKGMrAUoVztEqmluO9iXIvPo
         ysbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent:x-gm-message-state;
        bh=PZZYgK7wlJ5SxYfR5wllf+rHr/TRO1tTR/4ohwjFFqI=;
        b=cSNn7c4u4Yc280DIqT6vDFWPxdo9VhZ/QmQ3hzi6h2ZixXhYLsCrGCB8nTLxGB2DQ/
         Mq0HSEoWM6xfoN25lrIT2/8vPQcyuBY1Ixq3GvN9uf93Op11sw9rrGQUkDcBzX6KLkCi
         3eJO4rzVAjZhfdo1XdWqbXPqllAkjWyVJH1CgLagDE5icPy6vlvFEQNOma9HLX1O4IEV
         zuESIO0biU2pCB1xgY5BR6aLoIwDBLfKnvVzFYCW0xPIt7arH1/+Mb5V7Ofhb+kfJcKE
         8nGnI6YF9ZVfApV6XgEcLb3Xj8fKCoOImXyo7WFH07Yde4MWZ2CdOQA1VGxZORPmPsLR
         nieg==
Received: by 10.236.48.99 with SMTP id u63mr9968785yhb.46.1354026911754;
        Tue, 27 Nov 2012 06:35:11 -0800 (PST)
Received: from wpzn4.hot.corp.google.com (216-239-44-65.google.com [216.239.44.65])
        by gmr-mx.google.com with ESMTPS id r10si711125ann.1.2012.11.27.06.35.11
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Tue, 27 Nov 2012 06:35:11 -0800 (PST)
Received: from valle.nyc.corp.google.com (valle.nyc.corp.google.com [172.26.78.170])
	by wpzn4.hot.corp.google.com (Postfix) with ESMTP id AD32C82004A;
	Tue, 27 Nov 2012 06:35:11 -0800 (PST)
Received: by valle.nyc.corp.google.com (Postfix, from userid 159662)
	id 51E7060FFE; Tue, 27 Nov 2012 09:35:11 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <CAMP44s0WYiV3hTE7u28_Wd59FkGfu3o_psS0gocpnibzN4--Fg@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Gm-Message-State: ALoCoQlVGdpOOKw0w1sDGTl9t+R0thKOfAW8nnE7srv4OuqXEg6jYhHBHVuchVoja03v0ebbP+tGFB88C8HdynC5SByqN3/R7sh9cclotwHti/3Xzs34uZtRJjnN4Jx7A4aSISAASOY5qExq1mPOPMbYXo3UdlZsS+2cA4kK9TDktuH8aaNBk7DbE2pazhRftuecXMFA575C
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210560>

On Sunday, November 25, 2012 at 06:40 EST,
     Felipe Contreras <felipe.contreras@gmail.com> wrote:

> On Sun, Nov 25, 2012 at 11:44 AM, Michael Haggerty
> <mhagger@alum.mit.edu> wrote:

[...]

> > On the contrary, there is *constant* traffic on the mailing list
> > about incompatibilities between different shell implementations (sh=
,
> > dash, bash, etc), not to mention those in other utilities (sed,
> > grep, etc) that one is forced to work with in shell scripts.
> > Compatibility is a *huge* pain when developing shell code for git.
> > The fact that users typically don't encounter such problems is due
> > to the hard work of POSIX lawyers on the mailing list correcting th=
e
> > compatibility errors of mortal programmers.
>
> *Theoretical* incompatibilities on probably obscure systems. *I* have
> never seen such compatibility issues *in practice*.

While "constant traffic" probably overstates the issue, these are not
theoretical problems. I recall at least three cases in the last year
or so where Git has seen breakage with Solaris or Mac OS X because
of sed or tr incompatibilities, and I don't even read this list that
thoroughly.

[...]

--=20
Magnus B=E4ck
baeck@google.com
