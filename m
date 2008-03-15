From: Szeder =?iso-8859-2?Q?G=E1bor?= <szeder@fzi.de>
Subject: Re: Fix recent 'unpack_trees()'-related changes breaking 'git stash'
Date: Sat, 15 Mar 2008 12:36:07 +0100
Message-ID: <20080315113607.GB10921@elysium.homelinux.org>
References: <20080315014133.GB32265@neumann> <alpine.LFD.1.00.0803142023490.3557@woody.linux-foundation.org> <7v1w6cpox6.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 15 12:37:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JaUhg-0005WV-GA
	for gcvg-git-2@gmane.org; Sat, 15 Mar 2008 12:37:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751706AbYCOLgx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 15 Mar 2008 07:36:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751696AbYCOLgx
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Mar 2008 07:36:53 -0400
Received: from moutng.kundenserver.de ([212.227.126.186]:58427 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751672AbYCOLgx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 15 Mar 2008 07:36:53 -0400
Received: from elysium (p5B132066.dip0.t-ipconnect.de [91.19.32.102])
	by mrelayeu.kundenserver.de (node=mrelayeu8) with ESMTP (Nemesis)
	id 0ML31I-1JaUgK1m9T-0001cl; Sat, 15 Mar 2008 12:36:09 +0100
Received: by elysium (Postfix, from userid 1000)
	id CF431124147; Sat, 15 Mar 2008 12:36:07 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <7v1w6cpox6.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-Provags-ID: V01U2FsdGVkX1+gl5cMRzVMjMsQiIE5MfguhpLTWuUwyt7g7Wz
 LbPAZo5L5FO3Q/qSWD9sHP2FRJj5c43mhDHPraxQosypMkaThY
 TsHsgiNeYEOR68brl42KQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77323>

On Fri, Mar 14, 2008 at 09:54:45PM -0700, Junio C Hamano wrote:
> It would be slightly simpler to write the above sequence like this:
>=20
> 	w_tree=3D$( (
> 		rm -f "$TMP-index" &&
>                 git read-tree --index-output=3D"$TMP-index" -m $i_tre=
e &&
>                 GIT_INDEX_FILE=3D"$TMP-index" &&
>                 export GIT_INDEX_FILE &&
>                 git add -u &&
>                 git write-tree &&
>                 rm -f "$TMP-index"
> 	) )
>=20
> I think your fix would apply equally well if we rewrite stash to work=
 like
> this.
Yes, with the above changes but without Linus' patch the bug is still
present.


Best,
G=E1bor
