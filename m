From: "pradeep singh rautela" <rautelap@gmail.com>
Subject: Re: [PATCH] gitignore(5): Allow "foo/" in ignore list to match directory "foo"
Date: Thu, 31 Jan 2008 17:26:18 +0530
Message-ID: <6bc632150801310356w1b2fa019n87d92986aed807c5@mail.gmail.com>
References: <6bc632150801230554l3b24e1e4lb4641bf7c16857c0@mail.gmail.com>
	 <47A06EF9.60704@users.sourceforge.net>
	 <7vprvjgi9v.fsf@gitster.siamese.dyndns.org>
	 <47A1733E.9040103@users.sourceforge.net>
	 <7vhcgue5nr.fsf_-_@gitster.siamese.dyndns.org>
	 <7v63xae4lf.fsf_-_@gitster.siamese.dyndns.org>
	 <20080131094124.GA25546@coredump.intra.peff.net>
	 <7vfxwecmfe.fsf@gitster.siamese.dyndns.org>
	 <20080131104256.GF25546@coredump.intra.peff.net>
	 <alpine.LSU.1.00.0801311128190.23907@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Jeff King" <peff@peff.net>, "Junio C Hamano" <gitster@pobox.com>,
	"Adam Piatyszek" <ediap@users.sourceforge.net>,
	"Linus Torvalds" <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jan 31 12:57:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JKY2O-0007Od-HP
	for gcvg-git-2@gmane.org; Thu, 31 Jan 2008 12:57:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757659AbYAaL4W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jan 2008 06:56:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756448AbYAaL4W
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Jan 2008 06:56:22 -0500
Received: from hs-out-0708.google.com ([64.233.178.245]:4661 "EHLO
	hs-out-2122.google.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751743AbYAaL4V (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jan 2008 06:56:21 -0500
Received: by hs-out-2122.google.com with SMTP id 54so582557hsz.5
        for <git@vger.kernel.org>; Thu, 31 Jan 2008 03:56:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=w+Poc+pS7yEllCTAjQ6qniKjWztkr/noBpjKUXAHNuY=;
        b=ard1aumnF4xOhi5wlhLFQXunaumSFW15Eq/zAdx9pDP8LT7KRJ5KPYDxsESRTWGpvOijFjrg35Ks9iWYCGNwDza4wYphbV5Y5WPzmEJeyqQYHZIPKkKT1/lNZ1NNWabbp6b8h7XPwgnt543Zt2i6+BnDUwbaKFLFlbiYu9eN3xA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=CfNCRlwhROcGCv7R8Z9TASQf2PVkaQuO5KCWIFbz6F8Yfgaitmfs8whmB+rNVIPreJOOltoc/MMaW7ldp3XYrEa2cTtOxY0B9jCpJw+mXVpSPa+aVCAhfjvwS30r1ykwBZFN9ZVkr0SKJEvTnQJM5/ZSX8F/JB/64XJhjcNBZW0=
Received: by 10.142.125.5 with SMTP id x5mr1048264wfc.40.1201780578422;
        Thu, 31 Jan 2008 03:56:18 -0800 (PST)
Received: by 10.143.12.19 with HTTP; Thu, 31 Jan 2008 03:56:18 -0800 (PST)
In-Reply-To: <alpine.LSU.1.00.0801311128190.23907@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72129>

On 31/01/2008, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
[snip]
>
> Just to add my two eurocents: I think the patch is complicated enough that
> we could go the other way round: while parsing the ignore entries, we can
> plainly state that entries with a trailing slash are ignored:
>
> -- snipsnap --
> [PATCH] Warn if an ignore/exclude entry ends in a slash
>
> Git does not like ignore entries ending in a slash; they will be ignored.
> So just be honest and warn the user about it.
>
> Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
>
> ---
>
>  dir.c |    5 +++++
>  1 files changed, 5 insertions(+), 0 deletions(-)
>
> diff --git a/dir.c b/dir.c
> index 1b9cc7a..c3e9a0d 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -135,6 +135,11 @@ void add_exclude(const char *string, const char *base,
>         }
>         x->pattern = string;
>         x->patternlen = strlen(string);
> +       if (x->patternlen && x->pattern[x->patternlen - 1] == '/') {
> +               warning("Ignoring ignore entry because of trailing slash: %s",
> +                       string);

How about something like,
                  warning("Ignoring ignore entry because of trailing
slash: %s\n Remove the trailing slash from the directory name to
ignore it", string);

May be this will help absolute git newbies.
Please ignore this if it sounds like a "too trivial, everyone should
know this" case.

Thanks,
           --Pradeep
> +               return;
> +       }
>         x->base = base;
>         x->baselen = baselen;
>         x->flags = 0;
>


-- 
Pradeep Singh Rautela
http://eagain.wordpress.com
http://emptydomain.googlepages.com
