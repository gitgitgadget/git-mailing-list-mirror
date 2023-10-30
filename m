Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 402C06AA7
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 10:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A1B4A2
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 03:40:44 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out2.suse.de (Postfix) with ESMTP id A95201FEEF;
	Mon, 30 Oct 2023 10:40:42 +0000 (UTC)
Received: from kitsune.suse.cz (kitsune.suse.cz [10.100.12.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by relay2.suse.de (Postfix) with ESMTPS id 5A896A3E04;
	Mon, 30 Oct 2023 10:40:42 +0000 (UTC)
Date: Mon, 30 Oct 2023 11:40:41 +0100
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] git-push: more visibility for -q option
Message-ID: <20231030104041.GJ6241@kitsune.suse.cz>
References: <20231020184627.14336-1-msuchanek@suse.de>
 <xmqqwmvhoy57.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqwmvhoy57.fsf@gitster.g>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Level: 
X-Spamd-Bar: /
Authentication-Results: smtp-out2.suse.de;
	dkim=none;
	dmarc=none;
	spf=softfail (smtp-out2.suse.de: 149.44.160.134 is neither permitted nor denied by domain of msuchanek@suse.de) smtp.mailfrom=msuchanek@suse.de
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [-0.27 / 50.00];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-3.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 DMARC_NA(0.20)[suse.de];
	 R_SPF_SOFTFAIL(0.60)[~all:c];
	 RWL_MAILSPIKE_GOOD(0.00)[149.44.160.134:from];
	 VIOLATED_DIRECT_SPF(3.50)[];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_TWO(0.00)[2];
	 NEURAL_HAM_SHORT(-1.00)[-1.000];
	 RCVD_NO_TLS_LAST(0.10)[];
	 FROM_EQ_ENVFROM(0.00)[];
	 R_DKIM_NA(0.20)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_COUNT_TWO(0.00)[2];
	 BAYES_HAM(-0.76)[84.19%]
X-Spam-Score: -0.27
X-Rspamd-Queue-Id: A95201FEEF

Hello,

On Fri, Oct 20, 2023 at 01:08:04PM -0700, Junio C Hamano wrote:
> Michal Suchanek <msuchanek@suse.de> writes:
> 
> > The -v option listed at the top as option al parameter while -q is not.
> 
> "as option al parameter" - ECANNOTPARSE.  Probably
> 
>     The `-v` option is shown in the SYNOPSIS section near the top,
>     but `-q` is not shown anywhere there.
> 
> or something, I think.  I agree showing it next to "-v" would make
> the most sense.

when rebasing to current master I see this is already applied with the
fixed commit message, great!

Thanks

Michal

> 
> >
> > List -q alongside -v.
> >
> > Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> > ---
> >  Documentation/git-push.txt | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
> > index 5b4edaf4a8..003bc7d9ce 100644
> > --- a/Documentation/git-push.txt
> > +++ b/Documentation/git-push.txt
> > @@ -10,7 +10,7 @@ SYNOPSIS
> >  --------
> >  [verse]
> >  'git push' [--all | --branches | --mirror | --tags] [--follow-tags] [--atomic] [-n | --dry-run] [--receive-pack=<git-receive-pack>]
> > -	   [--repo=<repository>] [-f | --force] [-d | --delete] [--prune] [-v | --verbose]
> > +	   [--repo=<repository>] [-f | --force] [-d | --delete] [--prune] [-q | --quiet] [-v | --verbose]
> 
> Yup, the change makes sense.  We may want to wrap the first line to
> a more reasonable length in a separate commit, and when that
> happens, we probably would want to start [-v] [-q] on a separate
> line as well, but for now this would do.
> 
