From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH] diff: add --ignore-blank-lines option
Date: Sun, 26 May 2013 22:35:54 +0200
Message-ID: <51A2722A.8040200@kdbg.org>
References: <1369591098-11267-1-git-send-email-apelisse@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Antoine Pelisse <apelisse@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 26 22:36:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ughg5-0006Cr-0R
	for gcvg-git-2@plane.gmane.org; Sun, 26 May 2013 22:36:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755186Ab3EZUgU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 May 2013 16:36:20 -0400
Received: from bsmtp1.bon.at ([213.33.87.15]:27326 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755069Ab3EZUf7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 May 2013 16:35:59 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 21DECCDF88;
	Sun, 26 May 2013 22:35:56 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 13AB319F5DE;
	Sun, 26 May 2013 22:35:55 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130329 Thunderbird/17.0.5
In-Reply-To: <1369591098-11267-1-git-send-email-apelisse@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225571>

Am 26.05.2013 19:58, schrieb Antoine Pelisse:
> The goal of the patch is to introduce the GNU diff
> -B/--ignore-blank-lines as closely as possible. The short option is not
> available because it's already used for "break-rewrites".
> 
> When this option is used, git-diff will not create hunks that simply
> adds or removes empty lines, but will still show empty lines
> addition/suppression if they are close enough to "valuable" changes.

So when an addition or removal of a blank line appears in a hunk that
also has non-blank-line changes, the addition or removal is not treated
specially?

How is a blank line defined? What happens if a line that has only
whitespace is added or removed? I'm thinking of diffs of files with CRLF
line breaks, where the CR would count as whitespace in the line, I think.

> +--ignore-blank-lines::
> +	Ignore changes whose lines are all blank.

I think this is too terse and does not convey what the option really does.

> +test_expect_success 'ignore-blank-lines: only new lines' '
> +	seq 5 >x &&

Please use test_seq instead of seq in all new tests.

-- Hannes
