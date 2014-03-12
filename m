From: David Kastrup <dak@gnu.org>
Subject: Re: New GSoC microproject ideas
Date: Wed, 12 Mar 2014 20:16:53 +0100
Message-ID: <87wqfzi5wa.fsf@fencepost.gnu.org>
References: <532049A7.6000304@alum.mit.edu>
	<xmqq1ty7me6a.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	git discussion list <git@vger.kernel.org>,
	Fabian <bafain@gmail.com>,
	Quint Guvernator <quintus.public@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 12 20:17:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WNoep-0005xz-IR
	for gcvg-git-2@plane.gmane.org; Wed, 12 Mar 2014 20:17:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750846AbaCLTRI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Mar 2014 15:17:08 -0400
Received: from fencepost.gnu.org ([208.118.235.10]:39249 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750703AbaCLTRG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Mar 2014 15:17:06 -0400
Received: from localhost ([127.0.0.1]:38289 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1WNoeH-0002mm-0o; Wed, 12 Mar 2014 15:17:05 -0400
Received: by lola (Postfix, from userid 1000)
	id 83491E05D9; Wed, 12 Mar 2014 20:16:53 +0100 (CET)
In-Reply-To: <xmqq1ty7me6a.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Wed, 12 Mar 2014 12:04:29 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243966>

Junio C Hamano <gitster@pobox.com> writes:

> Here is another, as I seem to have managed to kill another one ;-)
>
> -- >8 --
>
> "VAR=VAL command" is sufficient to run 'command' with environment
> variable VAR set to value VAL without affecting the environment of
> the shell itself, but we cannot do the same with a shell function
> (most notably, "test_must_fail");

No? bash:

dak@lola:/usr/local/tmp/lilypond$ zippo()
> {
> echo $XXX
> echo $XXX
> }
dak@lola:/usr/local/tmp/lilypond$ XXX=8 zippo
8
8


dak@lola:/usr/local/tmp/lilypond$ /bin/dash
$ zippo()
> {
> echo $XXX
> echo $XXX
> }
$ XXX=8 zippo
8
8
$ 

dak@lola:/usr/local/tmp/lilypond$ /bin/ash
$ zippo()
> {
> echo $XXX
> echo $XXX
> }
$ XXX=8 zippo
8
8
$ 


Seems to work just fine with a set of typical shells.

-- 
David Kastrup
