From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Remove the line length limit for graft files
Date: Fri, 27 Dec 2013 13:04:47 -0800
Message-ID: <20131227210447.GE20443@google.com>
References: <alpine.DEB.1.00.1312272146590.1191@s15462909.onlinehome-server.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, msysgit@googlegroups.com, gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: msysgit+bncBD6LRKOE4AIRB46W66KQKGQEMKEZ6XY@googlegroups.com Fri Dec 27 22:04:54 2013
Return-path: <msysgit+bncBD6LRKOE4AIRB46W66KQKGQEMKEZ6XY@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-qa0-f55.google.com ([209.85.216.55])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBD6LRKOE4AIRB46W66KQKGQEMKEZ6XY@googlegroups.com>)
	id 1VweaS-00021s-I7
	for gcvm-msysgit@m.gmane.org; Fri, 27 Dec 2013 22:04:52 +0100
Received: by mail-qa0-f55.google.com with SMTP id i13sf2279790qae.0
        for <gcvm-msysgit@m.gmane.org>; Fri, 27 Dec 2013 13:04:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :in-reply-to:user-agent:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type:content-disposition;
        bh=orArKHpVrTduGwGE6CAR8+8p3STl+0U4t/44y/VbUlM=;
        b=yTJ9lUQOcB/4WdXR2IFWqZL8a5Cd+7tkgyNB5R65VraOEq1Z98UE0dEU/HQs0sGRSz
         gnxiDuChRQ/1wkK1xx2NBj/aZohggK1T6TR308hPNfYyxZoIZK87bbQMZ8RyyOhbc03U
         yI501KuvmlE1Iu7couy0ACGOdAnKaN38aI/b5oCFTdNI5Osd0Iw5/m6NYlD7ysx3MmyF
         Q5XtE+FrFblXCRvzGHiQ0Mgm9u1pU9G4sKPC7gzgh6eKZF+520VR92+9fX8vwtMf7bq1
         RiTjk7oZ19nmlQ3gFXvnbSq5HUOrXC9lidInXKPY1JKBmGPr0/9g2JgD6OPGegyHNCXP
         uHoQ==
X-Received: by 10.50.37.133 with SMTP id y5mr431397igj.11.1388178291782;
        Fri, 27 Dec 2013 13:04:51 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.50.20.2 with SMTP id j2ls6819864ige.21.canary; Fri, 27 Dec
 2013 13:04:51 -0800 (PST)
X-Received: by 10.66.66.35 with SMTP id c3mr20027142pat.12.1388178290988;
        Fri, 27 Dec 2013 13:04:50 -0800 (PST)
Received: from mail-yh0-x22c.google.com (mail-yh0-x22c.google.com [2607:f8b0:4002:c01::22c])
        by gmr-mx.google.com with ESMTPS id k45si11209471yhn.4.2013.12.27.13.04.50
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 27 Dec 2013 13:04:50 -0800 (PST)
Received-SPF: pass (google.com: domain of jrnieder@gmail.com designates 2607:f8b0:4002:c01::22c as permitted sender) client-ip=2607:f8b0:4002:c01::22c;
Received: by mail-yh0-f44.google.com with SMTP id f64so2031158yha.17
        for <msysgit@googlegroups.com>; Fri, 27 Dec 2013 13:04:50 -0800 (PST)
X-Received: by 10.236.47.162 with SMTP id t22mr6955323yhb.123.1388178290753;
        Fri, 27 Dec 2013 13:04:50 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id m29sm48193760yho.14.2013.12.27.13.04.49
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 27 Dec 2013 13:04:49 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.1312272146590.1191@s15462909.onlinehome-server.info>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Original-Sender: jrnieder@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of jrnieder@gmail.com designates 2607:f8b0:4002:c01::22c
 as permitted sender) smtp.mail=jrnieder@gmail.com;       dkim=pass
 header.i=@gmail.com;       dmarc=pass (p=NONE dis=NONE) header.from=gmail.com
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
Content-Disposition: inline
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239746>

Hi,

Johannes Schindelin wrote:

> While regular commit histories hardly win comprehensibility in general
> if they merge more than twenty-two branches in one go, it is not Git's
> business to limit grafts in such a way.

Fun. :)  Makes sense.

[...]
> ---
>  builtin/blame.c |  8 ++++----
>  commit.c        | 10 +++++-----
>  2 files changed, 9 insertions(+), 9 deletions(-)

Is this easy to reproduce so some interested but lazy person could
write a test?

[...]
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

If there is no newline at EOF, this will skip the last line, while the
old behavior was to pay attention to it.  I haven't thought through
whether that's a good or bad change.  Maybe it should just be
documented?

[...]
> --- a/commit.c
> +++ b/commit.c
> @@ -196,19 +196,19 @@ static int read_graft_file(const char *graft_file)
[...]
> -	while (fgets(buf, sizeof(buf), fp)) {
> +	while (!strbuf_getwholeline(&buf, fp, '\n')) {

Likewise.

The rest of the patch looks good.

Merry christmas,
Jonathan

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
