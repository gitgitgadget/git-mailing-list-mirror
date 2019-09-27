Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 843081F466
	for <e@80x24.org>; Fri, 27 Sep 2019 15:24:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727334AbfI0PYl (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Sep 2019 11:24:41 -0400
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:48621 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727076AbfI0PYl (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 27 Sep 2019 11:24:41 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 11CBB71E
        for <git@vger.kernel.org>; Fri, 27 Sep 2019 11:24:40 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Fri, 27 Sep 2019 11:24:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        linuxprogrammer.org; h=date:from:to:subject:message-id
        :references:mime-version:content-type:content-transfer-encoding
        :in-reply-to; s=fm1; bh=enDL++w7VzsZMtEWVX+tfm6thu841KKm+I4fh6om
        bLI=; b=OBOtVl39i+66UDtLsaf34Hk2fQseyJ1OgewG8s7+chrS0e4OmCFkR1EN
        tSRWMuQjEjQXM2UmDeCGeUx8DVJgJkzLu1f1L25s/xKnmqNUAvRaRNKkOb09vcdu
        kp8y0VyrNaWEVIp9S4UaAh1zgolCDCzR9pybpDeAoWw7vyjPO8Z/WKv/vqzh0wAN
        3kDJVo2xBdndtSE2NQ8CwPvYr8ARzGAbLhWbRZTPjiKM7YjRf2Xc2CT7BtpldRmm
        DGYwDIKdsuB24SgDzg1llGVq61TJ8GtMRwMyp8hrUDOYFxWP9Koc7uwC3Yq9hCey
        K9QQEfD1Acb5Bu3cgevCcqpeabc0pA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=enDL++w7VzsZMtEWVX+tfm6thu841KKm+I4fh6omb
        LI=; b=kL/l8fp18vsCApCkPZAKYBCqI/d2xcK4vVPKohCk6wBDSw2oLgUpmkF5Q
        iNIZRZo37lwuF8xCbIGHBRDYqhNBgnxyXb+bspIV26n4vn5DUIoljTcND1nmgJDh
        ccnFa9YGbVCqsfpG0fky7rBKkJnURRyYG4oSrfYnvvW8svHrfbSjqO7Jw2ExiQtV
        NEXFeO72KKphP2MApKX+yBT10V6KHGVgpI3y9Nr3vFGAUK+ZazymcIDPy4BXw2ub
        QK4EGfltcsmGcZ1O5FcJVFt2apPFeKfUUtqrD6pl/7BqvVDmWtpevMF/8Cy6xR+N
        6/jGizSzBdWWPR2pMHJ8Avq3KdhNg==
X-ME-Sender: <xms:tymOXTxtauSMh4suPG5CH0_rmXq0kCl2o5HdJVQAXpPa3R3111mFZA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrfeeigdekiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtugfgjggfsehtke
    ertddtreejnecuhfhrohhmpegufihhsehlihhnuhigphhrohhgrhgrmhhmvghrrdhorhhg
    necukfhppeeikedrvddvgedrieekrdehnecurfgrrhgrmhepmhgrihhlfhhrohhmpegufi
    hhsehlihhnuhigphhrohhgrhgrmhhmvghrrdhorhhgnecuvehluhhsthgvrhfuihiivgep
    td
X-ME-Proxy: <xmx:tymOXSzCu1KZEJjV_RQYmelZo1p1UR_WL53Ls8H3cgqkbfONmpwT0g>
    <xmx:tymOXTZLmZxHl2rKNBRgem-A5pJgojxvDRxKi-QGIS7PrpRpHDtstA>
    <xmx:tymOXbmTUODMbbEoFtANNXv3yAp3rWmRYquN-EsFQFXGpRIe762TUA>
    <xmx:tymOXakr2q_HvA_Bg-EKUHz0vV-SVXT8Ez3cxyWUPYhTDoLZCuwjxw>
Received: from localhost (ip68-224-68-5.lv.lv.cox.net [68.224.68.5])
        by mail.messagingengine.com (Postfix) with ESMTPA id 3D583D60062
        for <git@vger.kernel.org>; Fri, 27 Sep 2019 11:24:39 -0400 (EDT)
Date:   Fri, 27 Sep 2019 08:24:37 -0700
From:   dwh@linuxprogrammer.org
To:     git@vger.kernel.org
Subject: Re: RFC: Cryptographic attestation for email-based patch workflows
Message-ID: <20190927152437.be6d7jnowuvvuyra@dev>
References: <20190910121324.GA6867@pure.paranoia.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190910121324.GA6867@pure.paranoia.local>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10.09.2019 08:13, Konstantin Ryabitsev wrote:
># Proposed approach
>
>I recommend that we provide a way to include cryptographic signature
>information natively using git-format-patch, using roughly the following
>process:
>
>- generate a signify-compatible cryptographic signature of the verbatim
>  patch content, perhaps slightly normalized for things like LF vs. CRLF
>  line endings (see minisign/libsodium for crypto details)
>- include both the signature and the public key in the area below '---',
>  using "Minisig:" and "Minikey:" taglines

I like where you're heading with this suggestion however there are some
issues. It is not clear what bytes the signature was calculated over.
Does it include the "From:" line of the email? How about the
"Signed-off-by"? If there is no binding of the identity of the submitter
to the key pair then you'll have problems with the TOFU policy you
describe further down (explained later). Also, since we're trying to
move to a Git that supports signatures from multiple different signing
tools and to also support multi-sig sign-offs (e.g. first the author,
then the reviewer, then the merger) these taglines need to be more
compex. At the very least either there needs to be a signature type
tagline or the type of the signature needs to be baked into the key and
signture values (see Secure Scuttlebutt encoding of keys/sigs). Also, if
we want to do chained multisign there should be some framing of what is
signed by each signature. If you're looking for something email like, we
could borrow from mime email attachment encoding to provide framing.

>For example:
>
>---8<---
>From b41a2a0f817caddc9a76f43c3c9ed7d8edd6b2de Mon Sep 17 00:00:00 2001
>From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
>Date: Tue, 10 Sep 2019 06:15:36 -0400
>Subject: [PATCH] Second commit
>
>Change the greeting.
>
>Signed-off-by: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
>---
> foo.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
> Minisig: RWT9fcUvSnHPLiqWgXEnn98sgk8nl4FteDRkD+9lVK+He//eLOxNZ5QjCROoKJgPGpL4uzoHicN+f6gB54qmtO1cQtfvjS+++QU=
> Minikey: RWT9fcUvSnHPLqqyfLbkGBMEscBWciFFp2iBj2XnZPzW69OVIoYwZ25q
>
>diff --git a/foo.c b/foo.c
>index d40a2b9..dcfad55 100644
>--- a/foo.c
>+++ b/foo.c
>@@ -1,5 +1,5 @@
> #include <stdio.h>
> int main()
> {
>-    printf("Hello, World!");
>+    printf("Hello, Signed World!");
> }
>--ᐞ
>2.21.0
>---8<---

I would instead have at the very least the signature tool in the value:

	Key: minisign|RWT9fcUvSnHPLqqyfLbkGBMEscBWciFFp2iBj2XnZPzW69OVIoYwZ25q
  Sig: minisign|RWT9fcUvSnHPLiqWgXEnn98sgk8nl4FteDRkD+9lVK+He//eLOxNZ5QjCROoKJgPGpL4uzoHicN+f6gB54qmtO1cQtfvjS+++QU=

But this doesn't solve multi-sig. 

>When git-am encounters a signed patch, it should:
>
>1. check if the email in From: matches existing entries in git's TOFU
>   (trust on first use) database, which is a simple key-value store
>   like:
>
>   konstantin@linuxfoundation.org: RWT9fcUvSnHPLqqyfLbkGBMEscBWciFFp2iBj2XnZPzW69OVIoYwZ25q
>
>2. if no matches, add a new entry to the TOFU tracking database and
>   consider the key automatically trusted (perhaps configurable)
>3. if there are existing matches:
>
>   a. compare the keys to make sure they haven't changed
>   b. if keys changed, emit a warning and let developer decide if they
>      trust the key change
>   c. if keys did not change, validate the signature
>   d. if validation failed, alert the developer and error out
>
>4. if the TOFU db exists at all, git-am should check if the email
>   address in From: matches any existing records and alert if the patch
>   carries no signature (in case it's been removed by a malicious
>   attacker).
>
>All of these operations should be sufficiently fast, since both ECC
>crypto and key-value lookups are fast operations that don't require a
>lot of resources.

TOFU has the problem of not providing cryptographic provenance over keys
while maintaining provenance on the binding between other identity
attributes and those keys (e.g. author string). In step 3 above there's
no way to know for sure that the submitter is actually who they claim to
be. Reviewers have no way of knowing that the new key used with the
patch is a legitimate key update. The only option with this design is to
do some out-of-band key verification (i.e. call the submitter and have
them read the key to you over the phone). Out-of-band key validation
hasn't scaled for GPG and it won't scale here either.

Instead of TOFU, a more secure design would require key enrollment, key
rotation, key recovery, and key revocation to all be separate,
cryptographically verified updates to the attribute-to-key database in
the repo. Your instinct for storing the attribute+key data in the repo
itself (i.e. in-band) is correct because it makes Git repos
self-verifiable in that cloning is all you need to do to get all of the
data necessary for verifying all of the digital signatures.

Key enrollment should be a separate patch submission that adds the
author and public key to the database file. The patch must be signed
using the key that is being added to the database. This provides the
provenance anchor for the key and also binds the attribute to the key.
The record in the data should also contain some data that enables secure
key recovery/rotation. A simple hashed secret passphrase and nonce
works. In the future, key recovery/rotation can be done by the owner by
submitting a new patch that updates the database record with a new key
and recovery data, signed with the new key and also including the nonce
and secret passphrase used to generate the previous key recovery hash.
Key revocation is a patch that removes the record from the database that
is signed by the key that is being removed or a new key plus the
recovery secret passphrase and nonce.

So back to the original proposal, I like the simplicity but with a few
tweaks, it could be an air tight digital signature scheme for emailed
patches. If air tight provenance is not what you're aiming for, then why
are you even using cryptography?

That's my 2p on this. I like where you're head is at Kontantin.

Cheers!
Dave
