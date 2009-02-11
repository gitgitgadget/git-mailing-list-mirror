From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGit PATCH] Add mergetool support to the classic StGit infrastructure
Date: Wed, 11 Feb 2009 10:25:13 +0100
Message-ID: <20090211092513.GD26136@diana.vm.bytemark.co.uk>
References: <20090210141413.28782.19243.stgit@pc1117.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 11 10:28:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXBMl-0001tH-PY
	for gcvg-git-2@gmane.org; Wed, 11 Feb 2009 10:26:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754337AbZBKJZS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Feb 2009 04:25:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754333AbZBKJZR
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Feb 2009 04:25:17 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:33358 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751560AbZBKJZQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Feb 2009 04:25:16 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1LXBLF-000757-00; Wed, 11 Feb 2009 09:25:13 +0000
Content-Disposition: inline
In-Reply-To: <20090210141413.28782.19243.stgit@pc1117.cambridge.arm.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109389>

On 2009-02-10 14:14:17 +0000, Catalin Marinas wrote:

> Since Git already has a tool for interactively solving conflicts
> which is highly customisable, there is no need to duplicate this
> feature via the i3merge and i2merge configuration options. The
> user-visible change is that now mergetool is invoked rather than the
> previously customised interactive merging tool.

Very good.

> +def mergetool(self, files =3D []):
> +    """Invoke 'git mergetool' to resolve any outstanding conflicts."=
""
> +    err =3D os.system('git mergetool %s' % ' '.join(files))
> +    if err:
> +        raise GitException('"git mergetool" failed, exit code: %d' %=
 err)

Again, what happens if "files" is not given?

> @@ -754,7 +758,6 @@ def resolved(filenames, reset =3D None):
>               '--stdin', '-z').input_nulterm(filenames).no_output()
>      GRun('update-index', '--add', '--').xargs(filenames)
>      for filename in filenames:
> -        gitmergeonefile.clean_up(filename)
>          # update the access and modificatied times
>          os.utime(filename, None)

Hmm, what does this line do, and why isn't it needed anymore? I don't
know this part of StGit, I'm just curious ...

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
