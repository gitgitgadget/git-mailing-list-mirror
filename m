From: Miles Bader <miles@gnu.org>
Subject: Re: [PATCH v2] do not overwrite untracked during merge from unborn branch
Date: Mon, 15 Nov 2010 10:51:06 +0900
Message-ID: <87r5enbbhx.fsf@catnip.gol.com>
References: <AANLkTimDnyzyV1FEEwEuxLfG1nSOcNa7Hzwt7DDssjba@mail.gmail.com>
	<20101114213453.GA29287@localhost> <20101114214601.GB29287@localhost>
	<20101114214927.GA29579@localhost> <20101114215315.GB29579@localhost>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Gert Palok <gert@planc.ee>,
	Junio C Hamano <gitster@pobox.com>
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Mon Nov 15 02:51:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PHoEC-0000Rf-LZ
	for gcvg-git-2@lo.gmane.org; Mon, 15 Nov 2010 02:51:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932353Ab0KOBvU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Nov 2010 20:51:20 -0500
Received: from smtp12.dentaku.gol.com ([203.216.5.74]:60850 "EHLO
	smtp12.dentaku.gol.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932223Ab0KOBvU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Nov 2010 20:51:20 -0500
Received: from 123.230.98.87.eo.eaccess.ne.jp ([123.230.98.87] helo=catnip.gol.com)
	by smtp12.dentaku.gol.com with esmtpa (Dentaku)
	id 1PHoDs-0000Is-Ed; Mon, 15 Nov 2010 10:51:08 +0900
Received: by catnip.gol.com (Postfix, from userid 1000)
	id DA865DF91; Mon, 15 Nov 2010 10:51:06 +0900 (JST)
System-Type: x86_64-unknown-linux-gnu
In-Reply-To: <20101114215315.GB29579@localhost> (Clemens Buchacher's message
	of "Sun, 14 Nov 2010 22:53:15 +0100")
X-Virus-Scanned: ClamAV GOL (outbound)
X-Abuse-Complaints: abuse@gol.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161470>

Clemens Buchacher <drizzd@aon.at> writes:
> Wrong again! (With args[6] instead of args[7].)  I wonder how many
> times I can get it wrong.

Hmm, well the use of external processes to implement such seemingly
basic functionality doesn't exactly help with the argument checking...

... and now that I look (though only briefly :), builtin/read-tree.c
seems almost trivial -- with the bulk of the code devoted to argument
parsing, error reporting, and handling different cases...!

Maybe it would be better to just rewrite "read_empty" (and
"reset_hard"?) in terms of the underlying functions read-tree.c uses?

-Miles

-- 
`Cars give people wonderful freedom and increase their opportunities.
 But they also destroy the environment, to an extent so drastic that
 they kill all social life' (from _A Pattern Language_)
