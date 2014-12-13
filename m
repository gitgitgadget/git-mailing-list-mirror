From: David Kastrup <dak@gnu.org>
Subject: Re: reject "backwards" merges
Date: Sat, 13 Dec 2014 10:47:29 +0100
Message-ID: <877fxvdgpa.fsf@fencepost.gnu.org>
References: <CACh33FqHindeksHv7wcgu983oBSbm5G0ZswrQdTAz5tqgZdgjQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git <git@vger.kernel.org>
To: Patrick Donnelly <batrick@batbytes.com>
X-From: git-owner@vger.kernel.org Sat Dec 13 11:45:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XzkCX-0007fv-0b
	for gcvg-git-2@plane.gmane.org; Sat, 13 Dec 2014 11:45:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966433AbaLMKpX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Dec 2014 05:45:23 -0500
Received: from fencepost.gnu.org ([208.118.235.10]:37273 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966327AbaLMKpW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Dec 2014 05:45:22 -0500
Received: from localhost ([127.0.0.1]:36313 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1XzkCN-0007f2-G4; Sat, 13 Dec 2014 05:45:19 -0500
Received: by lola (Postfix, from userid 1000)
	id EFEBBDF323; Sat, 13 Dec 2014 10:47:29 +0100 (CET)
In-Reply-To: <CACh33FqHindeksHv7wcgu983oBSbm5G0ZswrQdTAz5tqgZdgjQ@mail.gmail.com>
	(Patrick Donnelly's message of "Fri, 12 Dec 2014 13:40:29 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.0.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261393>

Patrick Donnelly <batrick@batbytes.com> writes:

> Is there a way to reject pushes that change the history of
> first-parents, caused by a "backwards" merge? To clarify by example
> (using branches instead of separate repositories):
>
> Here the desired first parent (HEAD^) would be commit
> 9cb303e2578af305d688abf62570ef31f3f113da. Unfortunately, the incorrect
> merge reversed the line of parents. Is there a way to prevent this
> from happening (via git-config) other than fixing the human?

You'd have to do this in a push hook.  Before pushing, Git does not
really have a way to figure out which kind of branch a merge will land
on.

Most "reversed merges" probably come into being by having a fast-forward
in a series of zig-zagged merges.  Naturally the history before the
fast-forward can only be "the right way round" for one of the two
branches.

-- 
David Kastrup
