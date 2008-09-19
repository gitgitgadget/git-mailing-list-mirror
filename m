From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH v2 1/4] diff.c: return pattern entry pointer rather than
 just the hunk header pattern
Date: Fri, 19 Sep 2008 14:11:59 -0500
Message-ID: <IWyC0OwsyyNa-yfA29138St-i1ziYm_Ijietm8MzVB8@cipher.nrlssc.navy.mil>
References: <7vskry1485.fsf@gitster.siamese.dyndns.org> <hvD4CKeY-shT7TB0JLaQn02KLTvzB720kcwBxBfYbo3S2ySzNzsn9g@cipher.nrlssc.navy.mil> <alpine.LNX.1.10.0809191209450.10710@suse104.zenez.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Arjen Laarhoven <arjen@yaph.org>,
	Mike Ralphson <mike.ralphson@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Jeff King <peff@peff.net>,
	Git Mailing List <git@vger.kernel.org>,
	Avery Pennarun <apenwarr@gmail.com>,
	Johan Herland <johan@herland.net>,
	Andreas Ericsson <ae@op5.se>, Kirill Smelkov <kirr@mns.spb.ru>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
	Gustaf Hendeby <hendeby@isy.liu.se>,
	Jonathan del Strother <maillist@steelskies.com>
To: Boyd Lynn Gerber <gerberb@zenez.com>
X-From: git-owner@vger.kernel.org Fri Sep 19 21:14:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KglRI-00077s-H1
	for gcvg-git-2@gmane.org; Fri, 19 Sep 2008 21:14:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753624AbYISTNj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Sep 2008 15:13:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753512AbYISTNj
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Sep 2008 15:13:39 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:43870 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753198AbYISTNi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Sep 2008 15:13:38 -0400
Received: by mail.nrlssc.navy.mil id m8JJC082032139; Fri, 19 Sep 2008 14:12:00 -0500
In-Reply-To: <alpine.LNX.1.10.0809191209450.10710@suse104.zenez.com>
X-OriginalArrivalTime: 19 Sep 2008 19:12:00.0417 (UTC) FILETIME=[97ABE110:01C91A8B]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96307>

Boyd Lynn Gerber wrote:
> So on these patches,
> What do you want me to do?  I applied them and things kinda worked.

Test t4018-diff-funcname.sh should pass. As Johan mentioned, in the
last patch '\\s' should have been converted to '[ \t]', rather than
to just ' ', but that should not affect the test and should only
affect html, python, and ruby patterns.

It would be nice if the tests were expanded.

>  The
> problem is pine/alpine messes them up a bit and it is not easy to
> manually fix them.  It would be easier to git clone/pull them from
> either a site or the trees.  

I expect they will be in Junio's tree soon, most likely the master
branch.

>I do think that on some we should use the
> actual charact vers the C-syntax.  "\t" for example.

"\t" is safe to use since it is interpreted by git in config.c: parse_value(),
not by the regex library. I was also concerned about that character until I
traced the code to parse_value(). Junio is right that better documentation of
this feature is needed.

-brandon
