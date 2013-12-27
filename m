From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Remove the line length limit for graft files
Date: Fri, 27 Dec 2013 13:48:46 -0800
Message-ID: <7vr48yj77l.fsf@alter.siamese.dyndns.org>
References: <alpine.DEB.1.00.1312272146590.1191@s15462909.onlinehome-server.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org,  msysgit@googlegroups.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: msysgit+bncBCG77UMM3EJRBOXL66KQKGQE3QNXPXY@googlegroups.com Fri Dec 27 22:48:45 2013
Return-path: <msysgit+bncBCG77UMM3EJRBOXL66KQKGQE3QNXPXY@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-yh0-f64.google.com ([209.85.213.64])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCG77UMM3EJRBOXL66KQKGQE3QNXPXY@googlegroups.com>)
	id 1VwfGt-0002y2-BJ
	for gcvm-msysgit@m.gmane.org; Fri, 27 Dec 2013 22:48:43 +0100
Received: by mail-yh0-f64.google.com with SMTP id b20sf2044788yha.29
        for <gcvm-msysgit@m.gmane.org>; Fri, 27 Dec 2013 13:48:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=N6Sbru75DtpEosEb9KUySPk4O//TfPMeEPNTPx/r0+U=;
        b=QLLqjMOvjoPrECYA9mxbgRbYeGAhO/Q/oyz3Gh+8PPh+1BAB/qvHTeXRibl4FZazGE
         e2lAWYZoeAf10pVS98WvTunsWeQS6x2EUUb8t5WC8ggqYafiB8JjIkTKwqnJo8Ezvovj
         AJDOqx8l6g1JyXI3WT8AvOMBunu2UtTC9IOOOH6ZhgY2PZiU3OWHfoDRrhTAjVWpyQ52
         P1IBd6i3gk8yvvbnMjkm2H6eOwVB6kypNgJhwBJEHXd/tvXOHA2rtvAhNvEKXMZpn8VG
         NHtdQ9zOpBa9tow1DIOMmaJrM4j5EbTYXDZn++Y6VXgS3bFSjH458ZaWFU1JYxgF3aqc
         8mPw==
X-Received: by 10.49.2.3 with SMTP id 3mr188qeq.41.1388180922494;
        Fri, 27 Dec 2013 13:48:42 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.49.104.76 with SMTP id gc12ls2892168qeb.44.gmail; Fri, 27 Dec
 2013 13:48:41 -0800 (PST)
X-Received: by 10.58.39.202 with SMTP id r10mr21724834vek.12.1388180921871;
        Fri, 27 Dec 2013 13:48:41 -0800 (PST)
Received: from smtp.pobox.com (b-pb-sasl-quonix.pobox.com. [208.72.237.35])
        by gmr-mx.google.com with ESMTP id u17si2010470vdg.1.2013.12.27.13.48.41
        for <msysgit@googlegroups.com>;
        Fri, 27 Dec 2013 13:48:41 -0800 (PST)
Received-SPF: pass (google.com: best guess record for domain of junio@b-sasl-quonix.pobox.com designates 208.72.237.35 as permitted sender) client-ip=208.72.237.35;
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8F1A45C6C9;
	Fri, 27 Dec 2013 16:48:41 -0500 (EST)
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 81E835C6C8;
	Fri, 27 Dec 2013 16:48:41 -0500 (EST)
Received: from pobox.com (unknown [198.0.213.178])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 80A3E5C6C7;
	Fri, 27 Dec 2013 16:48:40 -0500 (EST)
In-Reply-To: <alpine.DEB.1.00.1312272146590.1191@s15462909.onlinehome-server.info>
	(Johannes Schindelin's message of "Fri, 27 Dec 2013 21:49:57 +0100
	(CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
X-Pobox-Relay-ID: A607CB88-6F40-11E3-88B9-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
X-Original-Sender: gitster@pobox.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: best guess record for domain of junio@b-sasl-quonix.pobox.com
 designates 208.72.237.35 as permitted sender) smtp.mail=junio@b-sasl-quonix.pobox.com;
       dkim=pass header.i=@pobox.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239748>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Support for grafts predates Git's strbuf, and hence it is understandable
> that there was a hard-coded line length limit of 1023 characters (which
> was chosen a bit awkwardly, given that it is *exactly* one byte short of
> aligning with the 41 bytes occupied by a commit name and the following
> space or new-line character).
>
> While regular commit histories hardly win comprehensibility in general
> if they merge more than twenty-two branches in one go, it is not Git's
> business to limit grafts in such a way.
>
> In this particular developer's case, the use case that requires
> substantially longer graft lines to be supported is the visualization of
> the commits' order implied by their changes: commits are considered to
> have an implicit relationship iff exchanging them in an interactive
> rebase would result in merge conflicts.
>
> Thusly implied branches tend to be very shallow in general, and the
> resulting thicket of implied branches is usually very wide; It is
> actually quite common that *most* of the commits in a topic branch have
> not even one implied parent, so that a final merge commit has about as
> many implied parents as there are commits in said branch.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  builtin/blame.c |  8 ++++----
>  commit.c        | 10 +++++-----
>  2 files changed, 9 insertions(+), 9 deletions(-)

Makes sense.  It is in line with the spirit of ef98c5cafb3e
(commit-tree: lift completely arbitrary limit of 16 parents,
2008-06-27), too ;-)

Thanks, will queue.


> diff --git a/builtin/blame.c b/builtin/blame.c
> index 1407ae7..9047b6e 100644
> --- a/builtin/blame.c
> +++ b/builtin/blame.c
> @@ -1804,17 +1804,17 @@ static int prepare_lines(struct scoreboard *sb)
>  static int read_ancestry(const char *graft_file)
>  {
>  	FILE *fp = fopen(graft_file, "r");
> -	char buf[1024];
> +	struct strbuf buf = STRBUF_INIT;
>  	if (!fp)
>  		return -1;
> -	while (fgets(buf, sizeof(buf), fp)) {
> +	while (!strbuf_getwholeline(&buf, fp, '\n')) {
>  		/* The format is just "Commit Parent1 Parent2 ...\n" */
> -		int len = strlen(buf);
> -		struct commit_graft *graft = read_graft_line(buf, len);
> +		struct commit_graft *graft = read_graft_line(buf.buf, buf.len);
>  		if (graft)
>  			register_commit_graft(graft, 0);
>  	}
>  	fclose(fp);
> +	strbuf_release(&buf);
>  	return 0;
>  }
>  
> diff --git a/commit.c b/commit.c
> index de16a3c..57ebea2 100644
> --- a/commit.c
> +++ b/commit.c
> @@ -196,19 +196,19 @@ bad_graft_data:
>  static int read_graft_file(const char *graft_file)
>  {
>  	FILE *fp = fopen(graft_file, "r");
> -	char buf[1024];
> +	struct strbuf buf = STRBUF_INIT;
>  	if (!fp)
>  		return -1;
> -	while (fgets(buf, sizeof(buf), fp)) {
> +	while (!strbuf_getwholeline(&buf, fp, '\n')) {
>  		/* The format is just "Commit Parent1 Parent2 ...\n" */
> -		int len = strlen(buf);
> -		struct commit_graft *graft = read_graft_line(buf, len);
> +		struct commit_graft *graft = read_graft_line(buf.buf, buf.len);
>  		if (!graft)
>  			continue;
>  		if (register_commit_graft(graft, 1))
> -			error("duplicate graft data: %s", buf);
> +			error("duplicate graft data: %s", buf.buf);
>  	}
>  	fclose(fp);
> +	strbuf_release(&buf);
>  	return 0;
>  }
>  
> -- 
> 1.8.4.msysgit.0.1109.g3c58b16
>
> -- 

-- 
-- 
*** Please reply-to-all at all times ***
*** (do not pretend to know who is subscribed and who is not) ***
*** Please avoid top-posting. ***
The msysGit Wiki is here: https://github.com/msysgit/msysgit/wiki - Github accounts are free.

You received this message because you are subscribed to the Google
Groups "msysGit" group.
To post to this group, send email to msysgit@googlegroups.com
To unsubscribe from this group, send email to
msysgit+unsubscribe@googlegroups.com
For more options, and view previous threads, visit this group at
http://groups.google.com/group/msysgit?hl=en_US?hl=en

--- 
You received this message because you are subscribed to the Google Groups "msysGit" group.
To unsubscribe from this group and stop receiving emails from it, send an email to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/groups/opt_out.
