Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 614F71F597
	for <e@80x24.org>; Fri,  3 Aug 2018 07:20:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727661AbeHCJPl (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Aug 2018 05:15:41 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:39057 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727469AbeHCJPl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Aug 2018 05:15:41 -0400
Received: by mail-pl0-f65.google.com with SMTP id m1-v6so2184261plt.6
        for <git@vger.kernel.org>; Fri, 03 Aug 2018 00:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=TTDuKQTMLwAtryM6tleP9P+ytLGMcuLrT8G7SU2rOPY=;
        b=IICUeIG3sWH7L3g7B8+EDH3oFUVO+J69ap4dtl+WEgTfZ0xlVd6eJ2QXehjyKNbBQZ
         5T+uR482w6yezhEEV0TQ+sKdc/E6SV4WamK0rSt36nWCrnsbla3VAB1c2GPh7ZUjSEnL
         Uqx0zYI0BRdZGueOnnZ8pCwMsqb8RIqg6ttlg47g4rXUsQwDyiVDhC/jwodTlpY/q/zo
         eLDKITLXyK4LzQvlOGkaNffJh3DkampADGtUlUDw09BrI8A6E6UuFpXCevehHISQUtpk
         F50QelNTwqNqurVPfZRm0j8nBKrUAGsYHCXQ32oWALQcQXq7VNPRektva2kBeJEebMgA
         R7Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=TTDuKQTMLwAtryM6tleP9P+ytLGMcuLrT8G7SU2rOPY=;
        b=jHQ1f7oVyCCCcgC5p9uGwcbU6tMitb49WeUC4SYZbxAKMv8QZh4e30TWiw1Uh+GXWZ
         YMgEbobn4fTOBXKbgGcnOY6vorSe7JnHB1zfh107nCgscfq2xuKlilykudMTUXx9OMVw
         bVl+vQWl6Xsp0Ma6yyWQX0aQ7ctHi18efs4zC/sSNke9tL1tLuZtVuXvjDKBD9gGfu0L
         Qn6BYuG2FVTE2w+T1xgn4OwBBUOnAHTpflAyBSkUOeWtgZK+ZHFigL21yY4u41rRn2KH
         +BQd55tFbM1dGSOwvqyBSg/O1L4ThzLdF8jxqS3ctbD99V99n+dk2JM5th3sgQUjbpia
         D6Yw==
X-Gm-Message-State: AOUpUlGh9C7aHd/stvDxRjzqIQjuGxiBxFcOa6HcOlG4w5irkwwGafbF
        Cgr7vxWwpsBXuduKMxjsxZE=
X-Google-Smtp-Source: AAOMgpd/v3lyHNA/ySeMtukWlmu9EC9cF3WLndJ3AK8gfwaTQKChNbRpdnhsnOGfXreUln3YICCOMw==
X-Received: by 2002:a17:902:7c8e:: with SMTP id y14-v6mr2458042pll.265.1533280844556;
        Fri, 03 Aug 2018 00:20:44 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id j5-v6sm5609594pff.139.2018.08.03.00.20.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 03 Aug 2018 00:20:43 -0700 (PDT)
Date:   Fri, 3 Aug 2018 00:20:14 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Edward Thomson <ethomson@edwardthomson.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        demerphq <demerphq@gmail.com>, Adam Langley <agl@google.com>,
        keccak@noekeon.org
Subject: Re: [PATCH v2 2/2] doc hash-function-transition: pick SHA-256 as
 NewHash
Message-ID: <20180803072014.GA256410@aiede.svl.corp.google.com>
References: <xmqqin53t30d.fsf@gitster-ct.c.googlers.com>
 <20180726134111.17623-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180726134111.17623-1-avarab@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi again,

Sorry for the slow review.  I finally got a chance to look this over
again.

My main nits are about the commit message: I think it still focuses
too much on the process instead of the usual "knowing what I know now,
here's the clearest explanation for why we need this patch" approach.
I can send a patch illustrating what I mean tomorrow morning.

Ævar Arnfjörð Bjarmason wrote:

> From a security perspective, it seems that SHA-256, BLAKE2, SHA3-256,
> K12, and so on are all believed to have similar security properties.
> All are good options from a security point of view.
>
> SHA-256 has a number of advantages:
>
> * It has been around for a while, is widely used, and is supported by
>   just about every single crypto library (OpenSSL, mbedTLS, CryptoNG,
>   SecureTransport, etc).
>
> * When you compare against SHA1DC, most vectorized SHA-256
>   implementations are indeed faster, even without acceleration.
>
> * If we're doing signatures with OpenPGP (or even, I suppose, CMS),
>   we're going to be using SHA-2, so it doesn't make sense to have our
>   security depend on two separate algorithms when either one of them
>   alone could break the security when we could just depend on one.
>
> So SHA-256 it is.

The above is what I wrote, so of course I'd like it. ;-)

>                    See the "Hash algorithm analysis" thread as of
> [1]. Linus has come around to this choice and suggested Junio make the
> final pick, and he's endorsed SHA-256 [3].

The above paragraph has the same problem as before of (1) not being
self-contained and (2) focusing on the process that led to this patch
instead of the benefit of the patch itself.  I think we should omit it.

> This follow-up change changes occurrences of "NewHash" to
> "SHA-256" (or "sha256", depending on the context). The "Selection of a
> New Hash" section has also been changed to note that historically we
> used the the "NewHash" name while we didn't know what the new hash
> function would be.

nit: Commit messages are usually in the imperative tense.  This is in
the past tense, I think because it is a continuation of that
discussion about process.

For this part, I think we can let the patch speak for itself.

> This leaves no use of "NewHash" anywhere in git.git except in the
> aforementioned section (and as a variable name in t/t9700/test.pl, but
> that use from 2008 has nothing to do with this transition plan).

This part is helpful --- good.

> 1. https://public-inbox.org/git/20180720215220.GB18502@genre.crustytoothpaste.net/
> 2. https://public-inbox.org/git/CA+55aFwSe9BF8e0hLk9pp3FVD5LaVY5GRdsV3fbNtgzekJadyA@mail.gmail.com/
> 3. https://public-inbox.org/git/xmqqzhygwd5o.fsf@gitster-ct.c.googlers.com/

Footnotes to the historical part --- I'd recommend removing these.

> Helped-by: Jonathan Nieder <jrnieder@gmail.com>
> Helped-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>

Here I'd want to put a pile of acks, e.g.:

 Acked-by: Linus Torvalds <torvalds@linux-foundation.org>
 Acked-by: brian m. carlson <sandals@crustytoothpaste.net>
 Acked-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
 Acked-by: Dan Shumow <danshu@microsoft.com>
 Acked-by: Junio C Hamano <gitster@pobox.com>

[...]
> --- a/Documentation/technical/hash-function-transition.txt
> +++ b/Documentation/technical/hash-function-transition.txt
> @@ -59,14 +59,11 @@ that are believed to be cryptographically secure.
>  
>  Goals
>  -----
> -Where NewHash is a strong 256-bit hash function to replace SHA-1 (see
> -"Selection of a New Hash", below):
> -
> -1. The transition to NewHash can be done one local repository at a time.
> +1. The transition to SHA-256 can be done one local repository at a time.

Yay!

[...]
>  	[extensions]
> -		objectFormat = newhash
> +		objectFormat = sha256
>  		compatObjectFormat = sha1

Yes, makes sense.

[...]
> @@ -155,36 +152,36 @@ repository extensions.
>  Object names
>  ~~~~~~~~~~~~
>  Objects can be named by their 40 hexadecimal digit sha1-name or 64
> -hexadecimal digit newhash-name, plus names derived from those (see
> +hexadecimal digit sha256-name, plus names derived from those (see
>  gitrevisions(7)).
>  
>  The sha1-name of an object is the SHA-1 of the concatenation of its
>  type, length, a nul byte, and the object's sha1-content. This is the
>  traditional <sha1> used in Git to name objects.
>  
> -The newhash-name of an object is the NewHash of the concatenation of its
> -type, length, a nul byte, and the object's newhash-content.
> +The sha256-name of an object is the SHA-256 of the concatenation of its
> +type, length, a nul byte, and the object's sha256-content.

Sensible.

[...]
>  
>  Object format
>  ~~~~~~~~~~~~~
>  The content as a byte sequence of a tag, commit, or tree object named
> -by sha1 and newhash differ because an object named by newhash-name refers to
> +by sha1 and sha256 differ because an object named by sha256-name refers to

Not about this patch: this should say SHA-1 and SHA-256, I think.
Leaving it as is in this patch as you did is the right thing.

[...]
> @@ -255,10 +252,10 @@ network byte order):
>    up to and not including the table of CRC32 values.
>  - Zero or more NUL bytes.
>  - The trailer consists of the following:
> -  - A copy of the 20-byte NewHash checksum at the end of the
> +  - A copy of the 20-byte SHA-256 checksum at the end of the

Not about this patch: a SHA-256 is 32 bytes.  Leaving that for a
separate patch as you did is the right thing, though.

[...]
> -  - 20-byte NewHash checksum of all of the above.
> +  - 20-byte SHA-256 checksum of all of the above.

Likewise.

[...]
> @@ -351,12 +348,12 @@ the following steps:
>     (This list only contains objects reachable from the "wants". If the
>     pack from the server contained additional extraneous objects, then
>     they will be discarded.)
> -3. convert to newhash: open a new (newhash) packfile. Read the topologically
> +3. convert to sha256: open a new (sha256) packfile. Read the topologically

Not about this patch: this one's more murky, since it's talking about
the object names instead of the hash function.  I guess "sha256"
instead of "SHA-256" for this could be right, but I worry it's going
to take time for me to figure out the exact distinction.  That seems
like a reason to just call it SHA-256 (but in a separate patch).

[...]
> -   sha1-content, convert to newhash-content, and write it to the newhash
> -   pack. Record the new sha1<->newhash mapping entry for use in the idx.
> +   sha1-content, convert to sha256-content, and write it to the sha256
> +   pack. Record the new sha1<->sha256 mapping entry for use in the idx.
>  4. sort: reorder entries in the new pack to match the order of objects
> -   in the pack the server generated and include blobs. Write a newhash idx
> +   in the pack the server generated and include blobs. Write a sha256 idx
>     file

Likewise.

[...]
> @@ -388,16 +385,16 @@ send-pack.
>  
>  Signed Commits
>  ~~~~~~~~~~~~~~
> -We add a new field "gpgsig-newhash" to the commit object format to allow
> +We add a new field "gpgsig-sha256" to the commit object format to allow
>  signing commits without relying on SHA-1. It is similar to the
> -existing "gpgsig" field. Its signed payload is the newhash-content of the
> -commit object with any "gpgsig" and "gpgsig-newhash" fields removed.
> +existing "gpgsig" field. Its signed payload is the sha256-content of the
> +commit object with any "gpgsig" and "gpgsig-sha256" fields removed.

That reminds me --- we need to add support for stripping these out.

[...]
> @@ -601,18 +598,22 @@ The user can also explicitly specify which format to use for a
>  particular revision specifier and for output, overriding the mode. For
>  example:
>  
> -git --output-format=sha1 log abac87a^{sha1}..f787cac^{newhash}
> +git --output-format=sha1 log abac87a^{sha1}..f787cac^{sha256}
>  
> -Selection of a New Hash
> ------------------------
> +Choice of Hash
> +--------------

Yay!

[...]
> -Some hashes under consideration are SHA-256, SHA-512/256, SHA-256x16,
> -K12, and BLAKE2bp-256.
> +We choose SHA-256. See the thread starting at
> +<20180609224913.GC38834@genre.crustytoothpaste.net> for the discussion
> +(https://public-inbox.org/git/20180609224913.GC38834@genre.crustytoothpaste.net/)

Can this reference be moved to a footnote?  It's not part of the
design, but it's a good reference.

Thanks again for getting this documented.

Sincerely,
Jonathan
