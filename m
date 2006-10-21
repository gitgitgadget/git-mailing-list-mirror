From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] Syntax highlighting for combined diff
Date: Sat, 21 Oct 2006 03:40:43 -0700
Message-ID: <7v4ptygdec.fsf@assigned-by-dhcp.cox.net>
References: <ehbq0k$24l$1@sea.gmane.org> <200610211049.56477.jnareb@gmail.com>
	<7vfydigg4w.fsf@assigned-by-dhcp.cox.net>
	<200610211202.00314.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 21 12:40:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GbEHa-00021N-6d
	for gcvg-git@gmane.org; Sat, 21 Oct 2006 12:40:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992927AbWJUKko (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Oct 2006 06:40:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992930AbWJUKko
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Oct 2006 06:40:44 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:46842 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S2992927AbWJUKko (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Oct 2006 06:40:44 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061021104043.DDNR16798.fed1rmmtao09.cox.net@fed1rmimpo01.cox.net>;
          Sat, 21 Oct 2006 06:40:43 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id cygU1V0041kojtg0000000
	Sat, 21 Oct 2006 06:40:29 -0400
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <200610211202.00314.jnareb@gmail.com> (Jakub Narebski's message
	of "Sat, 21 Oct 2006 12:02:00 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29602>

Jakub Narebski <jnareb@gmail.com> writes:

> Junio C Hamano wrote:
>> Jakub Narebski <jnareb@gmail.com> writes:
>> 
>> > Do I understand code correctly, and the last '+' or '-'
>> > in the parents column means?
>> >
>> >         for (i = 0; i < ecbdata->nparents && len; i++) {
>> >                 if (line[i] == '-')
>> >                         color = DIFF_FILE_OLD;
>> >                 else if (line[i] == '+')
>> >                         color = DIFF_FILE_NEW;
>> >         }
>> >
>> > Anyone who wrote this code, could you answer me, please?
>> 
>> The "up to ecbdata->nparents" is Johannes in cd112ce.  But you
>> are looking at a wrong code, I am afraid, if your original
>> question was about the combined format (there is a comment about
>> the codepath dealing only with two-way diffs by Johannes, above
>> the part you quoted).  The output for combined diff is coming
>> from combine-diff.c:dump_sline().
>
> I was asking both about combined diff format, and how it is colored
> by git-diff --color, to add colored combined diff output to gitweb.

I was answering about both.  dump_sline() implements both format
and coloring.

> Any other ideas how combined commitdiff should look like in gitweb?

Combined or no combined, one thing that mildly irritates me
sometimes is that there does not seem to be an easy and obvious
way to do a rough equivalent of typing SPACE repeatedly while
viewing "git log -p".

In other words, I think it would be a nice addition to have "go
to commitdiff page of this parent" links near the top on the
commitdiff page.
