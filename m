From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: VCS comparison table
Date: Sun, 22 Oct 2006 21:27:35 +0200
Message-ID: <200610222127.36197.jnareb@gmail.com>
References: <Pine.LNX.4.64.0610172014250.3962@g5.osdl.org>
	<87zmbozau2.wl%cworth@cworth.org>
	<20061022185350.GW75501@over-yonder.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Carl Worth <cworth@cworth.org>, bazaar-ng@lists.canonical.com,
	git@vger.kernel.org, Erik =?iso-8859-1?q?B=E5gfors?= <zindar@gmail.com>
X-From: bazaar-ng-bounces@lists.canonical.com Sun Oct 22 21:27:47 2006
Return-path: <bazaar-ng-bounces@lists.canonical.com>
Envelope-to: gcvbg-bazaar-ng@m.gmane.org
Received: from esperanza.ubuntu.com ([82.211.81.173])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gbiz2-00061E-V3
	for gcvbg-bazaar-ng@m.gmane.org; Sun, 22 Oct 2006 21:27:45 +0200
Received: from localhost ([127.0.0.1] helo=esperanza.ubuntu.com)
	by esperanza.ubuntu.com with esmtp (Exim 4.60)
	(envelope-from <bazaar-ng-bounces@lists.canonical.com>)
	id 1Gbiyt-00019H-FC; Sun, 22 Oct 2006 20:27:35 +0100
Received: from hu-out-0506.google.com ([72.14.214.238])
	by esperanza.ubuntu.com with esmtp (Exim 4.60)
	(envelope-from <jnareb@gmail.com>) id 1Gbiyj-000198-4T
	for bazaar-ng@lists.canonical.com; Sun, 22 Oct 2006 20:27:25 +0100
Received: by hu-out-0506.google.com with SMTP id 27so911106hub
	for <bazaar-ng@lists.canonical.com>;
	Sun, 22 Oct 2006 12:27:24 -0700 (PDT)
Received: by 10.66.255.7 with SMTP id c7mr5970586ugi;
	Sun, 22 Oct 2006 12:27:24 -0700 (PDT)
Received: from host-81-190-23-110.torun.mm.pl ( [81.190.23.110])
	by mx.google.com with ESMTP id a1sm1574031ugf.2006.10.22.12.27.23;
	Sun, 22 Oct 2006 12:27:24 -0700 (PDT)
To: "Matthew D. Fuller" <fullermd@over-yonder.net>
User-Agent: KMail/1.9.3
In-Reply-To: <20061022185350.GW75501@over-yonder.net>
Content-Disposition: inline
X-BeenThere: bazaar-ng@lists.canonical.com
X-Mailman-Version: 2.1.8
Precedence: list
List-Id: bazaar-ng discussion <bazaar-ng.lists.canonical.com>
List-Unsubscribe: <https://lists.ubuntu.com/mailman/listinfo/bazaar-ng>,
	<mailto:bazaar-ng-request@lists.canonical.com?subject=unsubscribe>
List-Archive: <https://lists.ubuntu.com/archives/bazaar-ng>
List-Post: <mailto:bazaar-ng@lists.canonical.com>
List-Help: <mailto:bazaar-ng-request@lists.canonical.com?subject=help>
List-Subscribe: <https://lists.ubuntu.com/mailman/listinfo/bazaar-ng>,
	<mailto:bazaar-ng-request@lists.canonical.com?subject=subscribe>
Sender: bazaar-ng-bounces@lists.canonical.com
Errors-To: bazaar-ng-bounces@lists.canonical.com
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29776>

On Son, Oct 22, 2006 Matthew D. Fuller wrote:
> On Sun, Oct 22, 2006 at 07:25:41AM -0700 I heard the voice of
> Carl Worth, and lo! it spake thus:
>>
>> 	git pull . mainline
> 
> This throws me a little.  I'd expect it to Just Do It when it's
> fast-forwarding, but if it's doing a merge, I'd prefer it to stop and
> wait before creating the commit, even if there are no textual
> conflicts.  I realize you can just look at it afterward and back out
> the commit if necessary, but still...

Or you can use --no-commit option to git pull, and commit later.
But it is true that you can always amend the commit with
got commit --amend, even if the commit is merge.
 
>> Ah, I hadn't realized that bzr commits stored an "originating
>> branch" inside them.
> 
> Every branch has a nickname, settable with 'bzr nick' (defaulting to
> whatever the directory it's in is), and that's stored as a text field
> in each commit.  It's mostly cosmetic, but it's handy to see at a
> glance.

If I remember correctly Linus argued against it, because branch
name is something local to repository (most common example is
"mine 'master' is yours 'origin'").

There was proposal for "note" header for notes like merge algorithm
used, or branch name, visible only in 'raw' mode, but it wasn't 
implemented.

>> The mainline..featureA syntax literally just means:
>> 
>> 	the set of commits that are reachable by featureA
>> 	and excluding the set of commits reachable by mainline
> 
> From what I can gather from this, though, that means that when I merge
> stuff from featureA into mainline (and keep on with other stuff in
> featureA), I'll no longer be able to see those older commits from this
> command.  And I'll see merged revisions from branches other than
> mainline (until they themselves get merged into mainline), correct?
> It sounds more like a 'bzr missing --mine-only' than looking down a
> mainline in log...

That's true. That is what history viewers are for (gitk, qgit, tig,
gitview, git-show-branch, git-browser) are for.

And there is always reflog (if you enable it, of course).
