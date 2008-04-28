From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH] clone: detect and fail on excess parameters
Date: Mon, 28 Apr 2008 18:36:42 +0200
Message-ID: <20080428163642.GA22790@neumann>
References: <7vfxtcsbis.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 28 18:38:34 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqWMt-0005zq-8g
	for gcvg-git-2@gmane.org; Mon, 28 Apr 2008 18:38:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936173AbYD1Qgr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Apr 2008 12:36:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936140AbYD1Qgp
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Apr 2008 12:36:45 -0400
Received: from francis.fzi.de ([141.21.7.5]:48322 "EHLO exchange.fzi.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S936090AbYD1Qgo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2008 12:36:44 -0400
Received: from [127.0.1.1] ([141.21.4.196]) by exchange.fzi.de with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 28 Apr 2008 18:36:40 +0200
Content-Disposition: inline
In-Reply-To: <7vfxtcsbis.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-OriginalArrivalTime: 28 Apr 2008 16:36:40.0850 (UTC) FILETIME=[094ACF20:01C8A94E]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80557>

Hi,

On Wed, Apr 23, 2008 at 10:53:47AM -0700, Junio C Hamano wrote:
> "git clone [options] $src $dst excess-garbage" simply ignored
> excess-garbage without giving any diagnostic message.  Fix it.
>=20
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> [...]
> --- a/git-clone.sh
> +++ b/git-clone.sh
> @@ -219,6 +219,7 @@ fi
>  if test -n "$2"
>  then
>  	dir=3D"$2"
> +	test $# =3D=3D 2 || die "excess parameter to git-clone"
                ^^
I think you mean:

    test $# =3D 2 || die "excess parameter to git-clone"

I just noticed because it broke t1020-subdirectory at me.


Best,
G=E1bor
