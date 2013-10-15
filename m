From: Yoshioka Tsuneo <yoshiokatsuneo@gmail.com>
Subject: Re: [PATCH v3] diff.c: keep arrow(=>) on show_stats()'s shortened filename part to make rename visible.
Date: Tue, 15 Oct 2013 12:46:07 +0300
Message-ID: <E3435C7B-9673-40F5-96EA-AD59B20EBC4A@gmail.com>
References: <38848735-7CFA-404E-AE51-4F445F813266@gmail.com> <A15CCF08-83FD-4F3C-9773-C26DEE38FD33@gmail.com> <660A536D-9993-4B81-B6FF-A113F9111570@gmail.com> <877gdg7w46.fsf@linux-k42r.v.cablecom.net>
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Thomas Rast <tr@thomasrast.ch>,
	"git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Oct 15 11:46:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VW1DN-000342-Q6
	for gcvg-git-2@plane.gmane.org; Tue, 15 Oct 2013 11:46:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758532Ab3JOJqy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Oct 2013 05:46:54 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:39959 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758206Ab3JOJqx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Oct 2013 05:46:53 -0400
Received: by mail-lb0-f174.google.com with SMTP id w6so6506538lbh.5
        for <git@vger.kernel.org>; Tue, 15 Oct 2013 02:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=content-type:mime-version:subject:from:in-reply-to:date
         :content-transfer-encoding:message-id:references:to;
        bh=wFsRVHnFaRyUsqGeYE9+Cb4kuxXUfB+3Lxnj+S8OFJw=;
        b=lInl9+lV98fTUy7bBrfq+MANnY60N9ERakTSUVHCQcCvoq6aaPA/hp1io3IjK0S0rg
         td6I7bcKP5rU1+5cYbZVi0hDvrUpaUZx8mglMIrrqcq1yY8Gdi4PD5Q+UnjY1nHC/8Zz
         I2maPF80vUgCTH+rP+04zglD/5k1HXO4T1aLfuv0Se38EHRuks52YUXEsKwJfruSD22R
         X7kKJvFGZOvMemcgGWmRFRfch2LjABJ8sBrqfcXgXSrnkILnzjkf4DPx7DnLNcnzbJg2
         YlWjsnfDZrUTV7i2ea/2s/DwMQ3dGhTp84wEV2W6x9YZHa6OGJyhYdPkVu5dELsxPP8O
         DX0A==
X-Received: by 10.152.170.233 with SMTP id ap9mr416309lac.51.1381830411605;
        Tue, 15 Oct 2013 02:46:51 -0700 (PDT)
Received: from [10.128.134.109] (fsgw.f-secure.com. [193.110.108.33])
        by mx.google.com with ESMTPSA id ur6sm46884786lbc.5.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 15 Oct 2013 02:46:51 -0700 (PDT)
In-Reply-To: <877gdg7w46.fsf@linux-k42r.v.cablecom.net>
X-Mailer: Apple Mail (2.1510)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236170>

Hello Thomas

Thank you very much for your kind review.
Now, I just posted "PATCH v4" that will include your suggestion like ke=
eping "{", "}"
while omitting,  improving commit message and comment, and test.

Thanks!

---
Tsuneo Yoshioka (=E5=90=89=E5=B2=A1 =E6=81=92=E5=A4=AB)
yoshiokatsuneo@gmail.com




On Oct 13, 2013, at 11:29 PM, Thomas Rast <tr@thomasrast.ch> wrote:

> Hi,
>=20
> Yoshioka Tsuneo <yoshiokatsuneo@gmail.com> writes:
>=20
>> "git diff -M --stat" can detect rename and show renamed file name li=
ke
>> "foofoofoo =3D> barbarbar", but if destination filename is long the =
line
>> is shortened like "...barbarbar" so there is no way to know whether =
the
>> file is renamed or existed in the source commit.
>=20
> Thanks for your patch!  I think this is indeed something that should =
be
> fixed.
>=20
> Can you explain the algorithm chosen in the commit message or a block
> comment in the code?  I find it much easier to follow large code bloc=
ks
> (like the one you added) with a prior notion of what it tries to do.
>=20
>  [As an aside, Documentation/SubmittingPatches says
>=20
>    The body should provide a meaningful commit message, which:
>=20
>      . explains the problem the change tries to solve, iow, what is w=
rong
>        with the current code without the change.
>=20
>      . justifies the way the change solves the problem, iow, why the
>        result with the change is better.
>=20
>      . alternate solutions considered but discarded, if any.
>=20
>  Observe that you explained the first item very well, but not the
>  others.]
>=20
>> This commit makes it visible like "...foo =3D> ...bar".
>=20
> Also, you should rewrite this to be in the imperative mood:
>=20
>  Make sure there is always an arrow, e.g., "...foo =3D> ...bar".
>=20
> or some such.
>=20
>  [Again from SubmittingPatches:
>=20
>    Describe your changes in imperative mood, e.g. "make xyzzy do frot=
z"
>    instead of "[This patch] makes xyzzy do frotz" or "[I] changed xyz=
zy
>    to do frotz", as if you are giving orders to the codebase to chang=
e
>    its behaviour.]
>=20
>> Signed-off-by: Tsuneo Yoshioka <yoshiokatsuneo@gmail.com>
>> ---
>> diff.c | 58 +++++++++++++++++++++++++++++++++++++++++++++++++++-----=
--
>> 1 file changed, 51 insertions(+), 7 deletions(-)
>=20
> Can you add a test?  Perhaps like the one below.  (You can squash it
> into your commit if you like it.)
>=20
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
>=20
> diff --git a/t/t4001-diff-rename.sh b/t/t4001-diff-rename.sh
> index 2f327b7..03d6371 100755
> --- a/t/t4001-diff-rename.sh
> +++ b/t/t4001-diff-rename.sh
> @@ -156,4 +156,16 @@ test_expect_success 'rename pretty print common =
prefix and suffix overlap' '
> 	test_i18ngrep " d/f/{ =3D> f}/e " output
> '
>=20
> +test_expect_success 'rename of very long path shows =3D>' '
> +	mkdir long_dirname_that_does_not_fit_in_a_single_line &&
> +	mkdir another_extremely_long_path_but_not_the_same_as_the_first &&
> +	cp path1 long_dirname*/ &&
> +	git add long_dirname*/path1 &&
> +	test_commit add_long_pathname &&
> +	git mv long_dirname*/path1 another_extremely_*/ &&
> +	test_commit move_long_pathname &&
> +	git diff -M --stat HEAD^ HEAD >output &&
> +	test_i18ngrep "=3D>.*path1" output
> +'
> +
> test_done
>=20
> --=20
> Thomas Rast
> tr@thomasrast.ch
