From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: [PATCH] git-tag man: when to use lightweight or annotated tags
Date: Fri, 26 Jul 2013 10:51:52 -0400
Message-ID: <51F28D08.8050507@xiplink.com>
References: <51EFA9A9.4010103@gmail.com> <7vtxjj66kn.fsf@alter.siamese.dyndns.org> <51F12BE6.80606@gmail.com> <51F13A8F.9040400@xiplink.com> <51F23706.5040009@gmail.com> <51F2375E.1080003@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Daniele Segato <daniele.segato@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 26 16:53:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V2jO9-0001oi-SJ
	for gcvg-git-2@plane.gmane.org; Fri, 26 Jul 2013 16:53:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759137Ab3GZOw4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Jul 2013 10:52:56 -0400
Received: from smtp122.dfw.emailsrvr.com ([67.192.241.122]:43357 "EHLO
	smtp122.dfw.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759212Ab3GZOwz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jul 2013 10:52:55 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp22.relay.dfw1a.emailsrvr.com (SMTP Server) with ESMTP id 6B9D61705E4
	for <git@vger.kernel.org>; Fri, 26 Jul 2013 10:52:55 -0400 (EDT)
X-Virus-Scanned: OK
Received: from smtp106.ord1c.emailsrvr.com (smtp106.ord1c.emailsrvr.com [108.166.43.106])
	by smtp22.relay.dfw1a.emailsrvr.com (SMTP Server) with ESMTPS id 4EE5517054C
	for <git@vger.kernel.org>; Fri, 26 Jul 2013 10:52:55 -0400 (EDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp6.relay.ord1c.emailsrvr.com (SMTP Server) with ESMTP id 0506F981EF;
	Fri, 26 Jul 2013 10:51:42 -0400 (EDT)
X-Virus-Scanned: OK
Received: by smtp6.relay.ord1c.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id B3CB5981A6;
	Fri, 26 Jul 2013 10:51:41 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130623 Thunderbird/17.0.7
In-Reply-To: <51F2375E.1080003@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231187>

On 13-07-26 04:46 AM, Daniele Segato wrote:
> From 34fdcb56e5784699ffa327ebfcd2c5cd99b61d2d Mon Sep 17 00:00:00 2001
> From: Daniele Segato <daniele.segato@gmail.com>
> Date: Thu, 25 Jul 2013 15:33:18 +0200
> Subject: [PATCH] git-tag man: when to use lightweight or annotated tags

When sending a patch to the list it's not necessary to include these headers,
as the git tools will extract them from the email itself.

Also, when sending a revision to a previously posted patch it's customary to
include a revision number, e.g. "[PATCHv2]".

> stress the difference between the two with suggestion on when the user
> should use one in place of the other.
> 
> Signed-off-by: Daniele Segato <daniele.segato@gmail.com>
> ---
>  Documentation/git-tag.txt |    7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
> index 22894cb..5c6284e 100644
> --- a/Documentation/git-tag.txt
> +++ b/Documentation/git-tag.txt
> @@ -26,7 +26,7 @@ to delete, list or verify tags.
>  Unless `-f` is given, the named tag must not yet exist.
> 
>  If one of `-a`, `-s`, or `-u <key-id>` is passed, the command
> -creates a 'tag' object, and requires a tag message.  Unless
> +creates a 'tag' object called 'Annotated tag', and requires a tag message.

1) Don't capitalize "annotated" -- it's not capitalized anywhere else in the
text.  The same goes for "lightweight".

2) I find the phrasing here awkward.  The important thing to convey is that
"annotated tag" is a synonym for "tag object".  The proposed text implies
that there can be other kinds of tag objects that are not annotated tags, but
I don't think that's true.  I've mulled over different ways of introducing
the "annotated tag" term here, but I can't come up with a succinct way to do
it.  I think it's better to just introduce the term later.

> Unless
>  `-m <msg>` or `-F <file>` is given, an editor is started for the user to type
>  in the tag message.
> 
> @@ -36,6 +36,11 @@ are absent, `-a` is implied.
>  Otherwise just a tag reference for the SHA-1 object name of the commit
> object is
>  created (i.e. a lightweight tag).
> 
> +'Annotated' and 'Lightweight' tags are not the same thing for git and you
> shouldn't
> +mix them up. Annotated tags are meant for release while lightweight tags are
> +meant for private or temporary object labels. Most git commands only consider
> +Annotated tags by default.
> +

I'm sorry, but I feel this misses the mark.

It's redundant to say the tag types are not the same thing, since the fact
that they have different names already implies that.  Also, to me the
admonition "you shouldn't mix them up" is just a scary warning that conveys
no helpful information.

Furthermore, I think simply stating that the tag types are meant for
particular uses without explaining why is too glib.  Although it may be
natural in your circumstances to think of the tag types rigidly, I do not
think that's true for all git users and I don't think the documentation
should assume there's a One True Way to use tags.

The text should give readers enough information to decide for themselves how
they want to use the different types of tags.  That's why I included the
annotated tag's contents in my suggestion, so that readers could figure out
which tag type best meets their needs.

What you've proposed is a step in the right direction, but I think you need
to go further.

		M.
