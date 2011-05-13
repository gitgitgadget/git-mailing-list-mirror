From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: [RFC PATCH 0/2] better handle .gitmodules merge conflicts
Date: Fri, 13 May 2011 11:01:09 -0400
Message-ID: <4DCD47B5.8050505@xiplink.com>
References: <4DCC4A9D.3060007@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Fri May 13 17:11:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QKu1t-0003Wp-J8
	for gcvg-git-2@lo.gmane.org; Fri, 13 May 2011 17:11:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759442Ab1EMPLg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 May 2011 11:11:36 -0400
Received: from smtp182.iad.emailsrvr.com ([207.97.245.182]:54215 "EHLO
	smtp182.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755838Ab1EMPLf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 May 2011 11:11:35 -0400
X-Greylist: delayed 621 seconds by postgrey-1.27 at vger.kernel.org; Fri, 13 May 2011 11:11:35 EDT
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp38.relay.iad1a.emailsrvr.com (SMTP Server) with ESMTP id 8D35D3484E1;
	Fri, 13 May 2011 11:01:13 -0400 (EDT)
X-Virus-Scanned: OK
Received: by smtp38.relay.iad1a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id 52BEC34821E;
	Fri, 13 May 2011 11:01:13 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.17) Gecko/20110424 Thunderbird/3.1.10
In-Reply-To: <4DCC4A9D.3060007@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173543>

On 11-05-12 05:01 PM, Jens Lehmann wrote:
> This series contains a test to reproduce and a first attempt to fix the
> problem that "git diff", "git status" and "git fetch" die early when the
> .gitmodules file contains merge conflict markers. As I am not aware of any
> bug reports yet it looks like that either doesn't happen very often in the
> wild ("git diff" parses the .gitmodules file since 1.7.3, but even as
> heavy submodule users we only hit this once just recently) or the users
> encountering this problem just know what to do: resolve the conflict and
> carry on.

I fell in the latter camp when I ran into this.

I like to examine conflicts with "git gui" but IIRC it doesn't display any
conflicting files when there's a conflict in .gitmodules (it won't even
display conflicts in other files, presumably because some plumbing failed
early on the .gitmodules conflict).  That was quite a "WTF?" moment...

> But that is no excuse to behave so unfriendly, especially as this can
> happen in a completely normal workflow, when e.g. two users are adding
> different submodules in separate branches and they get merged. So this
> RFC patch is my first attempt to avoid those commands dying.

Yup -- thanks for addressing this!

		M.
