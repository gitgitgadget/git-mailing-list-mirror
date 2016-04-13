From: Stefan Beller <sbeller@google.com>
Subject: Re: Merge conflicts are reported relative to root not cwd
Date: Wed, 13 Apr 2016 15:18:24 -0700
Message-ID: <CAGZ79kZSyLZxMXSSv=uDpuA0zTUy6nU4vwEF5f7WLhoRp1hXig@mail.gmail.com>
References: <CAGZ79kbVfk=yAK3UB=H385_YfAtMHZe-gSE=EYVvvcS8jjy08A@mail.gmail.com>
	<xmqq4mb5jhm7.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 14 00:18:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqT7H-0004Pg-6a
	for gcvg-git-2@plane.gmane.org; Thu, 14 Apr 2016 00:18:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754258AbcDMWS0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Apr 2016 18:18:26 -0400
Received: from mail-io0-f170.google.com ([209.85.223.170]:33993 "EHLO
	mail-io0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753042AbcDMWSZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Apr 2016 18:18:25 -0400
Received: by mail-io0-f170.google.com with SMTP id 2so86429664ioy.1
        for <git@vger.kernel.org>; Wed, 13 Apr 2016 15:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=IaH9kxUmoNfKV1frRgsCQECkAPzQSG8N8b8ysHNN0gA=;
        b=RzcIGlY4iE72heJywJQdSg9Qc7r5Co9NASOqM0fkR7vdoAXB9Uf5OrTwVPTTRyk8nL
         rJNlju+v8pk+MsxNQ75lojHxLTa+w/tPDXKRbFy/5FtIoT2MxOomixeytQqXN2TU2TlT
         AcuJHKWZVso8pOodg3Gmfh/ZvKCNhOM9NNSYWR2uRXRH7u8UpTAASvHGvJGUcH2xzcBd
         awxLTH9tnYLKBoZQZbuENdRlVSyHNC91BJmF+8yscZnPqmgGJJW6yl8DzG6ICTTZ7/f/
         +bqjbl2IQ2ULippe4yarERSLZHZfm+G41nNCCyLxn/oPWlGHDtx7+zpfESkI5RpR1JoW
         55xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=IaH9kxUmoNfKV1frRgsCQECkAPzQSG8N8b8ysHNN0gA=;
        b=JpW/J7xgmljggssngQBgnK5LaTvveZSkzXemXMMDrEHN3qImf+ZHT8C3ThA4NWWxf9
         2JmOpimml3nx40Kaod18G+isBnI2CMrRBJb3WhG8tXljoTLwA9tV2rQsbz9i5sHimtll
         4BaVzDNL/Jd5YCh2VKsOtvEUy3oYE7Ez1cKDTlRYwcv6E0nTAE84J1SRlneUQs3gXUGw
         2EwDGVBN9FwKd3ZEh15xPo8SaylQUX+PiY6yf3fohG6c7bdqj9Ze4JjQdlO7ZzXAoMuJ
         ASakpeWSsY9jXF2gy6RBaAyMFQcrpt+OLWBcd2xB2Pgwc9b/SEbgk5yB6u4Ux8l5FI1l
         qj9g==
X-Gm-Message-State: AOPr4FUPQusthUCNBt3J/2/9g4FekDtdCKeh5FzsbKlbZQe25/o7V7hERX/ulgTKFYUSpqWttEAbLh0c3+SkAoaJ
X-Received: by 10.107.161.68 with SMTP id k65mr14461692ioe.110.1460585904624;
 Wed, 13 Apr 2016 15:18:24 -0700 (PDT)
Received: by 10.107.17.27 with HTTP; Wed, 13 Apr 2016 15:18:24 -0700 (PDT)
In-Reply-To: <xmqq4mb5jhm7.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291498>

On Wed, Apr 13, 2016 at 2:58 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> $ cd t/
>> $ git merge ...
>> ...
>> Auto-merging builtin/submodule--helper.c
>> Auto-merging builtin/fetch.c
>> CONFLICT (content): Merge conflict in builtin/fetch.c
>> Auto-merging builtin/clone.c
>> Auto-merging README.md
>> ...
>>
>> It should say ../builtin/fetch.c IMHO.
>> Any reason to keep the old behavior?
>
> I actually prefer to see the "relative to root" behaviour when it
> comes to things like this, that lets you view the things that happen
> in the whole-tree context.
>
> I would have to go insane before I start a whole-tree operation like
> "git merge" from deep in my tree, but if I happened to do that, e.g.
>
>         cd perl/blib/lib/Git/SVN/Memoize
>         git merge other-branch
>
> I'd rather see that the conflicted path, e.g. builtin/fetch.c,
> reported by showing it like the above output, not happening in
> ../../../../../../builtin/fetch.c which I have to count the
> up-dots to know which file it is talking about.
>

* In most trees you would still know which file is referred to, as
   there are no /$PATH/builtin/fetch.c files except for PATH=<empty>
   So I'd see that as a minor issue.

* This is your preference for whole-tree operations. What are
   whole-tree operations? (Is there a concise definition?
   Are submodules whole tree operations?)
   These questions are motivated by origin/sb/submodule-path-misc-bugs
   which a) fixes bugs and b) makes submodule handling consistent to the
   relative-to-cwd philosophy. As most submodule commands touch all
   submodules in the tree, we could argue it is a whole-tree operation, and
   you'd like to see submodule paths from the root level, too.

I'd like to avoid adding confusion here. So is there a an easy way to tell apart
which commands you would expect to use relative-to-cwd and which use
relative-to-root?
