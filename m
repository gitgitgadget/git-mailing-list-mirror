From: Stefan Beller <sbeller@google.com>
Subject: Re: weird diff output?
Date: Tue, 29 Mar 2016 10:37:38 -0700
Message-ID: <CAGZ79ka4ad5dQMWANJUDx-0+kV3qR=HttOJni2XfhFzjMKfcPw@mail.gmail.com>
References: <CA+P7+xoiFUiBwDU2Wo9nVukchBvJSknON2XN572b6rSHnOSWaQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git mailing list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Jacob Keller <jacob.keller@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 29 19:37:50 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1akxaP-0005MF-H8
	for gcvg-git-2@plane.gmane.org; Tue, 29 Mar 2016 19:37:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757871AbcC2Rhm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2016 13:37:42 -0400
Received: from mail-ig0-f172.google.com ([209.85.213.172]:37647 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757841AbcC2Rhj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2016 13:37:39 -0400
Received: by mail-ig0-f172.google.com with SMTP id l20so20820160igf.0
        for <git@vger.kernel.org>; Tue, 29 Mar 2016 10:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=NgDyCdBHwD/2LTspBqyDmm5UUZcAKiShvryRBTGfBo8=;
        b=NOiTLRhZKu7cwOktFuiG6E3Qz3nLTMQnNIe8IE6aoDeRTgB4UcY1TW/iv8/0Lgiq8a
         0zxbIRRbGUXoEPbFQ1IABbmJ363s2zur0u7/p8auQfHqfvmp7wxjqM6RpIOu/AOKA5yJ
         OX3aGJb1ha3sxbqyfSB3SrePbPOh6nSy0MaSyahWTkstMRePAjgOphCNkj5SDL8FORNm
         PTGO32si0wZgVJ7wprDFMxWbEpzR4+/WQ2up/rw6YyiHx4Chjae5Ou5LIAHgob44AuH6
         b9mdGC4bH2Z9PQ/1h0vTTJ3ioUaRSj0+yosthnvrYjf+MJsqK0R/MX+LpSEDre+Fxv6Q
         x0Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=NgDyCdBHwD/2LTspBqyDmm5UUZcAKiShvryRBTGfBo8=;
        b=NYwRtCd5YTqlUiDycCzzhVgvJeNWLcI5UPqpaRf7fZEK3EYQ1Ka8IgeBWZXeuZN2BH
         oE2/Bx/rN2MsIP4ZtdonJZKYzc8QHO96XbRREc7VS6+Y9w2Ce/DpTmg+SaDTqzL0O9oR
         jbT85uOquWPtMa5bORWR2V70KokBw0ig8AHg/QAoNUGaeSGF0yJqEEiBjRk14kI1OziI
         XKaVDtsqNgsG2zZngpPvYpZuK2qnuULFIkG/ghFXqtnK+FjPBOGYUjd9AehH3taVEFWn
         wjZsNH12plprydK33DYxkmZME5UIeabryh9UZFB44iT7Sc+8MY+SGP9aMVcf5soMZSQy
         g0qA==
X-Gm-Message-State: AD7BkJJXVUFDHzdGJzLVSHadOtljOqeABooa2LT0GNaoewHT4+lF6eJeSPVJi5krxdbnHhzwH05aombY6QBbQZz9
X-Received: by 10.50.28.105 with SMTP id a9mr17881299igh.94.1459273058291;
 Tue, 29 Mar 2016 10:37:38 -0700 (PDT)
Received: by 10.107.132.101 with HTTP; Tue, 29 Mar 2016 10:37:38 -0700 (PDT)
In-Reply-To: <CA+P7+xoiFUiBwDU2Wo9nVukchBvJSknON2XN572b6rSHnOSWaQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290151>

On Mon, Mar 28, 2016 at 5:26 PM, Jacob Keller <jacob.keller@gmail.com> wrote:
> On Mon, Mar 28, 2016 at 4:28 PM, Stefan Beller <sbeller@google.com> wrote:
>>  cat > expect <<EOF
>> +Entering '../nested1'
>> +Entering '../nested1/nested2'
>> +Entering '../nested1/nested2/nested3'
>> +Entering '../nested1/nested2/nested3/submodule'
>> +Entering '../sub1'
>> +Entering '../sub2'
>> +Entering '../sub3'
>> +EOF
>> +
>> +test_expect_failure 'test messages from "foreach --recursive" from subdirectory' '
>> +       (
>> +               cd clone2 &&
>> +               mkdir untracked &&
>> +               cd untracked &&
>> +               git submodule foreach --recursive >../../actual
>> +       ) &&
>> +       test_i18ncmp expect actual
>> +'
>> +
>> +cat > expect <<EOF
>>  nested1-nested1
>>  nested2-nested2
>>  nested3-nested3
>
> Complete tangent here. The diff above looks like
>
> <old-line>
> +
> +
> +
> +
> +<old-line>
>
> is it possible to get diff output that would look more like
>
> +<old-line>
> +
> +
> +
> +
> +
> <old-line>
>
> instead? This is one of those huge readability issues with diff
> formatting that seems like both are completely correct, but the second
> way is much easier in general to read what was added.
>
> I don't understand why diff algorithms result in the former instead of
> the latter, and am curious if anyone knows whether this has ever been
> thought about or solved by someone.

I thought this is an optimization for C code where you have a diff like:

    int existingStuff1(..) {
    ...
    }
    +
    + int foo(..) {
    +...
    +}

    int existingStuff2(...) {
    ...

Note that the closing '}' could be taken from the method existingStuff1 instead
of correctly closing foo. So the correct heuristic really depends on
what kind of text
we are diffing.

Maybe we need the opposite of the 'patience' algorithm in format-patch?

Another heuristic would be to check for empty lines and use that as a
strong hint,
whether to use the first or last line. (Rule: Try to use that last or
first line such that
the lines at the edges of the diff are empty lines, it needs to be
formalized a bit more)

>
> I've tried using various diffing algorithms (histogram, etc) and they
> always produce the same result above, and never what I would prefer.
>
> Regards,
> Jake

Thanks,
Stefan
