From: Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 0/3] Fix resolvable rename + D/F conflict testcases
Date: Mon, 6 Sep 2010 14:49:45 -0600
Message-ID: <AANLkTimLHitZFPRMSdXTSfq6tF=jcwu0Lp9ET0smg3-U@mail.gmail.com>
References: <AANLkTimz8qSwefp137-D+vEbsf6soG51u0im9EC911_O@mail.gmail.com>
	<1283806070-22027-1-git-send-email-newren@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, oinksocket@letterboxes.org,
	ken.schalk@intel.com, Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 06 22:49:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OsidU-0001c1-2U
	for gcvg-git-2@lo.gmane.org; Mon, 06 Sep 2010 22:49:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755402Ab0IFUts convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Sep 2010 16:49:48 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:33752 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752752Ab0IFUtq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Sep 2010 16:49:46 -0400
Received: by fxm13 with SMTP id 13so2649301fxm.19
        for <git@vger.kernel.org>; Mon, 06 Sep 2010 13:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=uII4yMpoevlD6XCfVl7XzBL3AYrTU6flee3wsLCH7/w=;
        b=rdllH+XU87Lu9esp7EIlFuEWMyuCWqXDRFXAJHAKKL4iG3vV9/dC/fHj5pRcSF5fb2
         IWm0IJwzptxiiLIecrZ2Dgbf710u0f0cUbD9NUS0Il+1uujwPDwSn1ZLDjOChXGVLVNH
         RcN9qYEpY3i+TcPAgtbJsNtLmsEbwsWVgI180=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Ne0T0tFfbo9gKNNR7bDupI5L96xJzeGwGQEMFyOBZl6Edk4W6tHyjSLjapfxZwm/Zd
         +ROITN2eQC6hLcb6kAkbpSfExmWYDXHw0hnlNuqTfVrCgDWyDvrWPeAjwg8/vNiSjhGP
         4PNxFHuelZdYhPBNmP27UY1DQW/gHk4ohPesc=
Received: by 10.223.115.207 with SMTP id j15mr3236630faq.105.1283806185518;
 Mon, 06 Sep 2010 13:49:45 -0700 (PDT)
Received: by 10.223.50.154 with HTTP; Mon, 6 Sep 2010 13:49:45 -0700 (PDT)
In-Reply-To: <1283806070-22027-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155619>

On Mon, Sep 6, 2010 at 2:47 PM, Elijah Newren <newren@gmail.com> wrote:
> This fixes an issue reported by Nick, as well as a closely related
> issue in the handling of rename + directory/file conflicts,
> particularly where a file on one side of the rename is a directory
> name on the other side of the merge.

I forgot to mention; this patch series is based on next, since it
touches some of the code from ks/recursive-rename-add-identical.

> Elijah Newren (3):
> =C2=A0t3509: Add rename + D/F conflict testcases that recursive strat=
egy
> =C2=A0 =C2=A0fails
> =C2=A0merge-recursive: Small code cleanup
> =C2=A0merge-recursive: D/F conflicts where was_a_dir/file -> was_a_di=
r
>
> =C2=A0merge-recursive.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 | =C2=A0 50 ++++++++++++++++-------------
> =C2=A0t/t3509-cherry-pick-merge-df.sh | =C2=A0 66 +++++++++++++++++++=
++++++++++++++++++++
> =C2=A02 files changed, 94 insertions(+), 22 deletions(-)
