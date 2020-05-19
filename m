Return-Path: <SRS0=xHKm=7B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECF37C433E0
	for <git@archiver.kernel.org>; Tue, 19 May 2020 04:53:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8188206D4
	for <git@archiver.kernel.org>; Tue, 19 May 2020 04:53:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="C9nB7+fC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbgESExM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 May 2020 00:53:12 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64204 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbgESExL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 May 2020 00:53:11 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2BA1E67225;
        Tue, 19 May 2020 00:53:04 -0400 (EDT)
        (envelope-from tmz@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:message-id:references:mime-version:content-type
        :in-reply-to; s=sasl; bh=QTXGFz9WQH9/Qbbx5M0kwO0Oyrc=; b=C9nB7+f
        CrEVHTJ0Jfm4n3QSu0VWAP8V+yJ639797hTLfhZvjL2SHiQBFivDGjkoUpfNp0kK
        1dvZtFlYsMyNvQDF6N3k9R+d/QU/cXOO71Ev4f0/BRvTINowd1CHCv7rOmryy9vR
        d7UWOD1XO8+iHDLqRFitSGwARXFjdcDAraGk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=date:from:to:cc
        :subject:message-id:references:mime-version:content-type
        :in-reply-to; q=dns; s=sasl; b=UpgMNcBU9yplmTi1xI5hjrqF9yDQmkC+m
        YlgyRygU9M+xEOczIjJdppT5CIXZz47BlSgyOMkHORhvJmlKT6WeJjlX1L2YRlu+
        dzHzx8Vb/3OSyFEWpzqCSdaUCL0sEFQP/v+zvTZI/FdwoSxgnq7lWTPlWhhlgMtu
        Yi+Dp9CIOs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A8A2167224;
        Tue, 19 May 2020 00:53:03 -0400 (EDT)
        (envelope-from tmz@pobox.com)
Received: from pobox.com (unknown [71.254.198.10])
        (using TLSv1.2 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D787367222;
        Tue, 19 May 2020 00:53:02 -0400 (EDT)
        (envelope-from tmz@pobox.com)
Date:   Tue, 19 May 2020 00:53:01 -0400
From:   Todd Zullinger <tmz@pobox.com>
To:     Son Luong Ngoc <sluongng@gmail.com>
Cc:     shouryashukla.oo@gmail.com, git@vger.kernel.org, gitster@pobox.com,
        newren@gmail.com, sandals@crustytoothpaste.net
Subject: Re: [PATCH v7 1/4] gitfaq: files in .gitignore are tracked
Message-ID: <20200519045301.GY24220@pobox.com>
References: <CAL3xRKdwOASiGys+7Uu_OA5kBPrTdAURfEw3UQ+rguTXT+C6JQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL3xRKdwOASiGys+7Uu_OA5kBPrTdAURfEw3UQ+rguTXT+C6JQ@mail.gmail.com>
X-Pobox-Relay-ID: 9EF5BE68-998C-11EA-A545-D1361DBA3BAF-09356542!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Son Luong Ngoc wrote:
> Hey folks,
> 
>> Add issue in 'Common Issues' section which addresses the problem of
>> Git tracking files/paths mentioned in '.gitignore'.
>>
>> Signed-off-by: Shourya Shukla <shouryashukla.oo@gmail.com>
>> ---
>>  Documentation/gitfaq.txt | 10 ++++++++++
>>  1 file changed, 10 insertions(+)
>>
>> diff --git a/Documentation/gitfaq.txt b/Documentation/gitfaq.txt
>> index 1cf83df118..11d9bac859 100644
>> --- a/Documentation/gitfaq.txt
>> +++ b/Documentation/gitfaq.txt
>> @@ -223,6 +223,16 @@ a file checked into the repository which is a template or set of defaults which
>>  can then be copied alongside and modified as appropriate.  This second, modified
>>  file is usually ignored to prevent accidentally committing it.
>>
>> +[[files-in-.gitignore-are-tracked]]
> 
> This does not work for older xmlto(centos6) for whatever reason.
> ```
> # make doc
> ...
> # xmlto -m manpage-normal.xsl  -m manpage-bold-literal.xsl -m
> manpage-base-url.xsl man gitfaq.xml
> xmlto: /<git-dir>/Documentation/gitfaq.xml does not validate (status 3)
> xmlto: Fix document syntax or use --skip-validation option
> /<git-dir>/Documentation/gitfaq.xml:3: element refentry: validity
> error : Element refentry content does not follow the DTD, expecting
> (beginpage? , indexterm* , refentryinfo? , refmeta? , (remark | link |
> olink | ulink)* , refnamediv+ , refsynopsisdiv? , (refsect1+ |
> refsection+)), got (refmeta refnamediv refsynopsisdiv refsect1
> refsect1 refsect1 refsect1 variablelist refsect1 refsect1 )
> ```

I ran into this as well.  I _think_ this is an asciidoc
issue (but it could be further up the doc tools chain).  On
CentOS 6, the asciidoc version is 8.4.5.  From earlier in
the make output:

    make[1]: Leaving directory `/builddir/build/BUILD/git-2.27.0.rc0'
    rm -f gitfaq.html+ gitfaq.html && \
	    asciidoc  -f asciidoc.conf -amanversion=2.27.0.rc0 -amanmanual='Git Manual' -amansource='Git' -b xhtml11 -d manpage -o gitfaq.html+ gitfaq.txt && \
	    mv gitfaq.html+ gitfaq.html
    WARNING: gitfaq.txt: line 245: missing [[files-in-.gitignore-are-tracked]] section

Dropping the "." from the anchor name works around the
failure, which seems like a reasonable thing to do.  With
the age of asciidoc and CentOS 6 approaching end-of-life
this November, we wouldn't want to spend too much effort to
work around issues there.  But this seems like an easy way
to allow the documentation to continue to build on such old
platforms.

There do appear to be other issues with the asciidoc's
parsing of the anchors, as some of the others are either not
included in the xml and html or are not quite in the place
they should be.  I didn't see an obvious reason for that,
but I didn't spend all that long looking over gitfaq.txt
because I imagine there are plenty of minor issues with
asciidoc-8.4.5.

I thought this change in asciidoc might have fixed the
issue:

    https://github.com/asciidoc/asciidoc/commit/4ceeb32

But I didn't have any luck after applying that to
asciidoc-8.4.5.

Anyway, here's the quick work-around in patch form.

-- >8 --
Subject: [PATCH] gitfaq: avoid validation error with older asciidoc

When building with asciidoc-8.4.5 (as found on CentOS/Red Hat 6), the
period in the "[[files-in-.gitignore-are-tracked]]" anchor is not
properly parsed as a section:

  WARNING: gitfaq.txt: line 245: missing [[files-in-.gitignore-are-tracked]] section

The resulting XML file fails to validate with xmlto:

    xmlto: /git/Documentation/gitfaq.xml does not validate (status 3)
    xmlto: Fix document syntax or use --skip-validation option
     /git/Documentation/gitfaq.xml:3: element refentry: validity error :
     Element refentry content does not follow the DTD, expecting
     (beginpage? , indexterm* , refentryinfo? , refmeta? , (remark | link
     | olink | ulink)* , refnamediv+ , refsynopsisdiv? , (refsect1+ |
     refsection+)), got (refmeta refnamediv refsynopsisdiv refsect1
     refsect1 refsect1 refsect1 variablelist refsect1 refsect1 )
    Document /git/Documentation/gitfaq.xml does not validate

Let's avoid breaking users of platforms which ship an old version of
asciidoc, since the cost to do so is quite low.

Reported-by: Son Luong Ngoc <sluongng@gmail.com>
Signed-off-by: Todd Zullinger <tmz@pobox.com>
---
 Documentation/gitfaq.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/gitfaq.txt b/Documentation/gitfaq.txt
index 370d62dae4..9cd7a592ac 100644
--- a/Documentation/gitfaq.txt
+++ b/Documentation/gitfaq.txt
@@ -223,7 +223,7 @@ a file checked into the repository which is a template or set of defaults which
 can then be copied alongside and modified as appropriate.  This second, modified
 file is usually ignored to prevent accidentally committing it.
 
-[[files-in-.gitignore-are-tracked]]
+[[files-in-gitignore-are-tracked]]
 I asked Git to ignore various files, yet they are still tracked::
 	A `gitignore` file ensures that certain file(s) which are not
 	tracked by Git remain untracked.  However, sometimes particular
-- 
2.26.1

-- >8 --

-- 
Todd
