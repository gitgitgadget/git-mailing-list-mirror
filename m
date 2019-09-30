Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 698F61F463
	for <e@80x24.org>; Mon, 30 Sep 2019 15:37:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731919AbfI3Php (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Sep 2019 11:37:45 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:43032 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731802AbfI3Php (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Sep 2019 11:37:45 -0400
Received: by mail-qt1-f196.google.com with SMTP id c3so17561163qtv.10
        for <git@vger.kernel.org>; Mon, 30 Sep 2019 08:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yw3jrPfKb90rVZXeb/iDTfR/px3KYH1vzuOgp/fHY/o=;
        b=OWbGJEXt9YLQsEwqc9oyfqrbgclWz4sMsMXawSU29OG0dj2Co4Jyv5bO4H5heNUXZH
         FDEvvzcRym5Qx8X03qrdVr8DBVNP7hsEU6r4tQat8QoJ3Nfv4wJoKcTj6mVVLC3mBNqD
         XRLbiN+5wlPB22oBCQkirUhKkFQlI2WSHL3B0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=yw3jrPfKb90rVZXeb/iDTfR/px3KYH1vzuOgp/fHY/o=;
        b=Mi5UogEx2vERx+w+6XZ2Uy8UxWnfZOsh0EISERUoyiShjfgYQqs0vLfUg7wiq0SqhV
         TE/IAvUWBFZ8z7c3ohtWDBHzhHSA0+YAFjCtAULxdEzHo6yLHGdqmgEhi71OMMgmecY6
         cvrBkuyFPmpdOuf+BYGj+Vawh5YYOjt955lcuUreUJKiWuqRuwQBL5/ahd1bU0Zk0esq
         +ZLh0MDLcPUpJYtBtJ3vEIxhQ7369EczMAGeGxBBfZGb2/oz52nUt5dGZxhmVVtM/vZB
         JtsL/e12R3LeeNkXQrdhUK//Xn2Cnfph8BIm4e21423E0lzIMoS5BrlJzb1lT+zBYeNH
         5aoA==
X-Gm-Message-State: APjAAAUcbts2Ps7N5mlrNEuNWOaq5GRiVVYFeK31fZ3UboX4QUTpPnzM
        ONEhlYV8CFTCPrHPj+/0pWuVZcAXrmk7bA==
X-Google-Smtp-Source: APXvYqxqeUGdbL0AbhJlD5bTl4l6CSbnnMWegcdfhw1IyjryWB07JmJuGYwmLtnvWdayjmCjC1tCpg==
X-Received: by 2002:ad4:5552:: with SMTP id v18mr20777562qvy.185.1569857863852;
        Mon, 30 Sep 2019 08:37:43 -0700 (PDT)
Received: from chatter.i7.local (192-0-228-88.cpe.teksavvy.com. [192.0.228.88])
        by smtp.gmail.com with ESMTPSA id q200sm5806815qke.114.2019.09.30.08.37.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2019 08:37:43 -0700 (PDT)
Date:   Mon, 30 Sep 2019 11:37:41 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     dwh@linuxprogrammer.org
Cc:     git@vger.kernel.org
Subject: Re: RFC: Cryptographic attestation for email-based patch workflows
Message-ID: <20190930153741.GA6124@chatter.i7.local>
Mail-Followup-To: dwh@linuxprogrammer.org, git@vger.kernel.org
References: <20190910121324.GA6867@pure.paranoia.local>
 <20190927152437.be6d7jnowuvvuyra@dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20190927152437.be6d7jnowuvvuyra@dev>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 27, 2019 at 08:24:37AM -0700, dwh@linuxprogrammer.org wrote:
>>- generate a signify-compatible cryptographic signature of the 
>>verbatim
>> patch content, perhaps slightly normalized for things like LF vs. CRLF
>> line endings (see minisign/libsodium for crypto details)
>>- include both the signature and the public key in the area below '---',
>> using "Minisig:" and "Minikey:" taglines
>
>I like where you're heading with this suggestion however there are some
>issues. It is not clear what bytes the signature was calculated over.

Just the actual patch.

>Does it include the "From:" line of the email? How about the
>"Signed-off-by"? If there is no binding of the identity of the submitter
>to the key pair then you'll have problems with the TOFU policy you
>describe further down (explained later). 

Ok, I'll argue my point on this later. :)

>Also, since we're trying to
>move to a Git that supports signatures from multiple different signing
>tools and to also support multi-sig sign-offs (e.g. first the author,
>then the reviewer, then the merger) these taglines need to be more
>compex. At the very least either there needs to be a signature type
>tagline or the type of the signature needs to be baked into the key and
>signture values (see Secure Scuttlebutt encoding of keys/sigs). Also, if
>we want to do chained multisign there should be some framing of what is
>signed by each signature. If you're looking for something email like, we
>could borrow from mime email attachment encoding to provide framing.

No, we definitely don't want to go down the MIME path (it's routinely 
mangled by archivers, so we're much more likely to lose anything that 
comes in via MIME attachments).

>I would instead have at the very least the signature tool in the value:
>
>	Key: minisign|RWT9fcUvSnHPLqqyfLbkGBMEscBWciFFp2iBj2XnZPzW69OVIoYwZ25q
> Sig: minisign|RWT9fcUvSnHPLiqWgXEnn98sgk8nl4FteDRkD+9lVK+He//eLOxNZ5QjCROoKJgPGpL4uzoHicN+f6gB54qmtO1cQtfvjS+++QU=

I don't think it's worth it to abstract this out. The main benefits of
minisigs are:

- it's an emerging standard (www.kernel.org should soon offer minisig 
  signatures on tarball downloads)
- it's short enough to include both the key and the signature into a few 
  bytes of information -- attempting to do the same with PGP would 
  balloon the message into kilobytes, even if ECC keys/subkeys are used

>But this doesn't solve multi-sig.

It doesn't attempt to, but it can be achieved in a number of clever 
ways. For example, the reviewer can sign the minisig signature on the 
original patch. E.g.:

Reviewed-by: Alter Ego <mricon@kernel.org>
Reviewed-minisig: {minisig signature of RWT9fcUvS...fvjS+++QU=}
Reviewed-minikey: {reviewer pubkey}

This would give you a chain of attestation to the original patch.

For series, this would be more complicated, since Reviewed-by: is 
usually posted for the cover letter. Perhaps series cover letters could 
include a signature of all individual patch signatures.

That said, this is not something I'm trying to solve -- my goal is to 
provide tamper-evident attestation of patches sent to mailing lists, and 
I expound on that further down.

>TOFU has the problem of not providing cryptographic provenance over 
>keys
>while maintaining provenance on the binding between other identity
>attributes and those keys (e.g. author string). In step 3 above there's
>no way to know for sure that the submitter is actually who they claim to
>be. 

Correct, but the same is true for any other key distribution mechanism.  
Even with PGP, most people I work with use the TOFU approach -- if a key 
is in their keyring, it's considered automatically trusted. My goal is 
not really to come up with a tamper-proof solution, but to offer a chain 
of cryptographic attestation. Developers can then *choose* to 
incorporate tamper-proof features of it into their workflows via tool 
support.

>Reviewers have no way of knowing that the new key used with the
>patch is a legitimate key update. The only option with this design is to
>do some out-of-band key verification (i.e. call the submitter and have
>them read the key to you over the phone). Out-of-band key validation
>hasn't scaled for GPG and it won't scale here either.

Yes, because delegated trust is *hard*. :) We either must rely on 
delegated trust via certification authorities -- with all the potential 
for abuse there -- or we must make trust decisions on our own, which 
doesn't scale well. As far as I can tell, there is no easy solution to 
this problem. TOFU just formalizes everyone's current coping mechanism.

>Instead of TOFU, a more secure design would require key enrollment, key
>rotation, key recovery, and key revocation to all be separate,
>cryptographically verified updates to the attribute-to-key database in
>the repo. 

Right, as long as it's understood that this delegates trust to people 
with write access to this repository (and infrastructure admins). This 
also has important drawbacks in the case of the Linux kernel, for 
example:

- there are thousands of people committing patches to the Linux kernel, 
  and it's not the same thousands of people with each mainline release, 
  so keeping key information for all of them in the repository would be 
  next to impossible
- while torvalds/linux.git is considered "canonical" for Linux, most 
  developers would be working off of other trees (netdev, arm, etc), so 
  it would make little sense for them to put their key information into 
  the mainline repository

>Your instinct for storing the attribute+key data in the repo
>itself (i.e. in-band) is correct because it makes Git repos
>self-verifiable in that cloning is all you need to do to get all of the
>data necessary for verifying all of the digital signatures.

Right, this is an important problem to solve, but it's not the one I'm 
trying to address. :) I'm specifically interested in cryptographic 
attestation of patches sent to mailing lists -- *before* code even makes 
it into git. Since there is no way to translate signatures on patches 
into git commit signatures, I'm not even attempting to solve that 
problem.

>Key enrollment should be a separate patch submission that adds the
>author and public key to the database file. The patch must be signed
>using the key that is being added to the database. This provides the
>provenance anchor for the key and also binds the attribute to the key.

I like it, but this won't scale for Linux kernel due to the reasons I've 
described above -- thousands of developers who come and go, plus 
multiple "canonical" linux.git trees, depending on the component you're 
working on.

>So back to the original proposal, I like the simplicity but with a few
>tweaks, it could be an air tight digital signature scheme for emailed
>patches. If air tight provenance is not what you're aiming for, then why
>are you even using cryptography?

My primary goal is to remove one of the last bits where we explicitly 
trust infrastructure in the Linux Kernel development -- vger.kernel.org 
and lore.kernel.org. If either of these systems are compromised, an 
attacker would be able to modify patches on the fly in order to insert 
malicious code without leaving a trace (e.g. intercept a patch as it is 
sent to the actual maintainer, but not when sent to others or to the 
archiver). Adding basic cryptographic signatures to the process will 
hopefully make this attack vector less likely and will at least offer a 
mechanism to perform post-mortem forensic examinations -- without 
introducing a central certification authority.

-K
