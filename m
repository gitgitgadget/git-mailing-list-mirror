From: Motiejus =?utf-8?Q?Jak=C5=A1tys?= <desired.mta@gmail.com>
Subject: Re: start of git2 (based on libgit2)
Date: Sat, 26 Mar 2011 02:13:01 +0000
Message-ID: <20110326021300.GC2934@jakstys.lt>
References: <20110325231203.GA7961@jakstys.lt>
 <4D8D2B31.4040908@lyx.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, libgit2@librelist.com
To: Vincent van Ravesteijn <vfr@lyx.org>
X-From: git-owner@vger.kernel.org Sat Mar 26 03:13:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q3J02-0007fn-1n
	for gcvg-git-2@lo.gmane.org; Sat, 26 Mar 2011 03:13:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933560Ab1CZCND convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 25 Mar 2011 22:13:03 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:54702 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932229Ab1CZCNB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 Mar 2011 22:13:01 -0400
Received: by wya21 with SMTP id 21so1559220wya.19
        for <git@vger.kernel.org>; Fri, 25 Mar 2011 19:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=bgrXVaowVGP4LPIDrpmcM+jjrPzGBoZiWWISVfHoK68=;
        b=rdIHbCELt/2QCNFr5UFvOdA8oOVo6wR9oDoQG8jIThhk/fI+e138HKBSv+lP19jrO9
         Kcci3gXxCIaJRVv69PT2QCtYu84I8lcMOyF6VAHupR+xAUKC47DA3/qj4uUipkaRezRN
         t4JTAwiSn6HIakizpGpC3uLgQ6VtOs9sl5B/s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=T0dMOBnyo23MFaPDrwzr0Nmn80JL56tLCZdiGpFf9itkbEHqyYSF/tq2r8cRe5zNux
         xzqAFvqpYirFh/n7vRrNZ0wJzCZ35XnOPlXI5X4hVz1Gs4XRvrKllr6Uo3kiJLJQZB90
         G4mdGiC9zLfF3IAwc8Zp9nPXXbW2FQm3QXKFM=
Received: by 10.227.55.4 with SMTP id s4mr1417050wbg.228.1301105580100;
        Fri, 25 Mar 2011 19:13:00 -0700 (PDT)
Received: from localhost ([109.246.247.245])
        by mx.google.com with ESMTPS id u9sm734631wbg.17.2011.03.25.19.12.58
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 25 Mar 2011 19:12:59 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4D8D2B31.4040908@lyx.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170037>

On Sat, Mar 26, 2011 at 12:54:25AM +0100, Vincent van Ravesteijn wrote:
> On 26-3-2011 0:12, Motiejus Jak=C5=A1tys wrote:
> >According to Jeff King[2], I should start with plumbing commands. I
> >agree.  However, how deep?  I.e. do I have to make sure all git rev-=
list
> >possible arguments are implemented?
>=20
> I guess a lot can be copied from Git itself. Actually
> builtin/rev-list.c consists mostly of command line arguments parsing
> methods, and outputting functions. The key is to parse what you want
> to know and ask libgit2 to provide the info. If libgit2 has
> implemented the basic functionality that is needed, the rest would
> be relatively simple.
> AFAICS, current git is a single binary on Windows already.

So I have the answer. Thank you. Further working path is getting
clearer. Finish with rev-list, make it work with t/. Then pick up
dependencies of one of the must-have commands (commit/merge/diff?),
implement them and implement the command.

>=20
> >Build tool. Currently libgit2 uses waf. I am not against it (I've ch=
osen
> >waf for one of my own C++ projects), However, it's too clumsy for me=
=2E Is
> >it me who lacks experience? Scons looks much easier for me. Moreover=
, we
> >do not need automatic configuration, so it makes waf "overfeatured".
>=20
> Why not CMake which is also used for libgit2 ?

Did not notice that. I noticed wscript and stopped looking... I never
tried CMake before. But I have nothing against it.

>=20
> I already wrote a CMakeLists file for your git2 app.

Very nice. Pull request? Patch?

>=20
> As you know, this project can be possibly fulfilled by a GSoC
> student (either you or someone else). Maybe people are awaiting this
> before diving into the project.

Competition is a good thing. The most important thing is picking the
best choice.

Thank you Vincent,
Motiejus
