From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] git-remote: add verbose mode
Date: Mon, 17 Nov 2008 02:15:46 -0800
Message-ID: <7vhc66zmi5.fsf@gitster.siamese.dyndns.org>
References: <1226913150-26088-1-git-send-email-crquan@gmail.com>
 <1226913150-26088-2-git-send-email-crquan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: crquan@gmail.com
X-From: git-owner@vger.kernel.org Mon Nov 17 11:17:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L21Ad-0000ZO-Gv
	for gcvg-git-2@gmane.org; Mon, 17 Nov 2008 11:17:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752817AbYKQKQJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Nov 2008 05:16:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752751AbYKQKQI
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Nov 2008 05:16:08 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:47009 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752724AbYKQKQH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Nov 2008 05:16:07 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 41B387EAC6;
	Mon, 17 Nov 2008 05:16:07 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 57FF17EAC4; Mon,
 17 Nov 2008 05:15:53 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: BF86F388-B490-11DD-883D-9CEDC82D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101207>

crquan@gmail.com writes:

> From: Denis ChengRq <crquan@gmail.com>
>
> Signed-off-by: Cheng Renquan <crquan@gmail.com>

Your other one (I am assuming the other one is also from you) has "From:
Cheng Renquan <crquan@gmail.com>" and this is "From: Denis ChengRq
<crquan@gmail.com>".  We'd prefer to keep the same person under a single
name in "git shortlog" list.  Under which name do you want to be known?

Please describe in what sense this is "verbose", iow, what additional
information is added by this patch, in your proposed commit log message.

> @@ -40,10 +40,13 @@ static int opt_parse_track(const struct option *opt, const char *arg, int not)
>  	return 0;
>  }
>  
> -static int fetch_remote(const char *name)
> +static int fetch_remote(const char *name, const char *url)
>  {
>  	const char *argv[] = { "fetch", name, NULL };
> -	printf("Updating %s\n", name);
> +	if (verbose)
> +		printf("Updating %s (%s)\n", name, url);

Are you guaranteeing that url is not NULL at this point in the code?
If so how?

How does this "--verbose" command the users give "git remote" relate to
the "--verbose" option the underlying "git fetch" has?  IOW, do you tell
"git fetch" to be verbose as well?  If so, how?  If not, why not?
