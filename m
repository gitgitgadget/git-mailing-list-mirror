From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH] git-filter-branch: add --egrep-filter option
Date: Sat, 16 Apr 2011 10:16:51 +0200
Message-ID: <201104161016.51690.j6t@kdbg.org>
References: <4DA8CBB0.6080103@rivulet.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Michael O'Cleirigh" <michael.ocleirigh@rivulet.ca>
X-From: git-owner@vger.kernel.org Sat Apr 16 10:17:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QB0h5-0006zf-9l
	for gcvg-git-2@lo.gmane.org; Sat, 16 Apr 2011 10:17:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751869Ab1DPIQ4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 16 Apr 2011 04:16:56 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:58073 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751787Ab1DPIQz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Apr 2011 04:16:55 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 99EDC13005A;
	Sat, 16 Apr 2011 10:16:52 +0200 (CEST)
Received: from localhost (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 10A0219F5C0;
	Sat, 16 Apr 2011 10:16:52 +0200 (CEST)
User-Agent: KMail/1.9.10
In-Reply-To: <4DA8CBB0.6080103@rivulet.ca>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171667>

On Samstag, 16. April 2011, Michael O'Cleirigh wrote:
> The --subdirectory-filter will look for a single directory and then r=
ewrite
> history to make its content the root.  This is ok except for cases wh=
ere we
> want to retain history of those files before they were moved into tha=
t
> directory.
>
> The --egrep-filter option allows specifying an egrep regex for the fi=
les in
> the tree of each commit to keep.  For example:
>
> Directories we want are A, B, C, D and they exist in several differen=
t
> lifetimes.  A and B exist sometimes together then B and C and finally=
 then
> D.
>
> e.g. git-filter-branch --egrep-filter "(A|B|C|D)"
>
> Each commit will then contain different combination's of A or B or C =
or D
> (up to A and B and C and D).

Why do you need a new --...-filter option for this? Your implementation=
 is=20
merely an instance of an --index-filter, and at that a very specialized=
 one,=20
which operates only at the top-most directory level.

> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0git ls-tree $commit | e=
grep "$filter_egrep" | git mktree |=20
xargs git read-tree -i -m

-- Hannes
