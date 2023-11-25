Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="IMGz+kNR";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="1JPeZV9V"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EAFD10E4
	for <git@vger.kernel.org>; Sat, 25 Nov 2023 02:50:50 -0800 (PST)
Received: from relay2.suse.de (unknown [149.44.160.134])
	by smtp-out2.suse.de (Postfix) with ESMTP id 32D461FD5C;
	Sat, 25 Nov 2023 10:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1700909449; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z9zguLCbfWR7riCfkWYi0k0Ubxa52G65gCSwQKvWn8c=;
	b=IMGz+kNRbox34agNsLDcC3Ca7e7gRHwG4RCK6i3YZAJDgxlpilJU+FUSGL5v9R5awrAlCl
	8SkupnanX/s9PDiKcv8/uPTLjV1lPPymyIBzH9DkiTzgVlDb3/ZxESi5v/qav+AZbD0g5C
	uKKPxLOKRYOslzDsviIS0HLdFf6MnsE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1700909449;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z9zguLCbfWR7riCfkWYi0k0Ubxa52G65gCSwQKvWn8c=;
	b=1JPeZV9VoCF8egxmjCmxFAI3mGp1E3AXKMj1822ReSCx4uXWMJy3P2dQg7PvxLYH1ZpLOG
	NvsLjqv5q2C5K/Cg==
Received: from kitsune.suse.cz (kitsune.suse.cz [10.100.12.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by relay2.suse.de (Postfix) with ESMTPS id 7CC992C142;
	Sat, 25 Nov 2023 10:50:47 +0000 (UTC)
Date: Sat, 25 Nov 2023 11:50:46 +0100
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: Oliver Bandel <oliver@first.in-berlin.de>
Cc: git@vger.kernel.org
Subject: Re: "git overlay" - command for overlaying branches
Message-ID: <20231125105046.GB9696@kitsune.suse.cz>
References: <n46dskd3hudzssaam56jesxr5elzdvs3asurqvbxkgsdcqitjs@qlufclnnjpsq>
 <20231124205945.GA9696@kitsune.suse.cz>
 <647focpqwyild7dbmw7dloc5q2irijk7z77ymmfut5zdjrqhzy@xsle27m6flun>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <647focpqwyild7dbmw7dloc5q2irijk7z77ymmfut5zdjrqhzy@xsle27m6flun>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spamd-Bar: ++++++++++++++++++
X-Spam-Score: 18.25
X-Rspamd-Server: rspamd1
X-Rspamd-Queue-Id: 32D461FD5C
Authentication-Results: smtp-out2.suse.de;
	dkim=none;
	dmarc=fail reason="No valid SPF, No valid DKIM" header.from=suse.de (policy=none);
	spf=softfail (smtp-out2.suse.de: 149.44.160.134 is neither permitted nor denied by domain of msuchanek@suse.de) smtp.mailfrom=msuchanek@suse.de
X-Spamd-Result: default: False [18.25 / 50.00];
	 RDNS_NONE(1.00)[];
	 SPAMHAUS_XBL(0.00)[149.44.160.134:from];
	 TO_DN_SOME(0.00)[];
	 RWL_MAILSPIKE_GOOD(-1.00)[149.44.160.134:from];
	 HFILTER_HELO_IP_A(1.00)[relay2.suse.de];
	 HFILTER_HELO_NORES_A_OR_MX(0.30)[relay2.suse.de];
	 R_SPF_SOFTFAIL(4.60)[~all:c];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_TWO(0.00)[2];
	 RCVD_NO_TLS_LAST(0.10)[];
	 FROM_EQ_ENVFROM(0.00)[];
	 R_DKIM_NA(2.20)[];
	 MIME_TRACE(0.00)[0:+];
	 R_MIXED_CHARSET(0.56)[subject];
	 BAYES_HAM(-3.00)[100.00%];
	 RDNS_DNSFAIL(0.00)[];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_SPAM_SHORT(3.00)[1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 VIOLATED_DIRECT_SPF(3.50)[];
	 NEURAL_SPAM_LONG(3.50)[1.000];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_COUNT_TWO(0.00)[2];
	 HFILTER_HOSTNAME_UNKNOWN(2.50)[];
	 DMARC_POLICY_SOFTFAIL(0.10)[suse.de : No valid SPF, No valid DKIM,none]

On Sat, Nov 25, 2023 at 12:51:06AM +0100, Oliver Bandel wrote:
> Quoting  Michal Suchánek <msuchanek@suse.de> (snt: 2023-11-24 21:59 +0100 CET) (rcv: 2023-11-24 21:59 +0100 CET):
> > On Fri, Nov 24, 2023 at 05:39:12PM +0100, Oliver Bandel wrote:
> > > Hello,
> > > 
> > > I'm adressing the problem with files separated from the main branch(es),
> > > which currently might be (more or less) solved with either submodules or subtrees.
> > > I want to suggest a new command here.
> > > 
> > > As usecase-example I assume a project that has 'branch_a' and 'branch_b'
> > > with some files may be identical, some different between them.
> > > I assume that the (classical) way the files are handled
> > > by belonging to those branches is intended.
> > > 
> > > Then say later I want to add more files to these branches,
> > > but don't want to commit them in either of these existing branches.
> > > Instead a branch 'branch_addons' is created, which solely contains
> > > files that are used in 'branch_a' as well as 'branch_b'.
> > 
> > Now you can merge branch_addons onto branch_a and branch_b and be done.
> 
> Maybe my example or the explanation was not clear enough or stopped to early.
> 
> After a merge, I may have added files from one branch to another branch
> and some files might be changed during the merge operation and this is
> persistent then.
> 
> But the overlay would be a temporal situation and so no "pollution" with files from
> other branches would occur and no changes of the files with same names
> (some were just temporarily hidden).
> 
> In an overlay situation, all involved branches are checked out into the
> working dir (the non-hidden files are checked out) at the same time.
> All changes (change/add/commit) could then be done in one go (with 'git
> add' and 'git commit' as in the usual way), and all commits will only
> affect those branches where the changed files are comming from.
> This means editing more than one branch at the same time,
> committing to more than one branch at the same time,
> but not merging them.
> 
> After un-overloading, the temporarily overlayed files from other
> branches will be removed from the working dir by git.
> No merge has been done, but changes to more than one branch might have
> happened.
> 
> I hope it's more clear now, how that differs from normal merge-branches situation.

It's not clear why would anyone do that, though.

> 
> Ciao,
>   Oliver
> 
> P.S.: Changing sources and tests together but only publishing the code would be
>       easy this way.

And why would you do that?

Even if you wanted the git archive has option to exclude directories so
you could publish separate releases from one branch.

>       Just check out the sources, overlay the tests, do the work, commit
>       the changes and after un-overlaying the sources branch has no
>       "tests pollution", and no other tricks are needed then.

Since you detail how 'do the work' would commit the changes to both
branches at the same time that means that specific revision of the code
is tied to specific revision of the tests, different revisions would not
work together. If the overlay branch is used with multiple different
branches it will diverge, and will be compatible only with one of them
at any time.

Merging a specific revision of the overlay branch solves this problem.
It ties the correct revision of the shared branch together with the
correct revision of the separate files.

It's the same with the interface-implementation example you gave
earlier.

>       Also useful, when working with LaTeX documents and you temporarily
>       want to change the included extra files (or use the other layoutet
>       old version together with the current one) from a different
>       branch, but don't want the changes be permanently in your
>       currently preferred main branch (nevertheless change the main-doc
>       and the extra files in one go).

Don't really understand what you are trying to do here.

>       For those people who commit their passwords or private keys into git,
>       this also could increase security ;-)
>       For testing the code, the secrets are just overlayed.

Or not put those into project git in the first place. When the secrets
are in an 'overlay branch' in the same repository they are published
anyway.

Thanks

Michal
