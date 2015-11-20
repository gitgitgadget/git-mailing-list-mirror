From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v4 09/12] Add several uses of get_object_hash.
Date: Fri, 20 Nov 2015 06:38:30 -0500
Message-ID: <20151120113830.GF11198@sigill.intra.peff.net>
References: <1447122150-672570-1-git-send-email-sandals@crustytoothpaste.net>
 <1447122150-672570-10-git-send-email-sandals@crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Fri Nov 20 12:38:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zzk1Y-0006iV-1P
	for gcvg-git-2@plane.gmane.org; Fri, 20 Nov 2015 12:38:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934360AbbKTLif (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Nov 2015 06:38:35 -0500
Received: from cloud.peff.net ([50.56.180.127]:60073 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757406AbbKTLie (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Nov 2015 06:38:34 -0500
Received: (qmail 19541 invoked by uid 102); 20 Nov 2015 11:38:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 20 Nov 2015 05:38:35 -0600
Received: (qmail 26709 invoked by uid 107); 20 Nov 2015 11:39:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 20 Nov 2015 06:39:06 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 20 Nov 2015 06:38:30 -0500
Content-Disposition: inline
In-Reply-To: <1447122150-672570-10-git-send-email-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281509>

On Tue, Nov 10, 2015 at 02:22:27AM +0000, brian m. carlson wrote:

> diff --git a/patch-ids.c b/patch-ids.c
> index bf81b923..83229a0d 100644
> --- a/patch-ids.c
> +++ b/patch-ids.c
> @@ -8,10 +8,10 @@ static int commit_patch_id(struct commit *commit, struct diff_options *options,
>  		    unsigned char *sha1)
>  {
>  	if (commit->parents)
> -		diff_tree_sha1(commit->parents->item->object.sha1,
> -		               commit->object.sha1, "", options);
> +		diff_tree_sha1(get_object_hash(commit->parents->item->object),
> +		               get_object_hash(commit->object), "", options);

I haven't looked carefully at this series yet, but while applying I
noticed that git complained about whitespace here (long run of spaces
which could be using tabs).

I've fixed it up for what I'm queuing, but you may want to do so
locally, too.

-Peff
