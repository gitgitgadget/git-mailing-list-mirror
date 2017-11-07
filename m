Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 631E6202A0
	for <e@80x24.org>; Tue,  7 Nov 2017 17:27:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758516AbdKGR1H (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Nov 2017 12:27:07 -0500
Received: from mout.web.de ([212.227.17.11]:53516 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1758510AbdKGR1F (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Nov 2017 12:27:05 -0500
Received: from localhost ([195.198.252.176]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Lo0V2-1ern483H1k-00g1Xm; Tue, 07
 Nov 2017 18:27:00 +0100
Date:   Tue, 7 Nov 2017 18:26:59 +0100
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 1/1] Introduce git add --renormalize .
Message-ID: <20171107172659.GA11119@tor.lan>
References: <xmqqshejq9mn.fsf@gitster.mtv.corp.google.com>
 <20171030162913.23164-1-tboegi@web.de>
 <xmqqvaimeixm.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqvaimeixm.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Provags-ID: V03:K0:YJrvm0eOfCOvd3uoS+n9qV94i1+DKtKPFkj2gs6Zx42O7ft2JKH
 sAoMoYekd44z8Z1VR6IshuURzJ9D6Qmx1vfzTdRyaKlp+3GkkNSbxaXpNgZdtV/iRDCAWGf
 s7fcD/M1PBP4041qGNvYDn4iiWP9Sd6GAUomy4tjMMtFAjsoBLFRfUuk+nEgxgSk9JNOkdr
 QGvUW/WXrSjU78wkD6s9A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:iTNz2/RYNTE=:WhPtwMEF7TniW3LxrzVwYp
 jeOducarLx8Sd9y/ize+hKIoAT1cCgzhITBxTz/6ucVgXJBYlJT2/Xysw+LuBS1GU4sWINDYR
 AqvkcQdgTaNXO6aqx5tLTGCfxLf3YafKvxYkUzxJv4PfHlAQCOKHgMpKSvBRo06+V/uzlawwr
 /ehpVMcBfJLnJZB+dH6tOR01Ecfl6wnI5Z8K8ecba2Vu4A2Gk7BFprt0c49m7/ogp3Ob1RPDk
 AAn3vPFKgGSK3Zm2Tcui/Xh3ZiMSjagx1xsEwLZfYdCunycokLmALjLnBf7Q9Rr17Li/s4JBY
 ZEAMbCO+BaEyZS82/G1jKD/ytzfqgHs4bD/9OaYcp7rhrD4OpEQicJS7W3dvj47/Zm8VovLIF
 JG455AuQkPW8kwvfKXqDWMOuK5I7q/ywPjAf4fBRX7DdOm9n9nP0omozMOI6yj4krQ6ikXfUJ
 xE3bIye8T/NEd1QgO5A4YZD0KRE4wWXVdnLdVCsaXH8ahW1nAaGNqhUGTwDQ2WTFXS51XSjz1
 2X2+i2AItp6UuKhkAO2DCaZdogho9y1bdj2ZZmsqTCbejgS8OStCXAXm05ggRscgtucJLb+Vo
 GI3n1BGrkO7zu2Qrr/2nzglofupHOyIe0R3JipwExpb/CpnI3w4pNOpTvtFxY2DmeIYKmbB/q
 xRK6tN2yvJNG7qrS6auIUAQB/g2Xo27lhp0juLpApE8NyIMNDdxPeQ+toBS3oV2Qdh7XdFRJ9
 KlU3cInzXsD2Ddtb31epFikYFdqzYZ+6N63GIf3rUT/4H41vPYFRaHJgQrdJmwdg5Q4PUrng/
 n5+UKXfW7NrohBYWFHMFHdNznZ0/Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[snip]
> 
> > @@ -175,6 +175,12 @@ for "git add --no-all <pathspec>...", i.e. ignored removed files.
> >  	warning (e.g., if you are manually performing operations on
> >  	submodules).
> >  
> > +--renormalize::
> > +	Normalizes the line endings from CRLF to LF of tracked files.
> > +	This applies to files which are either "text" or "text=auto"
> > +	in .gitattributes (or core.autocrlf is true or input)
> > +	--renormalize implies -u
> > +
> 
> OK.

I think the fact, that clean filters are re-run, and re-evaluated
in case they are changed, should be made more clear here.
I don't know how to explain it better that CRLF conversion and/or filters are
re-applied, this is an attempt:


--renormalize::
	Normalizes the line endings from CRLF to LF of tracked files,
	if the .gitattributes or core.autocrlf say so.
	Additionally the clean and ident filters, if any, are re-run.
	--renormalize implies -u





> 
> > +static int renormalize_tracked_files(const struct pathspec *pathspec, int flags)
> > +{
> > +	int i, retval = 0;
> > +
> > +	for (i = 0; i < active_nr; i++) {
> > +		struct cache_entry *ce = active_cache[i];
> > +
> > +		if (ce_stage(ce))
> > +			continue; /* do not touch unmerged paths */
> > +		if (!S_ISREG(ce->ce_mode) && !S_ISLNK(ce->ce_mode))
> > +			continue; /* do not touch non blobs */
> > +		if (pathspec && !ce_path_match(ce, pathspec, NULL))
> > +			continue;
> > +		retval |= add_file_to_cache(ce->name, flags | HASH_RENORMALIZE);
> 
> We are removing the entry and then adding the same entry under the
> same name, and iteration over the active_cache[] from 0 through
> active_nr should be safe, I guess.
> 
> > ...
> > -	add_new_files = !take_worktree_changes && !refresh_only;
> > +	add_new_files = !take_worktree_changes && !refresh_only && !add_renormalize;
> 
> If renormalize is given, we will *not* take new files, good.
> 
> > @@ -500,7 +521,10 @@ int cmd_add(int argc, const char **argv, const char *prefix)
> >  
> >  	plug_bulk_checkin();
> >  
> > -	exit_status |= add_files_to_cache(prefix, &pathspec, flags);
> > +	if (add_renormalize)
> > +		exit_status |= renormalize_tracked_files(&pathspec, flags);
> > +	else
> > +		exit_status |= add_files_to_cache(prefix, &pathspec, flags);
> >  
> >  	if (add_new_files)
> >  		exit_status |= add_files(&dir, flags);
> 
> OK.
> 
> > ...
> >  	int add_option = (ADD_CACHE_OK_TO_ADD|ADD_CACHE_OK_TO_REPLACE|
> >  			  (intent_only ? ADD_CACHE_NEW_ONLY : 0));
> > +	int newflags = HASH_WRITE_OBJECT;
> > +
> > +	if (flags & HASH_RENORMALIZE)
> > +		newflags |= HASH_RENORMALIZE;
> > ...
> > @@ -678,19 +682,23 @@ int add_to_index(struct index_state *istate, const char *path, struct stat *st,
> >  	if (ignore_case) {
> >  		adjust_dirname_case(istate, ce->name);
> >  	}
> > +	if (!(flags & HASH_RENORMALIZE)) {
> > +		alias = index_file_exists(istate, ce->name,
> > +					  ce_namelen(ce), ignore_case);
> > +		if (alias &&
> > +		    !ce_stage(alias) &&
> > +		    !ie_match_stat(istate, alias, st, ce_option)) {
> > +			/* Nothing changed, really */
> > +			if (!S_ISGITLINK(alias->ce_mode))
> > +				ce_mark_uptodate(alias);
> > +			alias->ce_flags |= CE_ADDED;
> 
> OK, so RENORMALIZE option forces the code to skip the "does the path
> exist already?  maybe we can do without adding it?" check.
> 
> >  	if (!intent_only) {
> > -		if (index_path(&ce->oid, path, st, HASH_WRITE_OBJECT)) {
> > +		if (index_path(&ce->oid, path, st, newflags)) {
> 
> And then we do hash it.  We later do add_index_entry() on this thing
> and we have OK_TO_REPLACE bit in the add_option, so we are good to go.
> 
> > diff --git a/sha1_file.c b/sha1_file.c
> > index 10c3a0083d..15abb184c2 100644
> > --- a/sha1_file.c
> > +++ b/sha1_file.c
> > @@ -74,6 +74,18 @@ static struct cached_object *find_cached_object(const unsigned char *sha1)
> >  	return NULL;
> >  }
> >  
> > +
> > +static enum safe_crlf get_safe_crlf(unsigned flags)
> > +{
> > +	if (flags & HASH_RENORMALIZE)
> > +		return SAFE_CRLF_RENORMALIZE;
> > +	else if (flags & HASH_WRITE_OBJECT)
> > +		return safe_crlf;
> > +	else
> > +		return SAFE_CRLF_FALSE;
> > +}
> > +
> > +
> >  int mkdir_in_gitdir(const char *path)
> >  {
> >  	if (mkdir(path, 0777)) {
> > @@ -1680,7 +1692,7 @@ static int index_mem(unsigned char *sha1, void *buf, size_t size,
> >  	if ((type == OBJ_BLOB) && path) {
> >  		struct strbuf nbuf = STRBUF_INIT;
> >  		if (convert_to_git(&the_index, path, buf, size, &nbuf,
> > -				   write_object ? safe_crlf : SAFE_CRLF_FALSE)) {
> > +				   get_safe_crlf(flags))) {
> >  			buf = strbuf_detach(&nbuf, &size);
> >  			re_allocated = 1;
> >  		}
> > @@ -1714,7 +1726,7 @@ static int index_stream_convert_blob(unsigned char *sha1, int fd,
> >  	assert(would_convert_to_git_filter_fd(path));
> >  
> >  	convert_to_git_filter_fd(&the_index, path, fd, &sbuf,
> > -				 write_object ? safe_crlf : SAFE_CRLF_FALSE);
> > +				 get_safe_crlf(flags));
> >  
> >  	if (write_object)
> >  		ret = write_sha1_file(sbuf.buf, sbuf.len, typename(OBJ_BLOB),
> 
> OK.  We used to force CRLF_FALSE when we are not writing it out; now
> we have three choices, and a new helper helps us isolating the logic
> to make that choice.
> 
> > diff --git a/t/t0025-crlf-renormalize.sh b/t/t0025-crlf-renormalize.sh
> > new file mode 100755
> > index 0000000000..fb1ed631d2
> > --- /dev/null
> > +++ b/t/t0025-crlf-renormalize.sh
> > @@ -0,0 +1,30 @@
> > +#!/bin/sh
> > +
> > +test_description='CRLF renormalization'
> > +
> > +. ./test-lib.sh
> > +
> > +test_expect_success setup '
> > +	git config core.autocrlf false &&
> > +	printf "LINEONE\nLINETWO\nLINETHREE"     >LF.txt &&
> > +	printf "LINEONE\r\nLINETWO\r\nLINETHREE" >CRLF.txt &&
> > +	printf "LINEONE\r\nLINETWO\nLINETHREE"   >CRLF_mix_LF.txt &&
> 
> Did you mean to make all these files end with an incomplete line?  I
> think it does not hurt but it is misleading---the reader would try
> to see if the incomplete lines are significant and necessary part of
> the test, which is not, and would end up wasting time, no?
> 
> > +	git add . &&
> > +	git commit -m initial
> > +'
> > +
> > +test_expect_success 'renormalize CRLF in repo' '
> > +	echo "*.txt text=auto" >.gitattributes &&
> > +	git add --renormalize "*.txt" &&
> > +cat >expect <<EOF &&
> > +i/lf w/crlf attr/text=auto CRLF.txt
> > +i/lf w/lf attr/text=auto LF.txt
> > +i/lf w/mixed attr/text=auto CRLF_mix_LF.txt
> > +EOF
> 
> Perhaps use the <<-\EOF pattern?
> 
> I'd suggest squashing this in (or I can do so myself if there is no
> other change needed).
> 
> Thanks.  Looks mostly good.

Thanks for review and proposed fixes and help.

[snip the TC. Adding line endings is good)
