From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: EasyGit Integration
Date: Tue, 9 Jun 2009 22:37:47 +0200
Message-ID: <20090609203747.GB13781@atjola.homenet>
References: <d411cc4a0906091159r51e7d16t4d66c6225322fb60@mail.gmail.com> <32541b130906091252i6c96c44buc148bb525d7cde14@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Scott Chacon <schacon@gmail.com>, git list <git@vger.kernel.org>
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 09 22:38:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ME84y-0007tw-DB
	for gcvg-git-2@gmane.org; Tue, 09 Jun 2009 22:37:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755513AbZFIUhs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Jun 2009 16:37:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755421AbZFIUhr
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jun 2009 16:37:47 -0400
Received: from mail.gmx.net ([213.165.64.20]:48854 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755232AbZFIUhr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jun 2009 16:37:47 -0400
Received: (qmail invoked by alias); 09 Jun 2009 20:37:48 -0000
Received: from i59F57D4A.versanet.de (EHLO atjola.local) [89.245.125.74]
  by mail.gmx.net (mp053) with SMTP; 09 Jun 2009 22:37:48 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1+4lrwIqzO4Ks0RgSA5gOpWMI5qMpNCB8nrHyLTr1
	H4wHL+TPob9hKZ
Content-Disposition: inline
In-Reply-To: <32541b130906091252i6c96c44buc148bb525d7cde14@mail.gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.58
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121220>

On 2009.06.09 15:52:46 -0400, Avery Pennarun wrote:
> On Tue, Jun 9, 2009 at 2:59 PM, Scott Chacon<schacon@gmail.com> wrote=
:
> > * breaks the various things that 'checkout' does into separate
> > commands - moves 'revert' to doing what 'checkout -- path' does, mo=
ves
> > current 'revert' to 'cherry-pick --revert' (which someone mentioned
> > was a good idea at the last GitTogether), and adds 'unstage' for
> > 'reset HEAD file'. =A0also adds a '-s' option to 'branch' to switch=
 to
> > the branch after you create it, which many people expect rather tha=
n
> > 'checkout -b'.
>=20
> This would definitely make it easier to explain things to svn users.
> To be honest, I'm not convinced svn's use of the word "revert" is
> really right, though.  Git's isn't *really* right either, since it
> actually makes a new commit, it doesn't remove the old one like it
> sounds like it does.  Maybe 'reverse' would be a better name for what
> git does, and we should just introduce another word for what svn does=
=2E
>  (With CVS, you just deleted the file and then did a checkout/update
> on it again, which made sense to me.  That works in git too.)
>=20
> Crazy idea: we could actually make 'git revert' do both: given a
> commit, it applies the reverse as it does now.  Given filenames, it
> simply brings them back to HEAD.  But maybe that's too crazy.

Doesn't seem that crazy to me. But maybe a bit problematic if you want
to support both, "git checkout -- ." and "git checkout HEAD -- .". And
adding DWIMmery there seems dangerous, as in:

git revert =3D=3D git checkout -- .

git revert HEAD =3D=3D
  no uncommitted changes =3D revert commit HEAD
  uncommitted changes =3D revert to HEAD

Bj=F6rn
