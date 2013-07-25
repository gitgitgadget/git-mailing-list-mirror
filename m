From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: [PATCH] git-tag man: when to use lightweight or annotated tags
Date: Thu, 25 Jul 2013 10:47:43 -0400
Message-ID: <51F13A8F.9040400@xiplink.com>
References: <51EFA9A9.4010103@gmail.com> <7vtxjj66kn.fsf@alter.siamese.dyndns.org> <51F12BE6.80606@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Daniele Segato <daniele.segato@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 25 16:56:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V2MyG-0008Em-M2
	for gcvg-git-2@plane.gmane.org; Thu, 25 Jul 2013 16:56:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756101Ab3GYO4o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Jul 2013 10:56:44 -0400
Received: from smtp172.dfw.emailsrvr.com ([67.192.241.172]:54838 "EHLO
	smtp172.dfw.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755884Ab3GYO4n (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jul 2013 10:56:43 -0400
X-Greylist: delayed 527 seconds by postgrey-1.27 at vger.kernel.org; Thu, 25 Jul 2013 10:56:43 EDT
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp7.relay.dfw1a.emailsrvr.com (SMTP Server) with ESMTP id 8B2892584D7;
	Thu, 25 Jul 2013 10:47:55 -0400 (EDT)
X-Virus-Scanned: OK
Received: by smtp7.relay.dfw1a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id 7FB7C25852E;
	Thu, 25 Jul 2013 10:47:34 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130623 Thunderbird/17.0.7
In-Reply-To: <51F12BE6.80606@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231137>

On 13-07-25 09:45 AM, Daniele Segato wrote:
> From d0f4eca712e7cf74286bfab306763a8a571b6c95 Mon Sep 17 00:00:00 2001
> From: Daniele Segato <daniele.segato@gmail.com>
> Date: Thu, 25 Jul 2013 15:33:18 +0200
> Subject: [PATCH] git-tag man: when to use lightweight or annotated tags
> 
> stress the difference between the two with suggestion on when the user
> should use one in place of the other.
> 
> Signed-off-by: Daniele Segato <daniele.segato@gmail.com>
> ---
>  Documentation/git-tag.txt |    4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
> index 22894cb..48f5504 100644
> --- a/Documentation/git-tag.txt
> +++ b/Documentation/git-tag.txt
> @@ -36,6 +36,10 @@ are absent, `-a` is implied.
>  Otherwise just a tag reference for the SHA-1 object name of the commit
> object is
>  created (i.e. a lightweight tag).
> 
> +Annotated and Lightweight tags are not the same thing for git and you shouldn't
> +mix them up. Annotated tags are meant for release while lightweight tags are
> +meant to tag random commits.

Unfortunately the word "annotated" hasn't yet been introduced at this point,
so the overall effect is even more confusing.  Also, I find the "release" vs.
"random" distinction a bit misleading since both types of tag can refer to
any object.  I also liked the direction of your earlier "command only
consider annotated tags by default" phrasing.

After reading the Tagging section of the Git Book[1] I came up with the
following.  Feel free to modify it as you like, or ignore it completely:

Tag objects (created with -a) are called annotated tags.  While a lightweight
tag is simply a name for an object (usually a commit object), an annotated
tag contains the creation date, the tagger's name and e-mail, a tagging
message, and can be signed and verified with GNU Privacy Guard (GnuPG).  Most
git commands only consider annotated tags by default.  In general lightweight
tags are for private or temporary object labels, while annotated tags are
meant to be permanent and/or published.  For example, an annotated tag is
normally used to identify a release point.

		M.

[1] http://git-scm.com/book/en/Git-Basics-Tagging
