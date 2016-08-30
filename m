Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E4431F859
	for <e@80x24.org>; Tue, 30 Aug 2016 06:53:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757337AbcH3Gxj (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Aug 2016 02:53:39 -0400
Received: from mout.gmx.net ([212.227.17.22]:53045 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752641AbcH3Gxi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Aug 2016 02:53:38 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0MPIvU-1bj2mB3G3k-004PH6; Tue, 30 Aug 2016 08:53:31
 +0200
Date:   Tue, 30 Aug 2016 08:53:30 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: Re: [PATCH 14/22] sequencer: prepare for rebase -i's commit
 functionality
In-Reply-To: <xmqq8tvf8dmz.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1608300836030.129229@virtualbox>
References: <cover.1472457609.git.johannes.schindelin@gmx.de> <1d83fa095c03eac9abfd1038ff7791bae8ace984.1472457609.git.johannes.schindelin@gmx.de> <xmqq8tvf8dmz.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:la5fyTSjaab7ZLYSBaZIdsI2xP+6L7ENKO94rEAbwa1+cxih9u3
 o8vD3j2X4ydw/x7LREI+9b9d39xAwzTkq2/qMQF2P20p8Ea4cYdOoIVLjAya6Mvdrm4aNAx
 0cHkp4q+VdFgO6YAj4OaJHEo/toYaIGQhvZ6roQHHyvEFby1dfSacnwpn9p75EDVa4pH5Y8
 34tI87EiJRHu+Dy8ZjNtQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:iSFXNoMMbp4=:QE8mUWVtUF9sCGToH8bfC2
 SbXbrpjz2aOO4scpMbX+FUUpx0c4bTdajRs2ziaB+0Ors4X+aQ/PMUd6RaKKGM3mYRFCBQsXo
 gTaNg7W2CD+NcekRVTWo6XyYYkMIcW565ATHoqtHChnw+KYIIw0L9qxosNwIY3iN2hklSoXyb
 RMHLIGLtiUx/ngJc5+ZbTrbUhTSG1PExAU0LSjcY76vVgL5yJsQnc+2jcxLL8chS2ksfewPPs
 E34Top15n987heloClVFzLrMvPzBLxTh9LPssSbRj37gu+8IecUvve4DgeHmEIQGXC2olR7V0
 cdM/wyYZcPo2uuRseGvhycF21Pa2XPkJqB7SvKJf7F0wo4U1lkkKU016ZWi2zQ7/RnaYVDmOw
 8qyKlmMngCuJtg+/Joj65zW5xKgZnJAKTGX+As7ACT+tXEoZ0wU6JahJc30yKopw+4bU0DtrG
 F+11Qf2krSsB6fYy2kwppRbtDtWrBDyi1zMQQQZigjUX5VDRqToqCeMrqdOoes/msSoFIg8JT
 s/7mzrhDwr6XTZBPndhRbpGvM8eAtGeAcBXikWU8mmHUWfdrvTBKrtjhcFqkXxW6xg+XCagpF
 HN//QQFO+LOjAwCUUxiZptkRA+q9DFk6LfRmVcda8TyR8GiCfgal1+NaeCEKEg5HGjYTTtf+P
 ckUJODKwwKKZLQq9t71mbfGKOMu+/Lr4Wv2jDpSe5scCB69aCfVdoj35F/WM/ZZOrYp58tfr2
 uaKtn0mjlSrZugCDRI02UqKjS2sxtoQ/9z7xj/7dpkk2M4PmKW3cQPxtS3/VLSEc+XlvwzTEJ
 ZKDxEMU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 29 Aug 2016, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > +/* We will introduce the 'interactive rebase' mode later */
> > +#define IS_REBASE_I() 0
> 
> I do not see a point in naming this all caps.

Old habit. Macros are all-caps.

> The use site would be a lot more pleasant to read when the reader does
> not have to care if this is implemented as a preprocessor macro or a
> helper function.

I converted this to a helper function.

> > @@ -377,20 +387,72 @@ static int is_index_unchanged(void)
> >  	return !hashcmp(active_cache_tree->sha1, head_commit->tree->object.oid.hash);
> >  }
> >  
> > +static char **read_author_script(void)
> > +{
> > +	struct strbuf script = STRBUF_INIT;
> > +	int i, count = 0;
> > +	char *p, *p2, **env;
> > +	size_t env_size;
> > +
> > +	if (strbuf_read_file(&script, rebase_path_author_script(), 256) <= 0)
> > +		return NULL;
> > +
> > +	for (p = script.buf; *p; p++)
> > +		if (skip_prefix(p, "'\\\\''", (const char **)&p2))
> > +			strbuf_splice(&script, p - script.buf, p2 - p, "'", 1);
> > +		else if (*p == '\'')
> > +			strbuf_splice(&script, p-- - script.buf, 1, "", 0);
> > +		else if (*p == '\n') {
> > +			*p = '\0';
> > +			count++;
> > +		}
> 
> Hmph.  What is this loop doing?  Is it decoding a sq-quoted buffer
> or something?  Don't we have a helper function to do that?

Well, it is not just decoding an sq-quoted buffer, but several lines with
definitions we sq-quoted ourselves, individually.

The quote.[ch] code currently has no code to dequote lines individually.

At this point, I would prefer to keep this code as-is, as I tested it over
the course of months and do not want to introduce regressions *now*.

> > +	env_size = (count + 1) * sizeof(*env);
> > +	strbuf_grow(&script, env_size);
> > +	memmove(script.buf + env_size, script.buf, script.len);
> > +	p = script.buf + env_size;
> > +	env = (char **)strbuf_detach(&script, NULL);
> > +
> > +	for (i = 0; i < count; i++) {
> > +		env[i] = p;
> > +		p += strlen(p) + 1;
> > +	}
> > +	env[count] = NULL;
> > +
> > +	return env;
> > +}
> > +
> >  /*
> >   * If we are cherry-pick, and if the merge did not result in
> >   * hand-editing, we will hit this commit and inherit the original
> >   * author date and name.
> >   * If we are revert, or if our cherry-pick results in a hand merge,
> > - * we had better say that the current user is responsible for that.
> > + * we had better say that the current user is responsible for that
> > + * (except, of course, while running an interactive rebase).
> >   */
> 
> The added "(except, ...)" reads as if "even if we are reverting, if
> that is done as part of an interactive rebase, the authorship rule
> for a revert does not apply".
> 
> If that is not what you meant, i.e. if you did not mean to imply
> that "rebase -i" doing a revert is a normal thing, this needs to be
> rephrased to avoid the misinterpretation.

I rephrased it.

Ciao,
Dscho
