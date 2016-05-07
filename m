From: Mike Rappazzo <rappazzo@gmail.com>
Subject: Re: [PATCH v3 1/2] rev-parse tests: add tests executed from a subdirectory
Date: Sat, 7 May 2016 09:35:29 -0400
Message-ID: <CANoM8SVr1_G6KevbGSHifGyQS-ei57q+5D+GE_QmKvf_ysF2Sg@mail.gmail.com>
References: <1462541720-79553-1-git-send-email-rappazzo@gmail.com>
 <1462541720-79553-2-git-send-email-rappazzo@gmail.com> <xmqqy47m25z4.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 07 15:36:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1az2Oo-0001o2-0f
	for gcvg-git-2@plane.gmane.org; Sat, 07 May 2016 15:36:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752682AbcEGNfv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 7 May 2016 09:35:51 -0400
Received: from mail-ig0-f194.google.com ([209.85.213.194]:35712 "EHLO
	mail-ig0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752661AbcEGNft convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 7 May 2016 09:35:49 -0400
Received: by mail-ig0-f194.google.com with SMTP id jn6so7401911igb.2
        for <git@vger.kernel.org>; Sat, 07 May 2016 06:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=YWMJfywE8oHrnQSHu8377dAC62xpFkOoTb3uYiVfURE=;
        b=afekNF7sDkUJ7ozE+UYuydZng6o4TTioxXwjBiGrwJPKBQpBJppRSGeP2KHAhJGFNv
         HXigHtLsKDlYYUb/g2C+grC4yupXmWqCW8/uGr2j22z6lWyPICJeg6xHcWbu7/ONyjae
         fCi4KOGiZkobJVC2mQmI7D1ybzNNmWzeGL1SKNpAiQ3bf9jF0r6dt0d66Q/TrPcCDHHW
         WbEOcsozAslD7K9n3f4yB5FuPaa65hd4Rfn8yxzYSqriO/NMoPT48a51uQPqidWWebB6
         4f+TiZktOy/vqYfrmZAQ/2GvbbcK57swhY/N471Bm9YX/T/gIm0gV7QP9LL7Xtuwsl1K
         pMcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=YWMJfywE8oHrnQSHu8377dAC62xpFkOoTb3uYiVfURE=;
        b=YKonWAP+mSAick/eFZTKjXjFluDidu3rt0xsMKFLeX2rHI9VNkj7l36jbrGASvFM2q
         B2HnWE0aOIkN+vA/acT7qMQu2i87w1dBpBBM7+qFFblEgOgCK+Nx74J9rRdbt3ioXF+p
         +Ay5FWRqD86ni2dk+85TADitd1pl4Cc8JNWUv0FuZ7lS7+vvxjr8bxrWlkUiExOuHFvp
         oeH5BQJVDtZcKrQXtSR7bkhbP30PD3AGZIYXxUmhZB6LIY7pNs7YUehMJbb8tnf/1+Zx
         49iC7tXtZQxpXupWT0OuqrXNCVJOwRsHvO2RWEjK528EcoRduQ5kEnM1i6IAEy+dC48/
         vV/Q==
X-Gm-Message-State: AOPr4FUCCmDvkODKERqiMPHniBpQZsBAaaUqCq3WRqc8JcHFp+RefEp+OmYZoDEyTDjiQfN5IyY1oyHFCatx6A==
X-Received: by 10.50.160.129 with SMTP id xk1mr2281598igb.55.1462628148648;
 Sat, 07 May 2016 06:35:48 -0700 (PDT)
Received: by 10.107.7.220 with HTTP; Sat, 7 May 2016 06:35:29 -0700 (PDT)
In-Reply-To: <xmqqy47m25z4.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293896>

On Fri, May 6, 2016 at 6:10 PM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> Michael Rappazzo <rappazzo@gmail.com> writes:
>
>> t1500-rev-parse contains envrionment leaks (changing dir without
>> changing back, setting config variables, etc).  Add a test to clean =
this
>> up up so that future tests can be added without worry of any setting
>> from a previous test.
>
> This is a wonderful thing to do, but...
>
>>  test_rev_parse toplevel false false true '' .git
>>
>> @@ -84,4 +85,41 @@ test_rev_parse 'GIT_DIR=3D../repo.git, core.bare =
=3D true' true false false ''
>>  git config --unset core.bare
>>  test_rev_parse 'GIT_DIR=3D../repo.git, core.bare undefined' false f=
alse true ''
>>
>> +test_expect_success 'cleanup from the previous tests' '
>> +     cd .. &&
>> +     rm -r work &&
>
> Instead of cleaning things up like this, could you please please
> please fix these existing tests that chdir around without being in a
> subshell?  If the "previous tests" failed before going down as this
> step expects, the "cd .. && rm -r" can make things worse.

I still have fixing this test up on my do-to list.  My previous
attempt[1] had some flaws
in addition to some objection to the approach I took to expand each tes=
t. Eric
Sunshine suggested using a table approach, but I am not sure if that ca=
n be done
cleanly.

I figured that a fix to the rev-parse code would supersede test
cleanup, so I separated
my efforts.

I originally copied the pattern from above this code:

> +#cleanup from the above
> +cd ..
> +rm -r work
> +mv repo.git .git || exit 1

but G=C3=A1bor had an objection to it [2].  So I went with this simple =
cleanup test.

I could move it back to outside of a test, and do some checks around
it.  Something
like:

    dir=3D$(pwd)
    target=3D${dir##*/}
    if [ "$target" =3D=3D "work" ]
    then
        cd ..
        rm -r "work"
    fi

>
>> +     mv repo.git .git &&
>> +     unset GIT_DIR &&
>> +     unset GIT_CONFIG &&
>
> The spirit of this change is to make the test more independent from
> the effects of what happened previously.  Use sane_unset so that
> we do not have to worry about previous step that may have failed
> before it has a chance to set GIT_DIR and GIT_CONFIG (which would
> cause these unset to fail).
>
>> +     git config core.bare $original_core_bare
>
> Is this (rather, the capturing of $original_core_bare up above)
> necessary?  We are in the default 'trash' repository when the
> capturing happens, and we know it is not a bare repository, right?

My goal was to have the test be in the state exactly as it was at the
beginning of
the test.  Right above my cleanup test this line is executed:

> git config --unset core.bare

I just wanted to be absolutely sure that the value was the same.  I
could certainly
simplify it to assume core.bare is "true" though.

Thanks,
_Mike


[1] http://thread.gmane.org/gmane.comp.version-control.git/291729
[2] http://article.gmane.org/gmane.comp.version-control.git/293003
