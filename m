From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH V3 2/2] user-manual: add section documenting shallow clones
Date: Wed, 23 Dec 2015 02:47:17 -0500
Message-ID: <CAPig+cRMdpJ-k9L33jE01ubfK6MOWNGwuoUULuQqOv8C0we+DQ@mail.gmail.com>
References: <CAPig+cQOAGzQMj5oNMEsD0u7Wqj80kyyYcOwi-Y0q1yHtX4s4A@mail.gmail.com>
	<1450842827-14115-1-git-send-email-ischis2@cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: "Stephen P. Smith" <ischis2@cox.net>
X-From: git-owner@vger.kernel.org Wed Dec 23 08:48:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aBe9R-0002bL-I2
	for gcvg-git-2@plane.gmane.org; Wed, 23 Dec 2015 08:48:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933520AbbLWHr2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Dec 2015 02:47:28 -0500
Received: from mail-vk0-f52.google.com ([209.85.213.52]:36582 "EHLO
	mail-vk0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933387AbbLWHrS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Dec 2015 02:47:18 -0500
Received: by mail-vk0-f52.google.com with SMTP id f2so91019863vkb.3
        for <git@vger.kernel.org>; Tue, 22 Dec 2015 23:47:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=5/m8f9nbdt7gTCkVwCHwBcF6JEyOyl+82xugXzpqscc=;
        b=jVJDYjd8Cgn8EE/Mf2THBuXrdZUw8swm4OSaC2lhUzh8FlRiCkamEXwgPs5Gpw7iU3
         +NLNAvbucw2BiVkvAgR53m3Hit6iKFO9hwvuFjGkE4secp3Zh7+VRYasufu7RoeJlGQ/
         DEyR3YDQNNKWCN5DQk+EACwIcOmzg8dIMbwpEuZssBkNQ97f9DVDc2iXJotnQGjUfBDu
         Ubn36hhO1dVexPyAls92mWWUxf11belAFxVqUgYqFZnQp+QxgZ3CwXEbFGkobK398kTk
         TRh6LHUyMolwoNZ533CI36cS/zw5wGxA6mWrM+TKL9TUJd/U+AV2BZhxG1ibPZb/+h9t
         imOg==
X-Received: by 10.31.47.130 with SMTP id v124mr18634821vkv.117.1450856837916;
 Tue, 22 Dec 2015 23:47:17 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Tue, 22 Dec 2015 23:47:17 -0800 (PST)
In-Reply-To: <1450842827-14115-1-git-send-email-ischis2@cox.net>
X-Google-Sender-Auth: iLI_BKivykE4jbyGBIbSK_isx9k
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282926>

On Tue, Dec 22, 2015 at 10:53 PM, Stephen P. Smith <ischis2@cox.net> wrote:
> Rather than merely pointing readers at the 1.5 release notes to
> learn about shallow clones, document them formally.

Thanks, this version looks better. A few comment below...

> Signed-off-by: Stephen P. Smith <ischis2@cox.net>
> ---

Right here, below the "---" line is a good place to describe what
changed since the previous version. It's also reviewer-friendly to
include a link to the last attempt, like this [1].

[1]: http://thread.gmane.org/gmane.comp.version-control.git/282828

>  Documentation/user-manual.txt | 21 ++++++++++++++++++---
>  1 file changed, 18 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
> @@ -2128,6 +2128,24 @@ The gitweb cgi script provides users an easy way to browse your
>  project's files and history without having to install Git; see the file
>  gitweb/INSTALL in the Git source tree for instructions on setting it up.
>
> +[[how-to-get-a-git-repository-with-minimal-history]]
> +How to get a Git repository with minimal history
> +------------------------------------------------
> +
> +A <<def_shallow_clone,shallow clone>> is useful when the recent
> +history of a project is needed and getting real history recorded in

Saying "full history" rather than "real history" might read better and
be more meaningful. Also, perhaps say "from the upstream" rather than
"recorded in the upstream".

> +the upstream is expensive. The resultant cloned <<def_repository,repository>>
> +has truncated history. This clone could be used to look at history
> +near the tip of a branch and contribute email patches to the project.

The final sentence pretty much just repeats what the first sentence
said, thus doesn't really add any value, thus perhaps ought to be
dropped.

A possible rewrite of the above paragraph:

    A <<def_shallow_clone,shallow clone>>, with its truncated
    history, is useful when one is interested only in recent history
    of a project and getting full history from the upstream is
    expensive.

> +A <<def_shallow_clone,shallow clone>> is created by specifying the
> +depth when creating a clone of a repository using the
> +linkgit:git-clone[1] `--depth` switch.  The depth can later be changed
> +by using the linkgit:git-fetch[1] `--depth` switch.  If there is later
> +a need to fetch the entire history and if the source repository is
> +complete, the linkgit:git-fetch[1] `--unshallow` switch can be used to
> +convert a shallow repository to a complete one.

Taken together, the last two sentences are a bit wordy. I wonder if
combining them and being somewhat more laconic would help:

    A <<def_shallow_clone,shallow clone>> is created by specifying
    the linkgit:git-clone[1] `--depth` switch. The depth can later be
    changed with the linkgit:git-fetch[1] `--depth` switch, or full
    history restored with `--unshallow`.

>  [[sharing-development-examples]]
>  Examples
>  --------
> @@ -4645,9 +4663,6 @@ standard end-of-chapter section?
>
>  Include cross-references to the glossary, where appropriate.
>
> -Document shallow clones?  See draft 1.5.0 release notes for some
> -documentation.
> -
>  Add a section on working with other version control systems, including
>  CVS, Subversion, and just imports of series of release tarballs.
>
> --
> 2.6.3.368.gf34be46
