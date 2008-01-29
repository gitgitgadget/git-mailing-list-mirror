From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: fetch <repo> <branch>:<branch> fetches tags?
Date: Tue, 29 Jan 2008 11:08:49 -0600
Message-ID: <479F5DA1.2030900@nrlssc.navy.mil>
References: <479E9063.5000403@nrlssc.navy.mil>	<7v3ashs5yg.fsf@gitster.siamese.dyndns.org>	<7vodb5qk2b.fsf@gitster.siamese.dyndns.org>	<loom.20080129T055937-532@post.gmane.org> <7vabmpovu5.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 29 18:18:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JJu5t-0000hD-N0
	for gcvg-git-2@gmane.org; Tue, 29 Jan 2008 18:17:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933747AbYA2RRP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jan 2008 12:17:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933222AbYA2RRO
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jan 2008 12:17:14 -0500
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:45571 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933738AbYA2RRM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jan 2008 12:17:12 -0500
Received: from starfish.gems.nrlssc.navy.mil (localhost [127.0.0.1])
	by mail.nrlssc.navy.mil (8.13.7/8.13.7) with ESMTP id m0TH8nJn025502;
	Tue, 29 Jan 2008 11:08:49 -0600
Received: from tick.nrlssc.navy.mil ([128.160.25.48]) by starfish.gems.nrlssc.navy.mil with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 29 Jan 2008 11:08:49 -0600
User-Agent: Thunderbird 2.0.0.9 (X11/20071031)
In-Reply-To: <7vabmpovu5.fsf@gitster.siamese.dyndns.org>
X-OriginalArrivalTime: 29 Jan 2008 17:08:49.0405 (UTC) FILETIME=[9D9F72D0:01C86299]
X-TM-AS-Product-Ver: : ISVW-6.0.0.2339-5.0.0.1023-15694001
X-TM-AS-Result: : Yes--21.845000-0-31-1
X-TM-AS-Category-Info: : 31:0.000000
X-TM-AS-MatchedID: : =?us-ascii?B?MTUwNTY3LTE1MDY1OC0xNTA2?=
	=?us-ascii?B?NTctNzAwMDc1LTEzOTAxMC03MDAwNzMtNzAzNzMxLTcwNDA0OS03?=
	=?us-ascii?B?MDg2NTUtNzA0NDI1LTcwMTQ1NS03MDcxMzYtNzA0ODg1LTcwMTQ1?=
	=?us-ascii?B?MC03MDUzODgtNzAyMDQ0LTcwMTE0Ni03MDA2MzAtNzA4MTc5LTcw?=
	=?us-ascii?B?MzM3OC03MDc3ODgtNzA2NDU0LTcwMTIwMi03MDgwNTgtNzA5NTg0?=
	=?us-ascii?B?LTcwMDE1My03MDczNjEtNzAxMzM3LTcwNzU1My03MDEyMzYtNzAy?=
	=?us-ascii?B?MDE2LTcwMTI5OC03MDM4NTEtNzAwNzgyLTcwOTE1NS03MDY1NjEt?=
	=?us-ascii?B?NzA2NjM5LTcwNzgwMC03MDA4NDYtNzExNDMyLTcwNDQ5Ni03MDA5?=
	=?us-ascii?B?NzEtMzAwMDE1LTcwNTkwMS03MDE0MzctNzA2ODkxLTcwNDcxMi03?=
	=?us-ascii?B?MDIwMTItNzAyMjI4LTcxMDUxMi03MDE5MTQtNzAwNjE4LTE4NzA2?=
	=?us-ascii?B?Ny03MDUxMDItNzAxODM3LTcwMDc3MS03MDIxMDItNzAyOTYyLTcw?=
	=?us-ascii?B?OTgyMy03MDYyNDktNzA3NDUxLTcwMjM1OC03MDkwNjUtNzA0NDIx?=
	=?us-ascii?B?LTE4ODEyMS03MDI2MDktNzEwNDQyLTcwMjE0My0xNDgwMzktMTQ4?=
	=?us-ascii 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71982>

Junio C Hamano wrote:
> Brandon Casey <drafnel@gmail.com> writes:
> 
>>> Having said that, I do not particularly think the new behaviour
>>> is bad per-se.  If you are storing what you fetched locally in
>>> tracking branches, you are interested in their work enough to
>>> want to auto-follow their tags.
>> How is "tracking" defined? Is this a term that implies some configuration
>> to link a local branch to a remote branch? Or is any local branch created
>> from a remote branch considered "tracking"?
> 
> I probably should have said "Instead of just letting fetch
> temporarily store the result in FETCH_HEAD and using it from
> there, you saved it away; that's a good indication of you care
> about it deeply enough".
> 
> It's really about what's convenient.  I was somewhat upset that
> the behaviour change was not I was very aware of (perhaps I said
> it was a good idea and I then forgot), I didn't think the
> earlier behaviour was broken, but if I have to choose, I think
> the new behaviour is probably slightly nicer than the old one.

It feels a little inconsistent to me.

With this behavior adopted as standard, then all forms of fetch will
fetch tags except for 'git-fetch <repo> <branch>'. I think this is
probably the least used form for porcelain.

What I understand you to be saying is that creating a branch during
fetch indicates "I care deeply enough, so I want tags". At the moment,
I don't know why I would fetch if I didn't want to make a branch. Even
if I just wanted to cherry-pick one patch, or one source file, or (some
other contrived example), I think I would create a branch to give it
some anchor point, and why not create the branch during the fetch.

And, if I fetch now with the colon notation implying I want tags, later,
if I 'git pull <repo> <branch>' from within that branch, why does that
imply that I do not still want tags just because I'm not creating a 'new'
branch.

I think the current metric for indicating "caring deeply enough" is the
remote tracking configuration. Tracking implies "I care deeply enough,
I want tags", lack of tracking does not imply this. But I said this already
in another email. I am not sure if this feels right because it is documented
or because it is right.

An alternative to this is to make fetch completely consistent so it either
"always" gets tags, or "never" gets tags, and requires an option to reverse
its behavior.

It seems to me that "never" gets tags is the safer choice. This is because
accidentally fetching tags is a pain to clean up, but if I forget to ask
for tags, I just run the same command again and ask this time. If I fetch
or pull and use the --tags (the current --tags should be changed to --all-tags)
then I know what I am doing.

The documented behavior for tracking branches and fetching tags could be
retained by requiring a fetch option in the branch configuration and
modifying git-remote and commands that use --track, to add the option
by default. The big downside is that this would require existing repositories
to update their config file which would also cause confusion.

-brandon
