From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGit PATCH 13/13] Remove the 'top' field
Date: Sun, 16 Sep 2007 01:36:32 +0200
Message-ID: <20070915233632.GC25507@diana.vm.bytemark.co.uk>
References: <20070914222819.7001.55921.stgit@morpheus.local> <20070914223215.7001.80066.stgit@morpheus.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, catalin.marinas@gmail.com
To: David =?iso-8859-1?Q?K=E5gedal?= <davidk@lysator.liu.se>
X-From: git-owner@vger.kernel.org Sun Sep 16 01:36:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IWhBs-0007pR-4L
	for gcvg-git-2@gmane.org; Sun, 16 Sep 2007 01:36:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753306AbXIOXgj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 15 Sep 2007 19:36:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753289AbXIOXgi
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Sep 2007 19:36:38 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4436 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753213AbXIOXgh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Sep 2007 19:36:37 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1IWhBg-0006iw-00; Sun, 16 Sep 2007 00:36:32 +0100
Content-Disposition: inline
In-Reply-To: <20070914223215.7001.80066.stgit@morpheus.local>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58280>

On 2007-09-15 00:32:15 +0200, David K=E5gedal wrote:

> @@ -436,7 +422,13 @@ class Series(PatchSet):
>                  patch =3D patch.strip()
>                  os.rename(os.path.join(branch_dir, patch),
>                            os.path.join(patch_dir, patch))
> -                Patch(patch, patch_dir, refs_base).update_top_ref()
> +                topfield =3D os.path.join(patch_dir, patch, 'top')
> +                if os.path.isfile(topfield):
> +                    top =3D read_string(topfield, False)
> +                else:
> +                    top =3D None
> +                if top:
> +                    git.set_ref(refs_base + '/' + patch, top)
>              set_format_version(1)
> =20
>          # Update 1 -> 2.

And remove the top file, maybe? (Or I may be mistaken; I don't have a
copy of the surrounding code handy.)

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
