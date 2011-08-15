From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: Core dump on commit
Date: Mon, 15 Aug 2011 22:12:18 +0700
Message-ID: <CACsJy8AL5D938HA-sQkFkn_d9xuT2Vw8BKfD-h+V=iEkNrS1eA@mail.gmail.com>
References: <loom.20110815T162144-798@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Marko Vukovic <amasniko@yahoo.com>
X-From: git-owner@vger.kernel.org Mon Aug 15 17:12:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QsyqV-0005tg-3H
	for gcvg-git-2@lo.gmane.org; Mon, 15 Aug 2011 17:12:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754498Ab1HOPMu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Aug 2011 11:12:50 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:63323 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754467Ab1HOPMt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Aug 2011 11:12:49 -0400
Received: by bke11 with SMTP id 11so3057133bke.19
        for <git@vger.kernel.org>; Mon, 15 Aug 2011 08:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=n13EYIB1jlG+LgCZuZR9DgOtEWm4dQ7ec2SD/YmyTjg=;
        b=J0lv8+tjJQ0H4XQHAPV6dgK9uFvGVBo5KNjy6HLjgfb3/BreUK5GhqeZH6yNSJggOt
         6SqaOjOIVTfS3rqsgpjkohPNg/KzMkUQ2zUY/Mh4QNO8BKYZK4hpxoCxvAU8vPpkTTEr
         ocNh9mOiTs1spjn7pgRZXrGEojQve5F3tHjI4=
Received: by 10.205.34.130 with SMTP id ss2mr975210bkb.175.1313421168153; Mon,
 15 Aug 2011 08:12:48 -0700 (PDT)
Received: by 10.204.156.19 with HTTP; Mon, 15 Aug 2011 08:12:18 -0700 (PDT)
In-Reply-To: <loom.20110815T162144-798@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179370>

On Mon, Aug 15, 2011 at 9:30 PM, Marko Vukovic <amasniko@yahoo.com> wrote:
> I get this error after running "git commit"
>
> error: Object 42504431bac2e2054483c1bbc35f1b535f8d11bb is a tag, not a commit
> Segmentation fault (core dumped)

Can you get the stack trace? Does HEAD point to
42504431bac2e2054483c1bbc35f1b535f8d11bb (iow what does "git rev-parse
HEAD" say).

> "git cat-file -p 42504431bac2e2054483c1bbc35f1b535f8d11bb" gives this:
>
> object 1b9a97613307b5c7bbc189a0e41506cb1534740a
> type commit
> tag v1.0
> tagger marko <marko@bib> Sun Aug 14 20:42:12 2011 -0400
>
> The first release

If HEAD does point to 42504431, I think you can do "git reset
1b9a976133" to reset the HEAD back to a commit object (as oppose to a
tag)

But please backup the repository somewhere, I'm still not sure how you
get into this situation. The repo may help.
--
Duy
