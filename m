From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 1/3] pretty: support "mboxrd" output format
Date: Tue, 31 May 2016 14:10:03 -0400
Message-ID: <CAPig+cQrQfxWrGhpvtb-GKYfK0tMLsx9JJ+eWRRx00F8mNXrLg@mail.gmail.com>
References: <20160530232142.21098-1-e@80x24.org>
	<20160530232142.21098-2-e@80x24.org>
	<CAPig+cQrSJe03_RtSyf5KO2vE3Rri7t70-he8SXA9Y4oBYY_Ww@mail.gmail.com>
	<20160531074506.GA8911@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Eric Wong <e@80x24.org>
X-From: git-owner@vger.kernel.org Tue May 31 20:10:12 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b7o7H-00072K-KZ
	for gcvg-git-2@plane.gmane.org; Tue, 31 May 2016 20:10:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755481AbcEaSKG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 May 2016 14:10:06 -0400
Received: from mail-it0-f45.google.com ([209.85.214.45]:36604 "EHLO
	mail-it0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755214AbcEaSKF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 May 2016 14:10:05 -0400
Received: by mail-it0-f45.google.com with SMTP id e62so67202375ita.1
        for <git@vger.kernel.org>; Tue, 31 May 2016 11:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=whI0VgiVR/1V7cVSx7Wdk3YeMDnsji2ZDBRxsWZhsDI=;
        b=WI0jWFhPMH5Dd06nxNt5VM5ryDWFZCetlIk61ANsmkHtD/LIYZ+2TxSPUq9jtzesp5
         lV3yW9o4qOxq8JdoR3qP+eXniBaqzLx0yGXcgeIgqcYPNmCy8i4mHXowZazMpMGY4M7M
         vxSJR9DNbpuA0WlggFki+vl8N3TSfqZ08MBa8fVJFLpVqfYAU0fjN1jJE2PMNFpLjs03
         VqR9uohrHdy8PuU15woiI+nTPUhN6NmsHH6LKpFi1lcFguZrXIfiIWAXpmRpQPUThg0t
         SUxsTWSczCGiJIWRO5WYqIx35Pfa9OqzGXKbzmKUx2iI0rS/2yETEEVIs27yZLpKQAX9
         bOzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=whI0VgiVR/1V7cVSx7Wdk3YeMDnsji2ZDBRxsWZhsDI=;
        b=Bfh0j1Pyp3CkStfAxJ2ziDKUTrIl5gLGQHIktZnaGQf9zfe9zaLgihnBNjZl3uTnZ6
         EyzhVpWGOe2YvGuVjI7ud3SfPKmvB0LR70tmHf3bHqW1jAb+ND+nSg/NKvAdBrS3Ps5B
         8xEPCXreXcWClh84nMu/V4EU8MRrwSbKYfJssogHrryKfLc7gt7NbkyUu9Tq1A1l5mBf
         Gtp7PaBO7Mg9S+BD6A1PeRhDWZqj/pGZHSvUtrXrvujoPWcFtJ0gCm8nqvhcosNXe987
         ZvHriIIGJl/CC/wHQL2FeRTH71ItcBGPn0DUwGvMEfohR+NY31waGIYAlIPM2PoTME0V
         3rww==
X-Gm-Message-State: ALyK8tJr2qT2KOzoxziBDK1cBwXkWJOlMMMoIPUiIeFZproL1BtGzUg8lrpLEHcWRPPMLi4ci8cfgKr0EJ9X+w==
X-Received: by 10.36.55.13 with SMTP id r13mr15203099itr.73.1464718203212;
 Tue, 31 May 2016 11:10:03 -0700 (PDT)
Received: by 10.79.0.30 with HTTP; Tue, 31 May 2016 11:10:03 -0700 (PDT)
In-Reply-To: <20160531074506.GA8911@dcvr.yhbt.net>
X-Google-Sender-Auth: _FrMr3_sCX1TeyZ6frCVn90xFCk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296001>

On Tue, May 31, 2016 at 3:45 AM, Eric Wong <e@80x24.org> wrote:
> Eric Sunshine <sunshine@sunshineco.com> wrote:
>> On Mon, May 30, 2016 at 7:21 PM, Eric Wong <e@80x24.org> wrote:
>> > +                       if (pp->fmt == CMIT_FMT_MBOXRD &&
>> > +                                       !regexec(mboxrd_from, line, 0, 0, 0))
>> > +                               strbuf_addch(sb, '>');
>>
>> At first glance, this seems dangerous since it's handing 'line' to
>> regexec() without paying attention to 'linelen'. For an arbitrary
>> regex, this could result in erroneous matches on subsequent "lines",
>> however, since this expression is anchored with '^', it's not a
>> problem. But, it is a bit subtle.
>
> Maybe having more context of the pp_remainder function and
> seeing the get_one_line call would've helped in the diff;
> I didn't think of this issue once I figured out where to
> place the change.

No, extra context wouldn't have helped. The problem is that
get_one_line() merely returns the length of the line, which might be
where the NUL-terminator is or it might be where the next newline is.
Therefore, you can't rely upon the "current line" being
NUL-terminated. So, in general, it's not "safe" to pass it to a
function expecting the "line" to end at a NUL-terminator.

> On the other hand, not being too familiar with git C APIs, I was
> more worried strbuf was not NUL-terminated for regexec, but it
> seems to be.

Yes, that's a guarantee, but it doesn't help in this case. Given
line="foo\nbar", get_one_line(line) will return 4, the length of
"foo\n", but regexec() won't know to stop looking until it hits the
NUL after the 'r'. An arbitrary regex, such as /bar/ will match beyond
what get_one_line() considers the end-of-line, which is why this code
looks scary (wrong) at first glance.

>> I wonder if hand-coding, rather than using a regex, could be an improvement:
>>
>>     static int is_mboxrd_from(const char *s, size_t n)
>>     {
>>         size_t f = strlen("From ");
>>         const char *t = s + n;
>>
>>         while (s < t && *s == '>')
>>             s++;
>>         return t - s >= f && !memcmp(s, "From ", f);
>>     }
>>
>> or something.
>
> Yikes.  I mostly work in high-level languages and do my best to
> avoid string parsing in C; so that scares me.  A lot.

The hand-coded is_mboxrd_from() above is pretty much idiomatic C and
(I think) typical of how such a function would be coded in Git itself,
so it looks normal and easy to grok to me (but, of course, I'm
probably biased since I wrote it).

> I admit a regex isn't necessary, but I'm wondering if the above
> could be made less frightening to someone like me.

Perhaps, but it's difficult to say without knowing how it frightens you.

> Maybe extra test cases + valgrind can quell my fears :)

I can envision tests such as:

    ""
    "F"
    "From"
    "From "
    "From     "
    "From foobar"

and so on, if that's what you mean.
