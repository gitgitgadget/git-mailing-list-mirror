Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0AC351F859
	for <e@80x24.org>; Tue, 30 Aug 2016 10:29:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758053AbcH3K3W (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Aug 2016 06:29:22 -0400
Received: from mout.gmx.net ([212.227.15.15]:60712 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755095AbcH3K3G (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Aug 2016 06:29:06 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0LdHqj-1bEB5c1anx-00iW4p; Tue, 30 Aug 2016 12:28:57
 +0200
Date:   Tue, 30 Aug 2016 11:17:38 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 10/14] sequencer: lib'ify read_populate_opts()
In-Reply-To: <xmqq37ln9ubo.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1608301116450.129229@virtualbox>
References: <cover.1471968378.git.johannes.schindelin@gmx.de> <cover.1472219214.git.johannes.schindelin@gmx.de> <0fde7522953f71bd07e6aa7a15081dbf069aa6b6.1472219214.git.johannes.schindelin@gmx.de> <xmqq37ln9ubo.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:5ubmoKNOkIH32oUjmdAYaDWwDrIWx+iq1fVmCYUZ2MRjH6j1zUr
 JffmRZPdEZ8KbnF2pvRyLS+Fa8/coDDADicPtwhyLNEXMcZZXRC5khRalLqHsfcrhMtMCJo
 PqTbWhA2v5FuWqVg1BxWJq9CBZomJHLqhSpyV+evDf5545QEyk18TV0qYUo8tW9/W9YkVTu
 YeY6lbF35tnU+myQxutfQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:BtVSylxfw6w=:C6G5KXxzQ3pwMpR+7yhpgX
 +QHf7E8qc2k5ajL21JwNCW+wMBc6ptUAohKXSwMMP/jNOxg2gvQULuIeGpfjVnUgVt8utYAjp
 ydvxK2a+4ejyO8aOHnj3gYP836EREawNqqq9fN7v3MkDYg1CyUXuIAVR+UpHDvaHSXSRYlzFe
 1dUflpDG98goLri2nFcPr9sJmmh9QTeyqVCgW6a4Uthw50XIBXlZD2PHtWy/NsokJPJZEnKYu
 C4HGyfmlhTCaCTugct90WJr0QkLIeXo9Q1xBKeTaxvvFlboj1MjGME8jhknF/uXQtoBVWLWo0
 Jq7v00xXQ+t3IGp4l2/UciR1yu2B9xXtyqCGtw81fqB/q/B+pYk61mJ2YfHLgdixJzwErbtus
 lzeSPWDwQKmXUallXAkm1IWkIJ323+FtOI1NqZYB+nsPoMuU6db+ctNZoNJxE4qFQdlKbydm7
 PhJM1jeVIYPtL5zn3ZzAKEHeua/VXNEcOZ6FM/xRuhLguHzAwafySwOvS0wT06akagjBmHBtv
 L4dh0Kjr44MVaOfjBwc8uayxDr6bZSUx7+c85w2Nj/53LQMQc0fyvvs+tM6XLN18dGfwLJeKx
 iK5OtwJcIXZUdSd7gIFceC6fScoToeF+QOuFQBgcJCavfo4lVL4K3ZDkCEh2hztLSw0B+sL6u
 TuCNsbe29Cf0F9crR/Nf7u8c/Vuu3YKNspuesHErebHrbg8BBpkLj8IpkXQmXeKz9kx1G+OL2
 BWNfxfnPQnv+UNcg/MvUpO7iOcGvxD5k9Q6xtH/3WP1u3tFIrTheK8vfspUK7ab0ZyekzZt40
 cWagCGe
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 29 Aug 2016, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > Instead of dying there, let the caller high up in the callchain notice
> > the error and handle it (by dying, still).
> >
> > The only caller of read_populate_opts(), sequencer_continue() can
> > already return errors, so its caller must be already prepared to
> > handle error returns, and with this step, we make it notice an error
> > return from this function.
> >
> > So this is a safe conversion to make read_populate_opts() callable
> > from new callers that want it not to die, without changing the
> > external behaviour of anything existing.
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >  sequencer.c | 14 ++++++++------
> >  1 file changed, 8 insertions(+), 6 deletions(-)
> >
> > diff --git a/sequencer.c b/sequencer.c
> > index e11b24f..be6020a 100644
> > --- a/sequencer.c
> > +++ b/sequencer.c
> > @@ -808,12 +808,14 @@ static int populate_opts_cb(const char *key, const char *value, void *data)
> >  	return 0;
> >  }
> >  
> > -static void read_populate_opts(struct replay_opts **opts_ptr)
> > +static int read_populate_opts(struct replay_opts **opts)
> >  {
> >  	if (!file_exists(git_path_opts_file()))
> > -		return;
> > -	if (git_config_from_file(populate_opts_cb, git_path_opts_file(), *opts_ptr) < 0)
> > -		die(_("Malformed options sheet: %s"), git_path_opts_file());
> > +		return 0;
> > +	if (git_config_from_file(populate_opts_cb, git_path_opts_file(), *opts) < 0)
> > +		return error(_("Malformed options sheet: %s"),
> > +			git_path_opts_file());
> > +	return 0;
> 
> As discussed, perhaps have a comment immediately before calling
> config-from-file that says that the call could die when it is fed a
> syntactically broken file, but we ignore it for now because we will
> be writing the file we have written, or something?

Sure. I added a code comment.

I still think that it is a serious mistake for library functions to die().
But I have no time to take care of git_parse_source() right now.

Ciao,
Dscho
