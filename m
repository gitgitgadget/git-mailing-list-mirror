Return-Path: <SRS0=mA98=7A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 963A5C433E0
	for <git@archiver.kernel.org>; Mon, 18 May 2020 21:46:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7537D20829
	for <git@archiver.kernel.org>; Mon, 18 May 2020 21:46:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbgERVqO convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Mon, 18 May 2020 17:46:14 -0400
Received: from smtp-nf-201.his.com ([216.194.196.93]:59270 "EHLO
        smtp-nf-201.his.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726250AbgERVqN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 May 2020 17:46:13 -0400
Received: from cuda201.his.com (cuda201.his.com [216.194.196.22])
        by smtp-nf-201.his.com (Postfix) with ESMTPS id 4AE9760439
        for <git@vger.kernel.org>; Mon, 18 May 2020 17:46:12 -0400 (EDT)
X-ASG-Debug-ID: 1589838371-061c4114b789030001-QuoKaX
Received: from smtp-nf-202.his.com (smtp-nf-202.his.com [216.194.196.20]) by cuda201.his.com with ESMTP id sVIGBjU5yeUj0Iwm; Mon, 18 May 2020 17:46:11 -0400 (EDT)
X-Barracuda-Envelope-From: keni@his.com
X-Barracuda-RBL-Trusted-Forwarder: 216.194.196.20
Received: from zproxy101.his.com (zproxy101.his.com [18.218.2.49])
        by smtp-nf-202.his.com (Postfix) with ESMTPS id C01026017A;
        Mon, 18 May 2020 17:46:11 -0400 (EDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zproxy101.his.com (Postfix) with ESMTP id 8AF8D177F1A;
        Mon, 18 May 2020 17:46:11 -0400 (EDT)
X-Barracuda-RBL-IP: 18.218.2.49
X-Barracuda-Effective-Source-IP: zproxy101.his.com[18.218.2.49]
X-Barracuda-Apparent-Source-IP: 18.218.2.49
Received: from zproxy101.his.com ([127.0.0.1])
        by localhost (zproxy101.his.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id GI7D-6qXgSsB; Mon, 18 May 2020 17:46:11 -0400 (EDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zproxy101.his.com (Postfix) with ESMTP id 733C1177F18;
        Mon, 18 May 2020 17:46:11 -0400 (EDT)
X-Virus-Scanned: amavisd-new at zproxy101.his.com
Received: from zproxy101.his.com ([127.0.0.1])
        by localhost (zproxy101.his.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id lRJ3MndI31rx; Mon, 18 May 2020 17:46:11 -0400 (EDT)
Received: from [192.168.1.168] (pool-74-96-209-77.washdc.fios.verizon.net [74.96.209.77])
        by zproxy101.his.com (Postfix) with ESMTPSA id 420BB177F1A;
        Mon, 18 May 2020 17:46:11 -0400 (EDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.60.0.2.5\))
Subject: Re: [RFC PATCH 3/6] Add namespace collision avoidance guidelines file
From:   Kenneth Lorber <keni@his.com>
X-ASG-Orig-Subj: Re: [RFC PATCH 3/6] Add namespace collision avoidance guidelines file
In-Reply-To: <xmqqh7we7f4b.fsf@gitster.c.googlers.com>
Date:   Mon, 18 May 2020 17:46:10 -0400
Cc:     Kenneth Lorber <keni@hers.com>, git@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <19B52AC4-E3E0-4BA4-A383-8EA34681E9B6@his.com>
References: <1589681624-36969-1-git-send-email-keni@hers.com>
 <1589681624-36969-4-git-send-email-keni@hers.com>
 <xmqqh7we7f4b.fsf@gitster.c.googlers.com>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3608.60.0.2.5)
X-Barracuda-Connect: smtp-nf-202.his.com[216.194.196.20]
X-Barracuda-Start-Time: 1589838371
X-Barracuda-URL: https://spam.his.com:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at his.com
X-Barracuda-Scan-Msg-Size: 5676
X-Barracuda-BRTS-Status: 1
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=6.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.81942
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



> On May 17, 2020, at 11:31 AM, Junio C Hamano <gitster@pobox.com> wrote:
> 
> Kenneth Lorber <keni@hers.com> writes:
> 
>> From: Kenneth Lorber <keni@his.com>
>> 
>> Add a file of guidelines to prevent the namespace collisions
>> mentioned in git help config without any guidance.
> 
> Collisions with whom are you worried about?

This patch came about when I went to split config for a server's repo into a static part and a dynamic part.  The static part goes in a configuration repo (where it gets updated and pushed to production) while the dynamic part is written by the various git commands (and includes the static part).  Several things came to mind:
- config doesn't have an extension, so adding a new name with the same extension doesn't work
- what files will the current git version put into .git?  I don't know.
- how can I avoid picking names that will show up in future versions of git?

So the first answer is: collisions with git.

We also give our developers git extensions to help with our work flow.  Some are aliases and some are
hook scripts, with all the code living in .git/hooks (because that seemed the safest place); if git
adds a new hook and I'm unlucky, all kinds of breakage are possible.

So the second answer is: collisions with organization or group extensions.

The third answer is theoretical: what happens if someone brings in a new git extension that collides with any of the above?

> Random $stuff the end users want to have the namespace that governs
> $stuff (where $stuff could be an environment variable, a file on the
> filesystem, refname in git, etc.)?
> 
> Random $stuff third-party tools want to add?
> 
> As far as git is concerned, all the files under $GIT_DIR are
> blackbox and off-limits from end users

Where does it say that?  I see this in the user manual: "cat .git/HEAD" so the user manual doesn't seem to press that point.
Just looking for ".git" also shows:
"you may instead put them in a file in your repository named `.git/info/exclude`"
"touch proj.git/git-daemon-export-ok"
"$ cat >> .git/config <<EOF" (note that this can cause all sorts of grief since it doesn't lock config)
(etc)

That's not true though, is it?  config needs to be edited for all kinds of things, and while "git config -e" is probably the correct answer, a quick grep under Documentation shows zero hits for "config -e" and at least on place where the user manual says "by editing `.git/config` with a text editor".  The hooks directory is also fair game for both users and extensions.  (There's nothing mentioned about running more than one program from a hook, but that's an ugly bit of code I'm not likely to send out, so I'm going to ignore that conflict.)

> and third-party tools, so
> there is no collisions in "a file on the filesystem", but creating a
> ref may result in a creation of a file in $GIT_DIR/,

I wasn't aware of that, thanks.  It also demonstrates the need to say more about this topic in the docs since I thought I had found all the conflict sources.  (Got it - git help revisions, "1. If $GIT_DIR/<refname> exists, that is what you mean").

And here's a real (if contrived) oddity:
$ git init
$ echo a > file1
$ git add file1
$ git commit -m xx
$ echo b >> file1
$ git commit -F .git/HEAD file1
$ git reflog COMMIT_EDITMSG
6fd4d85 COMMIT_EDITMSG@{0}: commit: ref: refs/heads/master
213ef7d COMMIT_EDITMSG@{1}: commit (initial): xx

> and carving out
> a part of refs/* hierarchy for use by a third-party tool is a
> worthwhile goal.  Just like "git bisect" uses refs/bisect/* for its
> own operation and wants to reserve the hierarchy from other tools
> and the end users, any third-party tool would want a similar
> carve-out.  The same for configuration variables.
> 
> HOWEVER
> 
> I would rather not to see an arbitrary set of rules that are not
> battle-tested in the field added to our documentation.

I can't fault that, but I'd like to see more than what's there.

> 
> Instead, my preference is to add a document that describes what
> namespaces (e.g. environment variable, reference, configuration
> varable) third-party tools may want carving out for themselves to
> raise awareness of writers of such tools, and tell them to talk to
> us on the list, saying "I plan to write a tool that wants to reserve
> refs/frotz/ hierarchy for its own use---comments?", so that people
> can respond with "I know a tool that already uses that hierarchy, so
> you'd need to come up with a different one" to save hassles of
> having to rename before it happens.

I don't think that's reasonable.  Individual users will not reach out to a mailing list to deal with their personal scripts - they'll just roll the dice.  Large corporations or startups in stealth mode may also be unable or unwilling to expose enough of their internal information to get a good recommendation in public.

> 
> After gaining experience from such exchanges, we might come up a set
> of rules so that no collisions would be possible without any
> coordination, and then we could document those rules.  

Would you be willing to support the "my" "this" and "our" levels while
replacing the $ID section with a note for people expecting wide distribution
of their extension to consult the mailing list?

Or even marking the entire section as "experimental - this may be updated as we gain experience with real world use; please consult the mailing list..." ?

> 
> I do not think that is plausible to happen, but that is OK.

I disagree, but then if I agreed I would not have submitted the patch :-)

Thanks for you comments,
Keni

