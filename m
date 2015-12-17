From: Shawn Pearce <spearce@spearce.org>
Subject: Re: RefTree: Alternate ref backend
Date: Thu, 17 Dec 2015 14:15:41 -0800
Message-ID: <CAJo=hJvwwOooPG2XUbhLZqyDMwsOa1Ba7eoA1AFLkF3BHk5V8Q@mail.gmail.com>
References: <CAJo=hJvnAPNAdDcAAwAvU9C4RVeQdoS3Ev9WTguHx4fD0V_nOg@mail.gmail.com>
 <xmqqk2ocbuw9.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>, David Turner <dturner@twopensource.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 17 23:16:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a9gqG-0006lM-JZ
	for gcvg-git-2@plane.gmane.org; Thu, 17 Dec 2015 23:16:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933773AbbLQWQE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Dec 2015 17:16:04 -0500
Received: from mail-vk0-f41.google.com ([209.85.213.41]:32823 "EHLO
	mail-vk0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933428AbbLQWQD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Dec 2015 17:16:03 -0500
Received: by mail-vk0-f41.google.com with SMTP id a188so55760875vkc.0
        for <git@vger.kernel.org>; Thu, 17 Dec 2015 14:16:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=KSEgcIaK72n4+3SsE7oBXEs6fNg4nuIKgW3gfGQ5hik=;
        b=YXCddYDgLKF2se78aYsUUOgePVWFga3qwB1Cvh2mVwrbca0YTs40+eNodSj/tAd+9T
         +CZeQx86o1iCsQNvItjn7sBLsNq6Eie5dY7xJivnaBw7pPyFCVRspSu/0F3JZ1sK43Ym
         CxEfItbPDKT1EtvTysKqh0SafR6+HEBYlHOUY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=KSEgcIaK72n4+3SsE7oBXEs6fNg4nuIKgW3gfGQ5hik=;
        b=VUNHTdZ6G6nKrns/NYOUzRDBmeThfaM1XY2mZzYnFUtzr8+FNmkK1wKGXJWSD5u7GH
         FLQYrluouWTlmpxU2ibGYv5I4aEADkTlw/6SXaUAM9Z3kk33MoL4q1YjpX0aOsEj0IkJ
         9B7rAw4jB8hYR92OpyeaagSHkUUp1UB5pQj4o72HOcpFsbihyx2J/fC0KeuueCtcZTHr
         ogBnwjSC5UIf6u1FSHTO+MLzp/CKj4szX0JwEQaHsdeQ9VR9EbxmAvUoox4lyDaV4HF3
         5crWdpygpQH3XoTV3wyGfqpXgW2MVc/4I/FxrwjqzfQdPsBKVHB5O2dxsLzoU+0Xxon+
         KfCg==
X-Gm-Message-State: ALoCoQledtHX+oFaTsXFB5rhLcXdbfvg8pbXkwMlU6IpFyVCB7jPewW2BmcmF+th4TJLfxwHGJI5TSklk03GwP4TNa1OWd8T2g==
X-Received: by 10.31.163.17 with SMTP id m17mr143315vke.46.1450390561540; Thu,
 17 Dec 2015 14:16:01 -0800 (PST)
Received: by 10.103.97.197 with HTTP; Thu, 17 Dec 2015 14:15:41 -0800 (PST)
In-Reply-To: <xmqqk2ocbuw9.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282683>

On Thu, Dec 17, 2015 at 1:57 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Shawn Pearce <spearce@spearce.org> writes:
>
>> For example, recent git.git has a structure like this:
>>
>>   $ git ls-tree -r refs/txn/committed
>>   120000 blob 22e42fc826b437033ca444e09368f53a0b169322 ..HEAD
>>   160000 commit 1ff88560c8d22bcdb528a6629239d638f927cb96 heads/maint
>>   160000 commit f3adf457e046f92f039353762a78dcb3afb2cb13 heads/master
>>   160000 commit 5ee9e94ccfede68f0c386c497dd85c017efa22d6 heads/next
>>   160000 commit d3835d54cffb16c4362979a5be3ba9958eab4116 heads/pu
>>   160000 commit 68a0f56b615b61afdbd86be01a3ca63dca70edc0 heads/todo
>>   ...
>>   160000 commit 17f9f635c101aef03874e1de1d8d0322187494b3 tags/v2.6.0
>>   160000 commit 5bebb9057df8287684c763c59c67f25f16884ef6 tags/v2.6.0-rc0
>>   160000 commit 16ffa6443e279a9b3b63d7a2bebeb07833506010 tags/v2.6.0-rc0^{}
>>   ...
>>   160000 commit be08dee9738eaaa0423885ed189c2b6ad8368cf0 tags/v2.6.0^{}
>>
>> Tags are stored twice, to cache the peel information for network advertisements.
>
> The object 17f9f635 is not a "commit" but is a "tag".  It is
> somewhat unfortunate that "ls-tree -r" reports it as a commit; as
> the command (or anything that deals with a gitlink) is not allowed
> to look at the actual object, it is the best it could do, though.

Yes; thus far GITLINK is only used for commits in submodules so its
reasonable for it to just hardcode the text "commit".

> The "..HEAD" hack looks somewhat ugly.  I can guess that the
> reasoning went like "if we stored these in the most natural way, we
> always need a top-level tree that hold two and only two entries,
> HEAD and heads/, which would require us one level of tree unwrapping
> to get to most of the refs" and "HEAD is the only oddball that is
> outside refs/ hierarchy,

Correct.

> others like MERGE_HEAD are ephemeral and
> for the purpose of Gerrit that does not even do working tree
> management, those things that are not necessary in order to manage
> only the committed state can be omitted.", but still...

Yes. I was mostly looking at this from a bare repository server
perspective, not a user working tree. On a bare repository you
probably don't have those special refs like MERGE_HEAD, FETCH_HEAD,
etc.

They could be stored as "..MERGE_HEAD", if you had to. But only HEAD
really matters to hint to clients what to checkout by default on
clone.
