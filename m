From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: t4151 missing quotes
Date: Mon, 9 May 2016 12:22:14 -0400
Message-ID: <CAPig+cTbAA8xDWvCXbBF+HJpxONS38hcjAiNuocC+PUBro9ALg@mail.gmail.com>
References: <CALR6jEiBsU+jQ8VoRsniMdztCpVDemQ3r00W-OXdRP6ZEt9CFg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Armin Kunaschik <megabreit@googlemail.com>
X-From: git-owner@vger.kernel.org Mon May 09 18:23:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aznwq-0006C5-II
	for gcvg-git-2@plane.gmane.org; Mon, 09 May 2016 18:22:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751057AbcEIQWQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 May 2016 12:22:16 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:36204 "EHLO
	mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750983AbcEIQWP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 May 2016 12:22:15 -0400
Received: by mail-io0-f196.google.com with SMTP id k129so19105972iof.3
        for <git@vger.kernel.org>; Mon, 09 May 2016 09:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=PzpOoS04YubcJvLFYRi4CyO46HTL2hyCJTrHV7fsS14=;
        b=Xn8zF7z1mFtCT/xq4cVoZQenHq2mlrFntnEFjPQi7IoRF5SQVBwpoy/NQJuPoUiU4w
         g4EznIR3gsGc1urSPF76XoHv5FmEoZHb8GYo3A8CRIwlUZieLGevF1WRr5rxYd1R+eo/
         xDGpJ31ucpish4LkIcgdRxtxfs82CqlupnrGbOIzftBce8wbU/d/4IgyeBSF3si8vAZU
         SGWlkcrCUwxcQeaND5iCGlem2/AU2CuXgvR0SMwEM3Mnah2890tq+17JA83Lqz6DDy5b
         +88UovyvfQ/3QOmhXy+HB7E5E0ck4d3Iq8Ri0V7cSBJONrTeVvrLIbiTQ6TKuOE034/f
         hxhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=PzpOoS04YubcJvLFYRi4CyO46HTL2hyCJTrHV7fsS14=;
        b=Ha5IGBtmi+DbtCg6BvYbjbBSRaL12raLkITq5GCWEjVzZRRVNyXWobVeoCeCOeSC07
         QULxKeDPi38Cr//PEZN1qpzAXMuNrftCPoospkGznzjnXVlCP0N8Yq5qPCQsUfFZbPqU
         eMJwEos1eB26Q47Y5OH/5ffeL1g9jwpTAiGvE+1QIaEHKidJPEK71IerkVIyV4sD2LWY
         Epdr2aumh4vkEoNM7/M11LsPg4ktb/DShnIyVjj36p/eqqJhU9qsJWr1DSQPGKfnZjIO
         q3GzFHSj/kgpTIoxA/J5KhuKRFkf7mb+zSV5y9/dnZi7HiOa1tvCUnsItEkO+0j6JkqN
         Nk9w==
X-Gm-Message-State: AOPr4FVvDHo0nGSMcc/fXddwuG1XKoaWLBlNDAmeb+F2hrDC+2E8MKqEg2niYS/i8MJHpUY3RlxB2bOL5jdvcQ==
X-Received: by 10.107.47.37 with SMTP id j37mr37019577ioo.168.1462810934889;
 Mon, 09 May 2016 09:22:14 -0700 (PDT)
Received: by 10.79.139.4 with HTTP; Mon, 9 May 2016 09:22:14 -0700 (PDT)
In-Reply-To: <CALR6jEiBsU+jQ8VoRsniMdztCpVDemQ3r00W-OXdRP6ZEt9CFg@mail.gmail.com>
X-Google-Sender-Auth: FWlvhAHIuVqho9C3-9sn4KO4sdA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294008>

On Mon, May 9, 2016 at 12:09 PM, Armin Kunaschik
<megabreit@googlemail.com> wrote:
> skipping through some failed tests I found more (smaller) problems
> inside the test... when test arguments are empty they need to be
> quoted (quite a lot test in this sentence).
>
> Error is like
> t4151-am-abort.sh[5]: test: argument expected
>
> My patch:
>
> *** t4151-am-abort.sh   Mon May  9 17:51:44 2016
> --- t4151-am-abort.sh.orig      Fri Apr 29 23:37:00 2016
> ***************
> *** 67,73 ****
>   test_expect_success 'am -3 --skip removes otherfile-4' '
>         git reset --hard initial &&
>         test_must_fail git am -3 0003-*.patch &&
> !       test 3 -eq "$(git ls-files -u | wc -l)" &&
>         test 4 = "$(cat otherfile-4)" &&
>         git am --skip &&
>         test_cmp_rev initial HEAD &&
> --- 67,73 ----
>   test_expect_success 'am -3 --skip removes otherfile-4' '
>         git reset --hard initial &&
>         test_must_fail git am -3 0003-*.patch &&
> !       test 3 -eq $(git ls-files -u | wc -l) &&
>         test 4 = "$(cat otherfile-4)" &&
>         git am --skip &&
>         test_cmp_rev initial HEAD &&
> ***************

Some comments:

Quoting the output of 'wc -l' will break the tests on Mac OS X and BSD
since the output contains leading whitespace which won't match the "3"
on the other side of the '='.

Your diff is backward, comparing 'current' against 'original', which
makes it difficult to read. Reviewers on this list expect to see
'original' compared against 'current'.

Use a unified format to make the diff easier to read; or just use
git-diff or git-format patch, which is even simpler.

It's not clear how the output of 'wc -l' could ever be the empty
string. Perhaps git-ls-files is dying and causing the pipe to abort
before 'wc -l' ever outputs anything? Without additional information
about the problem you're experiencing, it's difficult to judge if this
change is a good idea.
