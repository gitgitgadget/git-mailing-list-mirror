From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v5 25/27] refs: add LMDB refs storage backend
Date: Thu, 18 Feb 2016 15:23:21 -0500
Organization: Twitter
Message-ID: <1455827001.7528.87.camel@twopensource.com>
References: <1455772670-21142-1-git-send-email-dturner@twopensource.com>
	 <1455772670-21142-26-git-send-email-dturner@twopensource.com>
	 <20160218085023.GA30049@lanh>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, mhagger@alum.mit.edu
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 18 21:23:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aWV6u-0004a4-3r
	for gcvg-git-2@plane.gmane.org; Thu, 18 Feb 2016 21:23:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1948137AbcBRUX3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Feb 2016 15:23:29 -0500
Received: from mail-qk0-f172.google.com ([209.85.220.172]:34894 "EHLO
	mail-qk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1948118AbcBRUX0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Feb 2016 15:23:26 -0500
Received: by mail-qk0-f172.google.com with SMTP id o6so23159005qkc.2
        for <git@vger.kernel.org>; Thu, 18 Feb 2016 12:23:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:content-type:mime-version:content-transfer-encoding;
        bh=1iTmadxiHSDPpHcqg+7OFfb3XpAoMUOUI8byPe+UySY=;
        b=MLiEruDOGy3fIInga9+728Sra7WcQKOaNu1lAUUCfUZYRbKZwNWgpw6NmxW/l7B3sY
         AZgblJ6qpSsptgtq2qsY5YVycwSJuHPbL0HGc8Q05LFb9e20/LzktK0K7E7KQED0Rm7C
         6yKqT2NZX/KnAKiNSbpY8sioBuZO770T7hPxW7H6yQIQtZm0uJ56CfdgwA+SOXxdSdXC
         onEFTchFMNDauRbydyRuydHfBxwJHcRzlIZKUvqFTuoCrDMwHsX2+3Ni4/5vmQxWHMUk
         CfhQSQmaLewy0aNB8tS3nXWUjvSG7/WdkIvT8Cd+mSZp9myqymDuOra04THJV9tUDfIu
         Q6rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=1iTmadxiHSDPpHcqg+7OFfb3XpAoMUOUI8byPe+UySY=;
        b=PMcXw+XLn1fzV2QwyzSNgzPZ08/CqwOVyYDqrXVlLURS39nO9ufWBsL0ez3fw+ht9D
         ihEpWA5A0FyP3So+Q4580g+RSPkhu5y/DYhBRr4PqQipDXxFKAPMetfDxaM/JPoXNfCp
         BXc8iO0iwcdOyimhr/BnkqmzLac+BWVQ6lSAtGjFXJxXXtIRR3KXSC9eCMOb0Q0cLnSS
         Wd8B4oqORDwtQgoGNYgwpfJacg7sKpd/cNQvaBG4ZbWJkNVDDiSpiZIOC8nb947NcG4y
         LuN4p1EdueLqmdMnDvWE8Nc++XksOVAypOzF3g4JUsJMIC6qZGJQevAp9ixIPFlJLer6
         GDsA==
X-Gm-Message-State: AG10YOQ1R3XNSRajYrpvRJ43cw5khCZAHfRJIlQl64ujuQ9lCwy6Br/wsQV1ZRvP5/jN7A==
X-Received: by 10.55.52.211 with SMTP id b202mr11322298qka.27.1455827005141;
        Thu, 18 Feb 2016 12:23:25 -0800 (PST)
Received: from ubuntu ([8.25.196.25])
        by smtp.gmail.com with ESMTPSA id g64sm3265212qkb.44.2016.02.18.12.23.23
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 18 Feb 2016 12:23:24 -0800 (PST)
In-Reply-To: <20160218085023.GA30049@lanh>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286617>

On Thu, 2016-02-18 at 15:50 +0700, Duy Nguyen wrote:

[snip]

Thanks; applied the above

> This permission makes me wonder if we need adjust_shared_perm() here
> and some other places.

So just add this after every mkdir?

	if (shared_repository)
		adjust_shared_perm(db_path);

> > +	if (ret)
> > +		die("BUG: mdb_env_open (%s) failed: %s", path,
> > +		    mdb_strerror(ret));
> > +}
> > +
> > +static int lmdb_init_db(int shared, struct strbuf *err)
> > +{
> > +	/*
> > +	 * To create a db, all we need to do is make a directory
> > for
> > +	 * it to live in; lmdb will do the rest.
> > +	 */
> > +
> > +	if (!db_path)
> > +		db_path =
> > xstrdup(real_path(git_path("refs.lmdb")));
> > +
> > +	if (mkdir(db_path, 0775) && errno != EEXIST) {
> > +		strbuf_addf(err, "%s", strerror(errno));
> 
> maybe strbuf_addstr, unless want to add something more, "mkdir
> failed"?

added more

> > +static int read_per_worktree_ref(const char *submodule, const char
> > *refname,
> > +				 struct MDB_val *val, int
> > *needs_free)
> 
> From what I read, I suspect these _per_worktree functions will be
> identical for the next backend. Should we just hand over the job for
> files backend? For all entry points that may deal with per-worktree
> refs, e.g. lmdb_resolve_ref_unsafe, can we check ref_type() first
> thing, if it's per-worktree we call
> refs_be_files.resolve_ref_unsafe()
> instead?  It could even be done at frontend level,
> e.g. refs.c:resolve_ref_unsafe().
> 
> Though I may be talking rubbish here because I don't know how whether
> it has anything to do with transactions.

The reason I did it this way is that some ref chains cross backend
boundaries (e.g. HEAD -> refs/heads/master).  But if we have other
backends later, we could generalize.

> > +{
> > +	struct strbuf sb = STRBUF_INIT;
> > +	struct strbuf path = STRBUF_INIT;
> > +	struct stat st;
> > +	int ret = -1;
> > +
> > +	submodule_path(&path, submodule, refname);
> > +
> > +#ifndef NO_SYMLINK_HEAD
> 
> It started with the compiler warns about unused "st" when this macro
> is defined. Which makes me wonder, should we do something like this
> to
> make sure this code compiles unconditionally?
> 
> +#ifndef NO_SYMLINK_HEAD
> +       int no_symlink_head = 0;
> +#else
> +       int no_symlink_head = 1;
> +#endif
> ...
> +       if (!no_symlink_head) {
> ...

OK.

> > +int lmdb_transaction_begin_flags(struct strbuf *err, unsigned int
> > flags)
> 
> static?

yep

> > +static const char *parse_ref_data(struct lmdb_transaction
> > *transaction,
> > +				  const char *refname, const char
> > *ref_data,
> > +				  unsigned char *sha1, int
> > resolve_flags,
> > +				  int *flags, int bad_name)
> > +{
>[snip]
> This code looks a lot like near the end of resolve_ref_1(). Maybe we
> could share the code in refs/backend-common.c or something and call
> here instead?

When I wrote this, I couldn't find a straightforward way to factor out
the commonalities, but I'll try again now that I understand the refs
code better.

> > +static int show_one_reflog_ent(struct strbuf *sb,
> > each_reflog_ent_fn fn, void *cb_data)
> > +{
> > +	unsigned char osha1[20], nsha1[20];
> > +	char *email_end, *message;
> > +	unsigned long timestamp;
> > +	int tz;
> > +
> > +	/* old (raw sha) new (raw sha) name <email> SP time TAB
> > msg LF */
> 
> Hmm.. since you're going with raw sha-1, this is clearly not a text
> string anymore, any reason to still keep LF at the end?

IIRC, some of the common funcs depend on this.

> > +static int lmdb_delete_reflog(const char *refname)
> > +{
> > +	MDB_val key, val;
> > +	char *log_path;
> > +	int len;
> > +	MDB_cursor *cursor;
> > +	int ret = 0;
> > +	int mdb_ret;
> > +	struct strbuf err = STRBUF_INIT;
> > +	int in_transaction;
> > +
> > +	if (ref_type(refname) != REF_TYPE_NORMAL)
> > +		return refs_be_files.delete_reflog(refname);
> 
> Yay.. delegating work to files backend. I still think doing this in
> refs.c:delete_reflog() may be a good idea.

Yes, I agree.

> > +int lmdb_reflog_expire(const char *refname, const unsigned char
> > *sha1,
> 
> static?

Yep.

> > +static int lmdb_create_symref(const char *ref_target,
> > +			      const char *refs_heads_master,
> > +			      const char *logmsg)
> > +{
> > +
> ...
> > +	mdb_put_or_die(&transaction, &key, &val, 0);
> > +
> > +	/* TODO: Don't create ref d/f conflicts */
> 
> I'm not sure I get this comment. D/F conflicts are no longer a thing
> for lmdb backend, right?

I'm trying to avoid the lmdb backend creating a set of refs that the
files backend can't handle.  This would make collaboration with other
versions of git more difficult.

> > +MDB_env *submodule_txn_begin(struct lmdb_transaction *transaction)
> 
> static?

Yes.

> > +{
> > +	int ret;
> > +	MDB_env *submodule_env = NULL;
> > +	struct strbuf path = STRBUF_INIT;
> > +
> > +	strbuf_git_path_submodule(&path, transaction->submodule,
> > "refs.lmdb");
> > +
> > +	if (!is_directory(path.buf))
> > +		goto done;
> > +
> > +	mkdir(path.buf, 0775);
> 
> A few other places where mkdir() is called, we may need to
> adjust_shared_perm().

OK.

> > diff --git a/setup.c b/setup.c
> > index 1a62277..00625ab 100644
> > --- a/setup.c
> > +++ b/setup.c
> > @@ -279,7 +279,7 @@ int ref_storage_backend_config(const char *var,
> > const char *value, void *ptr)
> >   *
> >   *  - either an objects/ directory _or_ the proper
> >   *    GIT_OBJECT_DIRECTORY environment variable
> > - *  - a refs/ directory
> > + *  - a refs.lmdb/ directory or a refs/ directory
> >   *  - either a HEAD symlink or a HEAD file that is formatted as
> >   *    a proper "ref:", or a regular file HEAD that has a properly
> >   *    formatted sha1 object name.
> > @@ -313,8 +313,13 @@ int is_git_directory(const char *suspect)
> >  
> >  	strbuf_setlen(&path, len);
> >  	strbuf_addstr(&path, "/refs");
> > -	if (access(path.buf, X_OK))
> > -		goto done;
> > +
> > +	if (access(path.buf, X_OK)) {
> > +		strbuf_setlen(&path, len);
> > +		strbuf_addstr(&path, "/refs.lmdb");
> > +		if (access(path.buf, X_OK))
> > +			goto done;
> > +	}
> > 
> 
> I think it's ok leaving this function unmodified, which means "refs"
> directory will always be there and "refs.lmdb" does not matter. If
> somehow "refs" is deleted, old binaries get confused anyway so we
> can't delete it.

OK.

> > @@ -1089,8 +1089,11 @@ static int refs_from_alternate_cb(struct
> > alternate_object_database *e,
> >  		goto out;
> >  	/* Is this a git repository with refs? */
> >  	memcpy(other + len - 8, "/refs", 6);
> > -	if (!is_directory(other))
> > -		goto out;
> > +	if (!is_directory(other)) {
> > +		memcpy(other + len - 8, "/refs.lmdb", 11);
> > +		if (!is_directory(other))
> > +			goto out;
> > +	}
> 
> and probably the same here. I have no idea what this code does
> though,
> but if it's about detecting git directory, it should call
> is_git_directory() instead.

I'll back out my change, but not do the the is_git_directory thing
since I don't have a strong sense of why this code is the way it is.
