From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] Lower priority of Cogito's default exclude patterns
Date: Sat, 21 Jan 2006 03:04:23 +0100
Message-ID: <20060121020423.GJ28365@pasky.or.cz>
References: <20060107221931.10616.25897.stgit@backpacker.hemma.treskal.com> <20060119100712.GA12154@diana.vm.bytemark.co.uk> <20060119124244.GJ27976@pasky.or.cz> <20060119140728.GA14998@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 21 03:03:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F085l-0002hz-Ec
	for gcvg-git@gmane.org; Sat, 21 Jan 2006 03:03:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030376AbWAUCC6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 20 Jan 2006 21:02:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030314AbWAUCC6
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Jan 2006 21:02:58 -0500
Received: from w241.dkm.cz ([62.24.88.241]:53689 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1030376AbWAUCC5 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Jan 2006 21:02:57 -0500
Received: (qmail 3880 invoked by uid 2001); 21 Jan 2006 03:04:23 +0100
To: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Content-Disposition: inline
In-Reply-To: <20060119140728.GA14998@diana.vm.bytemark.co.uk>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14984>

Thanks, patch applied and pushed out.

Dear diary, on Thu, Jan 19, 2006 at 03:07:28PM CET, I got a letter
where Karl Hasselstr=F6m <kha@treskal.com> said that...
> On 2006-01-19 13:42:44 +0100, Petr Baudis wrote:
> > Oh, now I remember - one my major concern is that now Cogito will
> > not work if not make install'd, which is how I actually primarily
> > use it on my machine.
>=20
> The not-installed case could easily be worked around by users if
> cogito looked at /etc/cogito/exclude and ~/.cogito/exclude as well.
> (Or maybe that should be /etc/git/exclude and ~/.gitexclude, so that
> e.g. stgit can use the same files.) Would you accept a patch that did
> this?

Sorry, this doesn't make sense to me - how would that help? The user ca=
n
as well just make install in that case, instead of manually copying out
one file.

	if [ -n "${COGITO_SHARE}" ]; then
		COGITO_REAL_SHARE=3D"${COGITO_SHARE}"
		return
	fi
	if [ "${0%/*}" !=3D "$0" ]; then
		COGITO_REAL_SHARE=3D"${0%/*}/"
		return
	fi
	# I'm not sure if the following normally ever gets triggered.
	# I can only do it by `sh cg-status`. --pasky
	COGITO_REAL_SHARE=3D"./$_git_relpath/"

should work well, though.

--=20
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Of the 3 great composers Mozart tells us what it's like to be human,
Beethoven tells us what it's like to be Beethoven and Bach tells us
what it's like to be the universe.  -- Douglas Adams
