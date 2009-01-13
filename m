From: Ping Yin <pkufranky@gmail.com>
Subject: Re: "git diff --stat" doesn't show added empty file
Date: Tue, 13 Jan 2009 15:42:22 +0800
Message-ID: <46dff0320901122342q75e3e9e0gfe4e83bc7c60f193@mail.gmail.com>
References: <46dff0320901111936h6343e51fo94750d83e95743dc@mail.gmail.com>
	 <alpine.LFD.2.00.0901120805310.6528@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Jan 13 08:43:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMdwG-0006kB-3Q
	for gcvg-git-2@gmane.org; Tue, 13 Jan 2009 08:43:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754185AbZAMHmY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jan 2009 02:42:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753971AbZAMHmY
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Jan 2009 02:42:24 -0500
Received: from rv-out-0506.google.com ([209.85.198.226]:64233 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754004AbZAMHmX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jan 2009 02:42:23 -0500
Received: by rv-out-0506.google.com with SMTP id k40so10621342rvb.1
        for <git@vger.kernel.org>; Mon, 12 Jan 2009 23:42:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=oQaSljbaiOWl1fKpLC929KUGhfzhmbXhNL7K0OshZtU=;
        b=iZxg3Cr9Mrqk+C3x/iQA9F9qWj8NSSk36pQNw8dSGlKMclSVzFa7rqqjgOXR3PiFIY
         syFEoHGmG83ZAPII2gZOdZfzVwbg1DF7quWAHfr8VorvHhltZQF+KJPitNiAP3i8DEZT
         //to6/lZM8/m/FN/ZtQuRWAO21GJbLzuNxHrM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=e5tKsBueLdDy39P1nVF6N7UpSJ152hO/nxsqYxEdap3ayyOUlxvSKLpNrr3qbUGrud
         jLr8JNiS7qci0t6Bdd1yQ/AmY52CcvF8DxqxeqJgQiUQNp4FKKC2qf0sLmAQixyzU8+J
         38+JixqUBMvxzTOKMTxHfJET9JS3mVKSTuuSo=
Received: by 10.114.144.1 with SMTP id r1mr20097326wad.2.1231832542655; Mon, 
	12 Jan 2009 23:42:22 -0800 (PST)
In-Reply-To: <alpine.LFD.2.00.0901120805310.6528@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105464>

On Tue, Jan 13, 2009 at 12:13 AM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
>
> On Mon, 12 Jan 2009, Ping Yin wrote:
>> $ git diff --stat HEAD^..
>>  0 files changed, 0 insertions(+), 0 deletions(-)
>
> In the kernel, we use "git diff --stat --summary" for exactly this reason.
>
> Well, not exactly.
>
> The thing is, even if the file is _not_ empty, there's a huge difference
> between "added 100 lines to an already-existing file" and "created a new
> 100-line file". Which is exactly what "--summary" adds.
>
> And it sometimes even makes sense to show the summary without the
> diffstat. If you're _only_ interested in create/delete/rename information,
> you can do "git show --summary <cmit>". It won't give you line counts, but
> it will give you information about any changes to filenames, eg in the
> kernel archive, you could see an example of this with
>
>        git show -M --summary 95b482a8d31116f3f5c2a5089569393234d06385
>
> where you have a combination of renames, creates and deletes.
>
> So I think it's already better than what you ask for.
>
>                        Linus
>

Thanks. --summary works.
I just want to get all changed files. I think "git diff --name-status
A..B" should be better.


Ping Yin
