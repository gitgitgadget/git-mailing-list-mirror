From: David Kastrup <dak@gnu.org>
Subject: Re: error: src refspec refs/heads/master matches more than one.
Date: Fri, 14 Feb 2014 16:35:14 +0100
Message-ID: <87ppmp3dxp.fsf@fencepost.gnu.org>
References: <20140214113136.GA17817@raven.inka.de> <87a9dt981o.fsf@igel.home>
	<CACsJy8BevKQaRLYMMv7bTjf_ZAOnkrimws519OyhGZz6_Vr_-A@mail.gmail.com>
	<20140214151619.GB17817@raven.inka.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Mailing List <git@vger.kernel.org>
To: Josef Wolf <jw@raven.inka.de>
X-From: git-owner@vger.kernel.org Fri Feb 14 16:35:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WEKnT-0007WK-Cr
	for gcvg-git-2@plane.gmane.org; Fri, 14 Feb 2014 16:35:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752026AbaBNPfR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Feb 2014 10:35:17 -0500
Received: from fencepost.gnu.org ([208.118.235.10]:55227 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751065AbaBNPfQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Feb 2014 10:35:16 -0500
Received: from localhost ([127.0.0.1]:54268 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1WEKnL-00081J-3s; Fri, 14 Feb 2014 10:35:15 -0500
Received: by lola (Postfix, from userid 1000)
	id AA203E40F5; Fri, 14 Feb 2014 16:35:14 +0100 (CET)
In-Reply-To: <20140214151619.GB17817@raven.inka.de> (Josef Wolf's message of
	"Fri, 14 Feb 2014 16:16:19 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242106>

Josef Wolf <jw@raven.inka.de> writes:

> On Fri, Feb 14, 2014 at 07:59:18PM +0700, Duy Nguyen wrote:
>> On Fri, Feb 14, 2014 at 7:45 PM, Andreas Schwab <schwab@linux-m68k.org> wrote:
>> > Josef Wolf <jw@raven.inka.de> writes:
>> >
>> >> Notice the refs/heads _within_ refs/heads!
>> > Probably you did something like "git branch refs/heads/master".  You can
>> > remove it again with "git branch -d refs/heads/master".
>> As a porcelain, "git branch" should prevent (or at least warn) users
>> from creating such refs, I think.
>
> I don't think I did it the way Andreas thinks. This repository is maintained
> by a script, I don't create branches manually. The only command in this script
> that uses "heads" is
>
>   git symbolic-ref HEAD "refs/heads/$new_branch"
>
> to create new branches without any ancestry. And I double-checked that this
> command is _not_ resposible for those ghost branches.
>
> BTW: I see such ghost branches reappearing again and again, so it must be
>      something systematic.

You probably should check how $new_branch comes about.  Also, once a
directory refs/heads/refs/heads exists, "refs/heads/$new_branch" may
possibly be resolved as a branch with the name refs/heads/$new_branch.

-- 
David Kastrup
