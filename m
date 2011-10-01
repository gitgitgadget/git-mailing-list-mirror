From: Michael Witten <mfwitten@gmail.com>
Subject: Re: [PATCH] Clarify that '--tags' fetches tags only
Date: Sat, 1 Oct 2011 20:56:59 +0000
Message-ID: <CAMOZ1BsYYmH6hqcB4vfCq2LAu+fxJ4MzPQ1+-erUSqU1ptx2mQ@mail.gmail.com>
References: <1314997486-29996-1-git-send-email-anatol.pomozov@gmail.com>
 <1316649176-32352-1-git-send-email-anatol.pomozov@gmail.com>
 <119711285.RuumktFLOq@hyperion> <loom.20110930T041939-332@post.gmane.org>
 <CAMOZ1BsTKBPArRF-LxoNOJcQarMWx-2a2UBoVjWN-96xJ3Ad8A@mail.gmail.com>
 <loom.20111001T073652-884@post.gmane.org> <CAMOZ1Bvn64q5sVfo2-ZhTSpBttpjG1pHELJMM9sEmWsrqANCkw@mail.gmail.com>
 <loom.20111001T191413-25@post.gmane.org> <CAMOZ1Bsc2idQnKxeggruPi1rrY3+vsa=DoMydHY4+BM+qoW69w@mail.gmail.com>
 <loom.20111001T214551-834@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Peter Shenkin <shenkin@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 01 22:57:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RA6cq-00071G-CN
	for gcvg-git-2@lo.gmane.org; Sat, 01 Oct 2011 22:57:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756321Ab1JAU5c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Oct 2011 16:57:32 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:55780 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751661Ab1JAU5a (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Oct 2011 16:57:30 -0400
Received: by iaqq3 with SMTP id q3so3217827iaq.19
        for <git@vger.kernel.org>; Sat, 01 Oct 2011 13:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=r6rsWt1iKjlIYo4JNdWBGdAz/bWdmxuXzx/f9dhhdNg=;
        b=cCqfEU4usAkl3t4eOxo24xvWG6Uk/tT+iZvaLsN7ZzAsNNMX+stLI5EUCcCt6ACqCM
         VQAohLmUwcToO/ZaQ9poqkyDu2l59HMNsP2zT2Z7hcA8JkuBcV0FAN9PZo6Y4qwzjdoh
         LAqcNiV9zK28XDnf9J93CV8u8lo7wrUK1a2As=
Received: by 10.42.117.133 with SMTP id t5mr4942419icq.222.1317502649132; Sat,
 01 Oct 2011 13:57:29 -0700 (PDT)
Received: by 10.42.171.194 with HTTP; Sat, 1 Oct 2011 13:56:59 -0700 (PDT)
In-Reply-To: <loom.20111001T214551-834@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182576>

On Sat, Oct 1, 2011 at 20:22, Peter Shenkin <shenkin@gmail.com> wrote:
>
> The question is not how the --tags option should be
> documented, but rather why "--tags" should behave
> differently when the refspec is given on the commandline
> than when the refspec is given in the .git/config file.

Again, see here:

 [PATCH v3] Docs: Clarify the --tags option of `git fetch'
 Message-ID: <686c38876d5a4ad6bfac67ca77fe9bb3-mfwitten@gmail.com>
 http://article.gmane.org/gmane.comp.version-control.git/181887

namely:

    This option is merely a shorthand for writing the refspec
    `refs/tags/\*:refs/tags/\*'; that is,

            git fetch origin --tags
            git fetch origin --tags frotz

    are equivalent to:

            git fetch origin 'refs/tags/*:refs/tags/*'
            git fetch origin frotz 'refs/tags/*:refs/tags/*'

In other words, by writing "--tags", you are actually writing
"refs/tags/\*:refs/tags/\*"; because you are stating an *explicit*
refspec, "git fetch" doesn't bother with any *implicit* default
in your config, which is consistent with how "git fetch" works.

It would probably be a good idea if there were a "--defaults", too.
