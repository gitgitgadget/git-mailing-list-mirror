From: Chris Patti <cpatti@gmail.com>
Subject: Re: Odd results writing a Git pre-receive hook to syntax check PHP files.
Date: Mon, 30 Aug 2010 10:03:15 -0400
Message-ID: <AANLkTimqzDO49h40b16gQ_=X42NXN-wZNV7d7f3KYygt@mail.gmail.com>
References: <AANLkTikktdPoZN8MwJD+Gxus16xBGtScCAqT9W0eiWAb@mail.gmail.com>
	<4C7B8E1E.6050708@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Aug 30 16:03:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oq4xO-0000Cg-Hq
	for gcvg-git-2@lo.gmane.org; Mon, 30 Aug 2010 16:03:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755513Ab0H3ODU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Aug 2010 10:03:20 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:43325 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753506Ab0H3ODT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Aug 2010 10:03:19 -0400
Received: by bwz11 with SMTP id 11so3694342bwz.19
        for <git@vger.kernel.org>; Mon, 30 Aug 2010 07:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=gwRvYZIz3oU0MeddAvd00P/TrYDyPB99T8ehnIRec24=;
        b=fEQrKEbgIh0E/1rY/TAgUwkdVK9Z0gsNPBW0frilXtr4XxZzWOnGFgXkM+3lQPoTDN
         e4AG60J5ifnchCk38l7KsFknFaT/zRSW5MotlKbmyRJhRLuQRuyiAKhMBYOx1Ighshc8
         4lPaXt1cTjnXZRg9TO4zYkjrWNvt2mKa8Jh1g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=bxe2imjZMxz6E0Bu5ErmPVOSBaTD2BrFWgmAiX0idyCisBmQZ2ro0crdyL/ewW9kjy
         2B5KJr3iNQokIDMnxbmRz/mj49jRkFg2b9NxiBfBlUtPUcOJ8mBpy0W5LWOsL6yt1ur/
         8RboT2u1WQLU6di7DWNHkE+ommj5pbzjBEgWI=
Received: by 10.204.11.13 with SMTP id r13mr3288982bkr.96.1283176995595; Mon,
 30 Aug 2010 07:03:15 -0700 (PDT)
Received: by 10.204.66.196 with HTTP; Mon, 30 Aug 2010 07:03:15 -0700 (PDT)
In-Reply-To: <4C7B8E1E.6050708@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154805>

On Mon, Aug 30, 2010 at 6:55 AM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
>
> ...because "ls-tree" lists the complete tree at the given revision, not
> just the files changed in a commit. In fact, strictly speaking "ls-tree"
> does not even operate on revisions but tree identifiers - given a
> revision, it is resolved into a tree.
>
> You want to use something like "git diff --name-only oldrev newrev" or
> another variant from the diff family.
>
> Michael

That's great, thanks!  That gets me the file names.  Now, how do I get
to the contents of each file?

Do I have to do a git ls-tree and parse the contents, paying attention
to only the files listed out with the git diff --name-only? I'm
guessing there's a simpler way.   Git show <newref> prints out all the
diffs for that commit, but I need to examine the entire file.

Thanks so much for the response!
-Chris

-- 
Christopher Patti - Geek At Large | GTalk: cpatti@gmail.com | AIM:
chrisfeohpatti | P: (260) 54PATTI
"Technology challenges art, art inspires technology." - John Lasseter, Pixar
