From: Kevin Ballard <kevin@sb.org>
Subject: Re: [PATCHv3 1/2] rebase: better rearranging of fixup!/squash! lines with --autosquash
Date: Mon, 8 Nov 2010 03:10:05 -0800
Message-ID: <FB418838-D9A9-4FA6-8C32-FDC5F51DE783@sb.org>
References: <20101108115239.7309504f@chalon.bertin.fr>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Yann Dirson <dirson@bertin.fr>
X-From: git-owner@vger.kernel.org Mon Nov 08 12:10:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PFPc9-0006oo-F9
	for gcvg-git-2@lo.gmane.org; Mon, 08 Nov 2010 12:10:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754376Ab0KHLKK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Nov 2010 06:10:10 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:64548 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753654Ab0KHLKJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Nov 2010 06:10:09 -0500
Received: by iwn41 with SMTP id 41so3955140iwn.19
        for <git@vger.kernel.org>; Mon, 08 Nov 2010 03:10:08 -0800 (PST)
Received: by 10.231.144.197 with SMTP id a5mr3832363ibv.61.1289214607219;
        Mon, 08 Nov 2010 03:10:07 -0800 (PST)
Received: from [10.0.1.14] ([24.130.32.253])
        by mx.google.com with ESMTPS id i16sm3922495ibl.6.2010.11.08.03.10.06
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 08 Nov 2010 03:10:06 -0800 (PST)
In-Reply-To: <20101108115239.7309504f@chalon.bertin.fr>
X-Mailer: Apple Mail (2.1081)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160926>

On Nov 8, 2010, at 2:52 AM, Yann Dirson wrote:

> Kevin wrote:
>> The current behvaior of --autosquash can duplicate fixup!/squash! lines
>> if they match multiple commits, and it can also apply them to commits
>> that come after them in the todo list.
> 
> That last part of the sentence does not match my experience - it looks
> like you describe as a bug a nonexistent feature I miss :)
> 
> See http://marc.info/?l=git&m=128784082701920 for a testcase that
> exhibits what I think is a problem.

The bug is definitely present. It seems what you're describing is that you
want it to continue to place that fixup! there, but you want it to skip the
pick line that occurs earlier in the TODO list. My feeling is that this is
purely a bug, and should be fixed to not place the fixup! line after the
later commit.

If you do want the behavior where it skips the pick and places the fixup!
line after the later commit, I would encourage you to file a separate patch
for that.

-Kevin Ballard
