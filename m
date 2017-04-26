Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3607E207D6
	for <e@80x24.org>; Wed, 26 Apr 2017 11:31:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2999399AbdDZLbg (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Apr 2017 07:31:36 -0400
Received: from mout.gmx.net ([212.227.15.19]:56310 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1948571AbdDZLbf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Apr 2017 07:31:35 -0400
Received: from virtualbox ([95.208.59.147]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LoVvG-1djZwJ2V90-00ga4P; Wed, 26
 Apr 2017 13:31:21 +0200
Date:   Wed, 26 Apr 2017 13:31:20 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Jeff King <peff@peff.net>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Philip Oakley <philipoakley@iee.org>
Subject: Re: [PATCH v2 7/9] rebase -i: skip unnecessary picks using the
 rebase--helper
In-Reply-To: <20170426105503.wewlbefrsdmjqnob@sigill.intra.peff.net>
Message-ID: <alpine.DEB.2.20.1704261321470.3480@virtualbox>
References: <cover.1472833365.git.johannes.schindelin@gmx.de> <cover.1493128210.git.johannes.schindelin@gmx.de> <ecab086a62e96388f4dfc7e36a679821fdc7c8c3.1493128210.git.johannes.schindelin@gmx.de> <20170426105503.wewlbefrsdmjqnob@sigill.intra.peff.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:OAEBFr2J4loaP8siz/JNOEdkY5/Zu/HJDu7e5H7FmO9aPYSWmAC
 uSXTfLKrXAzoJ7Jw4VUNqSezJataxsWGrN/xMSFiDJtBszYKOAuTpDfMUXvupV4D//3rcro
 cwAVFkE+xYc9OjaL32pvov8DOCpVibHh225ZujolVSD3ViJOxUqSzMKg8dZL3RF0ly1GB8K
 aZ7A3ht511aTVNjrHAeDA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:FFAFpOtS7hk=:pgluamiRNl6E3i1BJaFZ6R
 t/E2ANhPNa3oit8HiuCHPcmMBkwqM4w94n5ePScKe7U/7Qzg4wTOykBEhezsxowJnt5XNu7/H
 tLYnKa0WtY+uioaT/MBuuZlg2QYH2rThFfR9kKx+pTPbMG/1cqijijGNJFMFiO4RmjDx2MVDj
 76tH2XQtzXe2rWA8lVHiZuERIo5Q5/HYDt6AOZlcFgJaRdQMs4WLyU6qpTNKRAn+6t+tnTjlA
 w5eTQyFWiZP0B6RQQ+GtJzVQwiSIalATzokWuoVQBizFJUE/oqO4pAQZ5u5u/iiwp67ccUiO9
 a7OrrAzThAzIKBMdak7yAHov+C0LPZ9Fo2mMbwwJtH6xUDpQxIkjkjTUJ7CSuz1BizHqzUz8L
 djEXnoJSQavVL+Y0YYp3TC/4AczV8wNwe57Rx+8xH3HAimcE9idpd3T+9L4VuqcSqUC3UHQoq
 Cp08lVPrv0JQcFb7u54U70txJ/LNXe2I4i3Fiobdk4eACAYLohAlg8QkFGrnEsc6pHgY6Exec
 AKtb3D+2lSjsdbPTyTg8I+s9RLQBd/kqLXP2mywhx7XS2kUy0WD1jgsCPdCIDCE54ODo33971
 Hszv7L1bVBFHWV0Qnd0W6xlwFdVSCptAa5fr2q2ZGg4nUmQs6/Iv16+h7CjJ0cJZJX3edqd0L
 9B3e2Y8UoIEYvv58u4mnPt18JILlp47iRoJdZzf0AwboEWvdTTxxD7UEfKVpFEUDmgUAWf4iK
 82rBJw/EjAd9ncNI5VP74eNGVw+wOmU4RWLeuzRc+d9zfNE42Ae+o7EAQnZk8WCb1z9QIrRB4
 rkC9kbM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Wed, 26 Apr 2017, Jeff King wrote:

> On Tue, Apr 25, 2017 at 03:52:10PM +0200, Johannes Schindelin wrote:
> 
> > diff --git a/sequencer.c b/sequencer.c
> > index 3a935fa4cbc..bbbc98c9116 100644
> > --- a/sequencer.c
> > +++ b/sequencer.c
> > @@ -2616,3 +2616,93 @@ int check_todo_list(void)
> >  
> >  	return res;
> >  }
> > +
> > +/* skip picking commits whose parents are unchanged */
> > +int skip_unnecessary_picks(void)
> 
> Coverity warns of some descriptor leaks in this function (and in
> rearrange_squash). I think you get those emails, so I won't repeat the
> details here.

I do. The leaks in rearrange_squash() seem to be false positives (I will
have to have another look later, I spent way too many hours pouring over
those Coverity reports this week).

The leaks in skip_unnecessary_picks() are real, though, and I have a patch
to fix them this way:

-- snip --
Subject: [PATCH] sequencer: plug resource leak when skipping unnecessary picks

The resource leak only happens in case of an error writing or truncating
the file, therefore it seems less critical, but we should still fix it
nonetheless.

Discovered by Coverity.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sequencer.c b/sequencer.c
index e25a4e1180c..9c765e8850a 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2678,11 +2678,13 @@ int skip_unnecessary_picks(void)
 		if (write_in_full(fd, todo_list.buf.buf + offset,
 				todo_list.buf.len - offset) < 0) {
 			todo_list_release(&todo_list);
+			close(fd);
 			return error_errno(_("could not write to '%s'"),
 				rebase_path_todo());
 		}
 		if (ftruncate(fd, todo_list.buf.len - offset) < 0) {
 			todo_list_release(&todo_list);
+			close(fd);
 			return error_errno(_("could not truncate '%s'"),
 				rebase_path_todo());
 		}
-- snap --

> But I while looking at them I did notice something it didn't mention:
> 
> > +	if (i > 0) {
> > +		int offset = i < todo_list.nr ?
> > +			todo_list.items[i].offset_in_buf : todo_list.buf.len;
> > +		const char *done_path = rebase_path_done();
> > +
> > +		fd = open(done_path, O_CREAT | O_WRONLY | O_APPEND, 0666);
> > +		if (write_in_full(fd, todo_list.buf.buf, offset) < 0) {
> > +			todo_list_release(&todo_list);
> > +			return error_errno(_("could not write to '%s'"),
> > +				done_path);
> > +		}
> > +		close(fd);
> 
> This should probably check the result of open().

Indeed.

> I know write_in_full() will fail if fd is -1, but we'd rather show the
> user the errno from open(), not EBADF.

I guess Coverity follows that code path and determines that it is handled.

If only it would also follow the code paths of the FLEX_ARRAYs and figure
out that we play games with struct definitions whose last entries are
technically incorrect.

> Technically the free() calls from todo_list_release() can also munge
> errno before you print it. You might want to just call error_errno()
> first, then do the cleanup (including the missing close()).

Ah, you're right. I'll have to rework that patch I mentioned above.

> > +		fd = open(rebase_path_todo(), O_WRONLY, 0666);
> > +		if (write_in_full(fd, todo_list.buf.buf + offset,
> > +				todo_list.buf.len - offset) < 0) {
> > +			todo_list_release(&todo_list);
> > +			return error_errno(_("could not write to '%s'"),
> > +				rebase_path_todo());
> > +		}
> 
> Ditto here.

Right.

Ciao,
Dscho
