From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: Convenient shortcut to push delete current branch?
Date: Thu, 1 Oct 2015 11:22:23 -0700
Message-ID: <CA+P7+xpWXoNiK67xCepoChr8rqX-Z5EcNb-Bs3xhC+Uot2ruYg@mail.gmail.com>
References: <CAHd499C3n8DGuhxwajQbFrH+Fr8zHRA7sVjhG3yfSD5kKPSZsA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>
To: Robert Dailey <rcdailey.lists@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 01 20:22:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZhiVE-0005YY-OP
	for gcvg-git-2@plane.gmane.org; Thu, 01 Oct 2015 20:22:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752232AbbJASWo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Oct 2015 14:22:44 -0400
Received: from mail-ig0-f181.google.com ([209.85.213.181]:34172 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751123AbbJASWn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Oct 2015 14:22:43 -0400
Received: by igcpb10 with SMTP id pb10so1725274igc.1
        for <git@vger.kernel.org>; Thu, 01 Oct 2015 11:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=gaWlAJVn/pB0K6Bva6vx/AGKenbvA5ea0fc3RPFmFfk=;
        b=yx+F0mp7Up8QhK0AgfllhikE3MZDO9au5+ozE2s1B5sOfGG2RBBHnwS9UxuqpVUq4G
         YrRtelPmTmQAdyclkIedWq6Zd/qCJPeQkLCCQ2RcTrkCCOYHKgQVj9+kyujh6qcDJ7iT
         5vPdUwwaWATkVgM0rAyqtJw4r8WRXc5oENi3i4uI9FdCyydpHUd6SfHxx42RQaV4LASg
         PM/HEh1zM0PDykboMh2rzgZ4B9o1tiNwFpo24Rc8dDbEl/2FX5QGenwMcXk22G237yCL
         s2yVFjsI39LDjSFQ3NABE4cLN9FaYBR+80dnI2MWjdX2R/nz0ErVYccaskHvZxzGq7Sq
         PN/w==
X-Received: by 10.50.134.67 with SMTP id pi3mr216143igb.73.1443723763239; Thu,
 01 Oct 2015 11:22:43 -0700 (PDT)
Received: by 10.107.132.155 with HTTP; Thu, 1 Oct 2015 11:22:23 -0700 (PDT)
In-Reply-To: <CAHd499C3n8DGuhxwajQbFrH+Fr8zHRA7sVjhG3yfSD5kKPSZsA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278898>

On Thu, Oct 1, 2015 at 9:43 AM, Robert Dailey <rcdailey.lists@gmail.com> wrote:
> For convenient pushing of current branch, git supports this syntax:
>
> $ git push origin HEAD
>
> This will push your current branch up. However, is there such a
> shortcut for *deleting* the branch? The only goal here is to avoid
> having to type the branch name in the push command. Normally I rely on
> tab completion but we have tons of branches, all which start with some
> prefix mixed with numbers, so it becomes cumbersome to rely on tab
> completion. Ideally I'd like to be able to do:
>
> $ git push --delete origin HEAD
> $ git push origin :HEAD
>
> Is there a syntax like this available?

You can do

git push origin:<branchname>

but I don't believe HEAD is supported. It might be valuable to extend
push to have a --delete option which would maybe be useful for those
who didn't learn the full refspec syntax.

I don't think git push origin :HEAD makes too much sense, since that's
on the remote side of a refspec, and you want it interpreted
locally... I suppose it makes sense somewhat, but other refspecs with
HEAD on the remote side of the refspec don't really make sense, where
as HEAD always makes sense on the local side of the refspec.

Regards,
Jake
