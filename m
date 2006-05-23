From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 2/2] cvsimport: cleanup commit function
Date: Tue, 23 May 2006 16:41:33 -0700
Message-ID: <7vpsi41f82.fsf@assigned-by-dhcp.cox.net>
References: <46a038f90605220554y569c11b9p24027772bd2ee79a@mail.gmail.com>
	<44720C66.6040304@gentoo.org>
	<46a038f90605221241x58ffa2a4o26159d38d86a8092@mail.gmail.com>
	<Pine.LNX.4.64.0605221256090.3697@g5.osdl.org>
	<20060522214128.GE16677@kiste.smurf.noris.de>
	<7v8xotadm3.fsf@assigned-by-dhcp.cox.net>
	<46a038f90605221615j59583bcdqf128bab31603148e@mail.gmail.com>
	<20060523065232.GA6180@coredump.intra.peff.net>
	<20060523070007.GC6180@coredump.intra.peff.net>
	<118833cc0605231047o2012deefh5e77b8496da1e673@mail.gmail.com>
	<20060523205944.GA16164@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Morten Welinder <mwelinder@gmail.com>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Matthias Urlichs <smurf@smurf.noris.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 24 01:42:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FigVh-0005ZG-Qz
	for gcvg-git@gmane.org; Wed, 24 May 2006 01:41:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932107AbWEWXlf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 May 2006 19:41:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932329AbWEWXlf
	(ORCPT <rfc822;git-outgoing>); Tue, 23 May 2006 19:41:35 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:18906 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S932107AbWEWXlf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 May 2006 19:41:35 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060523234134.VQUP24290.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 23 May 2006 19:41:34 -0400
To: Jeff King <peff@peff.net>
In-Reply-To: <20060523205944.GA16164@coredump.intra.peff.net> (Jeff King's
	message of "Tue, 23 May 2006 16:59:44 -0400")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20648>

Jeff King <peff@peff.net> writes:

> On Tue, May 23, 2006 at 01:47:01PM -0400, Morten Welinder wrote:
>
>> Why run "env" and not just muck with %ENV?
>> >+       my $pid = open2(my $commit_read, my $commit_write,
>> >+               'env',
>> >+               "GIT_AUTHOR_NAME=$author_name",
>> >+               "GIT_AUTHOR_EMAIL=$author_email",
>> >+               "GIT_AUTHOR_DATE=$commit_date",
>> >+               "GIT_COMMITTER_NAME=$author_name",
>> >+               "GIT_COMMITTER_EMAIL=$author_email",
>> >+               "GIT_COMMITTER_DATE=$commit_date",
>> >+               'git-commit-tree', $tree, @commit_args);
>
> Oops, that's an obvious fork optimization that I should have caught.

Are you two talking about running git-commit-tree via env is two
fork-execs instead of just one?  Does that have a measurable
difference?

Not that I have anything against the updated code, but I do not
particularly thing it is such a big issue.

> PS What is the preferred format for throwing patches into replies like
> this? Putting the patch at the end (as here) or throwing the reply
> comments in the ignored section near the diffstat?

You could do it either way.  Although I personally find the
former easier to read (meshes well with "do not top post"
mantra), it appears many other people finds the cover letter
material should come after the first '---' separator.

If you append the patch to your message, btw, you would need to
realize that the receiving end needs to edit your message to
remove the top part before running "git am" to apply.
