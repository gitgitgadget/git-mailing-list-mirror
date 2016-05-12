From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: [PATCH] Documentation: clarify signature verification v2
Date: Thu, 12 May 2016 13:34:36 +0530
Message-ID: <CAFZEwPOJg=njvhtK7ZQf_-3DUVjMpFBEV_0m1NHAE1UL7eM5ng@mail.gmail.com>
References: <20160512065022.GA32387@hashbang.sh>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	"Michael J. Gruber" <git@drmicha.warpmail.net>,
	"Brian M. Carlson" <sandals@crustytoothpaste.ath.cx>,
	Junio C Hamano <gitster@pobox.com>
To: Fox in the shell <KellerFuchs@hashbang.sh>
X-From: git-owner@vger.kernel.org Thu May 12 10:04:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0lbx-0007GB-3J
	for gcvg-git-2@plane.gmane.org; Thu, 12 May 2016 10:04:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752045AbcELIEk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 May 2016 04:04:40 -0400
Received: from mail-yw0-f171.google.com ([209.85.161.171]:33914 "EHLO
	mail-yw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751614AbcELIEh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2016 04:04:37 -0400
Received: by mail-yw0-f171.google.com with SMTP id j74so65956247ywg.1
        for <git@vger.kernel.org>; Thu, 12 May 2016 01:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=fDrjVhvASoXS8ASOTRM8CPXVnd1luLnYechjvvaS4OQ=;
        b=Pw+gnBdztoOgawsvHRpjetIGW7norPrCrNx354v+zuwQGKY4FbohF7Pu1Nz5sSoMcL
         Ut162UegZpUKLdojuco22E8O5ZJT2DKAAUlcoOvJjJKoy/q4cgihSjg67i/kOcb9kzjl
         L+sTLPegcaBxU2gjpuivhsAXlMTWluWJY3BzrN9D0SrifOmu9RMROdPztvZ8U/6pWOXv
         SGxTeqhxz76jSu9TnPcBXCKUjJOaKB6oH6oB/G7wut3qUFAqrpxmdm5jAD82RR9Cwqta
         MehUJd12Nb1XMJJad6+X5f6WHwKDsjDQtrOkdNwflk1Y79w4ZYCYf2Kn5IE7RugyCI1+
         /L7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=fDrjVhvASoXS8ASOTRM8CPXVnd1luLnYechjvvaS4OQ=;
        b=iUrC/EYw4TllchzLubR2GkYKbB1D+KRWa1sPlmTmWo7TG1IIwlA6GT3CmjFODvTewb
         IBScsBXWa8AkLSX6ajuV6wijJnM9U20Esj2a2wtFWD/ENwTrQjogmv3AbdvLM67w3Ejo
         PfLiGhWPJLDJBkgS5Jva0dsJFiR9a+Aymap84i/f4D+y3lTer13SASXj14IKq8iPqZp1
         hDO/Qpoij1AsQ03Uy7gILX8Lelf8ml22ugwWVuqhHn8Ucia7+Lh3M1i09dHd0QtfrrdE
         VzH2K/sZ/KxlIizHtGoC1vqiZCQX+dOVfFHjZNibGJWMCrzbWxJa9w4k7xsM1BHq3J+Q
         5QCA==
X-Gm-Message-State: AOPr4FWVfBHtHukwT+x7paOjO7F6bIAoC03vIkIef0E1pVU26bnAr2G2a6/sWg77OdzRCTatt0lMq5B0Nm23xg==
X-Received: by 10.37.56.71 with SMTP id f68mr3832964yba.21.1463040276407; Thu,
 12 May 2016 01:04:36 -0700 (PDT)
Received: by 10.13.219.213 with HTTP; Thu, 12 May 2016 01:04:36 -0700 (PDT)
In-Reply-To: <20160512065022.GA32387@hashbang.sh>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294401>

On Thu, May 12, 2016 at 12:20 PM, Fox in the shell
<KellerFuchs@hashbang.sh> wrote:
>
> Hi,
>
> Here is a second attempt at this patch.
> Sorry for the delay, life somewhat got in the way.
>

Its okay! We understand that things might take a little more time than expected!

> --
> Clarify which commits need to be signed.
>
> Uniformise the vocabulary used wrt. key/signature validity with OpenPGP:
> - a signature is valid if made by a key with a valid uid;
> - in the default trust-model, a uid is valid if signed by a trusted key;
> - a key is trusted if the (local) user set a trust level for it.
>
> Thanks to Junio C Hamano <gitster@pobox.com> for reviewing
>   the first attempt at this patch.
> ---

Its good to provide links to the previous version[1] of the patch.
Please go through the Documentation/SubmittingPatches once.
Seems like Junio was waiting for someone to point this out[2].

A couple of notes of how to submit the patches:
 * You have cc'ied the reviewers. Good!

 * Include the version no (v2) inside the [PATCH] like [PATCH v2]

 * The next version should be as a reply to the previous one.
    Hint: use --in-reply-to with git-send-email

 * git-am is used to pick up these patches and it gets the subject
   of the email and strips of [PATCH ...] and then uses the other stuff
   in the commit message headline.

 * The rest of the commit message are the words before ---.
    So currently git-am will pick up your paragraph as commit message:

          "Hi,

            Here is a second attempt at this patch.
            Sorry for the delay, life somewhat got in the way."

    which is quite undesirable as a commit message.

 * Comments are put after ---. So your paragraph
      "Clarify which commits need to be signed.

        Uniformise the vocabulary used wrt. key/signature validity with OpenPGP
         - a signature is valid if made by a key with a valid uid;
         - in the default trust-model, a uid is valid if signed by a
trusted key;
         - a key is trusted if the (local) user set a trust level for it.

           Thanks to Junio C Hamano <gitster@pobox.com> for reviewing
           the first attempt at this patch."

    is actually treated as a comment.

 * Also your signoff is missing.

 * If you want to credit someone then its better to use syntax like:
      "Helped-by: Junio C Hamano <gitster@pobox.com>"

 * It also seems like you probably wanted to add the
   "Reviewed-by:" tag. Please note only the reviewers can
   add that tag.

>  Documentation/merge-options.txt  | 7 +++++--
>  Documentation/pretty-formats.txt | 4 ++--
>  2 files changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/merge-options.txt b/Documentation/merge-options.txt
> index f08e9b8..30808a0 100644
> --- a/Documentation/merge-options.txt
> +++ b/Documentation/merge-options.txt
> @@ -89,8 +89,11 @@ option can be used to override --squash.
>
>  --verify-signatures::
>  --no-verify-signatures::
> -       Verify that the commits being merged have good and trusted GPG signatures
> -       and abort the merge in case they do not.
> +       Verify that the tip commit of the side branch being merged is
> +       signed with a valid key, i.e. a key that has a valid uid: in the
> +       default trust model, this means the signing key has been signed by
> +       a trusted key.  If the tip commit of the side branch is not signed
> +       with a valid key, the merge is aborted.
>
>  --summary::
>  --no-summary::
> diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
> index 671cebd..29b19b9 100644
> --- a/Documentation/pretty-formats.txt
> +++ b/Documentation/pretty-formats.txt
> @@ -143,8 +143,8 @@ ifndef::git-rev-list[]
>  - '%N': commit notes
>  endif::git-rev-list[]
>  - '%GG': raw verification message from GPG for a signed commit
> -- '%G?': show "G" for a Good signature, "B" for a Bad signature, "U" for a good,
> -  untrusted signature and "N" for no signature
> +- '%G?': show "G" for a good (valid) signature, "B" for a bad signature,
> +  "U" for a good signature with unknown validity and "N" for no signature
>  - '%GS': show the name of the signer for a signed commit
>  - '%GK': show the key used to sign a signed commit
>  - '%gD': reflog selector, e.g., `refs/stash@{1}`
> --
> 2.1.4

[1]: http://thread.gmane.org/gmane.comp.version-control.git/291123
[2]: http://article.gmane.org/gmane.comp.version-control.git/291185
