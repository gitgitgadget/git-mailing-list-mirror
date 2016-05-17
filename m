From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v6 00/17] Port branch.c to use ref-filter's printing options
Date: Wed, 18 May 2016 00:32:51 +0530
Message-ID: <CAOLa=ZQ-XwEhTRwoNhrBH=NCQhpsHR=PfgtDrfJs23j6hkBWRA@mail.gmail.com>
References: <1463309133-14503-1-git-send-email-Karthik.188@gmail.com>
 <xmqq4m9x1wl2.fsf@gitster.mtv.corp.google.com> <CAOLa=ZQ5nUazL61eqj34-v06rueyjzvvJHzp8du7HHGi5=7TMA@mail.gmail.com>
 <xmqqtwhwwp0c.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 17 21:03:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b2kH9-0000q3-Kb
	for gcvg-git-2@plane.gmane.org; Tue, 17 May 2016 21:03:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752621AbcEQTDX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 17 May 2016 15:03:23 -0400
Received: from mail-qk0-f178.google.com ([209.85.220.178]:33880 "EHLO
	mail-qk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751663AbcEQTDW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 May 2016 15:03:22 -0400
Received: by mail-qk0-f178.google.com with SMTP id r184so14311210qkc.1
        for <git@vger.kernel.org>; Tue, 17 May 2016 12:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GJ0BzGMBjj3nz9MKsb/l5hr3W5hvl7mShl9YENguufg=;
        b=pQEPLzaQ9ycHbeseXmugMPGZMy/yPnq4p9iSk7iSrqwDePxzB1JDIxJ0xdpS3Ku0db
         wj06vK6yIlq/pp05q6whbsuu8g6zC1hjT5p8HTlsqIWw7IQMJKLi/1Sx9uNE6wG6mHzR
         tTigodOiPp/IS4ZU6QMkZ1BjNEDuKl+mBs64gIbucr0lXhxtAKfp28QG7qTlBDDxnCQT
         9EeLxAAlLTg0oQ5pNyZ7z2laDuRl6C0dBLr83EkwOLhySfr1LrwfDQwusNIQCG/jVDxG
         XPE3WyqSVCs9IyGxBZuxIM7gKgDEZDwUquR0OmlleojDBqsUrjCTFAU4s5EcH5HGaaB3
         ddFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GJ0BzGMBjj3nz9MKsb/l5hr3W5hvl7mShl9YENguufg=;
        b=kQo+FgahF0zCOyfVt+WIBERejSng7QKa9mRBelg3lSnRLU94KsqTnOnEnQnpTnIT/E
         reEzEC90tHtwzDdxTKRqHl1BrXzWz6sJLR0+poEukhAUoUfGr4jUL/Mmst8D/u7IcGvE
         NT+j9JLinZ9tM3FBzUb/rAaaXYKHK2VvFbd7n+lW7Gt80L6ucPF7k3rq0m0/72emVrRh
         xdN0/3VTIvJdgFwHJfCbGM2b9gf9wMG+U9gW688s7JNElbXhWE6dcAjfJ8gtTBdRC3su
         CDd9lvs9x53d5ZyHKjE5IbNhpO4Ochmn4KhTx5UsK1hFX+EHCcBpKO9joine0AAQEjYj
         rgsw==
X-Gm-Message-State: AOPr4FW+C59e2RKbEuyrDL+wJQjGjSX/AaKxrLgegfa0fl+bfAGxIOhW96bfdALYD1752tZ0kKolVyC0Gv9yDA==
X-Received: by 10.55.79.5 with SMTP id d5mr3536162qkb.30.1463511801257; Tue,
 17 May 2016 12:03:21 -0700 (PDT)
Received: by 10.140.92.178 with HTTP; Tue, 17 May 2016 12:02:51 -0700 (PDT)
In-Reply-To: <xmqqtwhwwp0c.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294896>

On Tue, May 17, 2016 at 11:22 PM, Junio C Hamano <gitster@pobox.com> wr=
ote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> Hello, sorry for the confusion, it's built on top of 'next' which co=
ntains
>> f307218 (t6302: simplify non-gpg cases). The merge conflict is due t=
o the
>> commit made by you 1cca17df (Documentation: fix linkgit references).
>
> That is not "confusion", but an "incorrect piece of information".
>
> The series does not seem to apply on 'next', either.
>
> Where did you exactly rebase on top of?  It is not on f307218, it is
> not on 'next', 'next@{1}',... 'next@{8}'.
>
> f3072180 (t6302: simplify non-gpg cases, 2016-05-09) was merged to
> 'next' at 9fcb98b2 (Merge branch 'es/test-gpg-tags' into next,
> 2016-05-10), but the series does not seem to apply there, either.
>
> $ git co 9fcb98b2
> Applying: ref-filter: implement %(if), %(then), and %(else) atoms
> error: patch failed: Documentation/git-for-each-ref.txt:181
> error: Documentation/git-for-each-ref.txt: patch does not apply
> Patch failed at 0001 ref-filter: implement %(if), %(then), and %(else=
) atoms
> The copy of the patch that failed is found in: .git/rebase-apply/patc=
h
> When you have resolved this problem, run "git am --continue".
> If you prefer to skip this patch, run "git am --skip" instead.
> To restore the original branch and stop patching, run "git am --abort=
".
>
> Not that a series built on top of any 'next' is directly usable.
> You are forcing me to identify which topics in 'next' you depend on,
> and build a topic that does not contain anything unrelated that is
> in 'next' before starting to apply these patches.  Can you pick a
> more appropriate place to base these patches on, please?  Why isn't
> this based on 'master', for example?

Hello,

Sorry for that.
The only reason I haven't based it on 'master' is because it doesn't co=
ntain
'f307218'.

=E2=9E=94 git branch --contains=3Df307218
  next
  ref-filter

Now speaking of which, this is based on next.

=E2=9E=94 git branch -v
    * next       78b384c Sync with master

And Idk what the problem is but it seems to apply perfectly on top of i=
t [1]

=E2=9E=94 git am v6-00*
Applying: ref-filter: implement %(if), %(then), and %(else) atoms
Applying: ref-filter: include reference to 'used_atom' within 'atom_val=
ue'
Applying: ref-filter: implement %(if:equals=3D<string>) and
%(if:notequals=3D<string>)
Applying: ref-filter: modify "%(objectname:short)" to take length
Applying: ref-filter: move get_head_description() from branch.c
Applying: ref-filter: introduce format_ref_array_item()
Applying: ref-filter: make %(upstream:track) prints "[gone]" for
invalid upstreams
Applying: ref-filter: add support for %(upstream:track,nobracket)
Applying: ref-filter: make "%(symref)" atom work with the ':short' modi=
fier
Applying: ref-filter: introduce refname_atom_parser_internal()
Applying: ref-filter: introduce symref_atom_parser() and refname_atom_p=
arser()
Applying: ref-filter: make remote_ref_atom_parser() use
refname_atom_parser_internal()
Applying: ref-filter: add `:dir` and `:base` options for ref printing a=
toms
Applying: ref-filter: allow porcelain to translate messages in the outp=
ut
Applying: branch, tag: use porcelain output
Applying: branch: use ref-filter printing APIs
Applying: branch: implement '--format' option

[1] : https://github.com/KarthikNayak/git/commits/ref-filter

--=20
Regards,
Karthik Nayak
