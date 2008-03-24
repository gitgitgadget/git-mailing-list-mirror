From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [StGit PATCH 0/6] Two bugfixes
Date: Mon, 24 Mar 2008 09:16:42 +0000
Message-ID: <b0943d9e0803240216p2000dc23i41580ecc15102cd5@mail.gmail.com>
References: <20080320002604.13102.53757.stgit@yoghurt>
	 <b0943d9e0803200819k7300fd1fn8a21896c7ad2a1@mail.gmail.com>
	 <20080324083550.GB23337@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, "Erik Sandberg" <mandolaerik@gmail.com>
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
X-From: git-owner@vger.kernel.org Mon Mar 24 10:17:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jdinz-0002Tr-Vz
	for gcvg-git-2@gmane.org; Mon, 24 Mar 2008 10:17:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754567AbYCXJQn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 24 Mar 2008 05:16:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754503AbYCXJQn
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Mar 2008 05:16:43 -0400
Received: from rv-out-0910.google.com ([209.85.198.191]:46073 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754490AbYCXJQm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 Mar 2008 05:16:42 -0400
Received: by rv-out-0910.google.com with SMTP id k20so1419814rvb.1
        for <git@vger.kernel.org>; Mon, 24 Mar 2008 02:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=aLZO0O382yxBkGiI+RXW6h6uJ2YO+D6ZEfcJlf8hJJM=;
        b=RbMVr4ioPyiP/nRJ7f1o0ha+0IzBw2Ay7YRwlSYRaSNJeBIajPdZEw7uNL0hjx58fg/ZApZmbCzJOyrK8CqUsg5i95MEsss3BcTfTNLX3BAJeZYweClZcwWmmJ2UNETiZZdZAHiydTqKjW0sWtC8Y8hQtViHg+0wDqkiMlxXDFE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=JNN0oDDI+579Gi82n8E3r5AY3w6cg4E7IcdF/AsuBU9fmdsD9V1ASU8l8pQvsANzScoG6CWg/s09Sra2l/1+pOWi3s5d67X2WzzU322mVWeMzb6gxs8E+fogE5Zu0te715pQjkqszd8nmN+q0GstTDC449ULbKKOycGuXLLrsB0=
Received: by 10.140.188.10 with SMTP id l10mr1970600rvf.6.1206350202159;
        Mon, 24 Mar 2008 02:16:42 -0700 (PDT)
Received: by 10.141.175.11 with HTTP; Mon, 24 Mar 2008 02:16:42 -0700 (PDT)
In-Reply-To: <20080324083550.GB23337@diana.vm.bytemark.co.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78013>

On 24/03/2008, Karl Hasselstr=F6m <kha@treskal.com> wrote:
> On 2008-03-20 15:19:12 +0000, Catalin Marinas wrote:
>
>  > BTW, I have about 5 patches that apply to the stable and master
>  > branch, mainly UI updates I needed recently (like picking multiple
>  > patches at once). Since the master branch still needs some work
>  > (which I'll try to help with), maybe it's worth releasing a 0.14.2=
,
>  > together with some of the bugs reported so far.
>
>
> Absolutely. I think it would be worthwhile to treat "stable" much lik=
e
>  Junio handles his "maint" -- apply minor and/or important fixes ther=
e,
>  and release minor releases from it somewhat frequently. And merge it
>  to master often, so that master always has everything stable has.

I'll try to release 0.14.2 today or tomorrow as I'll be on holiday
afterwards for 2.5 weeks.

BTW, on the master branch, I noticed that
StackTransaction.push_patch() checks whether the patch is empty before
pushing it. The behaviour on stable is that it reports whether it's
empty after push (just like "modified", so that you know that a patch
no longer has data as a result of the merge).

On the merging side during push, we have to add the plain patch
applying first followed by a three-way merge. Do we ever need the
Index.merge() function (implemented with git-read-tree) or should we
should always uses the git-recursive-merge in
IndexAndWorktree.merge()?

--=20
Catalin
