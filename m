From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH 0/5] RESEND: git notes
Date: Sat, 16 May 2009 18:01:33 +0200
Message-ID: <200905161801.33369.johan@herland.net>
References: <cover.1242437696.git.johan@herland.net>
 <4A0ED68F.6060200@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-15
Content-Transfer-Encoding: 7BIT
Cc: gitster@pobox.com, git@vger.kernel.org, johannes.schindelin@gmx.de,
	trast@student.ethz.ch, tavestbo@trolltech.com,
	chriscool@tuxfamily.org
To: git@drmicha.warpmail.net
X-From: git-owner@vger.kernel.org Sat May 16 18:01:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M5MKj-0006WX-3g
	for gcvg-git-2@gmane.org; Sat, 16 May 2009 18:01:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754386AbZEPQBh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 May 2009 12:01:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753349AbZEPQBg
	(ORCPT <rfc822;git-outgoing>); Sat, 16 May 2009 12:01:36 -0400
Received: from mx.getmail.no ([84.208.15.66]:44807 "EHLO
	get-mta-out01.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752627AbZEPQBf (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 16 May 2009 12:01:35 -0400
Content-disposition: inline
Received: from mx.getmail.no ([10.5.16.4]) by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KJQ00AI3V6NPSD0@get-mta-out01.get.basefarm.net> for
 git@vger.kernel.org; Sat, 16 May 2009 18:01:35 +0200 (MEST)
Received: from alpha.localnet ([84.215.102.95])
 by get-mta-in02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KJQ002IXV6LZD80@get-mta-in02.get.basefarm.net> for
 git@vger.kernel.org; Sat, 16 May 2009 18:01:35 +0200 (MEST)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2009.5.16.154336
User-Agent: KMail/1.11.3 (Linux/2.6.29-ARCH; KDE/4.2.3; x86_64; ; )
In-reply-to: <4A0ED68F.6060200@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119364>

On Saturday 16 May 2009, git@drmicha.warpmail.net wrote:
> Johan Herland venit, vidit, dixit 16.05.2009 03:45:
> > Dscho has asked me to take over the responsibility for the js/notes
> > patch series.
> >
> > The following is a re-roll and resend of the patch series currently
> > in pu, plus my own 2 patches for adding support for "-m" and "-F" to
> > "git notes edit".
> >
> > On advice from Dscho, I have squashed the current bugfix and cleanup
> > patches in js/notes into the first 4 "main" patches. As a result the
> > original 15 + 2 patch series is now down to 5 (4 + 1) patches.
> >
> > In sum, these 5 patches produce the exact same result as the original
> > js/notes series (plus my 2 patches).
> >
> > I have taken the liberty of squashing the various Signed-off-by tags
> > (along with their corresponding patches) into these 5 new patches.
> > I hope this is OK with everybody. If not, I apologize; please tell me,
> > and I will re-send.
>
> Well, effectively you removed me (and others) from the author list :|

I know, and I'm sorry. This is not an ideal solution.

When a patch series is cooking in 'pu' and it receives fixes and cleanups 
from people on the list, traditionally (I believe) Junio expects a 
new/replacement series that incorporates this feedback to be posted to the 
list. This results in cleaner series, but at the cost of collapsing 
authorship down to the primary author.

In this case, the original author (Dscho) has not had the time to do this 
re-roll, and the bugfixes/cleanups have instead been added to the end of the 
patch series, resulting in the original js/notes series growing from 4 to 15 
patches.

I believe the re-roll I have done results in a nicer and cleaner overall 
series, and I have tried to mitigate the loss of authorship by adding small 
notes in the commit messages mentioning the fixes contributed by others. 
Still, Dscho stands as the primary author for the 4 "main" patches, and I 
believe this is correct, even if the notes feature has been discussed and 
developed conceptually by many others (myself included).

> I think the issue with the tree difference after this series (compared
> to the original one) shows that this squashing action makes reviewers'
> lives more complicated rather than easier. If it were the other way
> round squashing would be fine, of course.

When taking over this patch series, I believe I had 4 choices:

1. Leave everything as-is, adding my two patches on top of the existing 15. 
For reviewers of the notes feature as a whole, I don't believe an ever-
growing patch series makes their life easier. Also, I believe a shorter 
patch series looks nicer after being merged to 'next' (otherwise, why are we 
doing this whole 're-rolling while in pu'-workflow?)

2. Squash the existing 15-patch series down to 4 patches, and add my 2 
patches on top. This would yield a 4+2-patch series that would by tree-
identical to the original js/notes series after patch #4. However, 
everybody's authorship would be lost, except my own (patch 5 & 6), and this 
strikes me as a bit hypocritical.

3. Like #2, but also squash my first patch (the bugfix/cleanup part) into 
the first 4 patches. This, I believe, best follows the intent of 'pu' 
(squashing bugfixes and cleanups into the original series). Unfortunately, 
it breaks the tree-equality provided in #2.

4. Squash all 17 patches into a 4-patch series. However, I believe the final 
patch (adding support for '-m' and '-F' to 'git notes edit') is more of a 
feature patch, than a bugfix/cleanup patch, and thus should not be squashed.


I therefore went with #3, which is - as I said above - not an ideal 
solution, but AFAICS the best under the circumstances.


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
