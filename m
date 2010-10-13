From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: [RFC] Hidden refs
Date: Wed, 13 Oct 2010 12:14:00 -0400
Message-ID: <4CB5DAC8.7000004@xiplink.com>
References: <3305459.485811.1286983945370.JavaMail.root@mail.hq.genarts.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Stephen Bash <bash@genarts.com>
X-From: git-owner@vger.kernel.org Wed Oct 13 18:13:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P63xE-0006WU-4r
	for gcvg-git-2@lo.gmane.org; Wed, 13 Oct 2010 18:13:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751701Ab0JMQNS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Oct 2010 12:13:18 -0400
Received: from smtp142.iad.emailsrvr.com ([207.97.245.142]:48434 "EHLO
	smtp142.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751438Ab0JMQNS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Oct 2010 12:13:18 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp44.relay.iad1a.emailsrvr.com (SMTP Server) with ESMTP id 6E86B12828F;
	Wed, 13 Oct 2010 12:13:17 -0400 (EDT)
X-Orig-To: bash@genarts.com
X-Orig-To: git@vger.kernel.org
X-Orig-To: mbranchaud@xiplink.com
X-Virus-Scanned: OK
Received: by smtp44.relay.iad1a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id 46149128288;
	Wed, 13 Oct 2010 12:13:17 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.12) Gecko/20100915 Thunderbird/3.0.8
In-Reply-To: <3305459.485811.1286983945370.JavaMail.root@mail.hq.genarts.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158942>

On 10-10-13 11:32 AM, Stephen Bash wrote:
>> So I'm wondering if it makes sense to properly support hidden 
>> directories in refs/, and what it would take to do so. (I image, for
>> example, that things would behave quite differently on Windows...)
>> 
>> Thoughts?
> 
> We currently use refs/hidden/heads and refs/hidden/tags for hidden refs.
> It does require calling 'gitk --branches --tags' rather than 'gitk --all',
> but otherwise I like the behavior (git branch only lists refs/heads, git
> tag only lists ref/tags).  And they never get cloned by default (they can
> still be fetched when needed).

Hmm, maybe I'm just over-designing.

It's true that we could just use refs/builds (instead of .builds) and that
those refs would need to be explicitly retrieved by anyone who wanted to see
them (which is fine).  And after the builds/ refs are fetched and done with,
it's easy enough to get rid of them with a simple "rm -r .git/refs/builds"

It appears all I'm looking for is a way to avoid that rm command.  Seems a
bit silly in the end.

Thanks for the perspective!

		M.
