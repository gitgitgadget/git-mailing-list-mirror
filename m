Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0034E1F403
	for <e@80x24.org>; Mon, 18 Jun 2018 21:42:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935792AbeFRVmo (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Jun 2018 17:42:44 -0400
Received: from mout.gmx.net ([212.227.15.19]:42979 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935628AbeFRVmn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jun 2018 17:42:43 -0400
Received: from [192.168.0.129] ([37.201.195.106]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MXZ4Q-1fjvLw2X4A-00WWe8; Mon, 18
 Jun 2018 23:42:34 +0200
Date:   Mon, 18 Jun 2018 23:42:42 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     phillip.wood@dunelm.org.uk
cc:     Elijah Newren <newren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>, ch <cr@onlinehome.de>,
        git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v2] sequencer: do not squash 'reword' commits when we
 hit conflicts
In-Reply-To: <0ead1e75-98e9-8357-3e8d-2ff2f3cc5cc0@talktalk.net>
Message-ID: <nycvar.QRO.7.76.6.1806182326420.77@tvgsbejvaqbjf.bet>
References: <CAPig+cRKxpNrTNSEgB66LBxcJk1b24ViR=T-fkqo07wxMFywpQ@mail.gmail.com> <20180617053703.19856-1-newren@gmail.com> <d62d834a-58dd-590a-cf71-028220323bf9@talktalk.net> <nycvar.QRO.7.76.6.1806172048270.77@tvgsbejvaqbjf.bet>
 <0ead1e75-98e9-8357-3e8d-2ff2f3cc5cc0@talktalk.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:45qeUJq2RpsON6ID17ru1fWuY/L7z9fZ33S0rWLi16uklCPObzV
 MEiTZoHa8idx50QkrlHx0TdIJzKaiQZDx7u7uvLODGgLFLo+/Ak9IKZCbaxMqdBz+O6sDiq
 YFFZ1/g2J8GIgKP5GckO/dPSwt7JDykKKN6iKBeDXf0+oJl3aBL8ILf1L5PvPn12hlvtLyN
 0ycP46a+sHmd8UH1nRhyw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:5pUjcgwnGRE=:Y0aRhcvMRw50bhkfeV//4k
 bVg7QxbR7QlaJtdgp3pmudbfsPkPgxIwX36TQkVOtrrS+93aT9UdXeL6C8jqw5Co+MfIAueV5
 LEnVQMIdeo0glKPpCRvGFCzVi/E7D34nNDcU8aJtRIHkFziO7AFGfYzjSy9bIp3ruqQft6N6q
 pGSPyTOsZqOxzv17+pXs2I0Mgtb33MeaVEbbCmWS6RVurKQtujDZB+IX4BGks2Gkpy+Pule31
 d+oDwzPjJN+WNj6HuBQC7O3KHo4ZcvU0JNZ0j9Jhke1CcGNkcv2Z61luNs6Wj/qi8wK/YVkXb
 0HExe6MsmmebMhZc6TtPXM0UoscReJzcUE8a3QevNnqJ0FdgPFuOOeesoik3/iFFN0WK40rsS
 3nGnXBtlotIpHgwUsWwKistdGqrlRMvBOk7BvZ9X0/kYWE+ijfoNsbGfw/CsJf8TrGc2BHfLZ
 futi8u0S70SzQlpt8pWltLPQJ4Wu4VpW4CLnNDQJxVHAke3K35Tqow+1Apu4Q/evVWm6C+S1z
 aD8YD8SHXNBCWls/NPgUPnlUgt2FfyNC3XxIWNccGV/SBVIgPJdNlNSMl/bKxNJcPAhJxJQzO
 u0DAeGra7OZyYOzwr2BGopVyEsBjijQwDdj0oIinjQrAF4URUDtuCscA4IOi5UfRA2XHmlGFL
 FYc2ZS1TfZgVagBJq/PKbWDQxHo7o784yz+18jKkP4Rvapd187uY21BQJ3vQGR46qfblpOQxG
 YdL/1CauPX5nfeCSg8hf6TZq/RvO01gITfIenFJ+dMQ8Ywgh/JZ4/6784/q95271KWq/K3XvX
 to3MVPU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On Mon, 18 Jun 2018, Phillip Wood wrote:

> On 17/06/18 20:28, Johannes Schindelin wrote:
> > 
> > On Sun, 17 Jun 2018, Phillip Wood wrote:
> > 
> >> On 17/06/18 06:37, Elijah Newren wrote:
> >>> Ever since commit 18633e1a22 ("rebase -i: use the rebase--helper
> >>> builtin", 2017-02-09), when a commit marked as 'reword' in an
> >>> interactive rebase has conflicts and fails to apply, when the rebase
> >>> is resumed that commit will be squashed into its parent with its
> >>> commit message taken.
> >>>
> >>> The issue can be understood better by looking at commit 56dc3ab04b
> >>> ("sequencer (rebase -i): implement the 'edit' command", 2017-01-02),
> >>> which introduced error_with_patch() for the edit command.  For the
> >>> edit command, it needs to stop the rebase whether or not the patch
> >>> applies cleanly.  If the patch does apply cleanly, then when it
> >>> resumes it knows it needs to amend all changes into the previous
> >>> commit.  If it does not apply cleanly, then the changes should not
> >>> be amended.  Thus, it passes !res (success of applying the 'edit'
> >>> commit) to error_with_patch() for the to_amend flag.
> >>>
> >>> The problematic line of code actually came from commit 04efc8b57c
> >>> ("sequencer (rebase -i): implement the 'reword' command", 2017-01-02).
> >>> Note that to get to this point in the code:
> >>>    * !!res (i.e. patch application failed)
> >>>    * item->command < TODO_SQUASH
> >>>    * item->command != TODO_EDIT
> >>>    * !is_fixup(item->command) [i.e. not squash or fixup]
> >>> So that means this can only be a failed patch application that is
> >>> either a pick, revert, or reword.  For any of those cases we want a
> >>> new commit, so we should not set the to_amend flag.
> >>
> >> Unfortunately I'm not sure it's that simple. Looking and do_pick()
> >> sometimes reword amends HEAD and sometimes it does not. In the
> >> "normal" case then the commit is picked and committed with '--edit'.
> >> However when fast-forwarding the code fast forwards to the commit to
> >> be reworded and then amends it. If the root commit is being reworded
> >> it takes the same code path. While these cases cannot fail with
> >> conflicts, it is possible for the user to cancel the commit or for
> >> them to fail due to collisions with untracked files.
> >>
> >> If I remember correctly the shell version always picks the commit and
> >> then calls 'git commit --amend' afterwards which is less efficient
> >> but consistent.
> >>
> >> I'm afraid I don't have a simple solution for fixing this, as
> >> currently pick_commits() does not know if the commit was called with
> >> AMEND_MSG, I guess that means adding some kind of flag for do_pick()
> >> to set.
> > 
> > Oh, you're right, the fast-forwarding path would pose a problem. I
> > think there is an easy way to resolve this, though: in the case that
> > we do want to amend the to-be-reworded commit, we simply have to see
> > whether HEAD points to the very same commit mentioned in the `reword`
> > command:
> 
> That's clever, I think to get it to work for rewording the root commit,
> it will need to do something like comparing HEAD to squash-onto as well.

... because squash-onto is a fresh, empty root commit (to be "amended"
when a non-root commit is to be picked as a new root commit). Good point.

> > -- snip --
> > diff --git a/sequencer.c b/sequencer.c
> > index 2dad7041960..99d33d4e063 100644
> > --- a/sequencer.c
> > +++ b/sequencer.c
> > @@ -3691,10 +3691,22 @@ static int pick_commits(struct todo_list
> > *todo_list, struct replay_opts *opts)
> >                                         intend_to_amend();
> >                                 return error_failed_squash(item->commit, opts,
> >                                         item->arg_len, item->arg);
> > -                       } else if (res && is_rebase_i(opts) && item->commit)
> > +                       } else if (res && is_rebase_i(opts) && item->commit) {
> > +                               int to_amend = 0;
> > +
> > +                               if (item->command == TODO_REWORD) {
> > +                                       struct object_id head;
> > +
> > +                                       if (!get_oid("HEAD", &head) &&
> > +					    !oidcmp(&item->commit->object.oid,
> > +                                                   &head))
> > +                                               to_amend = 1;

This would now become

					if (!get_oid("HEAD", &head) &&
					    (!oidcmp(&item->commit->object.oid,
						     &head) ||
					     (opts->have_squash_onto &&
					      !oidcmp(&opts->squash_onto,
						      &head))))
						to_amend = 1;

This is awfully indented, so a better idea would probably be to avoid the
extra block just to declare `head`:


-                       } else if (res && is_rebase_i(opts) && item->commit)
+                       } else if (res && is_rebase_i(opts) && item->commit) {
+                               int to_amend = 0;
+                               struct object_id oid;
+
+				/*
+				 * If we fast-forwarded already, or if we
+				 * are about to create a new root commit,
+				 * we definitely want to amend, otherwise
+				 * we do not.
+				 */
+                               if (item->command == TODO_REWORD &&
+				    !get_oid("HEAD", &oid) &&
+				    (!oidcmp(&item->commit->object.oid, &oid) ||
+				     (opts->have_squash_onto &&
+				      !oidcmp(&opts->squash_onto, &head))))
+					to_amend = 1;
+
                                return res | error_with_patch(item->commit,
                                        item->arg, item->arg_len, opts, res,
-                                       item->command == TODO_REWORD);
+                                       to_amend);
+                       }
                } else if (item->command == TODO_EXEC) {


What do you think?

And: could you perchance add a regression test for a failing pick onto
squash-onto (I am desperately in need of sleeping, otherwise I would do it
myself)? Something that executes `reset [new root]` and then `pick abcdef`
where abcdef would overwrite an untracked file should trigger this
relatively easily.

Thanks,
Dscho
