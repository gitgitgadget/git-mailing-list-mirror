Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 17B3220248
	for <e@80x24.org>; Mon,  1 Apr 2019 00:47:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731595AbfDAArP (ORCPT <rfc822;e@80x24.org>);
        Sun, 31 Mar 2019 20:47:15 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:45127 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731529AbfDAArP (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 31 Mar 2019 20:47:15 -0400
Received: by mail-io1-f66.google.com with SMTP id s7so6297930iom.12
        for <git@vger.kernel.org>; Sun, 31 Mar 2019 17:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5s9aKhW5BlZk8Rdp0MTMHpCSDnsBLjrDBr5tJq0aNcM=;
        b=d2IQwDz3DjJuV7UnXngw+AWOqgB/D1za6phfvYUe+r9YYXpzoUJ7bO3S1AtTrw4l8I
         vuXG+ZidX33lG5IWGKRkPFi9BtinxinPYSJ3WReRwU7ugjEj0kJHcnYTBKFXxrwL9rJG
         qvxSw8f6CcxQmXWCNDpO4fEaypdghZuknGlddlObbFMRQr8yVbTsj1OYOO8JrSpekjms
         aHSk3EHKq4ZwTCQ4l8qSTPs8JqZmArLeFh1/6jFxbEEo54TTiUmUOeo5eOzbNT6CE0Or
         RGOp3fu7Aqy9XNVKHoVE23pt9c6oF5jSMSt4BY4VtcIaFJ5AH4lbNWUmnT1Ke0FDsXTP
         YNeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5s9aKhW5BlZk8Rdp0MTMHpCSDnsBLjrDBr5tJq0aNcM=;
        b=ngsRa42xrS9lzRm/qI7dmhxBuQHF6d0os+ySYXEd9l709gJVwPWFF+ndjKeHa96QVW
         8WFoAzkeHNOk5yQGODEK7AlKu8dlZK6WiWklYTj0hNUkBRvLmTJw2YK7YIz8pD3rW3wV
         jWnsYLkkE/GVofNCXpZHQaYH1+nzXi5hw8lbzzOYAMQ3ScVzH2Wal8cmtMjhVr1fOlsu
         zUG0wh3Hk2GrciwuHryqeE9uzOtaopvIKsSjbdWHpe7l/XXHZx/2C3kqxzuhxLuftG8o
         9tYeoICNTqO+ZV+RixDgT1YPsklcyptFTHFQ6Y1Tg5Af2BxNuOKFXz69tl9GvNGW2w3M
         EAkg==
X-Gm-Message-State: APjAAAU8OrgUHSKjMDcFskPfU1kTeVFoWsnlr5ep+G1n5dgxXI2FtnLh
        j6IcHsRM87dTH1V+m1Zg4W/iP8WKNVW2h6rmjUVGV43G
X-Google-Smtp-Source: APXvYqz05OXa9/Ejlr5lRpjG04G/iurM8YVMkoSyfJcPrktTxh6whib/EOxMpA5wnmTsqf21AdyF99ooWb0Xzw6NifA=
X-Received: by 2002:a5e:d616:: with SMTP id w22mr42299095iom.118.1554079634122;
 Sun, 31 Mar 2019 17:47:14 -0700 (PDT)
MIME-Version: 1.0
References: <CAKrvxcUkLcJ782xe-ETAPNWvD-zv_KXmu0VxRPvJhOGnrChVOg@mail.gmail.com>
 <CACsJy8Dz1TLpMSRNwGtvv9kBHKJsKcses+LegfOfpz2_N3eEHg@mail.gmail.com> <CAKrvxcWFtA7pT++pJRT1ccOwUVzqvD1o0xeXC45em__VHte6pQ@mail.gmail.com>
In-Reply-To: <CAKrvxcWFtA7pT++pJRT1ccOwUVzqvD1o0xeXC45em__VHte6pQ@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 1 Apr 2019 07:46:47 +0700
Message-ID: <CACsJy8AWZLOrcDdmwKJ=x2Co56jVibVfUzaRg30gieOwwHaN_A@mail.gmail.com>
Subject: Re: Typo in the .gitignore docs?
To:     "Dr. Adam Nielsen" <info@drnielsen.de>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Please send plain text mails. HTML mails are dropped by
git@vger.kernel.org so other people will not see them.

On Sun, Mar 31, 2019 at 6:27 PM Dr. Adam Nielsen <info@drnielsen.de> wrote:
>
> Thank you for your quick response.
>
> I will create a pull request and its probably best to continue the discus=
sion from there:

Actually if you want to reach the git development community, this is the pl=
ace.

> Am So., 31. M=C3=A4rz 2019 um 11:54 Uhr schrieb Duy Nguyen <pclouds@gmail=
.com>:
>>
>> On Sun, Mar 31, 2019 at 2:53 AM Dr. Adam Nielsen <info@drnielsen.de> wro=
te:
>> >
>> > Hi everyone,
>> >
>> > I think there is a typo in the gitignore docs.
>> >
>> > Its stated on https://git-scm.com/docs/gitignore that
>> >
>> > >If the pattern does not contain a slash /, Git treats it as a shell
>> > >glob pattern and checks for a match against the pathname relative to
>> > >the location of the .gitignore file (relative to the toplevel of the
>> > >work tree if not from a .gitignore file).
>> >
>> > I think that maybe two things are not 100% correct. First I think it
>> > should be "If the pattern does contain" instead of "does not contain".
>> > Secondly, I think it should be mentioned that this is only true for
>> > slashes that are not a trailing slash.
>>
>> The trailing slash is already covered in the previous paragraph as you n=
oticed.
>
>
> If this is the purpose of the line  "it is removed for the purpose of the
> following description" then I would highly recommend to remove that line.
> If I am not mistaken, the line is only used for the next paragraph.
> It also makes the paragraph where this line appears over-complicated when=
 one reads it.

I think slashes are mentioned in the next three paragraphs actually.
Although the last one (about leading slash) is probably irrelevant,
because a slash can't be leading and trailing at the same time (and
the whole pattern "/" is probably seen as leading slash).

>> The "does not contain" is correct, but perhaps the wording is a bit
>> too easy to misunderstand. If you go back to the original version of
>> this document in cedb8d5d33 (Create a new manpage for the gitignore
>> format, and reference it elsewhere, 2007-06-02), you can see an
>> example of the "otherwise" part where the present of '/' will anchor
>> the pattern to the current directory
>>
>> +   For example, "Documentation/\*.html" matches
>> +   "Documentation/git.html" but not
>> +   "Documentation/ppc/ppc.html".  A leading slash matches the
>> +   beginning of the pathname; for example, "/*.c" matches
>> +   "cat-file.c" but not "mozilla-sha1/sha1.c".
>>
>> This part was later removed by me in 2e22a85e5c (gitignore.txt:
>> elaborate shell glob syntax, 2018-02-01). In hindsight that was a
>> mistake since having an example seems to help clarify the description.
>
>
> The latter example is still in the documentation. I think that the first
> example is just about the paragraph for the "*". An example for the
> paragraph about the "non-containable" slash "/" would be that
> "Documentation/\*.html" does not match "Foo/Documentation/git.html".
>
>
>>
>>
>> So rewording this paragraph (and keep the 'does not contain' part) to
>> be easier to understand would be great. If you turn 'does not contain'
>> to 'does contain' then you would need to update the 'otherwise'
>> paragraph as well.
>
>
> I do not see any change if you remove the line "Otherwise, Git
> treats the pattern as a shell glob:". The symbols "*", "?", "[]"
> do also work if the pattern does not contain a slash.

These two paragraphs cover the "contain slash" and "not contain slash"
cases, one for each. So if the first paragraph is updated to cover the
'do contain slash' then the second has to cover the other case. You
probably see the problem here, that the current 'otherwise' paragraph
does not really tell us more about the 'do not contain slash' case. I
was suggesting that if we update one, we might want to clarify the
other.

>> I think the part that trips people is the 'pathname' in 'checks for a
>> match against the pathname relative...'. I think the key point is
>> matching the pattern against any pathname _component_ in the path
>> relative to the location of .gitignore. In other words '*.c' would
>> match 'abc.c' component in 'def/abc.c'. 'def/ghi/abc.c' or 'abc.c'.
>
>
> Yes, I absolutely agree, this is the key point that should be made more c=
lear.
>
> I understand with "the location of the .gitignore file (relative to the
> toplevel of the work tree if not from a .gitignore file)" the root
> directory, or a .gitignore file that happens to be in a subdirectory.
> So if we ignore the subdirectory case it would read to me like this :
>
> "If the pattern does not contain a slash , it checks for a match
> against the pathname relative to the root". And according to this
> I would mistakenly think that '*.c' would match '/abc.c' but not
> '/def/abc.c'. If this is not meant, then I do not know why it is
> mentioned in first place that it is matching the pattern "against
> any pathname relative to...". This seems to be always the case.

It's from 81c13fde37 (gitignore.5: Clarify matching rules -
2010-03-05). I think it's more about the 'does contain slash'. I
dunno. Adding Jonathan maybe he remembers something.

>
>
>>
>>
>> The following 'otherwise' paragraph perhaps could also elaborate a bit
>> more, that the pattern is matched against the entire path (relative to
>> .gitignore), not just one path component. The FNM_PATHNAME implies
>> that (because it would not make sense otherwise) but that's just too
>> hard to see.
>
>
> That would be an option. However, since I do not the see purpose of the '=
otherwise' case, I would just be clear about it in the mentioned paragraph.
>
>
>>
>>
>> Patches are welcome.
>
>
> I will create a pull request.
>>
>>
>> > You find discussions about this at
>> > https://github.com/git/git-scm.com/issues/1332 and at
>> > https://stackoverflow.com/a/41761521/2311074
>> >
>> > Here is my proposal for an alternative, maybe more clear version:
>> >
>> > >Whenever you have a string that contains a non-trailing slash "/" , i=
ts always considered from
>> > >the root. There is no difference between foo/bar and /foo/bar. The pa=
ttern foo/ is not
>> > >considered from the root, because it has no non-trailing slash "/".
>> > >One may match a path that does not start at the root by using "**" (s=
ee below).
>> >
>> > Also since we are on it, I would suggest to reduce
>> >
>> > >If the pattern ends with a slash, it is removed for the purpose of th=
e following description, but it
>> > >would only find a match with a directory. In other words, foo/ will m=
atch a directory foo and
>> > >paths underneath it, but will not match a regular file or a symbolic =
link foo (this is consistent
>> > >with the way how pathspec works in general in Git).
>> >
>> > to
>> >
>> > >If the pattern ends with a slash, it would only find a match with a d=
irectory. In other words, foo/
>> > >will match a directory foo and paths underneath it, but will not matc=
h a regular file or a
>> > >symbolic link foo.
>> >
>> > What do you think?
>> >
>> > Best regards,
>> > Adam
>>
>>
>>
>> --
>> Duy
>
>
>> The desscription before cedb8d5d33 (in git-ls-files.txt) uses
>> _filename_ instead of pathname, which is probably clearer:
>>
>> - - if it does not contain a slash '/', it is a shell glob
>> -   pattern and used to match against the filename without
>> -   leading directories.
>
>
> Yes that seems clearer.
>


--=20
Duy
