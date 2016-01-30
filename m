From: Max Kirillov <max@max630.net>
Subject: Re: [PATCH v3 1/6] worktree: new repo extension to manage worktree
 behaviors
Date: Sat, 30 Jan 2016 15:59:44 +0200
Message-ID: <20160130135944.GA4978@wheezy.local>
References: <1451186079-6119-1-git-send-email-pclouds@gmail.com>
 <1453808685-21235-1-git-send-email-pclouds@gmail.com>
 <1453808685-21235-2-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	max@max630.net, git@drmicha.warpmail.net, Jens.Lehmann@web.de
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 30 15:07:09 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aPWB8-0003xk-M1
	for gcvg-git-2@plane.gmane.org; Sat, 30 Jan 2016 15:07:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756789AbcA3OG7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 30 Jan 2016 09:06:59 -0500
Received: from p3plsmtpa09-07.prod.phx3.secureserver.net ([173.201.193.236]:51227
	"EHLO p3plsmtpa09-07.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756368AbcA3OG6 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 30 Jan 2016 09:06:58 -0500
X-Greylist: delayed 427 seconds by postgrey-1.27 at vger.kernel.org; Sat, 30 Jan 2016 09:06:58 EST
Received: from wheezy.local ([82.181.81.240])
	by p3plsmtpa09-07.prod.phx3.secureserver.net with 
	id CDzj1s0055B68XE01Dzp6M; Sat, 30 Jan 2016 06:59:51 -0700
Content-Disposition: inline
In-Reply-To: <1453808685-21235-2-git-send-email-pclouds@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285113>

On Tue, Jan 26, 2016 at 06:44:40PM +0700, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=
=BB=8Dc Duy wrote:
> +WORKTREE VERSIONS AND MIGRATION
> +-------------------------------
> +Multiple worktree is still an experimental feature and evolving. Eve=
ry
> +time the behavior is changed, the "worktree version" is stepped
> +up. Worktree version is stored as a configuration variable
> +extensions.worktree.
> +
> +Version 0
> +~~~~~~~~~
> +This is the first release. Version 0 is implied if extensions.worktr=
ee
> +does not exist.
> +

=2E..

> +`worktree`
> +~~~~~~~~~~
> +
> +Define behavior in multiple worktree setup. The value specifies the
> +version. Default version is zero.

This sounds too pessimistic. There is now a need to
introduce incompatible change, because there is no way to
make config separation. There would be a need to increase
the version regularly in case of previous option which
suggested to hardcode per-worktree versions, so that each
change of their list would need a version increase. Now
there is no need to increase the version beyond 1, so it can
be "version 0 is like in older gits, version 1 is separated
config file, and version 2 will never happen" :) The
extension parameter coould even be called like
"worktreeConfig" and be boolean.
