From: Marcus Kida <marcus.kida@gmail.com>
Subject: Re: Bug: git branch -D can be used to delete branch which is currently checked out - Part 2
Date: Fri, 11 Mar 2016 08:20:38 +1100
Message-ID: <41E8F374-9E8A-48AE-A5D5-A3C24B79ED7E@gmail.com>
References: <F6588CBF-D13E-475F-847F-6154370F4A2E@gmail.com> <alpine.DEB.2.20.1603101313220.4690@virtualbox>
Mime-Version: 1.0 (Mac OS X Mail 9.2 \(3112\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 10 22:20:50 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ae80n-0004aT-Aa
	for gcvg-git-2@plane.gmane.org; Thu, 10 Mar 2016 22:20:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932399AbcCJVUp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 10 Mar 2016 16:20:45 -0500
Received: from mail-pa0-f47.google.com ([209.85.220.47]:34189 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932216AbcCJVUo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Mar 2016 16:20:44 -0500
Received: by mail-pa0-f47.google.com with SMTP id fe3so59900596pab.1
        for <git@vger.kernel.org>; Thu, 10 Mar 2016 13:20:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=dKwRaJeJnp5E6diLK54ZKiOn8u0ybmmXAxnreuGNplc=;
        b=t5WLePbEsC2Pe9dits1CpAyJUTkA+bs+h7zjfOOmEttcTWpsM6uf8s2j/FYJerdSSu
         nRUgcYTyEoM7KeaeR5F3s4Hq4uIiDUd9eTyujKrAZD3VnbcbSvtxCcnWv0XAWB4FWhhO
         xh4xOm5RG3tdtisvqaGOS6puFlB2u7SEfn2x1NpuK5tXFGdG4nfeU4etHAGV/R+HWLxv
         HYskxDkRWyFMNmfL2PeIs19cOoPgknuUeJhbMa3ljDO8kBi+5YTutFDi0T9LEvpsoyxn
         eSMRjGrecCRNEZomgRPNScwMHpvCUKzUSXeB2pWsCVdcM+WupsYlZuxrcPnOmaG5r2jC
         6Q1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=dKwRaJeJnp5E6diLK54ZKiOn8u0ybmmXAxnreuGNplc=;
        b=NFUOHGdx4kQ6jZFrO4lpeGxtSpsX5jRCRLw7e133596hcYhbmQhydBGI4suQsktWqh
         eJfPER17pXI1NnuYnfBpSUx4xy1XYZluBpn/mCqfelY3a01FyVMXSzg6J3geEWYRkxk0
         d2yH3uYCO+HrrBO154e3LunqUAclntTtjF1FoOl0O3Z2t5F7/hNfU+X6HzR/hFOqIbUs
         Kp73UmLXx6ebz7rEPGeB+/1chqqK+7yLG1u2/TpEGCWxuzNKi7v3V4256Cp7G8RSZEy4
         nViBL7UHXY7l82gAXlefgSPfHoC9B3oNdrCmCFgI2t7furF7RCRIRSAwa/6v7iCcPFjK
         bh4A==
X-Gm-Message-State: AD7BkJICGCWxW5JSK3On4qTv2o8A8ckrerUtABsFkeJhrLE8RlufXVEK9z+N1+IfBAA5qA==
X-Received: by 10.66.147.164 with SMTP id tl4mr7990043pab.40.1457644843716;
        Thu, 10 Mar 2016 13:20:43 -0800 (PST)
Received: from mkida.office.atlassian.com ([103.233.242.8])
        by smtp.gmail.com with ESMTPSA id to9sm7645255pab.27.2016.03.10.13.20.41
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 10 Mar 2016 13:20:42 -0800 (PST)
In-Reply-To: <alpine.DEB.2.20.1603101313220.4690@virtualbox>
X-Mailer: Apple Mail (2.3112)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288641>

Hi Johannes,
Hi Junio,

here you=E2=80=99ll find a patch to hotfix the =E2=80=9Cdelete-a-branch=
-you=E2=80=99re-on" issue.
As Junio already stated there=E2=80=99s many more places where case (in=
)sensitivity is not handled correctly but this patch would at least pre=
vent you from deleting the branch you=E2=80=99re currently working on (=
which happened to me yesterday and lead to quite some additional stress=
).

If you think this isn=E2=80=99t worth patching now, please discard my p=
atch.
If you think it=E2=80=99s worth patching and implementing a more advanc=
ed filesystem backend at a later time, please apply it.

If tested this and validate it works @ 2.8.0-rc1.=20

Thank you.

---
diff --git a/builtin/branch.c b/builtin/branch.c
index 7b45b6b..46bde61 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -215,7 +215,7 @@ static int delete_branches(int argc, const char **a=
rgv, int force, int kinds,
 		int flags =3D 0;
=20
 		strbuf_branchname(&bname, argv[i]);
-		if (kinds =3D=3D FILTER_REFS_BRANCHES && !strcmp(head, bname.buf)) {
+		if (kinds =3D=3D FILTER_REFS_BRANCHES && !strcasecmp(head, bname.buf=
)) {
 			error(_("Cannot delete the branch '%s' "
 			      "which you are currently on."), bname.buf);
 			ret =3D 1;
---

Cheers,
Marcus

> On 10 Mar 2016, at 11:15 PM, Johannes Schindelin <Johannes.Schindelin=
@gmx.de> wrote:
>=20
> Hi Marcus,
>=20
> On Thu, 10 Mar 2016, Marcus Kida wrote:
>=20
>> Proposed solution:
>>=20
>> Use `strcasecmp`, `stricmp`, `strcmpi` here: https://github.com/git/=
git/blob/f02fbc4f9433937ee0463d0342d6d7d97e1f6f1e/builtin/branch.c#L218
>>=20
>> Not sure if/which one of this will work on POSIX as well as MS too t=
hough.
>=20
> This is not quite a solution (it is not a patch). And you *definitely=
*
> want to make the use of strcasecmp() contingent on ignore_case. You a=
re
> not alone on this world, after all, and other people have case-sensit=
ive
> filesystems. It's totally doable, of course.
>=20
> So, do you feel up to the task?
>=20
> Ciao,
> Johannes
