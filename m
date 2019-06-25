Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1818E1F461
	for <e@80x24.org>; Tue, 25 Jun 2019 11:31:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730158AbfFYLbp (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Jun 2019 07:31:45 -0400
Received: from smtp-out-6.talktalk.net ([62.24.135.70]:6454 "EHLO
        smtp-out-6.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728940AbfFYLbp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jun 2019 07:31:45 -0400
Received: from [192.168.1.22] ([89.243.184.39])
        by smtp.talktalk.net with SMTP
        id fjfphLYYkgI7ifjfphXltc; Tue, 25 Jun 2019 12:31:42 +0100
X-Originating-IP: [89.243.184.39]
X-Spam: 0
X-OAuthority: v=2.3 cv=KYisTjQD c=1 sm=1 tr=0 a=3GZFt4OQGy0NQQxJwP7nlQ==:117
 a=3GZFt4OQGy0NQQxJwP7nlQ==:17 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19
 a=IkcTkHD0fZMA:10 a=FM8yyPGvAAAA:8 a=H4HFkFZM3-vW7ffzldsA:9 a=QEXdDO2ut3YA:10
 a=-RjHeblGm-41HPTmQUZ_:22
Subject: Re: [PATCH] make slash-rules more readable
To:     "Dr. Adam Nielsen" <admin@in-ici.net>, git@vger.kernel.org
References: <20190604173446.2664-1-admin@in-ici.net>
 <bd722415-1547-8db5-f88a-c35c8b48d8be@in-ici.net>
From:   Philip Oakley <philipoakley@iee.org>
Message-ID: <13f99ce6-f856-6554-5c14-1b1838d697d0@iee.org>
Date:   Tue, 25 Jun 2019 12:31:41 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <bd722415-1547-8db5-f88a-c35c8b48d8be@in-ici.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-CMAE-Envelope: MS4wfA27WJxdcDmql8035gBLIKhG1egq2rCwHxPt8amYK04DbkMrpan/b3CzBTnNvsl4m1S9jcc1lmoa4A/a3foHQ8m4ZwdutM4Ltv4ptnDsN8GzKp3h1sXx
 fTku+H0cgESd3kHawBZOW7e52puOU84v3DIBZX36uV7hJB0muYdJGpmea13PyRy+qq8aQ3eyiAjVEPf1FQqqE8zSMWaUaRmXgmA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

only one minor point...

On 25/06/2019 12:05, Dr. Adam Nielsen wrote:
> Hi everyone,
>
> any comments about the patch note from 04.06 ?
>
> All the best,
> Adam
>
> On 04.06.19 19:34, Dr. Adam Nielsen wrote:
>> gitignore.txt: make slash-rules more readable
>>
>> Renew paragraphs relevant for pattern with slash.
>> Aim to make it more clear and to avoid possible
>> pitfalls for the reader. Add some examples.
>>
>> Signed-off-by: Dr. Adam Nielsen <admin@in-ici.net>
>>
>> ---
>>   Documentation/gitignore.txt | 66 ++++++++++++++++++++++++-------------
>>   1 file changed, 44 insertions(+), 22 deletions(-)
>>
>> diff --git a/Documentation/gitignore.txt b/Documentation/gitignore.txt
>> index b5bc9dbff0..d47b1ae296 100644
>> --- a/Documentation/gitignore.txt
>> +++ b/Documentation/gitignore.txt
>> @@ -89,28 +89,28 @@ PATTERN FORMAT
>>      Put a backslash ("`\`") in front of the first "`!`" for patterns
>>      that begin with a literal "`!`", for example, "`\!important!.txt`".
>>   - - If the pattern ends with a slash, it is removed for the
>> -   purpose of the following description, but it would only find
>> -   a match with a directory.  In other words, `foo/` will match a
>> -   directory `foo` and paths underneath it, but will not match a
>> -   regular file or a symbolic link `foo` (this is consistent
>> -   with the way how pathspec works in general in Git).
>> -
>> - - If the pattern does not contain a slash '/', Git treats it as
>> -   a shell glob pattern and checks for a match against the
>> -   pathname relative to the location of the `.gitignore` file
>> -   (relative to the toplevel of the work tree if not from a
>> -   `.gitignore` file).
>> -
>> - - Otherwise, Git treats the pattern as a shell glob: "`*`" matches
>> -   anything except "`/`", "`?`" matches any one character except "`/`"
>> -   and "`[]`" matches one character in a selected range. See
>> -   fnmatch(3) and the FNM_PATHNAME flag for a more detailed
>> -   description.
>> -
>> - - A leading slash matches the beginning of the pathname.
>> -   For example, "/{asterisk}.c" matches "cat-file.c" but not
>> -   "mozilla-sha1/sha1.c".
>> + - The slash '/' is used as the directory separator. Separators may
>> +   occur at the beginning, middle or end of the `.gitignore` search 
>> pattern.
>> +
>> + - If there is a separator at the beginning or middle (or both) of the
>> +   pattern, then the pattern is relative to the directory level of the
>> +   particular `.gitignore` file itself. Otherwise the pattern may also
>> +   match at any level below the `.gitignore` level.
>> +
>> + - If there is a separator at the end of the pattern then the pattern
>> +   will only match directories, otherwise the pattern can match both
>> +   files and directories.
>> +
>> + - For example, a pattern `doc/frotz/` matches `doc/frotz` directory,
>> +   but not `a/doc/frotz` directory; however `frotz/` matches `frotz`

her I misread this as:  "but not a `doc/frotz` directory;"
i.e. the leading 'a' is too easy to skim over as is part of the 
sentence's prose, so maybe change to a 'baz' lead directory (bar already 
having been used below).

>> +   and `a/frotz` that is a directory (all paths are relative from
>> +   the `.gitignore` file).
>> +
>> + - An asterisk "`*`" matches anything except a slash.
>> +   The character "`?`" matches any one character except "`/`".
>> +   The range notation, e.g. `[a-zA-Z]`, can be used to match
>> +   one of the characters in a range. See fnmatch(3) and the
>> +   FNM_PATHNAME flag for a more detailed description.
>>     Two consecutive asterisks ("`**`") in patterns matched against
>>   full pathname may have special meaning:
>> @@ -152,6 +152,28 @@ To stop tracking a file that is currently 
>> tracked, use
>>   EXAMPLES
>>   --------
>>   + - The pattern `hello.*` matches any file or folder
>> +   whose name begins with `hello`. If one wants to restrict
>> +   this only to the directory and not in its subdirectories,
>> +   one can prepend the pattern with a slash, i.e. `/hello.*`;
>> +   the pattern now matches `hello.txt`, `hello.c` but not
>> +   `a/hello.java`.
>> +
>> + - The pattern `foo/` will match a directory `foo` and
>> +   paths underneath it, but will not match a regular file
>> +   or a symbolic link `foo` (this is consistent with the
>> +   way how pathspec works in general in Git)
>> +
>> + - The pattern `doc/frotz` and `/doc/frotz` have the same effect
>> +   in any `.gitignore` file. In other words, a leading slash
>> +   is not relevant  if there is already a middle slash in
>> +   the pattern.
>> +
>> + - The pattern "foo/*", matches "foo/test.json"
>> +   (a regular file), "foo/bar" (a directory), but it does not match
>> +   "foo/bar/hello.c" (a regular file), as the asterisk in the
>> +   pattern does not match "bar/hello.c" which has a slash in it.
>> +
>>   --------------------------------------------------------------
>>       $ git status
>>       [...]
>>
>
Have you tried it out on any StackOverflow replies to see if those that 
inhabit that zone find it helpful?
Philip
