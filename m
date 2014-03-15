From: Justin Lebar <jlebar@google.com>
Subject: Re: [PATCH 0/6] Fix misuses of "nor"
Date: Sat, 15 Mar 2014 09:56:59 -0700
Message-ID: <CAMuNMfri8Sd5pWccnfkE4b1Fdp3i-Cbo6vTk1QVN3SZcOnKvTw@mail.gmail.com>
References: <1394872922-2000-1-git-send-email-jlebar@google.com> <CACsJy8C2Qainuix2CXy7P71BxE1ajrzfxYMmNAyVa04mfSJJ-A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Richard Hansen <rhansen@bbn.com>,
	Jiang Xin <worldhello.net@gmail.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 15 17:57:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WOrtl-0001AE-FW
	for gcvg-git-2@plane.gmane.org; Sat, 15 Mar 2014 17:57:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755849AbaCOQ5V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Mar 2014 12:57:21 -0400
Received: from mail-qa0-f53.google.com ([209.85.216.53]:59459 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755720AbaCOQ5U (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Mar 2014 12:57:20 -0400
Received: by mail-qa0-f53.google.com with SMTP id w8so3806085qac.12
        for <git@vger.kernel.org>; Sat, 15 Mar 2014 09:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=OGVUWJSkG7j6v2fQBLpit008/MXnUiCBjCh4vcldeKE=;
        b=oIf5GhGeOgBfiZ1UX6nIhkpO6aLsPwmoFpXpDM9ITEA59uyfBb7RtZAo3BPtFLdLdj
         bkvovcw4YsJWqqrncleM9nXLwU17XaDUfcwCUnxfLTFtjRX0/cTot2dpiyqHHfz4MKbr
         irXbbonhoF/bt2cNrMNhfWsbizL7r4/YjuWUuYqDkdqjaUNROpViBziRYKXtmilLtXmf
         i99StvPx8VOT6VSJ8JpTMhjwGmHWU8stR4uY305Ure81wMGWw1nrL0jNjjGpHuO8jFzu
         UX4jpHbpFOYw7MEvXq0LoisI0goRY647ingc+G+d6r10EXQSwSfUk6rI8jJLMTrBF2m3
         tQ6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=OGVUWJSkG7j6v2fQBLpit008/MXnUiCBjCh4vcldeKE=;
        b=gr1VFt9f7NDe2GrJWx3GHG4+qW68lKp6ykmJfdF/Ba/SQLc7zpYQpdAFciOb0jUug5
         xRLu5DXzm62yjvAwkdLxlKbvI59nDrhU6yHpXgZT3pJtHdwTk60nRE7P9TWGNt2eFx65
         ufkuKrHyxSusg+wj2vcNLBeDZI3FOpwsCpYbIKGbienqfBBe/7a2zRk8UiNEu/rIjxoN
         pBqU9PPnhpmZN+XASVATDWzs45yv6SvNGwly5ATakTmBQiLouvM5kWQsL4d4kCcvekrh
         odsY91G2Bc8VcMPcGnfLb5A0eOtwGVQbvxt296dhJQnZCUkEDouiq8jHyOcGdTOy2cud
         WQ3Q==
X-Gm-Message-State: ALoCoQneKvebFz/dtpyTMsKOJCp0x5BmyBH313Za7VrcVF062XCTQtOKi6oZmpWpe2Bpz7R5YK0izKVR2KkYBUX0PcQYTjrYoqmPriSsPbGxrgOJ90h/uxmtJQS1aZRlDsodxtLd5BOgCm2eXH7vWmBVChDGru9iGfy1IBTZhv1PGPaThNwHQSc9WaH42Udxl9/gCj98BMwa
X-Received: by 10.140.88.212 with SMTP id t78mr16586870qgd.47.1394902640044;
 Sat, 15 Mar 2014 09:57:20 -0700 (PDT)
Received: by 10.96.69.36 with HTTP; Sat, 15 Mar 2014 09:56:59 -0700 (PDT)
In-Reply-To: <CACsJy8C2Qainuix2CXy7P71BxE1ajrzfxYMmNAyVa04mfSJJ-A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244161>

> I guess I'm cc'd because I made a few of those or/nor mistakes.

I actually didn't look that closely at the blame; I cc'ed you because
you were a top contributor in a few of the directories I was touching.

> I suggest that you merge "Fix misuses of "nor" outside comments"
> and "Tests: Fix muses of "nor"" into one. Otherwise you break the test
> suite at 5/6

Sure thing, will do.

There's a similar incompatibility with the l10n change and "Fix
misuses of "nor" outside comments": The former references strings
changed in the latter.  Should I merge these, or should I enforce a
particular ordering between these patches?  (Right now the l10n patch
comes before the string changes in the code, but that's probably wrong
now that I think about it.)

> Being a non-native English speaker I'm not really qualified to review this.

FWIW even being a native English speaker I was unsure about a few of
the changes myself.  This caused me to finally break down and order
Garner's Modern American Usage, which I hope will reveal all.  :)

-Justin

On Sat, Mar 15, 2014 at 1:56 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Sat, Mar 15, 2014 at 3:41 PM, Justin Lebar <jlebar@google.com> wrote:
>> I got annoyed by git's awkward use of "nor" in man pages and in git add -p, so
>> I went ahead and audited all uses of "nor" in the tree.  One might be able to
>> argue that some of the uses I've changed are technically acceptable, but that's
>> a pretty low bar to set for ourselves.  I aimed to make everything both correct
>> and idiomatic.
>
> I guess I'm cc'd because I made a few of those or/nor mistakes. Being
> a non-native English speaker I'm not really qualified to review this.
> But I suggest that you merge "Fix misuses of "nor" outside comments"
> and "Tests: Fix muses of "nor"" into one. Otherwise you break the test
> suite at 5/6 (and 6/6 fixes it, but breaking the test suite at any
> commit is not very bisect-friendly).
> --
> Duy
