Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BCD9B20798
	for <e@80x24.org>; Sat, 14 Jan 2017 18:03:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751210AbdANSDU (ORCPT <rfc822;e@80x24.org>);
        Sat, 14 Jan 2017 13:03:20 -0500
Received: from mout.gmx.net ([212.227.15.19]:53344 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750807AbdANSDT (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Jan 2017 13:03:19 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LfC00-1cmO5k3AyW-00omcj; Sat, 14
 Jan 2017 18:56:12 +0100
Date:   Sat, 14 Jan 2017 18:56:10 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org, Kevin Daudt <me@ikke.info>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>,
        Stephan Beyer <s-beyer@gmx.net>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 06/38] sequencer (rebase -i): implement the 'edit'
 command
In-Reply-To: <xmqq7f60kssh.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1701141855180.3469@virtualbox>
References: <cover.1481642927.git.johannes.schindelin@gmx.de> <cover.1483370556.git.johannes.schindelin@gmx.de> <736f100f4c219ee5c81e1e7b664128785df80521.1483370556.git.johannes.schindelin@gmx.de> <xmqq7f60kssh.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:EBL2QUTdhdaDLEcwUtls6h5uigKEOr6tZ941H5aSNa/c4XK4lDX
 pC3VHBWOBdGPMHSMjlc8Zm/aYNVhSspV2FuTiIQ2wYB9EBGCjCNzkNnhwKUBWbULiHUaTZf
 FQ4yBKUJ8SqI9B5i5sE9rTY2VD9Xg/zgowDYDeQtfqkmvI8v1FQ/rE9GgeRG4pywhFqEAMz
 s1tAFMA+NqrbPAuh4cZKg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:oGcnuEwOm5g=:7gviJV6gbG/DO2yN16FVmq
 JsLK4I+Y+nDyUhaxh0I1wn2IFkYoRIE5uWi0jaVnViVzYQyKtKbhC/Lsd87L1M3mVmV7/rJKA
 NWzkP4JGVQV9ZeIrjPUcpmKjel381ZFI1/+AmpPycKuVQ3xuSmra37+P3O2DqNt25mt9m3h9z
 FuEU4UMOJUY/S4JGFybf/Jck4L2C4JYhH2HrT9mSAcc6FvonnDXfNrPhAJaAbqq2GJo3nFxLP
 lHybMOU3stW1W+3hH9lCYqdCIRYHeFbPgGBThmDWqWXLmfZasTrTCmVUOMxJjlWEifhhbxZC8
 jJ8yvPT6CdeOahUA0WhLY3pTWMZSFywMYepg6BdOa12W5FMK+U9IusY5EU7b1D+xThe3/eay6
 +vz6WssZbh2LfWbM++FnKwaE/xCg3imhSZlFFOUIKW+O+s0Cd+P3WO4hYav5pgBUrsqk124W4
 9Pn1Ibp4rt2PzjzJJI+yXh2Ni2joCqmkUbk/JeuS0FvCFVXzXqjFyT17T2svg3EO0Uzvr1xqd
 LuTjpshGNnIMHF+GNIYrJDNc9gzt4CWa+uZ61YhSgelAAuFm1URxJTHjmr9JymOD4grVDkiou
 BudiVqah7vpKScjiGsdYlrzlGP2bqSRXfKIJOWMuQvBEGMPgw3eHKoRJGt412rrRC0su8LLDQ
 W2vboy4yBIsk6nqAzT6yHvvwaM5JJnzqNpTFpvnIkQ1pDT1XV3dA4baSmlVyc5W76kzIax6w5
 ToyRh6Z/B/3+buuR6fzBgUUrVSxv08rbBukb25lQG9TUqu+dVqCDC5QvkgQYnTiWxwD9XxzlJ
 fJ0o8v+
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, 12 Jan 2017, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > +static int make_patch(struct commit *commit, struct replay_opts *opts)
> > +{
> > +	struct strbuf buf = STRBUF_INIT;
> > +	struct rev_info log_tree_opt;
> > +	const char *subject, *p;
> > +	int res = 0;
> > +
> > +	p = short_commit_name(commit);
> > +	if (write_message(p, strlen(p), rebase_path_stopped_sha(), 1) < 0)
> > +		return -1;
> > +
> > +	strbuf_addf(&buf, "%s/patch", get_dir(opts));
> > +	memset(&log_tree_opt, 0, sizeof(log_tree_opt));
> > +	init_revisions(&log_tree_opt, NULL);
> > +	log_tree_opt.abbrev = 0;
> > +	log_tree_opt.diff = 1;
> > +	log_tree_opt.diffopt.output_format = DIFF_FORMAT_PATCH;
> > +	log_tree_opt.disable_stdin = 1;
> > +	log_tree_opt.no_commit_id = 1;
> > +	log_tree_opt.diffopt.file = fopen(buf.buf, "w");
> > +	log_tree_opt.diffopt.use_color = GIT_COLOR_NEVER;
> > +	if (!log_tree_opt.diffopt.file)
> > +		res |= error_errno(_("could not open '%s'"), buf.buf);
> > +	else {
> > +		res |= log_tree_commit(&log_tree_opt, commit);
> > +		fclose(log_tree_opt.diffopt.file);
> > +	}
> > +	strbuf_reset(&buf);
> > +
> > +	strbuf_addf(&buf, "%s/message", get_dir(opts));
> > +	if (!file_exists(buf.buf)) {
> > +		const char *commit_buffer = get_commit_buffer(commit, NULL);
> > +		find_commit_subject(commit_buffer, &subject);
> > +		res |= write_message(subject, strlen(subject), buf.buf, 1);
> > +		unuse_commit_buffer(commit, commit_buffer);
> > +	}
> > +	strbuf_release(&buf);
> > +
> > +	return res;
> > +}
> 
> Unlike the scripted version, where a merge is shown with "diff --cc"
> and a root commit is shown as "Root commit", this only deals with a
> single-parent commit.

Indeed. The reason is that we never encounter a merge commit (as we
explicitly do not handle --preserve-merges) nor root commits (as we
explicitly do not handle --root)

Ciao,
Johannes
