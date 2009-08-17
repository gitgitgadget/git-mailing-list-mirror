From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC PATCH v3 8/8] --sparse for porcelains
Date: Mon, 17 Aug 2009 17:19:31 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0908171712220.4991@intel-tinevez-2-302>
References: <1250005446-12047-1-git-send-email-pclouds@gmail.com>  <200908142223.07994.jnareb@gmail.com> <7veird4yyi.fsf@alter.siamese.dyndns.org>  <200908160137.30384.jnareb@gmail.com> <alpine.DEB.1.00.0908161002460.8306@pacific.mpi-cbg.de> 
 <alpine.DEB.1.00.0908171101090.4991@intel-tinevez-2-302> <fcaeb9bf0908170549w26b008bdhe67f113a58ecb4eb@mail.gmail.com>  <alpine.DEB.1.00.0908171524150.4991@intel-tinevez-2-302> <fcaeb9bf0908170741v210e7f4et9f1c68bc9a81ca65@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-1707990239-1250522371=:4991"
Cc: Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 17 17:19:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Md3zs-0004ok-Kd
	for gcvg-git-2@lo.gmane.org; Mon, 17 Aug 2009 17:19:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756183AbZHQPTe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2009 11:19:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756077AbZHQPTd
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Aug 2009 11:19:33 -0400
Received: from mail.gmx.net ([213.165.64.20]:60353 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756080AbZHQPTd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2009 11:19:33 -0400
Received: (qmail invoked by alias); 17 Aug 2009 15:19:32 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp009) with SMTP; 17 Aug 2009 17:19:32 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18Wp2w0s9MWb7OolzN0rF44+pjHQXrPr02Qzxn/5l
	UlRUZImZoISdwM
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <fcaeb9bf0908170741v210e7f4et9f1c68bc9a81ca65@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.5600000000000001
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126192>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1707990239-1250522371=:4991
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi,

On Mon, 17 Aug 2009, Nguyen Thai Ngoc Duy wrote:

> On Mon, Aug 17, 2009 at 8:35 PM, Johannes
> Schindelin<Johannes.Schindelin@gmx.de> wrote:
>
> > The problem of course is that the other branch has an ancient version 
> > of that file (which should _not_ overwrite the current, modified 
> > version!), i.e. "git diff HEAD..other -- file" does not come empty.
> >
> > As 'file' is assume-unchanged, zinnnng, the file gets "updated".
> 
> Then it is a bug. Assume-unchanged as in reading is good.
> Assume-unchanged in writing sounds scary. Something like this should
> fix it (not well tested though). It's on top of my series, but you can
> adapt it to 'next' or 'master' easily.

No.

The purpose of 'assume-unchanged' is to tell Git that it has no business 
checking that the file is unchanged.  It should _assume_ that it is 
unchanged.  That's what this flag says.

So do you agree that assume-changed is not quite similar enough to sparse 
to use the same bit?

> > Another use case: documentation.  I do not have that use case yet, but 
> > I know about people who do.
> 
> Translators usually checkout one or two files (I am Vietnamese 
> Translation Coordinator of GNOME, but well... I check them all out. I 
> suppose "normal" translators would not want to do like I do.)

Exactly.

echo /Documentation/ > .git/info/sparse

Remember: the documentation contributors are the least programming-savvy 
contributors of any project.

> >  Specifying what you _want_ to have checked out is much more 
> > straight-forward here than the opposite.
> 
> I think it depends on type of projects. For documentation projects, you 
> may want a few files. For software projects, usually you need everything 
> _except_ a few big directories. For WebKit, it's a bunch of test data 
> that I don't care about. Firmware in hardware-related projects or media 
> files in game projects fall in the same category. I don't have strong 
> opinion on this. Either include or exclude is fine to me.

Okay, let me just ask: if you have a sparse checkout, what would you think 
I mean when I talk about the "sparse files"?

Ciao,
Dscho

--8323329-1707990239-1250522371=:4991--
