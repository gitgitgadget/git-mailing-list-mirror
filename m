From: David Kastrup <dak@gnu.org>
Subject: Re: git branch --merged and git branch --verbose do not combine
Date: Mon, 15 Sep 2014 21:07:05 +0200
Message-ID: <87a960r9d2.fsf@fencepost.gnu.org>
References: <87fvfutza3.fsf@fencepost.gnu.org>
	<xmqq38bs92sg.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 15 21:07:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XTbcY-0000Xa-Mw
	for gcvg-git-2@plane.gmane.org; Mon, 15 Sep 2014 21:07:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753705AbaIOTHY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Sep 2014 15:07:24 -0400
Received: from fencepost.gnu.org ([208.118.235.10]:37877 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751292AbaIOTHV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Sep 2014 15:07:21 -0400
Received: from localhost ([127.0.0.1]:36919 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1XTbcO-0003GF-M6; Mon, 15 Sep 2014 15:07:21 -0400
Received: by lola (Postfix, from userid 1000)
	id B062DDF8C9; Mon, 15 Sep 2014 21:07:05 +0200 (CEST)
In-Reply-To: <xmqq38bs92sg.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Mon, 15 Sep 2014 11:06:23 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257069>

Junio C Hamano <gitster@pobox.com> writes:

> David Kastrup <dak@gnu.org> writes:
>
>> dak@lola:/usr/local/tmp/lilypond$ ../git/git branch --merged --verbose
>> fatal: malformed object name --verbose
>
> Only at the very end of the command line if you omit something that
> is required, Git helps by defaulting the missing rev to HEAD.  You
> can be a bit more explicit in the middle, i.e. instead of asking
> "Which are branches that already has been merged in --verbose?", you
> can ask "branch --merged HEAD --verbose", meaning "What are branhes
> that already has been merged in HEAD, please give me a verbose
> answer?" perhaps?

This gives the same result as

git branch --verbose --merged

namely _only_ listing the current branch verbosely.  Use of --verbose
kills any effect of --merged: instead of branches merged to the named
branch (or to the default of HEAD), _only_ the named branch (or the
default of HEAD) gets listed.

So no.

-- 
David Kastrup
