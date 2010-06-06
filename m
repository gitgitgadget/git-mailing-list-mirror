From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 1/4] diff/xdiff: refactor EOF-EOL detection
Date: Sun, 6 Jun 2010 11:01:02 +0200
Message-ID: <201006061101.02156.j6t@kdbg.org>
References: <cover.1275575236.git.git@drmicha.warpmail.net> <4C08AD75.6040307@drmicha.warpmail.net> <7vfx10yfmn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 06 11:04:19 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OLBmD-00019w-K2
	for gcvg-git-2@lo.gmane.org; Sun, 06 Jun 2010 11:04:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754218Ab0FFJEI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jun 2010 05:04:08 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:22265 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751543Ab0FFJEG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jun 2010 05:04:06 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 46E37A7EC1;
	Sun,  6 Jun 2010 11:03:58 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 6148A19F5F4;
	Sun,  6 Jun 2010 11:01:02 +0200 (CEST)
User-Agent: KMail/1.9.10
In-Reply-To: <7vfx10yfmn.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148510>

On Sonntag, 6. Juni 2010, Junio C Hamano wrote:
> Symlinks are minority among the tracked contents (e.g. in git.git there is
> only one), and they are almost always a single incomplete line.  When they
> change, you do want to notice, and I happen to find it a good visual aid
> to have these incomplete line indicators, in addition to the unusual
> 120000 mode on the index line.

You make whole lot of assumptions, don't you?

A repository cannot have many tracked symlinks? They change infrequently? 
Additional clues are needed to notice that they change?

> Peff uses --textconv to show changes to the exif information on his photo
> collections.  If he has any symlinks, and if he finds that removal of "\No
> newline" is a regression and not an improvement, what recourse does your
> patch give him?  Saying --no-textconv to work around that regression is
> not a solution, isn't it?

Oh, I'm pretty sure that Peff wouldn't use --textconv on his repository if he 
cared that diffs contained complete reproducible information.

> If you start from a false premise that "\No newline" was an unnecessary
> warning,

That's a strawman. Michael never meant it that way although he said it 
(unfortunately).

For me, the 120000 mode is visual clue enough (and a very strong visual 
trigger, BTW) when I browse through a diff. It's appropriate that "\No 
newline" is suppressed for symbolic links so that it does not distract from 
the mode line, because "\No newline" is a much strong trigger (that makes 
alarm bells ring).

-- Hannes
