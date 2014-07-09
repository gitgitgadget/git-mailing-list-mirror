From: David Turner <dturner@twopensource.com>
Subject: Re: t5150-request-pull.sh fails on newest master in Debian
Date: Tue, 08 Jul 2014 18:18:22 -0700
Organization: Twitter
Message-ID: <1404868702.3775.2.camel@stross>
References: <CAA787r=78UWio3E==s+J2PbVqshQdWXpS9hiJrmNz+F0vLiuGg@mail.gmail.com>
	 <1404505370.3109.15.camel@stross>
	 <CAA787rmf36V1=Sd8TZrc7DboTkeJDYKuEGgCe90mZLLKSp6=tw@mail.gmail.com>
	 <1404525502.3109.25.camel@stross>
	 <CAA787rnMonCuON+C0U5FDXKzjTBdpOusCpGLeWytDWaA1torEw@mail.gmail.com>
	 <CAA787r=Q5B7R1sxiVhRgobPHHPro6D5YyqVO+P_MZC=aGa+ZHw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?ISO-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: =?ISO-8859-1?Q?=D8yvind?= "A. Holm" <sunny@sunbase.org>
X-From: git-owner@vger.kernel.org Wed Jul 09 03:18:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X4gWk-0001X2-VR
	for gcvg-git-2@plane.gmane.org; Wed, 09 Jul 2014 03:18:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751151AbaGIBS1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 Jul 2014 21:18:27 -0400
Received: from mail-qa0-f49.google.com ([209.85.216.49]:35125 "EHLO
	mail-qa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750947AbaGIBS0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jul 2014 21:18:26 -0400
Received: by mail-qa0-f49.google.com with SMTP id w8so5378771qac.8
        for <git@vger.kernel.org>; Tue, 08 Jul 2014 18:18:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:content-transfer-encoding
         :mime-version;
        bh=79j+WDmyS/weSZ8o31Uh8WCdaTsq+y++FcTvkwPjx+Y=;
        b=fmaROfVhLOrxhGfkAdDpbxnOb1Cx1HHC/B42ngTHoE12HaimeqSahrJTvOmbgHNp/B
         wWJLYRhJqfVrOuR2w7caQ+JGeN5Pr0PtgQXxunSJ0tTJ7uqXkMCPQ+Al5BWgnsrpEP3M
         EtvGNZvJm4teNFUulfr/bvAVP7TZoEpZPwS2p3Z0bB+qG0+wY7tr+hXiA/eU91HxAKrf
         euy2zylJ7XIgKlflnZdBkfPK8pdfZskwuh/XfkQevAVFiCv8AYPtbzgI7krZVU2Skgbs
         0hMbkcsSgFKDHHbXYzIijTdqtZoQ5tY8F3RF3mMq2gcewPRQDO4BxTrzq9xGC+hCwd60
         D6fQ==
X-Gm-Message-State: ALoCoQmZnEIMDNmOr+y6o5Wd4QOi9KmZGNKcpl+KUs3m7Svv1z9XPEDz5jILZKB/4LApVYxAFACL
X-Received: by 10.224.65.134 with SMTP id j6mr13488480qai.90.1404868705403;
        Tue, 08 Jul 2014 18:18:25 -0700 (PDT)
Received: from [172.25.140.220] ([8.25.197.27])
        by mx.google.com with ESMTPSA id 7sm29504431qgg.25.2014.07.08.18.18.23
        for <multiple recipients>
        (version=SSLv3 cipher=RC4-SHA bits=128/128);
        Tue, 08 Jul 2014 18:18:24 -0700 (PDT)
In-Reply-To: <CAA787r=Q5B7R1sxiVhRgobPHHPro6D5YyqVO+P_MZC=aGa+ZHw@mail.gmail.com>
X-Mailer: Evolution 3.2.3-0ubuntu6 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253058>

On Wed, 2014-07-09 at 02:52 +0200, =C3=98yvind A. Holm wrote:
> On 3 July 2014 23:55, =C3=98yvind A. Holm <sunny@sunbase.org> wrote:
> > When compiling newest master (v2.0.1-472-g6f92e5f) on Debian 7.5
> > (64-bit), t5150-request-pull.sh fails when compiling with
> >
> > $ make configure
> > $ ./configure --prefix=3D/usr/local/varprg/git.master.v2.0.1-472-g6=
f92e5f
> > $ make prefix=3D/usr/local/varprg/git.master.v2.0.1-472-g6f92e5f
> > $ cd t
> > $ ./t5150-request-pull.sh
>=20
> FYI, t5150-request-pull.sh passes all tests now on newest master
> (v2.0.1-474-g72c7794) in Debian. There are two new commits on master
> since I wrote this, and the commit that makes things work again is
> 4602f1a ("diff-tree: call free_commit_list() instead of duplicating
> its code"). Reverting this commit brings the failure back.
>=20
> The whole thing is still a mystery to me, though. I can't see why thi=
s
> should have anything to do with the use of ./configure --prefix.

The problem only happens when a ref with an allowed wildcard winds up o=
n
a page boundary (with the wildcard before the page boundary).  This
depends intricately on the details of memory allocation, so pretty much
anything could make it come and go.

Does the fix I posted work for you?  If not, let me know and I'll look
into it more.
