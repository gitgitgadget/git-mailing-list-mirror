From: Aaron Bentley <aaron.bentley@utoronto.ca>
Subject: Re: VCS comparison table
Date: Tue, 17 Oct 2006 15:44:37 -0400
Message-ID: <453532A5.6060701@utoronto.ca>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com> <egr3ud$nqm$1@sea.gmane.org> <45340713.6000707@utoronto.ca> <Pine.LNX.4.64.0610161625370.3962@g5.osdl.org> <45345AEF.6070107@utoronto.ca> <45348B5E.8000404@op5.se> <4534E335.8070203@utoronto.ca> <4534F133.1090003@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@osdl.org>,
	Jakub Narebski <jnareb@gmail.com>,
	bazaar-ng@lists.canonical.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 17 21:45:07 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZurp-0003if-3Z
	for gcvg-git@gmane.org; Tue, 17 Oct 2006 21:44:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751241AbWJQToq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Oct 2006 15:44:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751242AbWJQTop
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Oct 2006 15:44:45 -0400
Received: from server4.panoramicfeedback.com ([66.216.124.41]:6593 "EHLO
	server4.panoramicfeedback.com") by vger.kernel.org with ESMTP
	id S1751241AbWJQToo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Oct 2006 15:44:44 -0400
Received: from server4.panoramicfeedback.com ([66.216.124.41] helo=[192.168.2.19])
	by server4.panoramicfeedback.com with esmtp (Exim 3.36 #1 (Debian))
	id 1GZurf-0002x2-00; Tue, 17 Oct 2006 15:44:39 -0400
User-Agent: Debian Thunderbird 1.0.2 (X11/20060830)
X-Accept-Language: en-us, en
To: Andreas Ericsson <ae@op5.se>
In-Reply-To: <4534F133.1090003@op5.se>
X-Enigmail-Version: 0.91.0.0
X-Panometrics-MailScanner: Found to be clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29108>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Andreas Ericsson wrote:
>> In Bazaar, a revision id always refers to the same logical entity, but
>> it may be stored in different formats in different repositories.
>>
> 
> This I don't understand. Let's say Alice has revision-154 in her repo,
> located at alice.example.com. Let's say that commit is accessible with
> the url "alice.example.com:revision-154". Bob pulls from her repo into
> his own, which is located at bob.example.com.
> 
> Lots of questions here, so I'll split them up. Feel free to delete the
> non-applicable ones.
> 
> Will the commit in Bob's repo be accessible at
> "bob.example.com:revision-154"?

bzr differentiates between pull and merge.  Pull is a mirroring command.
 So with pull, yes revision-154 will be accessible at
bob.example.com:revision-154.

With merge, it won't.  Bob can refer to it as "154:alice.example.com",
though.

> If it's not, how can you backtrack from old bugreports and find the
> error being discussed?

Refer to it as 'alice.example.com revno 154' or by its revision-id.

> If it is, how does that work if Bob suddenly wants to commit things
> before Alice is done working with her changes?

I don't see how this applies.  You can always commit in a branch.  If
alice and bob both commit, then they are diverged and can't pull.  If
alice merges bob, then they converge and bob can pull alice.

> Also, suppose they both push to a master-repo where Caesar has pushed
> his changes and nicked the slot for revision-154. Does the master repo
> re-organize everything and then invalidate Bob's and Alice's changes, or
> does it tell Alice and Bob that they need to update and then reorganize
> their repos before they're allowed to push?

They must merge from the master-repo before they can push to it.

>> In our terminology, if it can diverge from the original, it's a branch,
>> not a checkout.
>>
> 
> This clears things up immensely. bazaar checkout != git checkout.
> I still fail to see how a local copy you can't commit to is useful

My bzr is run from a local copy I can't commit to.  To get the latest
changes from http://bazaar-vcs.org, I can run "bzr update ~/bzr/dev".
To merge the latest changes into my branch, I can run
"bzr merge ~/bzr/dev".  It's also convenient for applying other peoples'
patches to.

Aaron
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFFNTKl0F+nu1YWqI0RAhRkAJ0d5KyRElEiFm/m5iRrTIk00RyqywCfe2IY
dhW46SYWm+FTQpN30VY5tPs=
=6SFm
-----END PGP SIGNATURE-----
