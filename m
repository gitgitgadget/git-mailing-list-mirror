From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: git checkout error
Date: Tue, 09 Oct 2012 11:36:12 +0200
Message-ID: <m2lifg7zsj.fsf@igel.home>
References: <CAB9Jk9DUEL_J3MmH_4k7NC82m+crpCf1r3NS3gQBMZy+kvY3-A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git <git@vger.kernel.org>
To: Angelo Borsotti <angelo.borsotti@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 09 11:36:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TLWEw-0005h6-Fx
	for gcvg-git-2@plane.gmane.org; Tue, 09 Oct 2012 11:36:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754681Ab2JIJgU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Oct 2012 05:36:20 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:57879 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751440Ab2JIJgR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Oct 2012 05:36:17 -0400
Received: from frontend1.mail.m-online.net (frontend1.mail.intern.m-online.net [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3XbYGj20Lzz3hhcC;
	Tue,  9 Oct 2012 11:36:13 +0200 (CEST)
X-Auth-Info: M7r0fLHAZL2WeqZGIhLY+KT+BkZIaBgtjhTTgqMkaIY=
Received: from igel.home (ppp-88-217-104-135.dynamic.mnet-online.de [88.217.104.135])
	by mail.mnet-online.de (Postfix) with ESMTPA id 3XbYGj1cYMzbbgp;
	Tue,  9 Oct 2012 11:36:13 +0200 (CEST)
Received: by igel.home (Postfix, from userid 501)
	id CF644CA2A4; Tue,  9 Oct 2012 11:36:12 +0200 (CEST)
X-Yow: Quick, sing me the BUDAPEST NATIONAL ANTHEM!!
In-Reply-To: <CAB9Jk9DUEL_J3MmH_4k7NC82m+crpCf1r3NS3gQBMZy+kvY3-A@mail.gmail.com>
	(Angelo Borsotti's message of "Tue, 9 Oct 2012 09:41:38 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207311>

Angelo Borsotti <angelo.borsotti@gmail.com> writes:

> If they are specified after -b, the command seems to behave as if -b
> was not specified, e.g.:
>
> $ git checkout -b --no-track topic remotes/origin/master

-b requires an argument <new_branch>, which you specify as --no-track
here.  <start_point> is topic, and the rest is interpreted as <paths>.

> fatal: git checkout: updating paths is incompatible with switching branches.

This error is detected before validating <new_branch>.

> while if they are specified before -b the command behaves properly, e.g.
>
> $ git checkout --no-track -b topic remotes/origin/master
> Switched to a new branch 'topic'

You can also specify --no-track after -b (and its argument):

$ git checkout -b topic --no-track remotes/origin/master

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
