From: Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 1/2] merge-recursive: Workaround unused variable warning
Date: Tue, 17 Aug 2010 18:00:57 -0600
Message-ID: <AANLkTikLXy4gPttmX=wzcDaFAfZO=OEk4PEDKh3sCSOF@mail.gmail.com>
References: <1281665352-10533-1-git-send-email-newren@gmail.com>
	<1281665352-10533-2-git-send-email-newren@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, Johannes Sixt <j.sixt@viscovery.net>,
	Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 18 02:01:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OlW65-0001Jh-NL
	for gcvg-git-2@lo.gmane.org; Wed, 18 Aug 2010 02:01:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752115Ab0HRABM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 17 Aug 2010 20:01:12 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:51930 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751208Ab0HRAA7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Aug 2010 20:00:59 -0400
Received: by fxm13 with SMTP id 13so3815654fxm.19
        for <git@vger.kernel.org>; Tue, 17 Aug 2010 17:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=LpIe2dd0vp1JFiQkgtzmg7FiqMv89oeKL0NsPr36NzE=;
        b=qLhn3JqxZsWbqhWhYBX9w2nYNp3tcgweTE5caYKZYv1XhlyZMEm6g9INASvqopjH3T
         pYs34FfPGV3roUzV0cFn2OksZl1dWrULmAh1BHL7sS+WXgSRc7zdCC+OKWyxmmIUBOU5
         UQdZodUWtaW5XACc+Pd24+39D+h175KIYHhT8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=rqhjAIqYovzyuHsNxjN4zKMtF5JJFZLkIhEn9kUS1owO44GRUSqrsqIFOfZ587S1fg
         Ie8FyiDEtn60u1f/MC7dmQQGKChgGgTEAJ/3n9yyz0M9JVVxHxB0yE7sq/SngZgiFGwK
         Ow/uwqPS4OxWdbC2CSijukdxXoInCWoJkDhyc=
Received: by 10.223.121.193 with SMTP id i1mr7155073far.77.1282089657728; Tue,
 17 Aug 2010 17:00:57 -0700 (PDT)
Received: by 10.223.149.82 with HTTP; Tue, 17 Aug 2010 17:00:57 -0700 (PDT)
In-Reply-To: <1281665352-10533-2-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153798>

Hi,

On Thu, Aug 12, 2010 at 8:09 PM, Elijah Newren <newren@gmail.com> wrote=
:
> diff --git a/merge-recursive.c b/merge-recursive.c
> index 9678c1d..7e32498 100644
> --- a/merge-recursive.c
> +++ b/merge-recursive.c
> @@ -1214,6 +1214,7 @@ static int process_df_entry(struct merge_option=
s *o,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* We currently only handle D->F cases */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0assert((!o_sha && a_sha && !b_sha) ||
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (!o_sha && !a_sha &&=
 b_sha));
> + =C2=A0 =C2=A0 =C2=A0 (void)o_sha;
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0entry->processed =3D 1;

It appears that this patch did not get included, though 2/2 from this
series did.  I'm not sure whether that was intentional or accidental.
If it was intentional, would a different method of fixing warnings
when NDEBUG is defined be preferred?  (Maybe changing the
"assert(foo)" into "if (!foo) die..." instead?)

If you'd rather just leave it as is, that's fine too.  I just wanted
to make sure it was addressed to Johannes' satisfaction, since he
brought it up as an issue for the Windows build caused by my previous
patches.

Thanks,
Elijah
