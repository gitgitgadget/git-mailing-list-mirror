From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 0/2] [GIT PULL] ktest: A couple of fixes
Date: Wed, 02 May 2012 20:07:35 -0400
Message-ID: <1336003655.14207.71.camel@gandalf.stny.rr.com>
References: <20120502004439.965120020@goodmis.org>
	 <CA+55aFy02d13HkfwY-TEGwu=2cd8en+_rnrnwcwixGKRmdJRtA@mail.gmail.com>
	 <7v62cf6y3d.fsf@alter.siamese.dyndns.org>
	 <1335966292.14207.40.camel@gandalf.stny.rr.com>
	 <7vsjfigx23.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-YTdWAVHovL7HIpXYuxXm"
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 03 02:07:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPjaQ-0002y2-PO
	for gcvg-git-2@plane.gmane.org; Thu, 03 May 2012 02:07:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752962Ab2ECAHh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 May 2012 20:07:37 -0400
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:27155 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752525Ab2ECAHg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 May 2012 20:07:36 -0400
X-Authority-Analysis: v=2.0 cv=T/EOvo2Q c=1 sm=0 a=ZycB6UtQUfgMyuk2+PxD7w==:17 a=XQbtiDEiEegA:10 a=9QRZpqc-8XMA:10 a=5SG0PmZfjMsA:10 a=meVymXHHAAAA:8 a=Z4Rwk6OoAAAA:8 a=Wmh-_wvY6hBZCr5p7QEA:9 a=X1RGp4ikp6kbpGtBG9kA:7 a=PUjeQqilurYA:10 a=jeBq3FmKZ4MA:10 a=jbrJJM5MRmoA:10 a=2PGdCOUo8GeGIDMN-_oA:9 a=ZycB6UtQUfgMyuk2+PxD7w==:117
X-Cloudmark-Score: 0
X-Originating-IP: 74.67.80.29
Received: from [74.67.80.29] ([74.67.80.29:41633] helo=[192.168.23.10])
	by hrndva-oedge02.mail.rr.com (envelope-from <rostedt@goodmis.org>)
	(ecelerity 2.2.3.46 r()) with ESMTP
	id F2/9D-05208-74CC1AF4; Thu, 03 May 2012 00:07:35 +0000
In-Reply-To: <7vsjfigx23.fsf@alter.siamese.dyndns.org>
X-Mailer: Evolution 3.2.2-1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196872>


--=-YTdWAVHovL7HIpXYuxXm
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit

On Wed, 2012-05-02 at 13:14 -0700, Junio C Hamano wrote:
> Steven Rostedt <rostedt@goodmis.org> writes:
> 
> > On Tue, 2012-05-01 at 20:49 -0700, Junio C Hamano wrote:
> >> Linus Torvalds <torvalds@linux-foundation.org> writes:
> >> 
> >
> >> When a normal developer wants to _reset to_ a particular tagged release,...
> >
> > The problem is,...
> > But then I would end up with ...
> 
> [comments on the part I declared "uninteresting" snipped]

Just have to snip it, you don't need to declare it uninteresting.


> > $ git-branch-status v3.0.4 v3.0.5              
> > Branch v3.0.4 can be fast forward to v3.0.5 in 240 commits
> >
> > $ git-branch-status v3.0.4 v3.1  
> > Branch v3.0.4 and v3.1
> > differ by 257 and 9380 commit(s) respectively
> 
> I personally do not think "257 and 9380" vs "15 and 400" totally
> uninteresting, in the sense that the absolute numbers do not matter much,

I disagree here. Maybe it's because of the example I used. Here's a more
appropriate one:

I usually work against the tip.git tree for my kernel work (not ktest),
and I have several branches for different things I work on. I
periodically rebase against the latest tip branch to make sure
everything works (these development branches are only local to my own
machines, not public). Sometimes I forget what I pushed forward and
where I left off. I'll make a branch off of another branch's commit and
push that, and continue developing. But I rebase the new stuff and test
it before pushing it again. So I have something like this:

$ git-branch-status tip/perf/core
Branch HEAD and tip/perf/core
differ by 15 and 644 commit(s) respectively

Here it shows that this branch has 15 patches that are pending. I'll
usually rebase against tip/perf/core, run a bunch of tests, and then
push it out when ready.

I'll continue to work on this branch and add more patches. But because
other people may add things to tip/perf/core that affect me, I need to
rebase once in a while. But I also check to see if the previous push was
in, and I use my script git-branch-status on a daily basis. Lets me know
what patches I need to look at. Maybe it's not that important, but I
find it useful in my everyday workflow.

> and the only question that matter is "Is everything in this one included
> in the other?" and I just say "git lgf master..topic" (where I have in my
> $HOME/.gitconfig "[alias] lgf = log --oneline --boundary --first-parent"
> defined) to see the list of commits on a topic, with the indication of
> where the topic forked from.  Obviously it takes the "never merge mainline
> into topics" discipline for it to be useful.
> 
> I also use "git show-branch $A $B $C..." for something like this but that
> is only useful when these branches are known to have only a handful of
> commits on their own, and its output is not very suited if they have
> hundreds of commits.


If I'm the only one that finds this feature useful, then I'm happy with
just using my script. It works well and I have it on all my boxes. I
just wanted to show others in case I'm not the only one that finds this
information useful.

I just thought it would be easy to implement as git already does this
check. I liked what I saw from git that I based my output of this script
on it. In fact, I just saw it today:

$ git checkout trace/rfc/tracing/fentry
Switched to branch 'trace/rfc/tracing/fentry'
Your branch and 'ftrace/rfc/tracing/fentry' have diverged,
and have 65913 and 4 different commit(s) each, respectively.


I'll throw in one more feature request, that you can take or leave (I
have another script for it ;-), something that does a listing of
branches in order of date. I have over a hundred branches in my repo,
and I forget which branch was the last one I was working on. So I
created a script called git-ls (attached).

Here's what the output looks like:

$ git-ls | tail
681d1c4    2012-04-19    trace/tip/perf/urgent                         tracing: Fix stacktrace of latency tracers (irqsoff and friends)
59cfede    2012-04-19    trace/rfc/iolatency                           tracing: Add iolatency tracer
61463fa    2012-04-24    trace/tip/perf/core                           ftrace/x86: Remove the complex ftrace NMI handling code
e201738    2012-04-26    trace/tip/perf/core-2                         ftrace/x86: Remove the complex ftrace NMI handling code
053cef1    2012-04-27    trace/rfc/tracing/fentry                      ftrace/x86: Add support for -mfentry to x86_64
4a6d70c    2012-04-27    trace/tip/perf/core-3                         ftrace/x86: Remove the complex ftrace NMI handling code
a76c3eb    2012-04-30    trace/rfc/kprobes/ftrace                      ftrace/x86: Add support for x86_32 to pass pt_regs to function tracer
6e1b77e    2012-05-02    trace/rfc/kprobes/ftrace-v2                   kprobes: Update header for ftrace optimization
a4cc5f1    2012-05-02    trace/tip/perf/next-2                         ftrace/x86: Add separate function to save regs
9bd8569    2012-05-02    trace/tip/perf/next                           trace: Make removal of ring buffer pages atomic

It lists the branches in order of date of last commit.

Again, just showing some things that I find useful. If no one else finds
these interesting, then just ignore it. I have my scripts :-)

-- Steve


--=-YTdWAVHovL7HIpXYuxXm
Content-Type: application/x-perl; name="git-ls"
Content-Disposition: attachment; filename="git-ls"
Content-Transfer-Encoding: 7bit

#!/usr/bin/perl

open(IN, "git branch |") or die "open git branch";

my @branches;

while (<IN>) {
    if (/^\*?\s*(\S*)/) {
	chomp;
	$branches[$#branches+1] = $1;
    }
}

my %branch_time;
my %branch_date;
my %branch_hash;
my %branch_subject;

foreach my $branch (@branches) {
    my $line = `git show --format="%ct <%ci> %h %s" -s $branch`;
    chomp $line;
    if ($line =~ /^(\S+) <(\S+).*?> (\S+) (.*)/) {
	$branch_time{$branch} = $1;
	$branch_date{$branch} = $2;
	$branch_hash{$branch} = $3;
	$branch_subject{$branch} = $4;
    }
}

foreach my $branch (sort { $branch_time{$a} <=> $branch_time{$b} } keys %branch_time) {
    my $hash = $branch_hash{$branch};
    my $subject = $branch_subject{$branch};
    my $date = $branch_date{$branch};
    printf "%-10s %-13s %-45s %s\n", $hash, $date, $branch, $subject;
}

--=-YTdWAVHovL7HIpXYuxXm--
