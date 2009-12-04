From: Karl Wiberg <kha@treskal.com>
Subject: Re: [StGit PATCH v2 3/6] stg mail: make __send_message do more
Date: Fri, 4 Dec 2009 08:00:29 +0100
Message-ID: <b8197bcb0912032300v62b8764bh7bff7e273a4792f5@mail.gmail.com>
References: <20091202003503.7737.51579.stgit@bob.kio>
	 <20091202004616.7737.60382.stgit@bob.kio>
	 <b8197bcb0912012303i3bd1061fhdb391de096996a27@mail.gmail.com>
	 <20091203193018.GF23258@ldl.fc.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: catalin.marinas@gmail.com, git <git@vger.kernel.org>
To: Alex Chiang <achiang@hp.com>
X-From: git-owner@vger.kernel.org Fri Dec 04 08:00:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NGS9e-0002MP-9s
	for gcvg-git-2@lo.gmane.org; Fri, 04 Dec 2009 08:00:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752969AbZLDHAZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Dec 2009 02:00:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752288AbZLDHAZ
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Dec 2009 02:00:25 -0500
Received: from mail1.space2u.com ([62.20.1.135]:46918 "EHLO mail1.space2u.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752235AbZLDHAZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Dec 2009 02:00:25 -0500
Received: from mail-bw0-f227.google.com (mail-bw0-f227.google.com [209.85.218.227])
	(authenticated bits=0)
	by mail1.space2u.com (8.14.3/8.14.3) with ESMTP id nB470NJN028151
	(version=TLSv1/SSLv3 cipher=DES-CBC3-SHA bits=168 verify=NOT)
	for <git@vger.kernel.org>; Fri, 4 Dec 2009 08:00:23 +0100
Received: by bwz27 with SMTP id 27so1724313bwz.21
        for <git@vger.kernel.org>; Thu, 03 Dec 2009 23:00:29 -0800 (PST)
Received: by 10.204.21.4 with SMTP id h4mr2775904bkb.58.1259910029376; Thu, 03 
	Dec 2009 23:00:29 -0800 (PST)
In-Reply-To: <20091203193018.GF23258@ldl.fc.hp.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134498>

On Thu, Dec 3, 2009 at 8:30 PM, Alex Chiang <achiang@hp.com> wrote:

> * Karl Wiberg <kha@treskal.com>:
>
> > On Wed, Dec 2, 2009 at 1:46 AM, Alex Chiang <achiang@hp.com> wrote:
> >
> > > +    for (p, n) in zip(patches, range(1, total_nr + 1)):
> > > +        msg_id = __send_message('patch', tmpl, options, p, n, total_nr, ref_id)
> >
> > Can be written as
> >
> >   for (n, p) in enumerate(patches):
> >
> > if you use n + 1 instead of n in the loop body.
>
> That is a little cleaner, but I decided to keep it as zip(). Why?
> Because using n + 1 in the loop body will push that line past 80
> columns. ;)
>
> It's also the original code (albeit with a simple variable rename).
>
> I know this isn't the kernel, and that there are plenty of other
> lines that are 80+ characters, but if you can keep it short, why
> not?

Oh, I fully favor keeping lines within the 80 columns allotted to us
by the ancestors---I just didn't realize it was going to be a problem
here.

In general, though, programmer time is worth optimizing for, and
thinking through exactly what zip(patches, range(1, total_nr + 1))
means (and getting it right!) is a small but not insignificant cost
every time someone reads the code.

-- 
Karl Wiberg, kha@treskal.com
   subrabbit.wordpress.com
   www.treskal.com/kalle
