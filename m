From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: git-apply does not work in a sub-directory of a Git repository
Date: Thu, 24 Mar 2016 17:49:05 +0700
Message-ID: <CACsJy8CTix-ZwN04MwYTB+JEtDCV27QVf7_0vWmhUSVCwU29Jg@mail.gmail.com>
References: <CA+DCAeQQQH59Lb43Y4Bi1xktPNoODV11KkUBbKNG1OZ7mDb-UQ@mail.gmail.com>
 <CAGZ79kYmoKX1w5X8jE5_yGb3VKricHEwxAianTyt4VUd71qH-A@mail.gmail.com>
 <CACsJy8DCk5YintK3PoO1BWdNmsiSLpAcGL4pU7QgNEG6S41CsQ@mail.gmail.com>
 <xmqqbn65dxtl.fsf@gitster.mtv.corp.google.com> <xmqqlh59cexj.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Stefan Beller <sbeller@google.com>,
	Mehul Jain <mehul.jain2029@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 24 11:51:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aj2rr-0004YR-7p
	for gcvg-git-2@plane.gmane.org; Thu, 24 Mar 2016 11:51:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757315AbcCXKvb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Mar 2016 06:51:31 -0400
Received: from mail-lf0-f47.google.com ([209.85.215.47]:36281 "EHLO
	mail-lf0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757277AbcCXKtg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Mar 2016 06:49:36 -0400
Received: by mail-lf0-f47.google.com with SMTP id d82so31225805lfe.3
        for <git@vger.kernel.org>; Thu, 24 Mar 2016 03:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=taFBH+igUFVP/oqMT4ttdLvMQLwyG6UjTls60Atqmc8=;
        b=FO8FuFM2GSVW6EADPw/Ftq7kigkOxBy7JD8r/ak9xbupYTQLUGGIElax7n0CQ/CaTX
         J5cqTvCpvnHnAvsftZ9XMxFA+SSW/C5ksspTFE6i62+SKSDe7T+RlcWuY2iyJm4JarZQ
         n+ncn5uCsTqdBjQNC9Z2DfiPU4mSzicALs2bIqs/Vmx1VpXSxDA1IXk2EzLM7/ediJkM
         JiazMSMBnDwe5pBBIfNXMfsx07WQYMuMbyr7mjaMVXKVRalciHkQ2Sk+WzcDpeAbBsSb
         VAvxfLJddvzr5GMsBB/lHceSTd6pn5maP0MZT6qBotIqwXbx+gPjStWcL6Z2+cx9lrzF
         XZqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=taFBH+igUFVP/oqMT4ttdLvMQLwyG6UjTls60Atqmc8=;
        b=GS+0iu7p1hi9qiGjmqjD+OPQO66x7N8Am3MpR5BdN80Ambht/wGBnnTYgJZZJsVTeB
         jF2tWwlrR+zVQjUs/LBv3rTWKw6JCYQKECnDVGvKAu9uV1NzrVNnsQ440EefEgFEMej+
         Ex69GJYgvVCoeUuqPipf4RbRrsLGgNL9VlFN5mkfGVqyP1jgB0CTugAAjWPduVExt6Y1
         YQC3kO8Hb+Zp0DdGoCdMcnzFdc53tMv3d2MCHarl0DfYcxVb101enpI2sP1dRI3rz+io
         o+2lrHmO1qhb8NXhuVFX9nH2NvOGMuBrnxUgIia7i/5gvU16NphEWD171c64E/YS7cNq
         5GEQ==
X-Gm-Message-State: AD7BkJJTOF8eQ2s143z8vlIh277usFcpbjTx8QuKshlltng5wTX8aitxNyGGmDj9g4fdULSaCnTZSCrNMSdljQ==
X-Received: by 10.25.23.94 with SMTP id n91mr2528208lfi.3.1458816574884; Thu,
 24 Mar 2016 03:49:34 -0700 (PDT)
Received: by 10.112.167.10 with HTTP; Thu, 24 Mar 2016 03:49:05 -0700 (PDT)
In-Reply-To: <xmqqlh59cexj.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289735>

On Wed, Mar 23, 2016 at 11:55 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> See
>>
>>   http://thread.gmane.org/gmane.comp.version-control.git/288316/focus=288321
>>
>> I agree it is bad that it silently ignores the path outside the
>> directory.  When run with --verbose, we should say "Skipped X that
>> is outside the directory." or something like that, just like we
>> issue notices when we applied with offset, etc.
>
> Another thing we may want to do is to loosen (or redo) the logic
> in builtin/apply.c::use_patch()
>
>         static int use_patch(struct patch *p)
>         {
>                 const char *pathname = p->new_name ? p->new_name : p->old_name;
>                 int i;
>
>                 /* Paths outside are not touched regardless of "--include" */
>                 if (0 < prefix_length) {
>                         int pathlen = strlen(pathname);
>                         if (pathlen <= prefix_length ||
>                             memcmp(prefix, pathname, prefix_length))
>                                 return 0;
>                 }
>
> The include/exclude mechanism does use wildmatch() but does not use
> the pathspec mechanism (it predates the pathspec machinery that was
> made reusable in places like this).  We should be able to
>
>     $ cd d/e/e/p/d/i/r
>     $ git apply --include=:/ ../../../../../../../patch
>
> to lift this limitation.  IOW, we can think of the use_patch() to
> include only the paths in the subdirectory we are in by default, but
> we can make it allow --include/--exclude command line option to
> override that default.

Interesting. Disabling that comment block seems to work ok. So
git-apply works more like git-grep, automatically narrowing to current
subdir, rather than full-tree like git-status. git-apply.txt should
probably mention about this because (at least to me) it sounds more
naturally that if I give a patch, git-apply should apply the whole
patch.

We probably should show a warning if everything file is filtered out
too because silence usually means "good" from a typical unix command.
It could be guarded with advice config key, and should only show if it
looks like there are matching paths on worktree, but filtered out.
Hmm?

> That way, the plain-vanilla use would still retain the "when working
> in subdirectory, we only touch that subdirectory" behaviour, which
> existing scripts may depend on, but users can loosen the default as
> necessary.
-- 
Duy
