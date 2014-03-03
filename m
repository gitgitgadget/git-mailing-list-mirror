From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH] commit.c:record_author_date() use skip_prefix() instead
 of starts_with()
Date: Mon, 03 Mar 2014 09:58:56 +0100
Message-ID: <53144450.3080006@alum.mit.edu>
References: <1393703299-7977-1-git-send-email-tanayabh@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Tanay Abhra <tanayabh@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 03 09:59:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKOiq-0001mp-II
	for gcvg-git-2@plane.gmane.org; Mon, 03 Mar 2014 09:59:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754061AbaCCI7B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2014 03:59:01 -0500
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:60547 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753760AbaCCI67 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Mar 2014 03:58:59 -0500
X-AuditID: 1207440d-f79d86d0000043db-f9-5314445218da
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 43.99.17371.25444135; Mon,  3 Mar 2014 03:58:58 -0500 (EST)
Received: from [192.168.69.148] (p57A2466F.dip0.t-ipconnect.de [87.162.70.111])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s238wvxG000489
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Mon, 3 Mar 2014 03:58:58 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20131103 Icedove/17.0.10
In-Reply-To: <1393703299-7977-1-git-send-email-tanayabh@gmail.com>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLKsWRmVeSWpSXmKPExsUixO6iqBvkIhJscOO4tUXXlW4mi18X3jM7
	MHnsnHWX3ePzJrkApihum6TEkrLgzPQ8fbsE7owds0oKZgpWPF74mrWB8RBvFyMnh4SAicTy
	rR+YIGwxiQv31rN1MXJxCAlcZpTYumM+M4Rzjkni4vkuVpAqXgFtibOH74F1sAioSmy68hbM
	ZhPQlVjU0wxmiwoES6y+/IAFol5Q4uTMJ2C2iICKxM9dt4GGcnAwC4hL9P8DCwsLxEt8ODsf
	rFVIwFGiY851NhCbU8BJYvG8XjaQcgmg8p7GIJAws4COxLu+B8wQtrzE9rdzmCcwCs5CsmwW
	krJZSMoWMDKvYpRLzCnN1c1NzMwpTk3WLU5OzMtLLdI10svNLNFLTSndxAgJXt4djP/XyRxi
	FOBgVOLhNVgqHCzEmlhWXJl7iFGSg0lJlPeLo0iwEF9SfkplRmJxRnxRaU5q8SFGCQ5mJRHe
	/GVA5bwpiZVVqUX5MClpDhYlcV61Jep+QgLpiSWp2ampBalFMFkZDg4lCV5LZ6ChgkWp6akV
	aZk5JQhpJg5OkOFcUiLFqXkpqUWJpSUZ8aDojS8Gxi9Iigdor7QTUDtvcUFiLlAUovUUoy7H
	7bZfnxiFWPLy81KlxHm7QYoEQIoySvPgVsBS1StGcaCPhXlFQS7hAaY5uEmvgJYwAS3pNgRb
	UpKIkJJqYJy/z6R9XV295LSt9/m+L5FfbZ07K7G0OGLbt7KdST0sh2ue3E+UnbPBJqj8lbzw
	d5bCHetmTDEK3mZgY+bpIZsipGFoby/vVu9nVFGafOKXytbpB5l/mAmcmaD53sOp 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243201>

The format of this email is wrong.  The non-commit-message notes should
come between the "---" line (<- note, there are three minus signs here)
and the patch itself.

On 03/01/2014 08:48 PM, Tanay Abhra wrote:
> Signed-off-by: Tanay Abhra <tanayabh@gmail.com>
> ---
>  commit.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/commit.c b/commit.c
> index 6bf4fe0..c954ecb 100644
> --- a/commit.c
> +++ b/commit.c
> @@ -566,7 +566,7 @@ static void record_author_date(struct author_date_slab *author_date,
>  	     buf;
>  	     buf = line_end + 1) {
>  		line_end = strchrnul(buf, '\n');
> -		if (!starts_with(buf, "author ")) {
> +		if (!skip_prefix(buf, "author ")) {

If this is the only change, there is not much point, is there?  How does
this help?  Perhaps there is some way to take advantage of the
difference between starts_with() and skip_prefix() to simplify the rest
of the function?

>  			if (!line_end[0] || line_end[1] == '\n')
>  				return; /* end of header */
>  			continue;
> -- 
> 1.7.9.5
> 
> Hello,
> 
> This is my patch for the GSoC microproject #10:
> 
> Rewrite commit.c:record_author_date() to use skip_prefix(). 
> Are there other places in this file where skip_prefix() would be more 
> readable than starts_with()?
> 
> Since skip_prefix() and starts_with() implement the same functionality with different
> return values, they can be interchanged easily.
> 
> Other usage of starts_with() in the same file can be found with
> 
> $ grep -n starts_with commit.c
> 
> 1116:		else if (starts_with(line, gpg_sig_header) &&
> 1196:		if (starts_with(buf, sigcheck_gpg_status[i].check + 1)) {

The rhetorical question that was part of this microproject was meant to
inspire you to actually *FIX* the other spots, at least if the change
makes sense.

> I have a query,should I tackle a bug from the mailing lists or research about the proposal 
> and present a rough draft?

My suggestion is that you follow up on this microproject until it is
perfect before worrying too much about the next step.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
