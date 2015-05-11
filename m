From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: Multiple push remotes via aliases
Date: Mon, 11 May 2015 16:17:58 +0200
Message-ID: <5550BA16.2090304@alum.mit.edu>
References: <20150510181703.GC225482@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 11 16:18:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YroX3-0005hO-DF
	for gcvg-git-2@plane.gmane.org; Mon, 11 May 2015 16:18:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751686AbbEKOSC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 May 2015 10:18:02 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:47885 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750962AbbEKOSB (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 May 2015 10:18:01 -0400
X-AuditID: 12074412-f79e46d0000036b4-71-5550ba187dc5
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 28.65.14004.81AB0555; Mon, 11 May 2015 10:18:00 -0400 (EDT)
Received: from [192.168.69.130] (p5DDB195E.dip0.t-ipconnect.de [93.219.25.94])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t4BEHwbJ031257
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Mon, 11 May 2015 10:17:59 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.6.0
In-Reply-To: <20150510181703.GC225482@vauxhall.crustytoothpaste.net>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrDIsWRmVeSWpSXmKPExsUixO6iqCuxKyDUYGEnj0XXlW4mi7aZP5gc
	mDyW3/zL5PF5k1wAUxS3TVJiSVlwZnqevl0Cd8baHSeZClYKVpxp2MDcwPiCt4uRk0NCwETi
	3cQGNghbTOLCvfVANheHkMBlRomzW84xQjjnmCSONC5lBaniFdCWeNy6mAXEZhFQldh5tR8s
	ziagK7Gop5kJxBYVCJJovTaVEaJeUOLkzCdg9SICXhLzH80AqxcW0JO40/gGbLOQgLPEzV8n
	wOKcAi4S575OB6tnBqrZcf0XK4QtL9G8dTbzBEb+WUjGzkJSNgtJ2QJG5lWMcok5pbm6uYmZ
	OcWpybrFyYl5ealFumZ6uZkleqkppZsYISEptINx/Um5Q4wCHIxKPLwGF/xDhVgTy4orcw8x
	SnIwKYnyNm4NCBXiS8pPqcxILM6ILyrNSS0+xCjBwawkwqu8BijHm5JYWZValA+TkuZgURLn
	/blY3U9IID2xJDU7NbUgtQgmK8PBoSTB27EDqFGwKDU9tSItM6cEIc3EwQkynEtKpDg1LyW1
	KLG0JCMeFJPxxcCoBEnxAO19B9LOW1yQmAsUhWg9xagoJc6bDZIQAElklObBjYUlmleM4kBf
	CvO+AKniASYpuO5XQIOZgAY7xoENLklESEk1MGZfatora2fkWTk1Z1fvfoETh+1EmF+Kygmf
	uXB+9n3b42fbPS4//uSs13jG2M/y7dXne3bfXXLun9gS+78ODgdP8/BPmGvE7TIhq3bRjddv
	9zF5KJ1tmi27X9XnW4oAl+zuC57Tbd68lJ3lsOQoB7fBZoV/z3eo7ita90a9ws3q 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268776>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 05/10/2015 08:17 PM, brian m. carlson wrote:
> I recently discovered that it was possible to specify multiple push
> URLs for a remote.  This is useful for me because some of my
> projects live both on GitHub and on my own server, and some live
> only one place or the other.
> 
> One feature that I'm looking for, however, is the ability to
> specify those URLs by reference to another remote.  For example,
> making the remote def (default) refer to the remotes gh and
> upstream instead of duplicating the URLs.  This makes dealing with
> URL changes easier and goes along with the DRY approach.
> 
> I don't think we already have this functionality (at least I don't
> see code for it), and I'd like to implement it, but maybe the
> documentation is just missing and I should submit a patch for that
> instead.  Do we have such a thing, and if not, do people think this
> is a worthwhile feature?

For fetching, we already have

> remotes.<group> The list of remotes which are fetched by "git
> remote update <group>". See git-remote(1).

ISTM that your feature is akin to this one and could piggyback on the
same configuration. By analogy with "git remote update <group>", the
corresponding command could be

    git remote push <group> [...]

You suggested being able to run something like

    git push <group> [...]

which is a little bit shorter. If so, then it is natural to ask
whether <group> should be allowed in place of <repo> whenever it makes
sense, as a general UI principle. If so, then

    git fetch <group> [...]

could be shorthand for "git remote update <group> [...]".

But please note that I haven't thought about whether the <repo> ->
<group> generalization could be done consistently, vs. whether the
groupwise commands are different enough from the single-repo commands
that the supposed generalization would be more confusing than useful.

Michael

- -- 
Michael Haggerty
mhagger@alum.mit.edu

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlVQuhUACgkQwg9mrRwfmAkFbQCghrQhBaerq0W7suJzu0cr7RGW
Cy0AoIkvgbWmOnwJfeldk73vNMPbc197
=arW/
-----END PGP SIGNATURE-----
