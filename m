From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [1.8.0] git-stash invocation changes
Date: Wed, 02 Feb 2011 19:15:37 +0100
Message-ID: <vpqtygmwbee.fsf@bauges.imag.fr>
References: <7vzkqh8vqw.fsf@alter.siamese.dyndns.org>
	<7vwrll57ha.fsf@alter.siamese.dyndns.org>
	<201102021823.19559.trast@student.ethz.ch>
	<AANLkTimu=drR+4v+B_aB+Y4jVqzaBghh1XYSZoACsBry@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Rast <trast@student.ethz.ch>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Feb 02 19:16:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PkhFb-0004kf-5F
	for gcvg-git-2@lo.gmane.org; Wed, 02 Feb 2011 19:16:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754854Ab1BBSQK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 Feb 2011 13:16:10 -0500
Received: from mx1.imag.fr ([129.88.30.5]:57228 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754851Ab1BBSQJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Feb 2011 13:16:09 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id p12IFZ2Y021902
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 2 Feb 2011 19:15:35 +0100
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1PkhEv-0004db-Ae; Wed, 02 Feb 2011 19:15:37 +0100
In-Reply-To: <AANLkTimu=drR+4v+B_aB+Y4jVqzaBghh1XYSZoACsBry@mail.gmail.com> (Shawn Pearce's message of "Wed\, 2 Feb 2011 09\:35\:52 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 02 Feb 2011 19:15:35 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: p12IFZ2Y021902
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1297275335.93682@5u95Fzk3rO0x+F1TkntkhA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165923>

Shawn Pearce <spearce@spearce.org> writes:

> On Wed, Feb 2, 2011 at 09:23, Thomas Rast <trast@student.ethz.ch> wro=
te:
>> Proposal:
>>
>> 1. Change 'git stash <not-a-stash-command>' to give a usage message
>> =A0 instead of using <not-a-stash-command> as the stash message.
>
> Oh please, yes, please do this.  We should have done this long, long
> ago.  Its easy enough to train your fingers or fix your scripts to sa=
y
> `git stash save list` rather than `git stash lsit` once stash errors
> out and gives you a usage message once.

Err, hasn't this been fixed long ago already?

$ git stash not-a-stash-command
Usage: git stash list [<options>]
   or: git stash show [<stash>]
   or: git stash drop [-q|--quiet] [<stash>]
   or: git stash ( pop | apply ) [--index] [-q|--quiet] [<stash>]
   or: git stash branch <branchname> [<stash>]
   or: git stash [save [--patch] [-k|--[no-]keep-index] [-q|--quiet] [<=
message>]]
   or: git stash clear
$ git stash save --no-such-option
error: unknown option for 'stash save': --no-such-option
       To provide a message, use git stash save -- '--no-such-option'
Usage: [...]

Only this could be seen as a problem:

$ git stash save this-is-not-a-stash-name
Saved working directory and index state On master: this-is-not-a-stash-=
name

in particular, it is wrt:

Thomas Rast <trast@student.ethz.ch> writes:

> 2. Change 'git stash -p <args>' to treat the <args> as filename
>    arguments similar to add -p.  Possibly add a -m option that lets
>    you specify a message anyway, if desired.

I'm not a user of "stash with messages" myself, so I can't say how
annoying the migration would be, but -m "message" sounds good to me.

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
