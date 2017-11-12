Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B7A6201C8
	for <e@80x24.org>; Sun, 12 Nov 2017 14:05:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751138AbdKLOFf (ORCPT <rfc822;e@80x24.org>);
        Sun, 12 Nov 2017 09:05:35 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:43702 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750994AbdKLOFe (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Nov 2017 09:05:34 -0500
Received: by mail-pg0-f67.google.com with SMTP id s75so10819574pgs.0
        for <git@vger.kernel.org>; Sun, 12 Nov 2017 06:05:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:in-reply-to:references:date
         :mime-version:content-transfer-encoding;
        bh=3tWCjyskzMg9mqw5CgTMi2805WsliEhrtfI+g3PCEqQ=;
        b=osP7Gmio4/zq9UX73/0wpXzv1DRSmdDF8bCqSY2E7ECleN7w/ZGLXp9l6jBy9fEw9i
         mTW1n/wHdwu7QbrWQL4f76VfWKa98yTwrbMrYhFf/rl/2Jc/ahMLlag/y9OUgjoYDZ+3
         HGvHS96TQn4b1V7ar3emZszhb+T5DZFafcWtzgKaZgTXFKqArCqU9rK7jnRDfD7Xa8TP
         0/fYk0FAaLUYkqvL/I7CAaEiDr5Lg5BHKZ+A2DNkF+bDucexTAgTVRp4LqLhvgDaUy+h
         Jv7Ib5lrolV2gEBAY0+/CY3sWoN+aff3QPqs+bVJfX2xoRUFkHw77Agh9tjZeCbD7iir
         dBww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:in-reply-to
         :references:date:mime-version:content-transfer-encoding;
        bh=3tWCjyskzMg9mqw5CgTMi2805WsliEhrtfI+g3PCEqQ=;
        b=Cj+arYaPi8wjPhPjaUtxa0IO9snA281HwI+F/xcSLH3LAmPwpaaW65N1ACaRWibCgu
         cdtq9UEoFGBwa1nwrDqqf7AJYCnqqWSVmmV6hRUpugXyAZyt3vag5awea5Uc+QSSL9BM
         r2jWfLNsNxriVP6k2/USZ6RdTr/9MzvwuhpPqfbUBt5+IjNQsN6h0fB0r7kC6IzCezdW
         1XDQ/siXzsgWVjxSURdJafvL8JanPQhBDQ+KzRi1PECkwLDRnykT3wQ+hm4/yzJ6inH3
         VQ5nCRYNlghM/cPfA8hG18mbMSwyl9Dpifx22nMt9C8RJSjzC32FPoJp97HaUXMnKYzm
         OcnQ==
X-Gm-Message-State: AJaThX5QLS8Mr+YPgXv0vuxivu7VRJBI4/6gKjVbmmykPPBFg59wcU62
        bFpCGdP4T0QQZzvDn6UMlMer28ri
X-Google-Smtp-Source: AGs4zMZhRav5bdhg4OMJraedlJOssowxMpycUGyY4hr7j+rpcYuuXPLs/nkGT3NxbZnWfrAGb66WaA==
X-Received: by 10.98.106.5 with SMTP id f5mr6786789pfc.27.1510495534119;
        Sun, 12 Nov 2017 06:05:34 -0800 (PST)
Received: from unique-pc ([117.246.57.0])
        by smtp.gmail.com with ESMTPSA id p14sm22717816pgr.51.2017.11.12.06.05.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 12 Nov 2017 06:05:32 -0800 (PST)
Message-ID: <1510495525.2683.12.camel@gmail.com>
Subject: Re: [RFC PATCH v3 4/4] builtin/branch: give more useful error
 messages when renaming
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
In-Reply-To: <xmqq375sjfzk.fsf@gitster.mtv.corp.google.com>
References: <20170925082024.2691-1-kaarticsivaraam91196@gmail.com>
         <20171102065407.25404-1-kaartic.sivaraam@gmail.com>
         <20171102065407.25404-5-kaartic.sivaraam@gmail.com>
         <xmqq375sjfzk.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset="ISO-8859-15"
Date:   Sun, 12 Nov 2017 19:35:25 +0530
Mime-Version: 1.0
X-Mailer: Evolution 3.22.6-1 
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 2017-11-06 at 11:30 +0900, Junio C Hamano wrote:
> Kaartic Sivaraam <kaartic.sivaraam@gmail.com> writes:
> 
> No {} around a single statement block of "if", especially when there
> is no "else" that has multi-statement block that needs {}.
> 

The code has changed a little since v3 so this if has been replaced
with a switch case.


> > +	switch (res) {
> > +		case BRANCH_EXISTS_NO_FORCE:
> > +			strbuf_addf(error_msg, "%s", (!old_branch_exists) ? connector_string : "");
> > +			strbuf_addf(error_msg,_("branch '%s' already exists"), newname);
> > +			break;
> 
> The case arms and their statements are indented by one level too much.
> The lines are getting overlong.  Find a good place to split, e.g.
> 
>     		strbuf_addf(error_msg, "%s",
> 			!old_branch_exists ? connector_string : "");
> 
> Leave a single SP after each "," in an arguments list.
> 

Fixed these.


> As Eric pointed out, this certainly smells like a sentence lego that
> we would be better off without.
> 

As stated in that mail,  I've replaced the connector " and " with "; "
as it seemed to be the most simple way to overcome the issue, at least
in my opinion. In case there's any better way to fix this let me know.


> >  static void copy_or_rename_branch(const char *oldname, const char *newname, int copy, int force)
> >  {
> >  	struct strbuf oldref = STRBUF_INIT, newref = STRBUF_INIT, logmsg = STRBUF_INIT;
> >  	struct strbuf oldsection = STRBUF_INIT, newsection = STRBUF_INIT;
> >  	int recovery = 0;
> > +	struct strbuf error_msg = STRBUF_INIT, empty = STRBUF_INIT;
> > +	enum branch_validation_result res;
> >  
> >  	if (!oldname) {
> >  		if (copy)
> > @@ -471,15 +502,13 @@ static void copy_or_rename_branch(const char *oldname, const char *newname, int
> >  			die(_("cannot rename the current branch while not on any."));
> >  	}
> >  
> > -	if (strbuf_check_branch_ref(&oldref, oldname)) {
> > +	if (strbuf_check_branch_ref(&oldref, oldname) && ref_exists(oldref.buf))
> > +	{
> 
> Opening brace { that begins a block comes at the end of the line
> that closes the condition of "if"; if you found that your line is
> overlong, perhaps do it like so instead:
> 
> 	if (strbuf_check_branch_ref(&oldref, oldname) &&
> 	    ref_exists(oldref.buf)) {

This part changed too. Anyways thanks for the detailed review :-)

-- 
Kaartic
