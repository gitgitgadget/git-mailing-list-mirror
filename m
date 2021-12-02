Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6628C433F5
	for <git@archiver.kernel.org>; Thu,  2 Dec 2021 19:08:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376647AbhLBTL6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Dec 2021 14:11:58 -0500
Received: from sonic307-55.consmr.mail.gq1.yahoo.com ([98.137.64.31]:42017
        "EHLO sonic307-55.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1376361AbhLBTLy (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 2 Dec 2021 14:11:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.ca; s=s2048; t=1638472117; bh=BCfhvIErqrhXTL/1/dIKsfPIJgKekdUxwJifk45GWg0=; h=Date:From:Subject:To:References:From:Subject:Reply-To; b=XNkVvtHzaxGJBKRgUvakQHorWhf1Zxre99QfJ/K/8WSD42uZlrI4u7mYuHVbMDkGg6FFgyu5mAKcyilPXME090v4cv6fjmFMMfYijTCtaFQvlxiO9j/+YkDExxtq8cI+PHEN0J7u6INeZAuzv5xSVb2yVUQbKPFj2ZrnJ5DIvZtjs8D00nepiPLnR9IVZGabffCD+KpPBeL1MX0VX5TTtJTuzPJQXTCgwCfHojmrCb+AMabOA6pUjmFQ6KMjpGUVpvayad6UiBU0Gl0bDgMV5CUt3d4NdRBHO6jGpj9tlGiziM00t4d7oXFoLomRbE7SJvNXk2bXAxGkOs4DXnv1qQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1638472117; bh=RzcJZ4lC+Msf3mWopQ+slW6jCkc8fFdJqbuE2YK2avj=; h=X-Sonic-MF:Date:From:Subject:To:From:Subject; b=Y2gQuIiHF6DGCcAFMdUgkIW5L7s5QYvRAcSQu1ngCajVBVUrX83NxLBeppIly8++OF3ZztkoNzVqoR91wDDd8V7x90RyQIaOaOhl6rWvr72KzpuzRQxucSai6MbrN+IcZYMXlrutvJO9g1TOnUxrUg08+mvv0LyuNPwb4jm2tVOR+x38oIWphku7oH7RWe2dMPDhVFvgw9EXMAg9WtCvjCf3KZMByJHXYWz/EAbKiJHqsCzcIZphNWhByrvbYuZtQR3PRjjtNaTgARkjMqLLI38fH4uTuaCiKTbWrKqnV+Yim3uF4uzT8DD19wQbTm9SQJVhIPLsmDi4N0FymlYUZA==
X-YMail-OSG: iGt9xbcVM1lKBzqj4ZhRkpyKXt6SG6r9q553kG3v8WvNrkSsd6Ysp1pdtlsXXN8
 QX1WID928g2AjQae610hjOlv5eUgNw30cBoSw552w64ntkeNuT2O3UbpaJZVlnUTIH4khIV5GQpy
 0_xruA4_R5UEGi8tRHF3u0qPBtra3ASBsdKG1hMN8PFZU1DJvpkZ5LgYM62KZ_oiWKbsBmCrVWhx
 JPManBl6XICDry.AiN3X4hcQV5eRKH8XX2GPdrQ6RzH4C5RZXM66YvxtlcwuaD.IPfY97JSxXckO
 gBCESLNjTO9WPzRAXq9Ha5V5X_LHffAnE0WKkUAoLWPcRTKhjkMEYHeOn2.KLkFbXqBvplut.eYq
 XORtvNc4xESYW3rc3A_0UFU_9BmiUDOXL0nwNjDc3iZ_7aTMteloNsAJrTP7MaVKGJUI9tEa70Y9
 Rxw9a3Ebph3lNWnycJK9UIc70EQ2Ig4HzE6Exw6pSdgh.NPVQpQmhxSgos4sg4LueTUEFWLU7GTE
 lmno.E4gc9ROdeAbPr.wS82PchBIrhBGNOqJYvTyB9UdYgHTf0HdDhdMNV4geyUha8G05FuMw.jQ
 yznF7rEI7Dmxlm1tcMD9TZZwOLndWPs3mI4CQUNO7bIhq1E_5mqMumhgDT63cdyWXzuv5YB3t6cI
 9h_ypcGZIXesbOn8yGT43HBeZ6vrpFj9pr1.a9Y3Hl1uihzgoxgPxuy3qtP7eFWf2tWgkpAKnqDv
 CKFaCRLC5yUqE1yapbHyG27.u_Z6SANFzYrC4H8hhzoL6UnW8fFa8U.pnk5OxTc8MaYo0zxzp.8V
 rGIO5Eq5vezQIKBXXXXePDxiyHYRwDBhmNT37Mp09vlfLbftE5icwe_DMKXJve98G3zy16_W1VjB
 DVZ55Wj_uJfcWE2eIf3jAD3pn4ufO8.bs.3ra503VkFg68ixXgcE1QJtm5_Uwh_37j.5qD6p7Tgm
 SFcBjd0MpD7.5ebWZc_rnu6mcuaUd7sG6G90XQHVC_dC1hN5fB5AI628qkBRuWWaOKRdRQfEAvQJ
 Vjhos3drEh3f1GyBHpnCiygF78DzYjQa5x.BogrkQLfN8A6EH8c0kBSHuD1sM7wHs51._FxQB3cr
 rSjq3k_k3WKI_QLyWCFTcZvVcE8SuJ.suPjpIkDSRBEnn4TmRHnSz5Y3v82i3dgAXxwwr0d3HLPU
 RtOx1j8dEcN8vKuxb0JUVip60PIU7qZhgjcH2mnYzVB0QpU20blCKwERL13kHukA5u3cs7Mt23p0
 E8PD.X7mGsvROJtDmOa6QwSJB6PUFMsgeuwWBi8EpNJaTDPI0WLaxJjAfnjLjBGeGAKQ8kWqqiqj
 X.Q1sq0urcZEx35ad9MYLpJUiCX0bEKIXgx7BHqeU34ZViZ6a.MRUGuw4.6xjgavAHHVKzjBTfQB
 OSm4EzGsuz9FxyZewY7R4viM7QdOSDhRe0hYQ1qGamI5YMNMrUkwg4YV2oZ6TlLbcc_a0AHUAx.k
 m7cS7._XvCCXpskx1iqA41BHO57WDWt4YdlR9B6U_n1PXiHtABoy26c4Md7VvV_5sAix4AupUzSo
 lR2o7hNL7PPF2WBAgQxOB73IYniF5Emm6bRp17M9jcKM3T63OYZ7kb0R7pxQjgVLoCycwFnwvqj7
 oJpUOXGkHDE8O5WUvF54lNkRjLjoxYrFSg9NhhM7bJN8.lqOqz44pdGOIYuF1P6a3CIdyycHXpce
 fk6CT8yWjGQ.2bOjzK1AvUooiKNDKrTrjhT1A3Z.0ss6x1poduzFqC_HhtgGnJ192VyUgmA38qCE
 XYeuSyes4p8JOg0XqvEdE840Ac.l3KZxVGcXSFd3ykGJQNi07jsvQLEd76mEO.n6GQ.FL0nul.GR
 wsdOIiUtlZzhT9ohHTL5FrzASIVJ5cIBJE80iVYx3ulx2EHxbrsc0wryDn7iZnjcQYZkT1dTqoKK
 fUYkv.rCG.FqGya8Y4801S.xkg275Aw1sIO3j_QDv846IqrKovK2MD9Rd15bxM614qlAFkZ09xNi
 JoJp.dtt80wFIFM8PKArni82DIIfMkM7Ujb05ytlB_gnz8RUL8kmxRZRx1DgPPs9uGoNlidw17Jg
 LIOI1HeVA3IyFP3p49xYFwEcwCELLIyEEwQ7MdnliSv1_f5ZIxiAGhwfD6cTlg8wwRdZ391MKMUB
 6e.kTab7PS_p_1ej.J2_arbR.BaBqGWw60NuYJCzH6CCtvW1awwDLlt4pTh5i5aVvxGXIo2Lg39U
 AH8bTxATlvSwjesxTQxgv.ABkmo_WBkGW8jH49D8l0Z17Is7WAGfZ7mzhm4SOFCzJNA--
X-Sonic-MF: <alex_y_xu@yahoo.ca>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.gq1.yahoo.com with HTTP; Thu, 2 Dec 2021 19:08:37 +0000
Received: by kubenode517.mail-prod1.omega.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID a213865cb39579e92007fefaaef9619e;
          Thu, 02 Dec 2021 19:08:24 +0000 (UTC)
Date:   Thu, 02 Dec 2021 14:08:20 -0500
From:   "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>
Subject: Confusing (maybe wrong?) conflict output with ort
To:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>
MIME-Version: 1.0
Message-Id: <1638470726.ql5i6zljva.none@localhost>
Content-Type: multipart/mixed; boundary="=-P/B11qfJVaVH1VeDu7XR"
References: <1638470726.ql5i6zljva.none.ref@localhost>
X-Mailer: WebService/1.1.19306 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--=-P/B11qfJVaVH1VeDu7XR
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi all,

After upgrading to git 2.34.1, I tried to rebase [0] onto [1], but=20
encountered "strange" conflict results.

git rebase -s recursive main produces [[RECURSIVE]]. It is roughly what=20
I expected to be output. If I take all the changes from the upper=20
section of the conflict, my changes will be effectively undone. If I=20
take all the changes from the lower section, then the upstream changes=20
will be undone.

On the other hand, running git rebase -s ort main produces [[ORT]]. I am=20
unsure if it is wrong, strictly speaking, but it is certainly unexpected=20
and difficult for me to resolve. Selecting the upper section of the=20
conflict does erase my changes, as before, but selecting the lower=20
section results in syntactically incorrect code (foreach is ended by=20
endif). The diff3 output makes even less sense to me.

A script is attached to assist in reproducing my results. Running it=20
initializes the repository to the desired state. Then, run "git rebase=20
-s strategy master" to produce the conflict.

Thanks,
Alex.

[0] https://gitlab.freedesktop.org/alxu/mesa/-/commit/4ad18ab613101e3489ca2=
d9e7151125f670e1ea5
[1] https://gitlab.freedesktop.org/alxu/mesa/-/commit/c47fd3dc0062101b3e75a=
414b17d2765735f7424

[[RECURSIVE]]

<<<<<<< HEAD
use_elf_tls =3D true
pre_args +=3D '-DUSE_ELF_TLS'

if with_platform_android and get_option('platform-sdk-version') >=3D 29
  # By default the NDK compiler, at least, emits emutls references instead =
of
  # ELF TLS, even when building targeting newer API levels.  Make it actual=
ly do
  # ELF TLS instead.
  c_args +=3D '-fno-emulated-tls'
  cpp_args +=3D '-fno-emulated-tls'
endif

# -mtls-dialect=3Dgnu2 speeds up non-initial-exec TLS significantly but req=
uires
# full toolchain (including libc) support.
have_mtls_dialect =3D false
foreach c_arg : get_option('c_args')
  if c_arg.startswith('-mtls-dialect=3D')
    have_mtls_dialect =3D true
    break
  endif
endforeach
if not have_mtls_dialect
  # need .run to check libc support. meson aborts when calling .run when
  # cross-compiling, but because this is just an optimization we can skip i=
t
  if meson.is_cross_build()
    warning('cannot auto-detect -mtls-dialect when cross-compiling, using c=
ompiler default')
  else
    # -fpic to force dynamic tls, otherwise TLS relaxation defeats check
    gnu2_test =3D cc.run('int __thread x; int main() { return x; }', args: =
['-mtls-dialect=3Dgnu2', '-fpic'], name: '-mtls-dialect=3Dgnu2')
    if gnu2_test.returncode() =3D=3D 0
      c_args +=3D '-mtls-dialect=3Dgnu2'
      cpp_args +=3D '-mtls-dialect=3Dgnu2'
=3D=3D=3D=3D=3D=3D=3D
use_elf_tls =3D false
if not with_platform_windows or not with_shared_glapi
  pre_args +=3D '-DUSE_ELF_TLS'
  use_elf_tls =3D true

  if with_platform_android and get_option('platform-sdk-version') >=3D 29
    # By default the NDK compiler, at least, emits emutls references instea=
d of
    # ELF TLS, even when building targeting newer API levels.  Make it actu=
ally do
    # ELF TLS instead.
    c_args +=3D '-fno-emulated-tls'
    cpp_args +=3D '-fno-emulated-tls'
  endif

  # -mtls-dialect=3Dgnu2 speeds up non-initial-exec TLS significantly but r=
equires
  # full toolchain (including libc) support.
  have_mtls_dialect =3D false
  foreach c_arg : get_option('c_args')
    if c_arg.startswith('-mtls-dialect=3D')
      have_mtls_dialect =3D true
      break
    endif
  endforeach
  if not have_mtls_dialect
    # need .run to check libc support. meson aborts when calling .run when
    # cross-compiling, but because this is just an optimization we can skip=
 it
    if meson.is_cross_build()
      warning('cannot auto-detect -mtls-dialect when cross-compiling, using=
 compiler default')
    else
      # -fpic to force dynamic tls, otherwise TLS relaxation defeats check
      gnu2_test =3D cc.run('int __thread x; int main() { return x; }', args=
: ['-mtls-dialect=3Dgnu2', '-fpic'], name: '-mtls-dialect=3Dgnu2')
      # https://gitlab.freedesktop.org/mesa/mesa/-/issues/5665
      if gnu2_test.returncode() =3D=3D 0 and (
           host_machine.cpu_family() !=3D 'x86_64' or
           # https://github.com/mesonbuild/meson/issues/6377
           #cc.get_linker_id() !=3D 'ld.lld' or
           cc.links('''int __thread x; int y; int main() { __asm__(
                  "leaq x@TLSDESC(%rip), %rax\n"
                  "movq y@GOTPCREL(%rip), %rdx\n"
                  "call *x@TLSCALL(%rax)\n"); }''', name: 'split TLSDESC')
           )
        c_args +=3D '-mtls-dialect=3Dgnu2'
        cpp_args +=3D '-mtls-dialect=3Dgnu2'
      endif
>>>>>>> 4ad18ab6131 (meson: check for lld split TLSDESC bug (fixes #5665))
    endif
  endif
endif

[[ORT]]

# -mtls-dialect=3Dgnu2 speeds up non-initial-exec TLS significantly but req=
uires
# full toolchain (including libc) support.
have_mtls_dialect =3D false
foreach c_arg : get_option('c_args')
  if c_arg.startswith('-mtls-dialect=3D')
    have_mtls_dialect =3D true
    break
  endif
<<<<<<< HEAD
endforeach
if not have_mtls_dialect
  # need .run to check libc support. meson aborts when calling .run when
  # cross-compiling, but because this is just an optimization we can skip i=
t
  if meson.is_cross_build()
    warning('cannot auto-detect -mtls-dialect when cross-compiling, using c=
ompiler default')
  else
    # -fpic to force dynamic tls, otherwise TLS relaxation defeats check
    gnu2_test =3D cc.run('int __thread x; int main() { return x; }', args: =
['-mtls-dialect=3Dgnu2', '-fpic'], name: '-mtls-dialect=3Dgnu2')
    if gnu2_test.returncode() =3D=3D 0
      c_args +=3D '-mtls-dialect=3Dgnu2'
      cpp_args +=3D '-mtls-dialect=3Dgnu2'
=3D=3D=3D=3D=3D=3D=3D

  # -mtls-dialect=3Dgnu2 speeds up non-initial-exec TLS significantly but r=
equires
  # full toolchain (including libc) support.
  have_mtls_dialect =3D false
  foreach c_arg : get_option('c_args')
    if c_arg.startswith('-mtls-dialect=3D')
      have_mtls_dialect =3D true
      break
    endif
  endforeach
  if not have_mtls_dialect
    # need .run to check libc support. meson aborts when calling .run when
    # cross-compiling, but because this is just an optimization we can skip=
 it
    if meson.is_cross_build()
      warning('cannot auto-detect -mtls-dialect when cross-compiling, using=
 compiler default')
    else
      # -fpic to force dynamic tls, otherwise TLS relaxation defeats check
      gnu2_test =3D cc.run('int __thread x; int main() { return x; }', args=
: ['-mtls-dialect=3Dgnu2', '-fpic'], name: '-mtls-dialect=3Dgnu2')
      # https://gitlab.freedesktop.org/mesa/mesa/-/issues/5665
      if gnu2_test.returncode() =3D=3D 0 and (
           host_machine.cpu_family() !=3D 'x86_64' or
           # https://github.com/mesonbuild/meson/issues/6377
           #cc.get_linker_id() !=3D 'ld.lld' or
           cc.links('''int __thread x; int y; int main() { __asm__(
                  "leaq x@TLSDESC(%rip), %rax\n"
                  "movq y@GOTPCREL(%rip), %rdx\n"
                  "call *x@TLSCALL(%rax)\n"); }''', name: 'split TLSDESC')
           )
        c_args +=3D '-mtls-dialect=3Dgnu2'
        cpp_args +=3D '-mtls-dialect=3Dgnu2'
      endif
>>>>>>> 4ad18ab6131 (meson: check for lld split TLSDESC bug (fixes #5665))
    endif
  endif
endif

--=-P/B11qfJVaVH1VeDu7XR
Content-Type: application/x-shellscript; name=reproducer.sh
Content-Disposition: attachment; filename=reproducer.sh
Content-Transfer-Encoding: base64

IyEvYmluL3NoCgpnaXQgaW5pdCAtYiBtYXN0ZXIKY2F0ID4gbWVzb24uYnVpbGQgPDwgRU9GCnVz
ZV9lbGZfdGxzID0gZmFsc2UKaWYgbm90IHdpdGhfcGxhdGZvcm1fd2luZG93cyBvciBub3Qgd2l0
aF9zaGFyZWRfZ2xhcGkKICBwcmVfYXJncyArPSAnLURVU0VfRUxGX1RMUycKICB1c2VfZWxmX3Rs
cyA9IHRydWUKCiAgaWYgd2l0aF9wbGF0Zm9ybV9hbmRyb2lkIGFuZCBnZXRfb3B0aW9uKCdwbGF0
Zm9ybS1zZGstdmVyc2lvbicpID49IDI5CiAgICAjIEJ5IGRlZmF1bHQgdGhlIE5ESyBjb21waWxl
ciwgYXQgbGVhc3QsIGVtaXRzIGVtdXRscyByZWZlcmVuY2VzIGluc3RlYWQgb2YKICAgICMgRUxG
IFRMUywgZXZlbiB3aGVuIGJ1aWxkaW5nIHRhcmdldGluZyBuZXdlciBBUEkgbGV2ZWxzLiAgTWFr
ZSBpdCBhY3R1YWxseSBkbwogICAgIyBFTEYgVExTIGluc3RlYWQuCiAgICBjX2FyZ3MgKz0gJy1m
bm8tZW11bGF0ZWQtdGxzJwogICAgY3BwX2FyZ3MgKz0gJy1mbm8tZW11bGF0ZWQtdGxzJwogIGVu
ZGlmCgogICMgLW10bHMtZGlhbGVjdD1nbnUyIHNwZWVkcyB1cCBub24taW5pdGlhbC1leGVjIFRM
UyBzaWduaWZpY2FudGx5IGJ1dCByZXF1aXJlcwogICMgZnVsbCB0b29sY2hhaW4gKGluY2x1ZGlu
ZyBsaWJjKSBzdXBwb3J0LgogIGhhdmVfbXRsc19kaWFsZWN0ID0gZmFsc2UKICBmb3JlYWNoIGNf
YXJnIDogZ2V0X29wdGlvbignY19hcmdzJykKICAgIGlmIGNfYXJnLnN0YXJ0c3dpdGgoJy1tdGxz
LWRpYWxlY3Q9JykKICAgICAgaGF2ZV9tdGxzX2RpYWxlY3QgPSB0cnVlCiAgICAgIGJyZWFrCiAg
ICBlbmRpZgogIGVuZGZvcmVhY2gKICBpZiBub3QgaGF2ZV9tdGxzX2RpYWxlY3QKICAgICMgbmVl
ZCAucnVuIHRvIGNoZWNrIGxpYmMgc3VwcG9ydC4gbWVzb24gYWJvcnRzIHdoZW4gY2FsbGluZyAu
cnVuIHdoZW4KICAgICMgY3Jvc3MtY29tcGlsaW5nLCBidXQgYmVjYXVzZSB0aGlzIGlzIGp1c3Qg
YW4gb3B0aW1pemF0aW9uIHdlIGNhbiBza2lwIGl0CiAgICBpZiBtZXNvbi5pc19jcm9zc19idWls
ZCgpCiAgICAgIHdhcm5pbmcoJ2Nhbm5vdCBhdXRvLWRldGVjdCAtbXRscy1kaWFsZWN0IHdoZW4g
Y3Jvc3MtY29tcGlsaW5nLCB1c2luZyBjb21waWxlciBkZWZhdWx0JykKICAgIGVsc2UKICAgICAg
IyAtZnBpYyB0byBmb3JjZSBkeW5hbWljIHRscywgb3RoZXJ3aXNlIFRMUyByZWxheGF0aW9uIGRl
ZmVhdHMgY2hlY2sKICAgICAgZ251Ml90ZXN0ID0gY2MucnVuKCdpbnQgX190aHJlYWQgeDsgaW50
IG1haW4oKSB7IHJldHVybiB4OyB9JywgYXJnczogWyctbXRscy1kaWFsZWN0PWdudTInLCAnLWZw
aWMnXSwgbmFtZTogJy1tdGxzLWRpYWxlY3Q9Z251MicpCiAgICAgIGlmIGdudTJfdGVzdC5yZXR1
cm5jb2RlKCkgPT0gMAogICAgICAgIGNfYXJncyArPSAnLW10bHMtZGlhbGVjdD1nbnUyJwogICAg
ICAgIGNwcF9hcmdzICs9ICctbXRscy1kaWFsZWN0PWdudTInCiAgICAgIGVuZGlmCiAgICBlbmRp
ZgogIGVuZGlmCmVuZGlmCkVPRgpnaXQgY29tbWl0IC1tIGJhc2UgbWVzb24uYnVpbGQKY2F0ID4g
bWVzb24uYnVpbGQgPDwgRU9GCnVzZV9lbGZfdGxzID0gdHJ1ZQpwcmVfYXJncyArPSAnLURVU0Vf
RUxGX1RMUycKCmlmIHdpdGhfcGxhdGZvcm1fYW5kcm9pZCBhbmQgZ2V0X29wdGlvbigncGxhdGZv
cm0tc2RrLXZlcnNpb24nKSA+PSAyOQogICMgQnkgZGVmYXVsdCB0aGUgTkRLIGNvbXBpbGVyLCBh
dCBsZWFzdCwgZW1pdHMgZW11dGxzIHJlZmVyZW5jZXMgaW5zdGVhZCBvZgogICMgRUxGIFRMUywg
ZXZlbiB3aGVuIGJ1aWxkaW5nIHRhcmdldGluZyBuZXdlciBBUEkgbGV2ZWxzLiAgTWFrZSBpdCBh
Y3R1YWxseSBkbwogICMgRUxGIFRMUyBpbnN0ZWFkLgogIGNfYXJncyArPSAnLWZuby1lbXVsYXRl
ZC10bHMnCiAgY3BwX2FyZ3MgKz0gJy1mbm8tZW11bGF0ZWQtdGxzJwplbmRpZgoKIyAtbXRscy1k
aWFsZWN0PWdudTIgc3BlZWRzIHVwIG5vbi1pbml0aWFsLWV4ZWMgVExTIHNpZ25pZmljYW50bHkg
YnV0IHJlcXVpcmVzCiMgZnVsbCB0b29sY2hhaW4gKGluY2x1ZGluZyBsaWJjKSBzdXBwb3J0Lgpo
YXZlX210bHNfZGlhbGVjdCA9IGZhbHNlCmZvcmVhY2ggY19hcmcgOiBnZXRfb3B0aW9uKCdjX2Fy
Z3MnKQogIGlmIGNfYXJnLnN0YXJ0c3dpdGgoJy1tdGxzLWRpYWxlY3Q9JykKICAgIGhhdmVfbXRs
c19kaWFsZWN0ID0gdHJ1ZQogICAgYnJlYWsKICBlbmRpZgplbmRmb3JlYWNoCmlmIG5vdCBoYXZl
X210bHNfZGlhbGVjdAogICMgbmVlZCAucnVuIHRvIGNoZWNrIGxpYmMgc3VwcG9ydC4gbWVzb24g
YWJvcnRzIHdoZW4gY2FsbGluZyAucnVuIHdoZW4KICAjIGNyb3NzLWNvbXBpbGluZywgYnV0IGJl
Y2F1c2UgdGhpcyBpcyBqdXN0IGFuIG9wdGltaXphdGlvbiB3ZSBjYW4gc2tpcCBpdAogIGlmIG1l
c29uLmlzX2Nyb3NzX2J1aWxkKCkKICAgIHdhcm5pbmcoJ2Nhbm5vdCBhdXRvLWRldGVjdCAtbXRs
cy1kaWFsZWN0IHdoZW4gY3Jvc3MtY29tcGlsaW5nLCB1c2luZyBjb21waWxlciBkZWZhdWx0JykK
ICBlbHNlCiAgICAjIC1mcGljIHRvIGZvcmNlIGR5bmFtaWMgdGxzLCBvdGhlcndpc2UgVExTIHJl
bGF4YXRpb24gZGVmZWF0cyBjaGVjawogICAgZ251Ml90ZXN0ID0gY2MucnVuKCdpbnQgX190aHJl
YWQgeDsgaW50IG1haW4oKSB7IHJldHVybiB4OyB9JywgYXJnczogWyctbXRscy1kaWFsZWN0PWdu
dTInLCAnLWZwaWMnXSwgbmFtZTogJy1tdGxzLWRpYWxlY3Q9Z251MicpCiAgICBpZiBnbnUyX3Rl
c3QucmV0dXJuY29kZSgpID09IDAKICAgICAgY19hcmdzICs9ICctbXRscy1kaWFsZWN0PWdudTIn
CiAgICAgIGNwcF9hcmdzICs9ICctbXRscy1kaWFsZWN0PWdudTInCiAgICBlbmRpZgogIGVuZGlm
CmVuZGlmCkVPRgpnaXQgY29tbWl0IC1tIHVwZGF0ZSBtZXNvbi5idWlsZApnaXQgY2hlY2tvdXQg
LWIgYnJhbmNoIEhFQUReCmdpdCBhcHBseSA8PCBFT0YKZGlmZiAtLWdpdCBhL21lc29uLmJ1aWxk
IGIvbWVzb24uYnVpbGQKaW5kZXggMmY0NGM5ZC4uNTgzODhkZCAxMDA2NDQKLS0tIGEvbWVzb24u
YnVpbGQKKysrIGIvbWVzb24uYnVpbGQKQEAgLTI4LDcgKzI4LDE2IEBAIGlmIG5vdCB3aXRoX3Bs
YXRmb3JtX3dpbmRvd3Mgb3Igbm90IHdpdGhfc2hhcmVkX2dsYXBpCiAgICAgZWxzZQogICAgICAg
IyAtZnBpYyB0byBmb3JjZSBkeW5hbWljIHRscywgb3RoZXJ3aXNlIFRMUyByZWxheGF0aW9uIGRl
ZmVhdHMgY2hlY2sKICAgICAgIGdudTJfdGVzdCA9IGNjLnJ1bignaW50IF9fdGhyZWFkIHg7IGlu
dCBtYWluKCkgeyByZXR1cm4geDsgfScsIGFyZ3M6IFsnLW10bHMtZGlhbGVjdD1nbnUyJywgJy1m
cGljJ10sIG5hbWU6ICctbXRscy1kaWFsZWN0PWdudTInKQotICAgICAgaWYgZ251Ml90ZXN0LnJl
dHVybmNvZGUoKSA9PSAwCisgICAgICAjIGh0dHBzOi8vZ2l0bGFiLmZyZWVkZXNrdG9wLm9yZy9t
ZXNhL21lc2EvLS9pc3N1ZXMvNTY2NQorICAgICAgaWYgZ251Ml90ZXN0LnJldHVybmNvZGUoKSA9
PSAwIGFuZCAoCisgICAgICAgICAgIGhvc3RfbWFjaGluZS5jcHVfZmFtaWx5KCkgIT0gJ3g4Nl82
NCcgb3IKKyAgICAgICAgICAgIyBodHRwczovL2dpdGh1Yi5jb20vbWVzb25idWlsZC9tZXNvbi9p
c3N1ZXMvNjM3NworICAgICAgICAgICAjY2MuZ2V0X2xpbmtlcl9pZCgpICE9ICdsZC5sbGQnIG9y
CisgICAgICAgICAgIGNjLmxpbmtzKCcnJ2ludCBfX3RocmVhZCB4OyBpbnQgeTsgaW50IG1haW4o
KSB7IF9fYXNtX18oCisgICAgICAgICAgICAgICAgICAibGVhcSB4QFRMU0RFU0MoJXJpcCksICVy
YXhcbiIKKyAgICAgICAgICAgICAgICAgICJtb3ZxIHlAR09UUENSRUwoJXJpcCksICVyZHhcbiIK
KyAgICAgICAgICAgICAgICAgICJjYWxsICp4QFRMU0NBTEwoJXJheClcbiIpOyB9JycnLCBuYW1l
OiAnc3BsaXQgVExTREVTQycpCisgICAgICAgICAgICkKICAgICAgICAgY19hcmdzICs9ICctbXRs
cy1kaWFsZWN0PWdudTInCiAgICAgICAgIGNwcF9hcmdzICs9ICctbXRscy1kaWFsZWN0PWdudTIn
CiAgICAgICBlbmRpZgpFT0YKZ2l0IGNvbW1pdCAtbSBtaW5lIG1lc29uLmJ1aWxkCg==

--=-P/B11qfJVaVH1VeDu7XR--
