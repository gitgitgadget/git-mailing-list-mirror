From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: kha/safe and kha/experimental updated
Date: Wed, 19 Dec 2007 17:02:02 +0000
Message-ID: <b0943d9e0712190902r2000c1ebob2303b32d1b948b8@mail.gmail.com>
References: <20071214105238.18066.23281.stgit@krank>
	 <200712191144.59747.jnareb@gmail.com>
	 <20071219114021.GB5565@diana.vm.bytemark.co.uk>
	 <200712191723.29591.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>,
	"=?ISO-8859-1?Q?David_K=E5gedal?=" <davidk@lysator.liu.se>,
	git@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 19 18:02:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J52JS-0007rM-N0
	for gcvg-git-2@gmane.org; Wed, 19 Dec 2007 18:02:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750878AbXLSRCG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 19 Dec 2007 12:02:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751016AbXLSRCF
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Dec 2007 12:02:05 -0500
Received: from nz-out-0506.google.com ([64.233.162.231]:46478 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751339AbXLSRCD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 19 Dec 2007 12:02:03 -0500
Received: by nz-out-0506.google.com with SMTP id s18so1583754nze.1
        for <git@vger.kernel.org>; Wed, 19 Dec 2007 09:02:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=ChzC3hEdI64cJ/PVO13z2DKQGDjhFWvPN5yJJAgdb28=;
        b=ZTSCvNvG6QKjfW+olK8gcQHCQQ1IiJyG4xSAqBvWDGeM292qNgRqDn/BnvtS2ew0BJVH+lyXaIz9oBCjG/BRaCETFIg93nmnCDeOf2UK7wIEzgDYVAu3YcAU7wC2e84J6D541BkwgDGhL52p2ijDSI6AKe6IwbUur+se4uwIEJQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=P0IZLMvZ0pWIWc2Uz1yLWLdpCamKfDupubkaqCzrunXHCttQzIwR8iJfSLBF8kgcib/xHRBqDISkGYEibR+hl4USD9FYmmj/bg3Cy2BXRr2iyJRupy5AuM1dz5IZUkAKN6COGCIrf0CcS7r/Pih+Kxk+rNDp8Fng2FNTWZmxxt0=
Received: by 10.141.68.12 with SMTP id v12mr6063231rvk.111.1198083722238;
        Wed, 19 Dec 2007 09:02:02 -0800 (PST)
Received: by 10.141.186.5 with HTTP; Wed, 19 Dec 2007 09:02:02 -0800 (PST)
In-Reply-To: <200712191723.29591.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68920>

On 19/12/2007, Jakub Narebski <jnareb@gmail.com> wrote:
> Karl Hasselstr=F6m wrote:
> > On 2007-12-19 11:44:57 +0100, Jakub Narebski wrote:
> >> On Wed, 19 Dec 2007, Karl Hasselstr=F6m wrote:
> >>> On 2007-12-18 08:39:52 -0800, Jakub Narebski wrote:
> >>>
> >>>> I also would like to have this command kept (and shown in 'stg
> >>>> help'!). Contrary to 'git add' it can check and add to index /
> >>>> update index only for files with conflict; we have -r
> >>>> (ancestor|current|patched) to choose one side, and we could add
> >>>> --check to check if there are no conflict markers with files
> >>>> (useful with -a/--all).
> >>>
> >>> This too sounds like stuff that could profitably be added to "git
> >>> add". Except for the ancestor/current/patched words, it is not
> >>> specific to patch stacks, so the implementation should be in git
> >>> and not in stg.
> >>
> >> No it cannot, at least the '-r (ancestor|current|patched)' part fo=
r
> >> resetting file to given version, even if we change the wording to
> >> ancestor, ours and theirs. The git-add command is about adding
> >> contents, which updates index, which almost as a intended
> >> side-effect clears merge state, i.e. stages; and not about resetti=
ng
> >> to stage.
> >
> >   git checkout-index --stage=3D1|2|3 <filename>
> >
> > does what you want. But "git cat-file" knows this handy syntax for
> > getting at particular index stages:
> >
> >   :stage:<filename>
>
> I always forget which stage is which. It would be nice if
> git-checkout-index implemented human-friendly names, just like
> git-diff-files has --base, --ours, --theirs, i.e. if it would be
> possible to write
>
>   git checkout-index --stage=3Dbase|ours|theirs <filename>

This gets even more confusing with StGIT. For plain git, after a git
merge or pull conflict, 'theirs' is stage 3. With StGIT, we first
advance the base of the stack and merge the patches onto it, in which
case the 'patched' (which I would normally call 'ours' rather than
'theirs') is 3.

--=20
Catalin
