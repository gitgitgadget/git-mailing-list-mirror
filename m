From: Kevin Daudt <me@ikke.info>
Subject: Re: [PATCH] rev-list: refuse --first-parent combined with --bisect
Date: Sun, 8 Mar 2015 00:13:05 +0100
Message-ID: <20150307231305.GA15619@vps892.directvps.nl>
References: <xmqq61ag72gc.fsf@gitster.dls.corp.google.com>
 <1425763876-15573-1-git-send-email-me@ikke.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Junio C. Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 08 00:13:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YUNuB-0006qJ-JR
	for gcvg-git-2@plane.gmane.org; Sun, 08 Mar 2015 00:13:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753126AbbCGXNI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Mar 2015 18:13:08 -0500
Received: from ikke.info ([178.21.113.177]:36177 "EHLO vps892.directvps.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751838AbbCGXNG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Mar 2015 18:13:06 -0500
Received: by vps892.directvps.nl (Postfix, from userid 1001)
	id 440D31DCF6D; Sun,  8 Mar 2015 00:13:05 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1425763876-15573-1-git-send-email-me@ikke.info>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265009>

On Sat, Mar 07, 2015 at 10:31:16PM +0100, Kevin Daudt wrote:
> diff --git a/builtin/rev-list.c b/builtin/rev-list.c
> index ff84a82..c271e15 100644
> --- a/builtin/rev-list.c
> +++ b/builtin/rev-list.c
> @@ -291,6 +291,9 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
>  	if (revs.bisect)
>  		bisect_list = 1;
>  
> +	if(revs.first_parent_only && revs.bisect)

I should have added a space after the if.

> +		die(_("--first-parent is incompattible with --bisect"));
> +
>  	if (DIFF_OPT_TST(&revs.diffopt, QUICK))
>  		info.flags |= REV_LIST_QUIET;
>  	for (i = 1 ; i < argc; i++) {
