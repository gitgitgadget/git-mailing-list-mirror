From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 02/13] Add skeleton SVN client and Makefile
Date: Wed, 7 Jul 2010 19:09:26 +0200
Message-ID: <20100707170926.GC18806@debian>
References: <1278461693-3828-1-git-send-email-artagnon@gmail.com>
 <1278461693-3828-3-git-send-email-artagnon@gmail.com>
 <20100707162516.GA1529@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Cc: Git Mailing List <git@vger.kernel.org>,
	David Michael Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>, avarab@gmail.com,
	Daniel Shahaf <d.s@daniel.shahaf.name>,
	Bert Huijben <rhuijben@collab.net>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Wong <normalperson@yhbt.net>, dev@subversion.apache.org,
	Stefan Sperling <stsp@elego.de>,
	Julian Foad <julian.foad@wandisco.com>,
	Will Palmer <wmpalmer@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: dev-return-4850-gcvsd-dev=m.gmane.org@subversion.apache.org Wed Jul 07 19:09:05 2010
Return-path: <dev-return-4850-gcvsd-dev=m.gmane.org@subversion.apache.org>
Envelope-to: gcvsd-dev@lo.gmane.org
Received: from hermes.apache.org ([140.211.11.3] helo=mail.apache.org)
	by lo.gmane.org with smtp (Exim 4.69)
	(envelope-from <dev-return-4850-gcvsd-dev=m.gmane.org@subversion.apache.org>)
	id 1OWY7M-0007t4-Jq
	for gcvsd-dev@lo.gmane.org; Wed, 07 Jul 2010 19:09:05 +0200
Received: (qmail 13740 invoked by uid 500); 7 Jul 2010 17:09:02 -0000
Mailing-List: contact dev-help@subversion.apache.org; run by ezmlm
Precedence: bulk
List-Help: <mailto:dev-help@subversion.apache.org>
List-Unsubscribe: <mailto:dev-unsubscribe@subversion.apache.org>
List-Post: <mailto:dev@subversion.apache.org>
List-Id: <dev.subversion.apache.org>
Delivered-To: mailing list dev@subversion.apache.org
Received: (qmail 13732 invoked by uid 99); 7 Jul 2010 17:09:02 -0000
Received: from nike.apache.org (HELO nike.apache.org) (192.87.106.230)
    by apache.org (qpsmtpd/0.29) with ESMTP; Wed, 07 Jul 2010 17:09:02 +0000
X-ASF-Spam-Status: No, hits=0.0 required=10.0
	tests=FREEMAIL_FROM,SPF_PASS
X-Spam-Check-By: apache.org
Received-SPF: pass (nike.apache.org: domain of artagnon@gmail.com designates 209.85.215.171 as permitted sender)
Received: from [209.85.215.171] (HELO mail-ey0-f171.google.com) (209.85.215.171)
    by apache.org (qpsmtpd/0.29) with ESMTP; Wed, 07 Jul 2010 17:08:53 +0000
Received: by eyg7 with SMTP id 7so260982eyg.16
        for <dev@subversion.apache.org>; Wed, 07 Jul 2010 10:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=CO0yQ8/gtuccJUOrlVQYQN/KTN8v0LkUsqsr4yHNdRA=;
        b=DUR6GduF/x8gmDs3Ngsb6ghtBFaX2ZYkuW1FTX8MLtSzvnHyas31kGh2qZEyv2AUwH
         ZepsMu85cOvXhNBFCOly3EmMa4LWTG4xpws8J1QoIF30Cq9MPC83rT2BOMgQUIoMkRyQ
         LmDWmDp17lstVvFrBwxEBcua0pNhsVFLue4Qg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=OF7eHKLlSuxtgCEG2HFW3aPxmTijvcTIpGaI9CCzniiX3LAWsh+/drczZhFmmLK3Wb
         F50xiU7yyQV9kd3TKje75PS7+GVUGnQzKchPSejWnAzqqtESNZd+qDYEujehSDDrRljg
         JsmU7wM53CgSoqnIBJHpw4mbCD8E3RUWAcHco=
Received: by 10.213.31.134 with SMTP id y6mr6221425ebc.51.1278522463862;
        Wed, 07 Jul 2010 10:07:43 -0700 (PDT)
Received: from debian (adm12-98.itu.dk [130.226.133.98])
        by mx.google.com with ESMTPS id z55sm62836788eeh.15.2010.07.07.10.07.41
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 07 Jul 2010 10:07:42 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100707162516.GA1529@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Virus-Checked: Checked by ClamAV on apache.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150483>

Hi Jonathan,

Jonathan Nieder writes:
> Ramkumar Ramachandra wrote:
> 
> > Add a basic SVN command-line client along with a Makefile that does
> > just enough to establish a connection with the ASF subversion server;
> 
> Thanks for splitting this out.

Thanks for getting the review process started :)

> Let’s see what’s needed to set up a connection:
> 
> > +++ b/Makefile
> > @@ -0,0 +1,8 @@
> > +svndumpr: *.c *.h
> > +	$(CC) -Wall -Werror -DAPR_POOL_DEBUG -ggdb3 -O0 -o $@ svndumpr.c -lsvn_client-1 -I. -I/usr/include/subversion-1 -I/usr/include/apr-1.0
> 
> Links against libsvnclient-1.  Good.
> 
> I assume the details of the Makefile are not important, since it is
> probably going to be revamped in the style of the svn build system
> anyway.

Right.

> > +++ b/svndumpr.c
> > @@ -0,0 +1,68 @@
> [...]
> > +svn_error_t *populate_context()
> [...]
> > +svn_error_t *open_connection(const char *url)
> [...]
> > +svn_error_t *replay_range(svn_revnum_t start_revision, svn_revnum_t end_revision)
> 
> Why not static?

Changed (see end of email).

> > +svn_error_t *populate_context()
> > +{
> > +	const char *http_library;
> > +	
> > +	SVN_ERR(svn_config_get_config(&(ctx->config), NULL, pool));
> > +	
> > +	http_library = getenv("SVN_HTTP_LIBRARY");
> > +	if (http_library)
> > +		svn_config_set(apr_hash_get(ctx->config, "servers", APR_HASH_KEY_STRING),
> > +		               "global", "http-library", http_library);
> 
> I tried googling for this SVN_HTTP_LIBRARY setting, but no
> useful hints.  I take it that this overrides the [global] http-library
> setting from ~/.subversion/servers?  Do other commands honor this
> environment variable or just svndumpr?

I originally had this to switch between neon and serf libraries. It
seems that this is no more necessary.

> [...]
> > +svn_error_t *open_connection(const char *url)
> > +{
> > +	SVN_ERR(svn_config_ensure (NULL, pool));
> > +	SVN_ERR(svn_client_create_context (&ctx, pool));
> > +	SVN_ERR(svn_ra_initialize(pool));
> > +
> > +#if defined(WIN32) || defined(__CYGWIN__)
> > +	if (getenv("SVN_ASP_DOT_NET_HACK"))
> > +		SVN_ERR(svn_wc_set_adm_dir("_svn", pool));
> > +#endif
> 
> I guess it’s water under the bridge now (from 5 years ago), but why do
> clients have to do this themselves?  It would not be so difficult for
> libsvnclient to automatically set the admin dir according to whether
> SVN_ASP_DOT_NET_HACK is set or not, or at least to provide a single
> function to call and do so.

Good question. I copied this out from some legacy code in the
Subversion trunk. Additionally, since I don't have a working copy,
this is completely unnecessary. Removed now.

> > +
> > +	SVN_ERR(populate_context());
> > +	SVN_ERR(svn_cmdline_create_auth_baton(&(ctx->auth_baton), TRUE,
> > +					      NULL, NULL, NULL, FALSE,
> > +					      FALSE, NULL, NULL, NULL,
> > +					      pool));
> 
> Maybe comments would help, for the boolean arguments.

Fixed.

> > +	SVN_ERR(svn_client_open_ra_session(&session, url, ctx, pool));
> > +	return SVN_NO_ERROR;
> > +}
> > +
> > +svn_error_t *replay_range(svn_revnum_t start_revision, svn_revnum_t end_revision)
> > +{
> > +	return SVN_NO_ERROR;
> > +}
> 
> Might be more self-explanatory without this function, but that
> is just nitpicking.

I've filled in the function in a future patch. It's just to say that
I'm "opening a connection and then calling replay_range, in that
order". Yes, replay_range does nothing in this patch.

> > +
> > +int main()
> > +{
> > +	const char url[] = "http://svn.apache.org/repos/asf";
> > +	svn_revnum_t start_revision = 1, end_revision = 500;
> > +	if (svn_cmdline_init ("svndumpr", stderr) != EXIT_SUCCESS)
> > +		return 1;
> > +
> > +	pool = svn_pool_create(NULL);
> > +
> > +	SVN_INT_ERR(open_connection(url));
> > +	SVN_INT_ERR(replay_range(start_revision, end_revision));
> > +
> > +	svn_pool_destroy(pool);
> > +	
> > +	return 0;
> > +}
> 
> So: this is an expensive no-op.

Exactly. I built up the patches so that at every stage, the program
compiles and runs fine, implementing part of full functionality.

Here's a diff of the modifications I made after your review:

diff --git a/svndumpr.c b/svndumpr.c
index 011941f..f3117aa 100644
--- a/svndumpr.c
+++ b/svndumpr.c
@@ -76,31 +76,19 @@ static svn_error_t *replay_revend(svn_revnum_t revision,
 	return SVN_NO_ERROR;
 }
 
-svn_error_t *populate_context()
-{
-	const char *http_library;
-	
-	SVN_ERR(svn_config_get_config(&(ctx->config), NULL, pool));
-	
-	http_library = getenv("SVN_HTTP_LIBRARY");
-	if (http_library)
-		svn_config_set(apr_hash_get(ctx->config, "servers", APR_HASH_KEY_STRING),
-		               "global", "http-library", http_library);
-	return SVN_NO_ERROR;
-}
-
-svn_error_t *open_connection(const char *url)
+static svn_error_t *open_connection(const char *url)
 {
 	SVN_ERR(svn_config_ensure (NULL, pool));
 	SVN_ERR(svn_client_create_context (&ctx, pool));
 	SVN_ERR(svn_ra_initialize(pool));
 
-#if defined(WIN32) || defined(__CYGWIN__)
-	if (getenv("SVN_ASP_DOT_NET_HACK"))
-		SVN_ERR(svn_wc_set_adm_dir("_svn", pool));
-#endif
+	SVN_ERR(svn_config_get_config(&(ctx->config), NULL, pool));
 
-	SVN_ERR(populate_context());
+	/* Populte ctx->auth_baton with the auth baton
+	   non-interactively. Arguments 3, 4 and 5 are for username,
+	   password and config_dir which is NULL in this case. Set
+	   no_auth_cache and trust_serv_cert to FALSE, don't provide a
+	   config, and omit cancel_func/ cancel_baton */
 	SVN_ERR(svn_cmdline_create_auth_baton(&(ctx->auth_baton), TRUE,
 					      NULL, NULL, NULL, FALSE,
 					      FALSE, NULL, NULL, NULL,
@@ -109,7 +97,7 @@ svn_error_t *open_connection(const char *url)
 	return SVN_NO_ERROR;
 }
 
-svn_error_t *replay_range(svn_revnum_t start_revision, svn_revnum_t end_revision)
+static svn_error_t *replay_range(svn_revnum_t start_revision, svn_revnum_t end_revision)
 {
 	const svn_delta_editor_t *dump_editor, *debug_editor;
 	void *debug_baton, *dump_baton;


-- Ram
