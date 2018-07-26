Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 66ABF1F597
	for <e@80x24.org>; Thu, 26 Jul 2018 10:48:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729074AbeGZMEZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Jul 2018 08:04:25 -0400
Received: from mout.gmx.net ([212.227.17.21]:44695 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728998AbeGZMEZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Jul 2018 08:04:25 -0400
Received: from [192.168.0.129] ([37.201.195.94]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LlV4F-1gJ4QZ2s7D-00bLEw; Thu, 26
 Jul 2018 12:48:00 +0200
Date:   Thu, 26 Jul 2018 12:47:57 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Stefan Beller <sbeller@google.com>
cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        git <git@vger.kernel.org>
Subject: Re: [PATCH v2 0/6] git-submodule.sh: convert part of cmd_update to
 C
In-Reply-To: <CAGZ79kZtrmjODGi1j-HRbchZYuALHnms22=wWBV1AF+zUBru_g@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1807261238160.71@tvgsbejvaqbjf.bet>
References: <20180717002654.120375-1-sbeller@google.com> <xmqqmuupogei.fsf@gitster-ct.c.googlers.com> <CAGZ79kZtrmjODGi1j-HRbchZYuALHnms22=wWBV1AF+zUBru_g@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:VA7nqEGA5QkjDvXLu3Lj8QXlgtKg1UPA913/JT8kKUjH2zmP41z
 GNZOU/wGeNfiaJsDWfU+Vzkjv4ImOpqhj8GyWYC+ZisTH8VYDUIvlZGJXgFZnHeAKEbTTab
 l61wTMxzSRnhPLO2l5aqBLW03SI1L6wekOVmPZUwzeBAeNVrgebrBwCBaO/YGcpjZWmOVyo
 /OrQOVhR9TKAGsV2oq+CQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:1wC8k9tNR34=:DP6b7vjDMx9YCK/8+LElBF
 RuOez2gG5sdLGiktnc9wGqNJSN0CwuPCdoSf7CHk35quqL12VRxQXNVLBQgnb2jwIv/EMZv3O
 xGLgglYgCm5mJ5Keu+hff4SPfDQ2XqqdPuWbTMj0t/ic0JKGPK/LUDD2tNhfVvGWnqtlCZ2aM
 7B3gXaz3AQ4++FV/AqoDvC6A6XdsDj+XRk8jzrxvZJUYPuGSZEYH7vyLlQVPKEQP1M1hWxjy0
 4zwcLzDK+fqYhrwFakP+RkLdlG20NH62VRmb7COz1p6WB6lOlJU8Cw7nqGPG0gWJv/QpO9IaF
 oyj2pn9AOwRC9COG1+8q78+OeW3Yau7JD7ZCgVPYUTdzswhndMwFCZbxHTyHG68n/gBsbyPz/
 i39LUpzSUBt4lucmFl+wevqqzDlMpx8zxsTt21ugl3YSX4QMd9f3zcdn0HahL8UwSVmDhPuR5
 soRJUc+6Zclls7OQuMtjQLZoYcQ4Dwlokl1eBrJ3bYZHmBmP5l+tbl/WF+WDC5pQ0HcMlFGKi
 CH0ThwN5mYjuSt/1deFm0/UaWYdzHpTHFlVJDLVcD7E7YYf+y51/5ebBJ+Div0Oglb2okDnsq
 uC46mpFgXrur1mUrvWnudUZIHOywsqKgIlHoBXspNYwvBNUawu0KBdW3rrlMyhqGdpqo37h2H
 03j5gROOMMjTXk7y3fCNEFZ2pYeXGU5YCJsta/tzq7zOqf/lkIVRch586z+w2+o9mizS9O+4G
 6n/qA3LPNUXPtd95hXwJsz53PX5eZJpyDcTP5Y2ySjHFVDSnCjrt+kertME+QR8nMX0vM+Stn
 9DtQ2Sh
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stefan,

On Tue, 17 Jul 2018, Stefan Beller wrote:

> > A tangent.
> >
> > Because this "-- " is a conventional signature separator, MUAs like
> > Emacs message-mode seems to omit everything below it from the quote
> > while responding, making it cumbersome to comment on the tbdiff.
> >
> > Something to think about if somebody is contemplating on adding more
> > to format-patch's cover letter.
> 
> +cc Eric who needs to think about this tangent, then.
> https://public-inbox.org/git/20180530080325.37520-1-sunshine@sunshineco.com/

I think this is just a natural fall-out from the users' choice of mail
program. Personally, I have no difficulty commenting on anything below the
`--` separator.

FWIW GitGitGadget follows the example of the `base-commit` footer and
places this information *above* the `--` separator.

> > >> 1:  d4e1ec45740 ! 1:  bbc8697a8ca git-submodule.sh: align error reporting for update mode to use path
> > >>     @@ -6,7 +6,6 @@
> > >>          on its path, so let's do that for invalid update modes, too.
> > >>
> > >>          Signed-off-by: Stefan Beller <sbeller@google.com>
> > >>     -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
> > >>
> > >>      diff --git a/git-submodule.sh b/git-submodule.sh
> > >>      --- a/git-submodule.sh
> >
> > This is quite unfortunate.  I wonder if it is easy to tell
> > range-diff that certain differences in the log message are to be
> > ignored so that we can show that the first patch is unchanged in a
> > case like this.  This series has 4 really changed ones with 2
> > otherwise unchanged ones shown all as changed, which is not too bad,
> > but for a series like sb/diff-colro-move-more reroll that has 9
> > patches, out of only two have real updated patches, showing
> > otherwise unchanged 7 as changed like this hunk does would make the
> > cover letter useless.  It is a shame that adding range-diff to the
> > cover does have so much potential.
> 
> Actually I thought it was really cool, i.e. when using your queued branch
> instead of my last sent branch, I can see any edits *you* did
> (including fixing up typos or applying at slightly different bases).

This is probably a good indicator that the practice on insisting on signing
off on every patch, rather than just the merge commit, is something to
re-think.

Those are real changes relative to the original commit, after all, and if
they are not desired, they should not be made.

> The sign offs are a bit unfortunate as they are repetitive.
> I have two conflicting points of view on that:
> 
> (A) This sign off is inherent to the workflow. So we could
> change the workflow, i.e. you pull series instead of applying them.
> I think this "more in git, less in email" workflow would find supporters,
> such as DScho (cc'd).
> 
> The downside is that (1) you'd have to change your
> workflow, i.e. instead of applying the patches at the base you think is
> best for maintenance you'd have to tell the author "please rebase to $X";
> but that also has upsides, such as "If you want to have your series integrated
> please merge with $Y and $Z" (looking at the object store stuff).
> 
> The other (2) downside is that everyone else (authors, reviewers) have
> to adapt as well. For authors this might be easy to adapt (push instead
> of sending email sounds like a win). For reviewers we'd need to have
> an easy way to review things "stored in git" and not exposed via email,
> which is not obvious how to do.
> 
> (B) The other point of view that I can offer is that we teach range-diff
> to ignore certain patterns. Maybe in combination with interpret-trailers
> this can be an easy configurable thing, or even a default to ignore
> all sign offs?

I thought about that myself.

The reason: I was surprised, a couple of times, when I realized long after
the fact, that some of my patches were changed without my knowledge nor
blessing before being merged into `master`.

To allow me to protest in a timely manner, I wanted to teach GitGitGadget
(which is the main reason I work on range-diff, as you undoubtedly suspect
by now) to warn me about such instances.

The range-diff patch series has simmered too long at this stage, though,
and I did not try to address such a "ignore <regex>" feature
*specifically* so that the range-diff command could be available sooner
than later. I already missed one major version, please refrain from
forcing me to miss another one.

Ciao,
Dscho
