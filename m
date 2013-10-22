From: Yoshioka Tsuneo <yoshiokatsuneo@gmail.com>
Subject: Re: [PATCH v8] diff.c: keep arrow(=>) on show_stats()'s shortened filename part to make rename visible
Date: Tue, 22 Oct 2013 23:14:46 +0300
Message-ID: <2CB6100D-747E-4F65-8F73-7BA381AC4BD4@gmail.com>
References: <38848735-7CFA-404E-AE51-4F445F813266@gmail.com> <A15CCF08-83FD-4F3C-9773-C26DEE38FD33@gmail.com> <660A536D-9993-4B81-B6FF-A113F9111570@gmail.com> <AFC93704-D6C5-49AF-9A66-C5EA81348FFA@gmail.com> <79A13931-694C-4DDC-BEDF-71A0DBA0ECA1@gmail.com> <89A4E8C6-C233-49E2-8141-837ABDBBC976@gmail.com> <FB9897CC-EDC7-4EBB-8DAB-140CEB5F93B3@gmail.com> <C876399C-9A78-4917-B0CF-D6519C7162F6@gmail.com> <87mwm5vkue.fsf@linux-k42r.v.cablecom.net> <BB9AEFCE-0E64-4EAA-8DEA-9A8125B8C553@gmail.com> <xmqqob6htbx9.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Rast <tr@thomasrast.ch>, git@vger.kernel.org,
	Duy Nguyen <pclouds@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 22 22:14:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VYiLu-0003h7-AY
	for gcvg-git-2@plane.gmane.org; Tue, 22 Oct 2013 22:14:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754381Ab3JVUOu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 Oct 2013 16:14:50 -0400
Received: from mail-lb0-f169.google.com ([209.85.217.169]:53857 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754139Ab3JVUOt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Oct 2013 16:14:49 -0400
Received: by mail-lb0-f169.google.com with SMTP id o14so2920100lbi.14
        for <git@vger.kernel.org>; Tue, 22 Oct 2013 13:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=content-type:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=DCWajxSVv+oZ7+jI4d8mo+mGQ1J2Yfi8l7ZjLQrXnpI=;
        b=YSsNkCFPcAjr+Co0/CrAtfJfqrtgYaXveRmwB7hUCJslBq55hIFaO+XY1/F5Ro0RbZ
         os39l4UEAQTzhHRfNPGXrdVqkayoXnji95zxUOloQRqSObmDxNDJOSG6Fi+X3GbOorll
         CSHRzr7gngi8i+tmKmwhXpaYBrBomHiAMgVWBejrr3CBqfEcGcrdWVUx7NgojYukGHhv
         PxgyPeCfWJSZaQ5NVkJTHzPAOotyXM+hjLqK5ExJ88SL/RhY53E1IcWoLFZjoUSiPRcD
         rrAr152Xoi88GLKal2tj11rC1zNfyl1HS7BO/KsZoKfeEQysPBHz9UcrnQkz34gSzXFq
         a15w==
X-Received: by 10.152.9.36 with SMTP id w4mr3039750laa.34.1382472887614;
        Tue, 22 Oct 2013 13:14:47 -0700 (PDT)
Received: from [192.168.0.14] (cs27064221.pp.htv.fi. [89.27.64.221])
        by mx.google.com with ESMTPSA id ao4sm22463060lac.1.2013.10.22.13.14.46
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 22 Oct 2013 13:14:46 -0700 (PDT)
In-Reply-To: <xmqqob6htbx9.fsf@gitster.dls.corp.google.com>
X-Mailer: Apple Mail (2.1510)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236487>

Hello Junio

Thank you for your comment.

> but this patch will show the
> source and the destination paths, both of which are truncated even
> more severely, because it always has to spend display columns for an
> extra "..." (to show truncation of the source side), " =3D> " (to sho=
w
> that it is a rename), and <"{","}"> pair (again to show that it is a
> rename).=20
To be more accurate, renaming output dose not always contains "{" or "}=
"
if there is no common part in source and destination paths,  although
probably there are enough large possibility to include "{" or "}".
And, in the original patch, "{" or "}" is not kept, but changed to be k=
ept
based Thomas Rast's feedback below.
(So, there was no  possibility to have "{=E2=80=A6 =3D> =E2=80=A6}" in =
the original patch.)

On Oct 13, 2013, at 11:29 PM, Thomas Rast <tr@thomasrast.ch> wrote:
> Note that in the test, the generated line looks like this:
>=20
> {..._does_not_fit_in_a_single_line =3D> .../path1                    =
      | 0
>=20
> I don't want to go all bikesheddey, but I think it's somewhat
> unfortunate that the elided parts do not correspond to each other.  I=
n
> particular, I think the closing brace should not be omitted.  Perhaps
> something like this would be ideal (making it up on the spot, don't
> count characters):
>=20
> {...a_single_line =3D> ..._as_the_first}/path1                       =
   | 0



And, it might be a bit nicer for me if the patch can be rejected(or ign=
ored as other patches)
from the beginning if the concept does not fit anyway.
# Though I know we can know more after seeing the implementation, anywa=
y :-)
# And, my original explanation about the patch might be not enough.

Thanks !

---
Tsuneo Yoshioka (=E5=90=89=E5=B2=A1 =E6=81=92=E5=A4=AB)
yoshiokatsuneo@gmail.com




On Oct 22, 2013, at 9:09 PM, Junio C Hamano <gitster@pobox.com> wrote:

> Yoshioka Tsuneo <yoshiokatsuneo@gmail.com> writes:
>=20
>> Also, I guess Junio might be suspicious to the idea to keep arrow("=3D=
>") itself, maybe ?
>=20
> I think there is no single "right" solution to this issue, and it
> has to boils down to the taste.
>=20
> When you are viewing "diff --stat -M" output in wide-enough medium,
> you are seeing three pieces of information: what the source path
> was, what the destination path will be, and what amount of change is
> made with the change. When the output width is too narrow to show
> these paths, with the current code, you see truncated destination
> path, possibly without the source path, but this patch will show the
> source and the destination paths, both of which are truncated even
> more severely, because it always has to spend display columns for an
> extra "..." (to show truncation of the source side), " =3D> " (to sho=
w
> that it is a rename), and <"{","}"> pair (again to show that it is a
> rename).  If the destination does not fit, the output before this
> patch would have thrown these away as part of left-truncation, to
> show the destination path as maximally as possible.  We do not have
> even half the width of the current "truncated to be destination
> only" output for each path.
>=20
> I am afraid that in the cases where the patch makes a difference,
> what happens would be that you can no longer tell what source or
> destination paths really are, because the leading directory part
> gets truncated too much, and if we didn't have this patch, at least
> you can tell what destination path is affected.  We would trade the
> guessability of at least one path (the destination) with just a
> single bit of information (an unidentifiable path got renamed to
> another unidentifiable path).
>=20
> I am not yet convinced that it is a good trade-off.  Especially
> given the diffstat output is not about files but more about
> contents, between an output in the extreme case the version after
> the patch needs to produce
>=20
> 	{... =3D> ...}/controller/Makefile | 7 +++++++
>=20
> that tells us "7 lines were updated in the procedure to build some
> unknown controller by copying or renaming from the build procedure
> of some other unknown controller", and the output the current code
> would give to the same rename
>=20
> 	.}/fooGadget/controller/Makefile | 7 +++++++
>=20
> that tells us "7 lines were updated in the build procedure for the
> foo Gadget", I think the latter contains more useful information,
> even though it does lose one bit of information ("there was a rename
> involved in producing this final path") compared to the version with
> the patch.
>=20
> So you are correct to say that I am still skeptical.
>=20
> In any case, the output from "diff --stat -M" should match the
> output from "apply --stat -M", I think.
