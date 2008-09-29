From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] doc: enhance git describe --tags help
Date: Mon, 29 Sep 2008 08:01:27 -0700
Message-ID: <20080929150127.GB18340@spearce.org>
References: <ce513bcc0809280648s352cda3fj5eb35b6e9cd40af9@mail.gmail.com> <20080928135526.GG5302@artemis.corp> <ce513bcc0809280729p47cc3790nb77b3cae8b805221@mail.gmail.com> <20080928143949.GH5302@artemis.corp> <20080928150318.GI5302@artemis.corp> <20080928151259.GJ5302@artemis.corp>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Erez Zilber <erezzi.list@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	open-iscsi@googlegroups.com, Junio C Hamano <gitster@pobox.com>
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Mon Sep 29 17:03:20 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KkKGj-0001nk-H8
	for gcvg-git-2@gmane.org; Mon, 29 Sep 2008 17:02:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751556AbYI2PB2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Sep 2008 11:01:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751502AbYI2PB2
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Sep 2008 11:01:28 -0400
Received: from george.spearce.org ([209.20.77.23]:49256 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751328AbYI2PB2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Sep 2008 11:01:28 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 711013835F; Mon, 29 Sep 2008 15:01:27 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20080928151259.GJ5302@artemis.corp>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97017>

Pierre Habouzit <madcoder@debian.org> wrote:
> diff --git a/Documentation/git-describe.txt b/Documentation/git-describe.txt
> index c4dbc2a..9cc8c2f 100644
> --- a/Documentation/git-describe.txt
> +++ b/Documentation/git-describe.txt
> @@ -30,7 +30,8 @@ OPTIONS
>  
>  --tags::
>  	Instead of using only the annotated tags, use any tag
> -	found in `.git/refs/tags`.
> +	found in `.git/refs/tags`. Though if an annotated tag is found in the
> +	ancestry, it will always be preferred to lightweight tags.

As technically correct as the statement is, I read this and go
"why do we even have --tags?".

If I read builtin-describe.c right we only honor --tags on an exact
match, or if there are no annotated tags at all in the history.
I wonder if docs like this aren't better for --tags:

--tags::
	If a lightweight tag exactly matches, output it.  If no
	annotated tag is found in the ancestry but a lightweight
	tag is found, output the lightweight tag.

?

-- 
Shawn.
