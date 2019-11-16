Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F2F41F4B5
	for <e@80x24.org>; Sat, 16 Nov 2019 02:40:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727386AbfKPCkL (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Nov 2019 21:40:11 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:54924 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727276AbfKPCkL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Nov 2019 21:40:11 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B097F98A10;
        Fri, 15 Nov 2019 21:40:10 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=TkvtV3aFX0HLuEMJJA7YHyDwaBc=; b=n26sAf
        0Yi3XhtinIYgeayW4KS4g8NQ/uTGK4sjKMR3Xo15SkiJgrWN10qloymJeqPvdhHp
        X1/SCpDWayZVLoGUimjv8gYejb4I3hjWw4s9UCe8hlGj4koBNs6yhmb954H134Qd
        AepBuP4HP1exO5Ux1qSi80fbFAJ28qbaOC9mg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=f/lJKsjmM7+0uM3j3jxI3z0mUQNAxjG3
        MBW0bSAM8vP35xgEskJthelSPpP7FIkbrwvtzkAQM6OZcNnyFf7YQZ3OFeeCBuAD
        K1g7zuA4c2W0vZsGJW7CJTN/fLV1dUCRrAtX9pWz0j1P+P+bkVAN/itQAbuUeqKc
        N9uv7L/+4vY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A880E98A0F;
        Fri, 15 Nov 2019 21:40:10 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id D42A798A0E;
        Fri, 15 Nov 2019 21:40:07 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Ben Keene via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Ben Keene <seraphire@gmail.com>,
        Ben Keene <bkeene@partswatch.com>
Subject: Re: [PATCH v2 1/3] Cast byte strings to unicode strings in python3
References: <pull.465.git.1573679665.gitgitgadget@gmail.com>
        <pull.465.v2.git.1573828978.gitgitgadget@gmail.com>
        <0bca930ff82623bbef172b4cb6c36ef8e5c46098.1573828978.git.gitgitgadget@gmail.com>
Date:   Sat, 16 Nov 2019 11:40:05 +0900
In-Reply-To: <0bca930ff82623bbef172b4cb6c36ef8e5c46098.1573828978.git.gitgitgadget@gmail.com>
        (Ben Keene via GitGitGadget's message of "Fri, 15 Nov 2019 14:42:56
        +0000")
Message-ID: <xmqqeey85yt6.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 67065B1A-081A-11EA-ABEC-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Ben Keene via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Ben Keene <bkeene@partswatch.com>
> Subject: Re: [PATCH v2 1/3] Cast byte strings to unicode strings in python3

That is "how" this patch tries to achieve something that is not
explained in this proposed log message.  Worse, the rest of the
proposed log message is entirely empty and does not help readers
understand what the author wanted to do, or decide if applying these
patches is a good idea.

You wrote something about Python 3 having issues while comparing the
strings read out of process.popen() against string literals in the
code elsewhere in the cover letter.  That information is probably
very relevant to explain why this commit exists, i.e. it should be
explained here.

Here is what I _think_ is close to why you wrote this patch, but as
I already said, I am far from being familiar with Py2to3
differences, so there may be factual misunderstanding you would want
to fix, even if you decide to pick some pieces out of it when
sending an updated patch.

    Subject: [PATCH] git-p4: compare "p4" output with the right string type

    Communicating with a subprocess yields a byte string in both
    Python 2 and Python 3.  Comparing the output or the error string
    with string literals makes the code fail, as string literals in
    Python 3 are unicode strings and not byte strings.

    Introduce a ustring() helper, which returns the corresponding
    unicode string for a given byte string (or return the argument
    as-is, when a unicode string is given) in Python 3, but returns
    the given bytestring as-is in Python 2.  Use it to turn strings
    obtained from subprocess to the type suitable to compare with
    the string literals in both versions of Python.

What does the name "ustring()" stand for?

What purpose does the function serve at the higher conceptual level?
Name the function after the answer to that question and the code
would become easier to explain.

It certainly is not "make sure we have unicode string", as the name
is shared between Python 2 and Python 3, and in the older Python 2
world, you want the helper to mean "keep the string a bytestring",
not turning it into a unicode string.  So I doubt ustring() is a
great name for this helper.

>              if skip_info:
>                  if 'code' in entry and entry['code'] == 'info':
>                      continue
> +                if b'code' in entry and entry[b'code'] == b'info':
> +                    continue

This one explicitly calls for 'bytes', which I think would work
correctly with Python 2.  But why would we have to prepare for both
variants existing in the entry[] hash (especially when working with
Python3)?  Shouldn't the code that populates entry[] be responsible
for turning a byte string into a unicode string?

Also, is subprocess.communicate the only way bytestrings can come to
"git-p4" program, or are there other avenues?  What I am wondering
is if it is sensible to declare that when running under Python 3,
the program will internally use unicode strings for everything and
convert any bytestring to unicode string as soon as it enters [*1*]

That would mean ...

>              if cb is not None:
>                  cb(entry)
>              else:
> -                result.append(entry)
> +                if isunicode:
> +                    out = {}
> +                    for key, value in entry.items():
> +                        out[ustring(key)] = ustring(value)
> +                    result.append(out)
> +                else:
> +                    result.append(entry)

... a hunk like this would become entirely unnecessary, as keys and
values of entry[] that are read from outside world would have
already been made into unicode strings under Python 3.

By the way, would values in entry[] always some string (iow, can
they have a literal number like 47 and 3.14)?

>      except EOFError:
>          pass
>      exitCode = p4.wait()
> @@ -792,7 +813,7 @@ def gitConfig(key, typeSpecifier=None):
>          cmd += [ key ]
>          s = read_pipe(cmd, ignore_error=True)
>          _gitConfig[key] = s.strip()
> -    return _gitConfig[key]
> +    return ustring(_gitConfig[key])

Likewise.  I'd expect, if we were to declare that our internal
strings are all unicode in Python 3, we'd be using a thin wrapper of
read_pipe() that yields a unicode string, so 's' would not be a
bytestring, and s.strip() would not be either.

>  def gitConfigBool(key):
>      """Return a bool, using git config --bool.  It is True only if the
> @@ -860,6 +881,7 @@ def branch_exists(branch):
>      cmd = [ "git", "rev-parse", "--symbolic", "--verify", branch ]
>      p = subprocess.Popen(cmd, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
>      out, _ = p.communicate()
> +    out = ustring(out)

But perhaps it is a bit too much and it is easier to call the
conversion helper on the results obtained by read_pipe() that gives
us bytestring, like this one (and one above that) does?  I dunno.

Thanks.


[Footnote]

*1* If it is not just string comparison but the general direction
    were to consistently use unicode strings under Python 3, which
    I think makes sense at the conceptual level, the sample log
    message I prepared in the earlier part of this response needs to
    be updated, so that it is not so message/comparison centric.

    I said "at the conceptual level", because there may be practical
    reasons not to use unicode everywhere (e.g. performance might
    degrade and some bytestrings used may not be text data in the
    first place).

