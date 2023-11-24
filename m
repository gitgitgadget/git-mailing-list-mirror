Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="xU8fmAm9";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="+F3qoPjC"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2a07:de40:b251:101:10:150:64:2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB02B10FB
	for <git@vger.kernel.org>; Fri, 24 Nov 2023 12:59:50 -0800 (PST)
Received: from relay2.suse.de (unknown [149.44.160.134])
	by smtp-out2.suse.de (Postfix) with ESMTP id D54501FDA9;
	Fri, 24 Nov 2023 20:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1700859588; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GJqyC6CpZFndpiUG8mtf3F/s+an9wzxzMednpc+iUao=;
	b=xU8fmAm9DwBay62JNqPfInVEZLiNQel1LYFZVxT5WqVP5eButJoMZu03SgfQZG+pnPnVgn
	SAvi4RPV+vUPTPNR9Xd0VZd3y8QdApOjGxrhColKfOmXdCHyUcB0MmAcyf4VDB+h7lh39K
	x0VqATngQGv2eXY+nXBwMqaWV37tZJw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1700859588;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GJqyC6CpZFndpiUG8mtf3F/s+an9wzxzMednpc+iUao=;
	b=+F3qoPjCtdiJCpWbxKy/fN8Cn1Sjlh67HWjpru2AFKGc4e9enEaZhzJvcdQaY5e609hTxm
	exxNMynIrSFd4gAA==
Received: from kitsune.suse.cz (kitsune.suse.cz [10.100.12.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by relay2.suse.de (Postfix) with ESMTPS id 094502C142;
	Fri, 24 Nov 2023 20:59:46 +0000 (UTC)
Date: Fri, 24 Nov 2023 21:59:45 +0100
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: Oliver Bandel <oliver@first.in-berlin.de>
Cc: git@vger.kernel.org
Subject: Re: "git overlay" - command for overlaying branches
Message-ID: <20231124205945.GA9696@kitsune.suse.cz>
References: <n46dskd3hudzssaam56jesxr5elzdvs3asurqvbxkgsdcqitjs@qlufclnnjpsq>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <n46dskd3hudzssaam56jesxr5elzdvs3asurqvbxkgsdcqitjs@qlufclnnjpsq>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spamd-Bar: +++++++++++++++++++++
X-Spam-Score: 21.25
X-Rspamd-Server: rspamd1
X-Rspamd-Queue-Id: D54501FDA9
Authentication-Results: smtp-out2.suse.de;
	dkim=none;
	dmarc=fail reason="No valid SPF, No valid DKIM" header.from=suse.de (policy=none);
	spf=softfail (smtp-out2.suse.de: 149.44.160.134 is neither permitted nor denied by domain of msuchanek@suse.de) smtp.mailfrom=msuchanek@suse.de
X-Spamd-Result: default: False [21.25 / 50.00];
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
	 BAYES_HAM(-0.00)[21.53%];
	 RDNS_DNSFAIL(0.00)[];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_SPAM_SHORT(3.00)[1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 VIOLATED_DIRECT_SPF(3.50)[];
	 NEURAL_SPAM_LONG(3.50)[1.000];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_COUNT_TWO(0.00)[2];
	 HFILTER_HOSTNAME_UNKNOWN(2.50)[];
	 DMARC_POLICY_SOFTFAIL(0.10)[suse.de : No valid SPF, No valid DKIM,none]

On Fri, Nov 24, 2023 at 05:39:12PM +0100, Oliver Bandel wrote:
> Hello,
> 
> I'm adressing the problem with files separated from the main branch(es),
> which currently might be (more or less) solved with either submodules or subtrees.
> I want to suggest a new command here.
> 
> As usecase-example I assume a project that has 'branch_a' and 'branch_b'
> with some files may be identical, some different between them.
> I assume that the (classical) way the files are handled
> by belonging to those branches is intended.
> 
> Then say later I want to add more files to these branches,
> but don't want to commit them in either of these existing branches.
> Instead a branch 'branch_addons' is created, which solely contains
> files that are used in 'branch_a' as well as 'branch_b'.

Now you can merge branch_addons onto branch_a and branch_b and be done.

Unfortunately, git does not provide 'theirs' merge strategy while 'ours'
is provided - somewhat asymmetrical.

Thanks

Michal
