From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGit PATCH] Add the --merged option to goto
Date: Thu, 26 Mar 2009 12:15:54 +0100
Message-ID: <20090326111554.GA19337@diana.vm.bytemark.co.uk>
References: <20090320161233.28989.82497.stgit@pc1117.cambridge.arm.com> <20090323084507.GA6447@diana.vm.bytemark.co.uk> <b0943d9e0903230933n5b71a53elcfaa13f00883861d@mail.gmail.com> <20090324131640.GB4040@diana.vm.bytemark.co.uk> <b0943d9e0903240840m3f22b702qd48293caad4187e3@mail.gmail.com> <20090325090541.GA24889@diana.vm.bytemark.co.uk> <b0943d9e0903250324j9ed0ed9k2d97cbacba6a7801@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 26 12:18:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lmnao-0004M1-7U
	for gcvg-git-2@gmane.org; Thu, 26 Mar 2009 12:17:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753158AbZCZLQG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 26 Mar 2009 07:16:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751949AbZCZLQF
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Mar 2009 07:16:05 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:35900 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751255AbZCZLQE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Mar 2009 07:16:04 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1LmnYw-00052l-00; Thu, 26 Mar 2009 11:15:54 +0000
Content-Disposition: inline
In-Reply-To: <b0943d9e0903250324j9ed0ed9k2d97cbacba6a7801@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114770>

On 2009-03-25 10:24:13 +0000, Catalin Marinas wrote:

> BTW, why don't we keep the tree information directly in the Index
> object? Since this object is modified only via its own interface, it
> can do all the checks and avoid the managing of temp_index_tree in
> the Transaction object.

I guess that might be a good idea -- it should be doable without any
extra overhead for users that don't want it.

> Yes. But it may be even better to do this in Index.
> Index.apply_treediff() would set the tree to None and read_tree or
> write_tree would set it to the corresponding tree.

We'd have to cover the other index operations too. But yes, this is
probably a good idea.

> > =A03. Why are empty patches considered not merged?
>
> They would be reported as empty anyway and in general you don't
> submit empty patches for upstream merging.

Ah, duh. I was forgetting what the "merged" detection was for in the
first place.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
