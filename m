From: Eric Miao <eric.y.miao@gmail.com>
Subject: Re: Support for a series of patches, i.e. patchset or changeset?
Date: Mon, 5 Nov 2012 22:12:35 +0800
Message-ID: <CAMPhdO-1ar52QGuSzbyFBSKMf48fDb6Bbxw5u3PCuVYxkO2=3w@mail.gmail.com>
References: <CAMPhdO_33CPJv2hAvPuJ10KZ7v_fgP9P2kV_WLVK2tapjQQ5=A@mail.gmail.com>
 <5097C190.80406@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Nov 05 15:13:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TVNQQ-0008BF-5N
	for gcvg-git-2@plane.gmane.org; Mon, 05 Nov 2012 15:13:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932470Ab2KEOM7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Nov 2012 09:12:59 -0500
Received: from mail-la0-f46.google.com ([209.85.215.46]:48659 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932456Ab2KEOM4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Nov 2012 09:12:56 -0500
Received: by mail-la0-f46.google.com with SMTP id h6so4244007lag.19
        for <git@vger.kernel.org>; Mon, 05 Nov 2012 06:12:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=OLOIIuEQDEPTnjsA2ZPo5XpyRTGnKihTtBnSNiR0ZVg=;
        b=aVS4Zn0+WBsSI0bg3V8UyVZ+cq71HCQjoPtOLP+2Q72EQ0H4SzAxchYGMKL1ftU64n
         O8kc3Rdpq1n9FHYCL/rnWhg/CBxtw+h50m0EoUJxbKcEN+hxt7OE0KF4GdtIJ4vF72R9
         9Shw6WZH+hCjX0Awd4NP52deh0o0VTQufQmtmXCKQZtNdeRA6b2YENKZF7XZWFG840Cc
         tKgA5Lvr8NIAkG0VpsU4FrTvvhL6cK8peDRngMnwqS3Ii+yRPQ9DYkfTzNSbx98/tK7U
         3qCQBZRBG97W67si/xL46x4U/RnoRgtDAMmQpq0az0XXy0pL58oEfdd2iIANTr/kIAzB
         ck4Q==
Received: by 10.112.29.199 with SMTP id m7mr3863829lbh.2.1352124775422; Mon,
 05 Nov 2012 06:12:55 -0800 (PST)
Received: by 10.114.75.1 with HTTP; Mon, 5 Nov 2012 06:12:35 -0800 (PST)
In-Reply-To: <5097C190.80406@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209059>

The problem is, most cases we have no idea of the base rev1, and commit rev2
which it's leading up to. E.g. for a single patch which is between
commit rev1..rev2,
how do we find out rev1 and rev2.

On Mon, Nov 5, 2012 at 9:39 PM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> Eric Miao venit, vidit, dixit 05.11.2012 03:26:
>> Hi All,
>>
>> Does anyone know if git has sort of support for a series of patches, i.e.
>> a patchset or changeset? So whenever we know the SHA1 id of a single
>> patch/commit, we know the patchset it belongs to. This is normal when
>> we do big changes and split that into smaller pieces and doing only one
>> simple thing in a single commit.
>>
>> This will be especially useful when tracking and cherry-picking changes,
>> i.e. monitoring on the changes of some specific files, and if a specific
>> patch is interesting, we may want to apply the whole changeset, not only
>> that specific one.
>
> First of all, if you know the sha1 of a commit, then all its ancestors
> are determined by that. If you want to describe a set of patches, say
> based on rev1 and leading up to rev2, then the expression
>
> rev2 ^rev1
>
> describes that set uniquely. Often you can do without ^rev1, e.g. if you
> know that all patch series are developed bases on origin/master, then
> specifying rev2 is enough as "git rev-list rev2 ^origin/master" will
> give you all commits in the series (unless they have been integrated,
> i.e. merged).
>
> Or are you thinking about patches "independent" of a base?
>
> Cheers,
> Michael
>
