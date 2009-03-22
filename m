From: Pat Notz <patnotz@gmail.com>
Subject: Re: [PATCH] githooks documentation: post-checkout hook is also called 
	after clone
Date: Sun, 22 Mar 2009 10:56:04 -0600
Message-ID: <1cd1989b0903220956w47ca2521s8945a4c71225909c@mail.gmail.com>
References: <49C66B03.6020908@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com, peff@peff.net
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Sun Mar 22 17:57:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LlQzV-0004zm-Nn
	for gcvg-git-2@gmane.org; Sun, 22 Mar 2009 17:57:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752958AbZCVQ4M convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 22 Mar 2009 12:56:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752844AbZCVQ4J
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Mar 2009 12:56:09 -0400
Received: from an-out-0708.google.com ([209.85.132.241]:47477 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751388AbZCVQ4I convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 22 Mar 2009 12:56:08 -0400
Received: by an-out-0708.google.com with SMTP id d14so1352298and.1
        for <git@vger.kernel.org>; Sun, 22 Mar 2009 09:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=MmSXbCKX8R4roLaTeS3OuF1NQGi08gKbQVLTXoXK2Qg=;
        b=rSKJ/TZuqEFGCQ8B1IFh29AOQZgJ//IDZgATPBhmLIPg7tHSFR5gK7//O1mnboLbHF
         DDBRmHoavDpqOL9uatTHpsfQ0xCVov5veZuF3sH1AX1ttGU8GF1QBCaOVtbMSLeXcVVH
         GYWofwGi1er8fRHjbTN25QTRhOjLTQUwbQyeI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=WAx8IEd8EdDTfiid/33XMeVKUkHr/ho8QvYkuMXytQaEyT1/CtYLPLXIbbT8KAR+WD
         qPEvDdhr/sgXuxuKZBRXHcXYsUQcUJBiOk2Xz4bHBrB+RXVmR2B6au+EEH6a+5MXt6jH
         HhlbL86bvw3E70XdFCCOr+PKGE9zNZFx1tnlk=
Received: by 10.100.254.15 with SMTP id b15mr5610222ani.155.1237740964892; 
	Sun, 22 Mar 2009 09:56:04 -0700 (PDT)
In-Reply-To: <49C66B03.6020908@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114152>

On Sun, Mar 22, 2009 at 10:44 AM, Jens Lehmann <Jens.Lehmann@web.de> wr=
ote:
> The documentation of the post-checkout hook just talks
> about git-checkout. But recently git-clone was changed to
> call it too, so we have to document that in githooks.txt.
>
> Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
> ---
> =A0Documentation/githooks.txt | =A0 =A03 +++
> =A01 files changed, 3 insertions(+), 0 deletions(-)
>
> diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
> index 1fd512b..76deefc 100644
> --- a/Documentation/githooks.txt
> +++ b/Documentation/githooks.txt
> @@ -151,6 +151,9 @@ indicating whether the checkout was a branch chec=
kout (changing branches,
> =A0flag=3D1) or a file checkout (retrieving a file from the index, fl=
ag=3D0).
> =A0This hook cannot affect the outcome of 'git-checkout'.
>
> +It is also run after 'git-clone'. The first parameter given to the h=
ook is
> +the null-ref, the second the ref of the new HEAD and the flag is alw=
ays 1.
> +

I don't think that's true if you clone with the --no-checkout (-n)
option though.

> =A0This hook can be used to perform repository validity checks, auto-=
display
> =A0differences from the previous HEAD if different, or set working di=
r metadata
> =A0properties.
> --
> 1.6.2.1.275.ga797b
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
