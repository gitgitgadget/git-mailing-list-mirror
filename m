From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: [PATCH v2 0/7] Teach fetch/pull the on-demand mode and make it
 the default
Date: Wed, 02 Mar 2011 11:09:29 -0500
Message-ID: <4D6E6BB9.9000904@xiplink.com>
References: <4D6D7A50.5090802@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Wed Mar 02 17:08:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Puobe-0002Zf-Ob
	for gcvg-git-2@lo.gmane.org; Wed, 02 Mar 2011 17:08:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754333Ab1CBQIu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Mar 2011 11:08:50 -0500
Received: from smtp112.iad.emailsrvr.com ([207.97.245.112]:40612 "EHLO
	smtp112.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751384Ab1CBQIt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Mar 2011 11:08:49 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp51.relay.iad1a.emailsrvr.com (SMTP Server) with ESMTP id 46F6B20C47;
	Wed,  2 Mar 2011 11:08:49 -0500 (EST)
X-Virus-Scanned: OK
Received: by smtp51.relay.iad1a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id 03F4020C30;
	Wed,  2 Mar 2011 11:08:48 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.13) Gecko/20101208 Thunderbird/3.1.7
In-Reply-To: <4D6D7A50.5090802@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168319>

On 11-03-01 05:59 PM, Jens Lehmann wrote:
> So here is version 2 of the on-demand recursive fetch for submodules.
> 
> Changes since the last version:
> 
> *) Add a name parameter to parse_fetch_recurse_submodules_arg()
> *) Enhance description of the "--submodule-default" fetch option
> *) Free the changed_submodule_paths string_list at the end of
>    fetch_populated_submodules() to aid libification and to make
>    valgrind happy
> *) Add a comment for the while loop in check_for_new_submodule_commits()
> *) Use "--all" instead of "--branches" and "--remotes" for rev-list to
>    include tags too
> *) Compute the argc value properly instead of hard coding it in
>    check_for_new_submodule_commits()
> *) Change size_t casts to intptr_t where appropriate
> *) Use "rev-list --not --all" when checking if a submodule commit exists
>    instead of a simple lookup/rev-parse to make sure they are not only
>    present but are reachable from a ref
> *) Describe that fetch and pull only work on populated submodules for
>    now in the BUGS section of their man pages (done in a separate commit
>    because this doesn't belong to a special commit in this series but
>    also to the functionality that has already been merged)
> 
> Thanks to Jonathan an Junio for the feedback that lead to these changes.
> 
> Issues that were raised but not addressed yet:
> 
> *) Should this option be called "on-demand" or "changed" or maybe even
>    "updated"?
>    I have no strong feelings about this, me just thinks the name should
>    tell somehow that only submodules where new commits are recorded in
>    the superproject which aren't already present locally will be fetched.
>    Opinions?

First, thanks again for this work!

I have a slight preference for "updated" or "updated-only", but no really
strong feelings either way.

		M.
