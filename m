From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Deprecate git-fetch-pack?
Date: Sun, 11 Nov 2007 14:35:44 -0800
Message-ID: <7vabpkbebj.fsf@gitster.siamese.dyndns.org>
References: <Pine.LNX.4.64.0711101752490.29952@iabervon.org>
	<7v4pftip42.fsf@gitster.siamese.dyndns.org>
	<74415967-7F49-426C-8BF5-1A0210C337AB@develooper.com>
	<Pine.LNX.4.64.0711111103240.4362@racer.site>
	<7vd4ugcwkm.fsf@gitster.siamese.dyndns.org>
	<20071111222117.GA7392@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Ask =?utf-8?Q?Bj?= =?utf-8?Q?=C3=B8rn?= Hansen 
	<ask@develooper.com>, Daniel Barkalow <barkalow@iabervon.org>,
	git@vger.kernel.org
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Sun Nov 11 23:36:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrLPr-0005hC-7I
	for gcvg-git-2@gmane.org; Sun, 11 Nov 2007 23:36:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757049AbXKKWf5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2007 17:35:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757045AbXKKWf5
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Nov 2007 17:35:57 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:45567 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757031AbXKKWf4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2007 17:35:56 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 0ADAA2F2;
	Sun, 11 Nov 2007 17:36:17 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 64334947E7;
	Sun, 11 Nov 2007 17:36:10 -0500 (EST)
In-Reply-To: <20071111222117.GA7392@thunk.org> (Theodore Tso's message of
	"Sun, 11 Nov 2007 17:21:17 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64530>

Theodore Tso <tytso@mit.edu> writes:

> On Sun, Nov 11, 2007 at 01:16:09PM -0800, Junio C Hamano wrote:
>> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>> > This should be a non-issue.  We really should start deprecating 
>> > "git-<command>" in favour of "git <command>" for real.
>> >
>> > New users should not even be told that this is correct usage.
>> 
>> If you can write "git-commit" and "git commit" interchangeably
>> while you cannot say "git-cat-file" and are forced to say "git
>> cat-file", I suspect that would lead to a great confusion and
>> unhappy users.
>
> One of the reasons why I use git-diff and git-commit and in particular
> "git-rebase --interactive master" very often is that it allows my
> shell's bang completion to work.  (i.e., "!git-rebase").  If we tell
> people they can not use "git-rebase", and must instead use "git
> rebase" instead, I would consider that pretty annoying/obnoxious.

Oh, of course.

But my impression was that Johannes was talking about
deprecating git-<foo> form only for plumbing, so that the users
will only see git-<foo> for the Porcelain.  That would not break
your bang completion for the porcelain commands.

If Johannes was talking about deprecating all git-<foo> form,
then that would indeed break your bang completion, but it has
conceptually a much bigger problem.  The topic was about fixing
"a new user sees too many git commands and gets scared" problem.
Deprecaing all git-<foo> form just replaces the problem with "a
new user sees too many git subcommands and gets scared" problem,
without solving anything.
