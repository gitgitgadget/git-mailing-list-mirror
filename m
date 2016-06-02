From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH] t1308: do not get fooled by symbolic links to the source tree
Date: Thu, 2 Jun 2016 16:23:00 -0700
Message-ID: <CAGZ79kY1ygqd4VmwMj4AGTxo2bO6HFKoShzv6S2MxFq6QNjM1w@mail.gmail.com>
References: <xmqqzir53mdc.fsf@gitster.mtv.corp.google.com> <712e0755-6008-21f5-0ee6-25ed9d97fd45@web.de>
 <xmqq1t4ftheu.fsf@gitster.mtv.corp.google.com> <xmqqwpm7s2ex.fsf@gitster.mtv.corp.google.com>
 <20160602213920.GA13356@sigill.intra.peff.net> <xmqqeg8fs0dw.fsf_-_@gitster.mtv.corp.google.com>
 <20160602231619.GA11277@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jun 03 01:23:09 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8bxE-0006x1-A6
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jun 2016 01:23:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933039AbcFBXXE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jun 2016 19:23:04 -0400
Received: from mail-qk0-f180.google.com ([209.85.220.180]:34305 "EHLO
	mail-qk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932942AbcFBXXC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jun 2016 19:23:02 -0400
Received: by mail-qk0-f180.google.com with SMTP id s186so14376599qkc.1
        for <git@vger.kernel.org>; Thu, 02 Jun 2016 16:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=DDe35SoI74lmaySESDx6W8qXJg8aGndLJc1aC+WXvOk=;
        b=gHKDYT7Ebkb1JaCzHKdNPahgRXIUoU0fbDoHKn+nS92q0FR3i1babhqWcbLYJ/TA3a
         lZXbt5aQDFhUtW0ao4oTdQclfLLwHH3DE5RndKonSx4v5aFSgx6Uoi8jljoViDOqLGt2
         fAyy7jwMtPY97CigQPhIDyvqmDX3uomUmHQ4N6cH7h+TT0xwj9cOjAXrlMJ/hB5ND1Ea
         LeHjnmC9Ww10yKHtG212DrtEnx152mnPLgJCvMYCtZsRzP2nPcTT3bWIru463exW8UR0
         v1+6mGKxbo0dQ+K4fOZCO1gsR90iPjohV0t9a46ncJyGRDeICYL1lDjjm/l2DFpsm+LH
         mJcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=DDe35SoI74lmaySESDx6W8qXJg8aGndLJc1aC+WXvOk=;
        b=i2Hfj3ECNm8ACgB97wfrqKZA0WHbmfTppexxGRgp3mHG/wvrym2Pq7+WUodCto5IUf
         8C7hz3RDok6jZNEUTJIXw3fIOKhbPeoc3iexom5xcbuehghuGJXa3xxcj4UIY3AdFhA7
         qLXGXs6by4NPr7XHr/uN4oiTrb+JMflyDYgMEFaf4QyephHlBAdEAyyR6+NqzsHARWOr
         eAl4WaI0Cd7oOrEk+X+ACIoXe09GD8E2Wx6KnMdpyb+VnyYeQsEnd4BxggG5kAtsGHIL
         s6RoUfEO54AQ8+Ku+aSY0ihD1Um+xv9OayH6T0sYAT3t4FxVx/RAh/L9jDYXEthu0u8R
         8kNQ==
X-Gm-Message-State: ALyK8tL+rVuC4Cw3r3dP9yMjwUw0U+0zlk49F7/e96d8cIQRyRfP4ZtNqz4JI8wal0BshAApbLI1K4TmHeQ7dfpv
X-Received: by 10.55.81.3 with SMTP id f3mr626147qkb.35.1464909780959; Thu, 02
 Jun 2016 16:23:00 -0700 (PDT)
Received: by 10.200.55.212 with HTTP; Thu, 2 Jun 2016 16:23:00 -0700 (PDT)
In-Reply-To: <20160602231619.GA11277@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296261>

On Thu, Jun 2, 2016 at 4:16 PM, Jeff King <peff@peff.net> wrote:
> On Thu, Jun 02, 2016 at 03:15:39PM -0700, Junio C Hamano wrote:
>
>> When your $PWD does not match $(/bin/pwd), e.g. you have your copy
>> of the git source tree in one place, point it with a symbolic link,
>> and then "cd" to that symbolic link before running 'make test', one
>> of the tests in t1308 expects that the per-user configuration was
>> reported to have been read from the true path (i.e. relative to the
>> target of such a symbolic link), but the test-config program reports
>> a path relative to $PWD (i.e. the symbolic link).
>>
>> Instead, expect a path relative to $HOME (aka $TRASH_DIRECTORY), as
>> per-user configuration is read from $HOME/.gitconfig and the test
>> framework sets these shell variables up in such a way to avoid this
>> problem.
>
> Looks good.
>
>   Acked-by: Jeff King <peff@peff.net>
>
> To prevent this in the future, I switched my default --root= to point to
> a symlink. I wonder if we could do something in the test suite, though,
> as we did long ago by introducing "trash directory" with a space to
> catch corner cases.
>
> I guess it would be something like:
>
>   if test_have_prereq SYMLINKS

IIUC this would need each test to be marked with SYMLINKS
when testing with symlinks is desired. Marking a test with that
is easily forgotten, so I'd rather do it by default as:

if (system supports symlinks):
>   then
>         mkdir "$TRASH_DIRECTORY.real" &&
>         ln -s "$TRASH_DIRECTORY.real" "$TRASH_DIRECTORY"
>   else
>         mkdir "$TRASH_DIRECTORY"
>   fi
>
> but there may be some other tweaks required (e.g., for cleanup).

I like the idea of testing with symlinks. (Does it have performance issues
when everything goes through symlinks?)

On the other hand if we do tests by default in a symlinked path, we could
introduce errors more easily in non-symlinked path, but that is what developers
use for developing (I guess), so it's not as likely?

Thanks,
Stefan

>
> -Peff
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
