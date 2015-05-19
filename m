From: Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: [PATCH v2] pull: handle --log=<n>
Date: Tue, 19 May 2015 23:43:52 +0200
Message-ID: <1432071832.14498.6.camel@kaarsemaker.net>
References: <1431956396-21788-1-git-send-email-pyokagan@gmail.com>
	 <5661061272076a1883cfde1087be4a42@www.dscho.org>
	 <xmqq617pda0r.fsf@gitster.dls.corp.google.com>
	 <6b905c01c9b57abc05fb49117c28c10e@www.dscho.org>
	 <CAPc5daVze4+8aLGPpZgxDnvKSwvQiaR=kRdwfAHXFYA7HChmMg@mail.gmail.com>
	 <1432070690.14498.4.camel@kaarsemaker.net>
	 <CAGZ79kaw_6Cq5SaLvJHrXDm9bh3+ovAddv9CQJ78m65MYF=SqA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Paul Tan <pyokagan@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue May 19 23:44:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YupIv-0000eK-Tv
	for gcvg-git-2@plane.gmane.org; Tue, 19 May 2015 23:44:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751769AbbESVn5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 May 2015 17:43:57 -0400
Received: from mail-wi0-f176.google.com ([209.85.212.176]:34829 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751275AbbESVn4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 May 2015 17:43:56 -0400
Received: by wicmx19 with SMTP id mx19so133436839wic.0
        for <git@vger.kernel.org>; Tue, 19 May 2015 14:43:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-type:mime-version:content-transfer-encoding;
        bh=WZnttFD0CoMc8NfnVbzt02punPTjZ63gfjGYmIxyUDU=;
        b=IqBlr1ypEZw3TfQFBset42EywAZ74SBrpyXCpdnRhrOfuvXrTJpdNOh/N96DfcW85r
         RYEhCaz8yYkS+SHLBxYCfYf6FGTvPE3vGikS6MO3KMJzFW+Hi0zhUuYPlsenHFbRwhgJ
         NCiu5uQH7tRaq6w3lYXyrn6plTKhVLkdLBmwIcqRCUlO0GdhSCF3x2euKdrY6DaAl+5T
         CD25FbrBIFFj8ArWNnPcWKidhtU+6M4u25lK0Ol/BJHJJOZpPfBy0ECiBl6L2z857NSw
         GvWvMJ/BleUVfksPkY1l8esoailYXb7SEw9GsKNo5XokZjAaOfPlrzaTfM2d0NylYzSK
         2oqQ==
X-Gm-Message-State: ALoCoQkdel3yfxt7RnImOSjUEm7MCZQocMrQZ2JrRymdG2K1oIWrpSGp2ZZpZ59O/O11AZGvKawE
X-Received: by 10.194.92.2 with SMTP id ci2mr55390783wjb.34.1432071834836;
        Tue, 19 May 2015 14:43:54 -0700 (PDT)
Received: from spirit.home.kaarsemaker.net (82-171-80-33.ip.telfort.nl. [82.171.80.33])
        by mx.google.com with ESMTPSA id j12sm23587357wjn.48.2015.05.19.14.43.53
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 May 2015 14:43:54 -0700 (PDT)
In-Reply-To: <CAGZ79kaw_6Cq5SaLvJHrXDm9bh3+ovAddv9CQJ78m65MYF=SqA@mail.gmail.com>
X-Mailer: Evolution 3.12.11-0ubuntu3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269407>

On di, 2015-05-19 at 14:33 -0700, Stefan Beller wrote:
> On Tue, May 19, 2015 at 2:24 PM, Dennis Kaarsemaker
> <dennis@kaarsemaker.net> wrote:
> > On di, 2015-05-19 at 06:57 -0700, Junio C Hamano wrote:
> >> On Tue, May 19, 2015 at 6:35 AM, Johannes Schindelin
> >> <johannes.schindelin@gmx.de> wrote:
> >> >
> >> > On 2015-05-18 20:18, Junio C Hamano wrote:
> >> >>
> >> >> So I dunno.  I really wish test_commit didn't create tags and either
> >> >> left the tagging to the calling script.
> >> >
> >> > Or maybe just add a --tag flag to `test_commit` and use that in all cases where the tags were actually needed. Yeah, I think I like that option best.
> >>
> >> Thanks for inferring what I wanted to say but left unsaid due to my
> >> stupidity and
> >> lack of proofreading. I meant to follow "either left to the caller"
> >> with "or with an
> >> option" ;-)
> >
> > I took a stab at this, adding a --tag option to test_commit and adding
> > the option to the test_commit calls that need it (or removing tests'
> > reliance on these tags where appropriate, or removing tests' workarounds
> > for dealing with these tags when they don't want them), and the result
> > is 59 files changed, 280 insertions(+), 281 deletions(-)
> 
> I guess most of the line changes are just adding the --tag?
> And I'd guess (281-280) that there is no huge code inside of test_commit
> either, so I'd assume it doesn't add clutter, but rather cleans up....

Full stat:

 t/t0100-previous.sh                        |  6 +++---
 t/t1011-read-tree-sparse-checkout.sh       |  2 +-
 t/t1403-show-ref.sh                        |  6 +++---
 t/t1430-bad-ref-name.sh                    |  2 +-
 t/t1450-fsck.sh                            |  4 ++--
 t/t2018-checkout-branch.sh                 |  4 ++--
 t/t2020-checkout-detach.sh                 |  8 ++++----
 t/t2030-unresolve-info.sh                  | 10 +++++-----
 t/t3200-branch.sh                          |  2 +-
 t/t3211-peel-ref.sh                        |  2 +-
 t/t3307-notes-man.sh                       |  4 ++--
 t/t3308-notes-merge.sh                     | 10 +++++-----
 t/t3309-notes-merge-auto-resolve.sh        | 30
+++++++++++++++---------------
 t/t3310-notes-merge-manual-resolve.sh      | 10 +++++-----
 t/t3311-notes-merge-fanout.sh              |  2 +-
 t/t3400-rebase.sh                          |  6 +++---
 t/t3404-rebase-interactive.sh              | 22 +++++++++++-----------
 t/t3406-rebase-message.sh                  |  6 +++---
 t/t3410-rebase-preserve-dropped-merges.sh  | 14 +++++++-------
 t/t3411-rebase-preserve-around-merges.sh   | 14 +++++++-------
 t/t3414-rebase-preserve-onto.sh            | 14 +++++++-------
 t/t3416-rebase-onto-threedots.sh           | 12 ++++++------
 t/t3418-rebase-continue.sh                 |  4 ++--
 t/t3421-rebase-topology-linear.sh          | 22 +++++++++++-----------
 t/t3425-rebase-topology-merges.sh          | 20 ++++++++++----------
 t/t3507-cherry-pick-conflict.sh            |  8 ++++----
 t/t3508-cherry-pick-many-commits.sh        |  6 +++---
 t/t3510-cherry-pick-sequence.sh            | 16 ++++++++--------
 t/t3511-cherry-pick-x.sh                   |  2 +-
 t/t4131-apply-fake-ancestor.sh             |  8 ++++----
 t/t4152-am-subjects.sh                     |  2 +-
 t/t4202-log.sh                             | 14 +++++++-------
 t/t4207-log-decoration-colors.sh           |  8 +++-----
 t/t4300-merge-tree.sh                      | 62 +++++++++++++++++++++++++++++---------------------------------
 t/t5407-post-rewrite-hook.sh               | 12 ++++++------
 t/t5509-fetch-push-namespaces.sh           |  4 ++--
 t/t5510-fetch.sh                           |  4 ++--
 t/t5514-fetch-multiple.sh                  |  2 +-
 t/t5571-pre-push-hook.sh                   |  2 +-
 t/t5704-bundle.sh                          |  5 +----
 t/t6009-rev-list-parent.sh                 | 18 +++++++++---------
 t/t6010-merge-base.sh                      | 24 ++++++++++++------------
 t/t6016-rev-list-graph-simplify-history.sh | 22 +++++++++++-----------
 t/t6019-rev-list-ancestry-path.sh          | 18 +++++++++---------
 t/t6101-rev-parse-parents.sh               |  8 ++++----
 t/t6111-rev-list-treesame.sh               |  2 +-
 t/t6300-for-each-ref.sh                    |  1 -
 t/t7003-filter-branch.sh                   | 16 ++++++++--------
 t/t7007-show.sh                            |  8 ++++----
 t/t7012-skip-worktree-writing.sh           |  2 +-
 t/t7060-wtstatus.sh                        |  6 +++---
 t/t7111-reset-table.sh                     |  6 +++---
 t/t7407-submodule-foreach.sh               |  2 +-
 t/t7512-status-help.sh                     |  6 +++---
 t/t7606-merge-custom.sh                    |  8 ++++----
 t/t7607-merge-overwrite.sh                 |  6 +++---
 t/t7608-merge-messages.sh                  |  4 ++--
 t/t9502-gitweb-standalone-parse-output.sh  |  2 +-
 t/test-lib-functions.sh                    |  9 ++++++++-
 59 files changed, 278 insertions(+), 281 deletions(-)

> > A test run on master with GIT_TEST_LONG set causes 1138 calls to
> > test_commit on my system, of which 255 now use the --tag option
> > (measured with a really crude hack that INCR's some keys in redis at
> > appropriate points in test_commit).
> 
> ... 255 out of 1138 is awesome IMHO! Do you see an improvement in time as
> well (as in "time make test" is X% faster overall) ?

I have not measured, but will.

> > Is this interesting enough to turn into a proper patch series?
> 
> I'd think this is worth making a real patch, definitely!

OK.
-- 
Dennis Kaarsemaker
www.kaarsemaker.net
