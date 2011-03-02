From: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
Subject: Re: [RFC] git blame-tree
Date: Wed, 2 Mar 2011 18:51:57 +0100
Message-ID: <AANLkTim4fKO=Lb0dY0DzRu1QqC8NHPoF8iveYQ2E6OBH@mail.gmail.com>
References: <20110302164031.GA18233@sigill.intra.peff.net>
	<20110302171653.GA18957@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 02 18:52:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PuqDV-0002L5-F0
	for gcvg-git-2@lo.gmane.org; Wed, 02 Mar 2011 18:52:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755280Ab1CBRv6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Mar 2011 12:51:58 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:54609 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754041Ab1CBRv6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Mar 2011 12:51:58 -0500
Received: by vws12 with SMTP id 12so167403vws.19
        for <git@vger.kernel.org>; Wed, 02 Mar 2011 09:51:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=sQhlklNlka96n1nwcA4SNvjJjA2WDm5lCsbQK0RwaPs=;
        b=Uebg8JknW7BsQMaXm0ONxjNfL8kJEPy615vkQcbuVHkBudVCGh5TuEY827ZZW0l5Vs
         2qBp+MD4Jtv5pXPA28H9/WmyW6CgwYoCd9GFKo3OtI3kex8DPBiqqUaUyFT+ZUt3ZPam
         XFU0gkizw6mHn2aTHZJ23skTDIm+4AQrskIj0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=c/IhKYid7Dz+eb5Pw3IQ8dujJIcAISc8/jEnNTBong3t0O6rr7d3lFHl2HNu5ioGZ6
         DjEc4vmwxbCoG2P+iBe6dg5UpSuRwtrLM0WWz58c7LjjoJPRiC8jNNYGNkHuvfIX+hE6
         //0jipMQuxjFcCxq5Zx5pJvJdXt7Cxfc/kXNI=
Received: by 10.52.179.194 with SMTP id di2mr136603vdc.131.1299088317380; Wed,
 02 Mar 2011 09:51:57 -0800 (PST)
Received: by 10.220.61.140 with HTTP; Wed, 2 Mar 2011 09:51:57 -0800 (PST)
In-Reply-To: <20110302171653.GA18957@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168328>

Hi,

On Wed, Mar 2, 2011 at 6:16 PM, Jeff King <peff@peff.net> wrote:
> I considered making it a special mode of "git blame" when blame is fed a
> directory instead of a file. But the implementations aren't shared at
> all (nor do I think they need to be; blame-tree is _way_ simpler). And I

git blame dir/file.c
  "Show what revision and author last modified each line of a file"

git blame dir/
  "Show what revision and author last modified each file"

This makes sense to me (the user).
I don't understand the implementation thing. I don't see a difference between
those two commands. Even more, if I'm educated  Unix user I might know
directories are also files.


> didn't want to steal that concept in case somebody can think of a more
> content-level way of blaming a whole tree that makes sense (obviously
> just showing the concatenation of the blames of each file is one way,
> but I don't know how useful that would be). If we want to go that way,
> we can always catch the special case in blame and just exec blame-tree.

Still can be in git-blame command, no?


> The initial set of interesting files we come up with is gotten by
> looking at the tree of the first pending object after parsing the rev
> options (defaulting to HEAD). Which sounds a little flaky to me, but
> does what you want in practice. I'd be curious if somebody can come up
> with a counterexample where the ability to manually specify the source
> tree would be more useful.

Same argument as for normal blame: I want to know who modified files at
the state of commit X (if I understand the question correctly).




-- 
Piotrek
