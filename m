From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH 0/3] "git config --get-urlmatch $section.$key $url"
Date: Wed, 31 Jul 2013 18:59:59 +0100
Message-ID: <51F9509F.60402@ramsay1.demon.co.uk>
References: <7vli4v66b3.fsf@alter.siamese.dyndns.org> <1375138150-19520-1-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Kyle J. McKay" <mackyle@gmail.com>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 31 20:02:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V4ajO-0008FU-6o
	for gcvg-git-2@plane.gmane.org; Wed, 31 Jul 2013 20:02:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757012Ab3GaSCe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Jul 2013 14:02:34 -0400
Received: from mdfmta010.mxout.tbr.inty.net ([91.221.168.51]:51547 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752575Ab3GaSCd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Jul 2013 14:02:33 -0400
Received: from mdfmta010.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta010.tbr.inty.net (Postfix) with ESMTP id C127C6F86E5;
	Wed, 31 Jul 2013 19:02:32 +0100 (BST)
Received: from mdfmta010.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta010.tbr.inty.net (Postfix) with ESMTP id 293806F85A9;
	Wed, 31 Jul 2013 19:02:32 +0100 (BST)
Received: from [193.237.126.196] (unknown [193.237.126.196])
	by mdfmta010.tbr.inty.net (Postfix) with ESMTP;
	Wed, 31 Jul 2013 19:02:31 +0100 (BST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130620 Thunderbird/17.0.7
In-Reply-To: <1375138150-19520-1-git-send-email-gitster@pobox.com>
X-MDF-HostID: 3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231441>

Junio C Hamano wrote:
> So here is a bit of refactoring to extract the logic to find the
> entry $section.<urlpattern>.$key from the configuration that best
> matches the given $url to answer "what value $section.$key should be
> for $url?" out of http.c (primarily because we never want to link
> "git cofnig" with the cURL library), and use it from "git config" to
> implement Peff's idea to extend "git config".
> 
> The first step is a pure code movement, plus some renaming of the
> functions.
> 
> The second step is to factor out the code to handle --bool, --int, etc.
> as a helper so that the new codepath can use it.
> 
> The last step currently duplicates the logic in http_options(), but
> we might want to refactor it further so that the two functions can
> share more code.  We hopefully can get rid of test-url-normalize and
> instead use "git config --get-urlmatch" in the tests that protect
> the http.<url>.config topic.

I haven't been following this topic too closely and I don't have any
feel for how long it will take to get to the end-game. However, unless
the removal of test-url-normalize is coming soon, could I request that
you apply my patch (or squash it into this series)? At present, I have
to apply the patch before building the next and pu branches; OK it's not
too onerous, but still ... :-P


ATB,
Ramsay Jones
