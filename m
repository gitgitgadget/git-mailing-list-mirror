From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: "git log -- SHA-1" - how to get/simulate this functionality?
Date: Mon, 26 Apr 2010 21:37:41 +0200
Message-ID: <y2n81b0412b1004261237w1c9221dn1ac75a29f50cb74d@mail.gmail.com>
References: <i2o76c5b8581004261054h591c266fre1a0dd87cd8511e1@mail.gmail.com>
	 <x2z76c5b8581004261056lcdb153a5j825db166916069e9@mail.gmail.com>
	 <z2m81b0412b1004261108n5453b5d2h179a944fa8db9b49@mail.gmail.com>
	 <p2y76c5b8581004261122g8e2950fci507cc9090a865843@mail.gmail.com>
	 <p2v81b0412b1004261157pf26db339t7d27b1b317a99b5e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Eugene Sajine <euguess@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 26 21:37:53 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O6U7r-0006NT-Jb
	for gcvg-git-2@lo.gmane.org; Mon, 26 Apr 2010 21:37:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754744Ab0DZTho (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Apr 2010 15:37:44 -0400
Received: from mail-yw0-f194.google.com ([209.85.211.194]:48195 "EHLO
	mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751716Ab0DZThn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Apr 2010 15:37:43 -0400
Received: by ywh32 with SMTP id 32so7389870ywh.33
        for <git@vger.kernel.org>; Mon, 26 Apr 2010 12:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=rkFXHaUrQy69GLk8qJQ66+DWOUkTEKKTh3JH7FZo+h0=;
        b=oRDQQpgRW++8zDHFMk6WmrV43YzLGiZO5Wv/+4jZMFXVrpCod8hGKKS0Gof3RsGHB3
         WvqI05wZfSk5mDVtZkZOlGSymH2ZoZRcKJAx/+81Bvr01PAhx8afngZf+xBERNUQ/Tgm
         i/EO4rBOzinx7YkKzIjf5zUBn/jxHyoY58AWE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=c1DiR8f1yoInJsQcz6DYooToTYdUwQC1ewup3WhAap+Zo6XFnpmxmQo3Xt/8gObTZ/
         Hpsf55Kg8VJoFvuQAKryPMCJ6Im1gljm1Y4mIOfLnwM/cqM47i8SfBh30uj5YHBkM4XX
         Bvjfe6VRmBbOPSXiSPi0uZK+jPESIz6rmmAmw=
Received: by 10.101.72.5 with SMTP id z5mr84016ank.5.1272310661792; Mon, 26 
	Apr 2010 12:37:41 -0700 (PDT)
Received: by 10.100.120.9 with HTTP; Mon, 26 Apr 2010 12:37:41 -0700 (PDT)
In-Reply-To: <p2v81b0412b1004261157pf26db339t7d27b1b317a99b5e@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145853>

On Mon, Apr 26, 2010 at 20:57, Alex Riesen <raa.lkml@gmail.com> wrote:
> On Mon, Apr 26, 2010 at 20:22, Eugene Sajine <euguess@gmail.com> wrote:
>> Well thank you for that, but that gives me what i already know - the content.
>> I need to "reverse engineer" the history by having only the content
>> and its SHA-1 in order to indentify the last commitID and get all
>> relevant info (author, date etc. )
>
> Hmm. In that case, your using of git log look like a good way to get the
> information. If you wanted an output format which is better suited for
> automated parsing, you can look at "git rev-list --pretty=format:...",
> let it output only commit and tree hashes, and grep the output of
> "git ls-tree" for your hash...

Actually, "git log --no-abbrev --raw --oneline" looks very simple to parse.
By the way, you may get ambiguous results: any file any time could have
had the given hash. IOW, by looking at the whole history you may see different
files having the same hash. It does mean the same content, so maybe its
OK for your purposes.
