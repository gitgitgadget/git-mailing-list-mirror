From: Tor Arvid Lund <torarvid@gmail.com>
Subject: Re: [PATCH 6/8] git-p4: better message for "git-p4 sync" when not cloned
Date: Tue, 8 Feb 2011 09:55:26 +0100
Message-ID: <AANLkTi=m9JM=L2E0pjZQr6ycrPnprA4ptTVQD+LYbX5S@mail.gmail.com>
References: <20110205224848.GA30963@arf.padd.com>
	<20110205225224.GG30963@arf.padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Tue Feb 08 09:55:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PmjMC-0001PK-Tb
	for gcvg-git-2@lo.gmane.org; Tue, 08 Feb 2011 09:55:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752491Ab1BHIz2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 Feb 2011 03:55:28 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:49646 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751262Ab1BHIz1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Feb 2011 03:55:27 -0500
Received: by gxk9 with SMTP id 9so2113457gxk.19
        for <git@vger.kernel.org>; Tue, 08 Feb 2011 00:55:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=EBvZQIXa2aZQRrnIBd6lR7nS+5+UqMn52IyqEsF8WDc=;
        b=jo8pirdrzDs2pj1M6EK+zHUEFigN2jT/yJoS3BOy22RfqYvRPkeXrFjdsa6yoqB7q1
         yF3GpiEoBfpmgPTWAbfKgBWs2b77I3wE1/22GD7YmkYP6tFZadDkzwXTvxoteG2jBTNJ
         Gddv+/EyhUIhcIJozTsMTyo8/NlT1EGmo2KyI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=TlRDtVhrDu+LJwEP2LjKC+RpXr5/SkUECkHj50Bh6PHdyP5ch/dYLiR0KX3opa+//o
         aSbf0uG9mtJI/Kl86nKCgVidVc1Bw+erE/w+AKRE1LSgt8REmkVG0hplOzFqFhnm3ZWq
         98rXMpDBMOXZZ7YucgfrX/e1SDKLifMYE0eoE=
Received: by 10.101.165.31 with SMTP id s31mr10352239ano.216.1297155326829;
 Tue, 08 Feb 2011 00:55:26 -0800 (PST)
Received: by 10.101.1.19 with HTTP; Tue, 8 Feb 2011 00:55:26 -0800 (PST)
In-Reply-To: <20110205225224.GG30963@arf.padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166340>

On Sat, Feb 5, 2011 at 11:52 PM, Pete Wyckoff <pw@padd.com> wrote:
> A common error is to do "git-p4 sync" in a repository that
> was not initialized by "git-p4 clone". =C2=A0There will be no
> p4 refs. =C2=A0The error message in this case is a traceback
> for an assertion, which is confusing.
>
> Change it instead to explain the likely problem.
>
> Signed-off-by: Pete Wyckoff <pw@padd.com>

Acked-By: Tor Arvid Lund <torarvid@gmail.com>

> ---
> =C2=A0contrib/fast-import/git-p4 | =C2=A0 =C2=A02 ++
> =C2=A01 files changed, 2 insertions(+), 0 deletions(-)
>
> diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
> index 6b847c4..04e6c3d 100755
> --- a/contrib/fast-import/git-p4
> +++ b/contrib/fast-import/git-p4
> @@ -1676,6 +1676,8 @@ class P4Sync(Command):
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 changes.sort(=
)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else:
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if not self.=
p4BranchesInGit:
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
die("No remote p4 branches. =C2=A0Perhaps you never did \"git p4 clone\=
" in here.");
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if self.verbo=
se:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 print "Getting p4 changes for %s...%s" % (', '.join(self.depotPaths),
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 self.changeRange)
> --
> 1.7.2.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
>
