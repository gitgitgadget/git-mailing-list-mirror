From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: Recovering from a loss of sync between git and svn
Date: Mon, 18 Mar 2013 17:09:36 +1100
Message-ID: <CAH3AnroBmiTb45SG4FeL57OXUrXXVWKsvkOa9b2q5eLi7Vvudw@mail.gmail.com>
References: <CAH3Anrq4y54YA=qeEbO5z1FKB7Adg4G8vf4jmPLzLWa6tky0wQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Mar 18 07:10:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UHTGw-0007M4-05
	for gcvg-git-2@plane.gmane.org; Mon, 18 Mar 2013 07:10:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751654Ab3CRGJi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Mar 2013 02:09:38 -0400
Received: from mail-lb0-f171.google.com ([209.85.217.171]:56723 "EHLO
	mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751252Ab3CRGJh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Mar 2013 02:09:37 -0400
Received: by mail-lb0-f171.google.com with SMTP id gg13so4348558lbb.16
        for <git@vger.kernel.org>; Sun, 17 Mar 2013 23:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:content-type;
        bh=6RUGZ5ceqGfcuYYBG8+6b4NpqFwi3Km9HOztL0TGBLc=;
        b=AXm/+6iaVL++pkPN+ZDjPoQZC6lQx5zEx1qd+19hUo9j16/8ZPFRgj8CcVaV4Qq+Ul
         QbOPywYM3gu4cKKFGXWuASDQX8ol3qXLZXSoHQApl9UNvBiayjNb11wjSgv+fybWNAw6
         8u97yID3OYK7WwPtcQOd0/3h5klyxSmYvXZNNEJHfXRAOJK8jdjNMPFnBG6qKFSAUpyQ
         rssOnicQ1yXW6BCGGu6jHJ50qHH9J8lskuojr7yfZVYjGgbVUCXDFa3ADvghkpkGhe5p
         WkoS4njhMeUF7TmGP1OSShZQAnx0fZjVQ/EyJpGoGnkK1HA5PyIExtorLkYAj2FIkdEW
         iyHA==
X-Received: by 10.112.28.41 with SMTP id y9mr5862314lbg.133.1363586976354;
 Sun, 17 Mar 2013 23:09:36 -0700 (PDT)
Received: by 10.114.68.74 with HTTP; Sun, 17 Mar 2013 23:09:36 -0700 (PDT)
In-Reply-To: <CAH3Anrq4y54YA=qeEbO5z1FKB7Adg4G8vf4jmPLzLWa6tky0wQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218394>

Ah, answering my own question....

I can see git svn reset does exactly what I need.

jon.

On Mon, Mar 18, 2013 at 4:03 PM, Jon Seymour <jon.seymour@gmail.com> wrote:
> G'day,
>
> I managed to lose sync between the git-svn repo that I am using to
> track an svn repo. In particular, the git-svn repo lost the content of
> about 5 commits with the net result that the git-svn repo and the svn
> repo it tracks have a difference of opinion about what the contents of
> trunk are for the files involved in the missing commits.
>
> The situation arose because I used --ignore-paths trunk on a
> git-svn-fetch when I was trying to deal with an SVN user that had
> copied trunk into the same SVN tag twice (which caused the source tree
> to be duplicated under the trunk directory of the SVN tag).
>
> I was hoping that --ignore-paths trunk would cause the git-svn copy of
> the tag to exclude the unwanted copy of the trunk directory in the
> tag. Instead, it appears to have caused my fetches of subsequent
> commits to SVN trunk to be empty, resulting in divergence between by
> git-svn repo and the SVN repo itself.
>
> Does anyone have any tips about how I can fix this other than pulling
> the entire SVN repo again?
>
> jon.
