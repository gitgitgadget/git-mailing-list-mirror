X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: git-format-patch little gripe
Date: Fri, 3 Nov 2006 11:52:53 -0800 (PST)
Message-ID: <20061103195253.9244.qmail@web31814.mail.mud.yahoo.com>
References: <7vwt6cbwzq.fsf@assigned-by-dhcp.cox.net>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
NNTP-Posting-Date: Fri, 3 Nov 2006 19:53:42 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:X-YMail-OSG:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=fDHxfy2YPNnVUaDY0Bv58fe8H8HpfZSkeUKag/04/CoY0ndm3a8uuvzQ8aZToFuAqq5bTmY9rhhhXP9rffLPlvyr27DkMCk9hUSy6oZ47BmdKXUnyEmukvldJeOZkQpps9GGflxWvOJMG2UBPbBn/lNV4t2KZ0vj5k0CgCy1jrQ=  ;
X-YMail-OSG: HDPgxgYVM1leyml1bTN4vHN2F5Ppyxc7SUuppG_c8mdrttM8x2RYn7A0yjK4kS05BA--
In-Reply-To: <7vwt6cbwzq.fsf@assigned-by-dhcp.cox.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30878>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gg569-00039F-FF for gcvg-git@gmane.org; Fri, 03 Nov
 2006 20:53:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753492AbWKCTwz (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 3 Nov 2006
 14:52:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753508AbWKCTwz
 (ORCPT <rfc822;git-outgoing>); Fri, 3 Nov 2006 14:52:55 -0500
Received: from web31814.mail.mud.yahoo.com ([68.142.206.167]:64860 "HELO
 web31814.mail.mud.yahoo.com") by vger.kernel.org with SMTP id
 S1753492AbWKCTwy (ORCPT <rfc822;git@vger.kernel.org>); Fri, 3 Nov 2006
 14:52:54 -0500
Received: (qmail 9246 invoked by uid 60001); 3 Nov 2006 19:52:53 -0000
Received: from [64.215.88.90] by web31814.mail.mud.yahoo.com via HTTP; Fri,
 03 Nov 2006 11:52:53 PST
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

--- Junio C Hamano <junkio@cox.net> wrote:
> It would have been nicer if you made that argument as a reply to
> one of these messages:
> 
> http://thread.gmane.org/gmane.comp.version-control.git/4266/focus=4279
> http://thread.gmane.org/gmane.comp.version-control.git/4843/focus=4843
> http://thread.gmane.org/gmane.comp.version-control.git/5440/focus=5446

I'm amazed at people who can read selectively messages in mailing lists.
The amount of messages sometimes is overwhelming.

> It is not an ideology; it is called not breaking existing UI,
> which is rather unfortunate, because its UI is not the greatest
> in the world.

Yes, it is very unfortunate.  It's like the metric system... nobody would
want to switch to it if you give them a _choice_... so water is going
to be freezing at 32 degrees and boiling over at 212.

So unless someone submits and commits a patch to fix this, and then we
shelter in the storm, it will never change.

> set" which is roughly "rev-list yours..upstream".  Some of your
> patches (i.e. "rev-list upstream..yours") may have already

Yeah, that's exactly what I do.

> One thing we talked about but nobody stepped up to code [*1*] is
> to give "git-format-patch --stdin" that reads list of commits,
> and runs "git-diff-tree --pretty --stat --summary -p $commit".
> With that, we could do something like:
> 
> 	git rev-list linus..orinoco | git format-patch --stdin

That'd be swell to have.

> Your "git-format-patch --single $commit" is a shorthand for a
> degenerated special case of that pattern.

Yes, except that I'd have to paste the sha-1 into the terminal
rather than on the command line.  This again proves that the current
git-format-patch <sha-1> to mean "<sha-1>..HEAD" is horribly broken.

> You cannot do patch-id based filtering with this form, but I see
> that "single" is often wanted on the list and #git, and people
> who want it do not care about patch-id based filtering at all.

The reason it is wanted is because it is _intuitive_.  This is
what engineers (of different backgrounds) tend to intuitively think
and assume given git's structure and the nature and meaning of
what an <sha-1> is in git, only to be surprised later when that
assumption is completely broken by git-format-patch.

"git-format-patch <sha-1>" intuitively means "Show me the commit identified
by the <sha-1> in a patch format."

Now if it had been called "git-format-patches" then maybe the argument
would've been different.

> And I do not think it is that "they do not realize how much they
> would be missing without patch-id filtering", in this case.  So
> the above command line would probably be Ok.

I do not think they'd be missing _anything_.  After all,
"git-format-patch <sha-1>..HEAD" is also intuitive.

> With --left-right (in "pu"), you could even do something a bit
> fancier like this:
> 
> 	git rev-list --left-right linus...8139cp linus...airo |
> 	git format-patch --stdin
> 
> The --left-right output option, when used in conjunction with
> the symmetric difference set operator, prefixes each commit with
> '<' (left) or '>' (right) to indicate which ancestry it belongs
> to (in the above example, the commits only in the branch that

Yeah, this is swell too!

> *1* format-patch is primarily the tool for a patch submitter,
> and I did its original version back when I was one.  For a long
> time (an equivalent to "eternity" in git timescale back then)
> Linus did not show _any_ interest in it (you can compare the

Yes, this is sad.  There's other places where Linus hasn't shown
any interest which have been suffering ever since.  Someone needs
to make the decision after all, or at least appoint someone to make
the decision (and then blame them ;-) later).

> dates on the messages I quoted above with the commit date of
> 0acfc972), and I suspect one of the reasons is because he was
> the toplevel maintainer and did not have a need for a tool like
> that.  Now I am the toplevel maintainer here and I haven't felt
> the need to update it myself for quite some time ("it works for
> me"), which is a bit sad.

If I had the clout, I'd change "git-format-patch <sha-1>" to
mean "git-format-patch <sha-1>^..<sha-1>" in a heart-beat, without
even blinking.

So what if people find out their tools now generate only _one_ patch
instead of N?  They'll revisit their scripts and use "<sha-1>..HEAD",
(which says what it means), instead of the completely broken current
behavior.

Also I doubt how many people actually have coded in their scripts
"git-format-patch <sha-1>" to mead by default "<sha-1>..HEAD" -- I'd think
that maintainers always want to know the "end point" and would always
use the <a>..<b> format, instead of presuming where/what their HEAD is.

Sorry it's my rant.  I know it's not your fault.

    Luben
