From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] reset: update help text
Date: Tue, 29 Mar 2011 16:04:57 -0500
Message-ID: <20110329210457.GA14031@elie>
References: <1301404805-12095-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Christian Couder <chriscool@tuxfamily.org>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Thomas Rast <trast@student.ethz.ch>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 29 23:05:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4g6E-000726-TA
	for gcvg-git-2@lo.gmane.org; Tue, 29 Mar 2011 23:05:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754632Ab1C2VFI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Mar 2011 17:05:08 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:43065 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754625Ab1C2VFF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Mar 2011 17:05:05 -0400
Received: by gwaa18 with SMTP id a18so255894gwa.19
        for <git@vger.kernel.org>; Tue, 29 Mar 2011 14:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=tRMqImwDWC+tU9jyKBuaBX7xUXs/gWp7jVEDZ/Z6ztg=;
        b=Ek4Hr+fFtrdwWywCyRtkj+u8O0OVCeWEvJLRfuVKp5PnZxyYlGMesq+tZ+Obz3gYpe
         G6J8lA6nu4skR9GUEijD/q9rPRaA4fu2jt2T0TjPbmkulu8AN52Qao5UdXZOJt6nCTK2
         tMKptqOK3hDxaIOO+hau2luSl31xT+k0MGCus=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=E58rmNnfDubM/bUxHSsgEyCrdnqWN1RSokwmEam2vvyH6fietl9LjxxcExFedYdoNA
         /pdNdGbtiqxyf/5PDug65yESGu3XOTgkmYJLEcDLGUnBYfgB3MvgfBKxAWHoqs6fmbur
         Gc5xzgppZ3sAH92J9imU1J4cQiAQQO2IDRTD0=
Received: by 10.150.214.8 with SMTP id m8mr645611ybg.121.1301432704463;
        Tue, 29 Mar 2011 14:05:04 -0700 (PDT)
Received: from elie (adsl-76-206-232-54.dsl.chcgil.sbcglobal.net [76.206.232.54])
        by mx.google.com with ESMTPS id v15sm2369528ybk.6.2011.03.29.14.05.02
        (version=SSLv3 cipher=OTHER);
        Tue, 29 Mar 2011 14:05:03 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1301404805-12095-1-git-send-email-pclouds@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170327>

(+cc: Christian, Michael, and Thomas)
Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:

> State --mixed is the default so users don't have to open up man page.
>
> Also make it clear how --hard and --merge are different.

Thanks; I think the goal of this patch is a good one.

> --- a/builtin/reset.c
> +++ b/builtin/reset.c
> @@ -243,17 +243,17 @@ int cmd_reset(int argc, const char **argv, cons=
t char *prefix)
>  	struct commit *commit;
>  	char *reflog_action, msg[1024];
>  	const struct option options[] =3D {
> -		OPT__QUIET(&quiet, "be quiet, only report errors"),
>  		OPT_SET_INT(0, "mixed", &reset_type,
> -						"reset HEAD and index", MIXED),
> +				"reset HEAD and index (default)", MIXED),

Nice.

>  		OPT_SET_INT(0, "soft", &reset_type, "reset only HEAD", SOFT),
>  		OPT_SET_INT(0, "hard", &reset_type,
>  				"reset HEAD, index and working tree", HARD),
>  		OPT_SET_INT(0, "merge", &reset_type,
> -				"reset HEAD, index and working tree", MERGE),
> +				"like --hard but keep local changes in working tree", MERGE),
>  		OPT_SET_INT(0, "keep", &reset_type,
>  				"reset HEAD but keep local changes", KEEP),

The description does not make it obvious to me how these two (--merge
and --keep) differ.  I think the intent of the options are:

 --keep:
	start working on a different commit, carrying over local changes
	(like "git checkout")
 --merge:
	return to <commit>, cancelling a merge-like operation that
	creates some unmerged and some clean index entries

Maybe something along these lines could be ok starting point?

	OPT_SET_INT(0, "keep", &reset_type,
		"move to <commit>, carrying over local changes in working tree",
		KEEP),
	OPT_SET_INT(0, "merge", &reset_type,
		"return to <commit>, cancelling failed merge or cherry-pick",
		MERGE),
