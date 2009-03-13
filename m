From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGit PATCH 4/5] Convert "sink" to the new infrastructure
Date: Fri, 13 Mar 2009 03:27:51 +0100
Message-ID: <20090313022751.GD15393@diana.vm.bytemark.co.uk>
References: <20090312120426.2992.35213.stgit@pc1117.cambridge.arm.com> <20090312120913.2992.21403.stgit@pc1117.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 13 03:29:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lhx9I-0002RQ-C4
	for gcvg-git-2@gmane.org; Fri, 13 Mar 2009 03:29:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751218AbZCMC1z convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Mar 2009 22:27:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750842AbZCMC1y
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Mar 2009 22:27:54 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:59846 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750732AbZCMC1y (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Mar 2009 22:27:54 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1Lhx7n-0004JX-00; Fri, 13 Mar 2009 02:27:51 +0000
Content-Disposition: inline
In-Reply-To: <20090312120913.2992.21403.stgit@pc1117.cambridge.arm.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113137>

Nicely done.

  Acked-by: Karl Hasselstr=F6m <kha@treskal.com>

On 2009-03-12 12:09:13 +0000, Catalin Marinas wrote:

> +    applied =3D applied[:insert_idx] + patches + applied[insert_idx:=
]
> +
> +    unapplied =3D [p for p in stack.patchorder.unapplied if p not in=
 patches]
> +    hidden =3D list(stack.patchorder.hidden)
> +
> +    iw =3D stack.repository.default_iw
> +    clean_iw =3D not options.keep and iw or None
> +    trans =3D transaction.StackTransaction(stack, 'sink',
> +                                         check_clean_iw =3D clean_iw=
)
> +
> +    try:
> +        trans.reorder_patches(applied, unapplied, hidden, iw)

Hmm. We should maybe have a default value for hidden: the current list
of patches. Not changing the hidden patches is a common operation.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
