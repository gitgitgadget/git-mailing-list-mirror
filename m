Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5BB9210F6A
	for <git@vger.kernel.org>; Mon,  3 Mar 2025 14:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741011010; cv=none; b=lHLXivzzJEItXVpjuUY7A8wai1wlqvT9zcP/YIJbSTfXUGdiZ7MmakvmWS/+8m9u/oZi84SqQOk5Kuc7wXf3EqbWiTZhBMun/kpN57PaeMEv3d/hNMBEGwAJXpE2SuzSIS4B+Q92C2OqCKuv/iPGAlApl+duw8Bj7uHChDV95tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741011010; c=relaxed/simple;
	bh=6zKpY2QYxQ5siu7AWv2HUyBNfp1ObixB4q1edxuzY50=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t1us6lOJdxmJFZs/M5YDYwSjNsO05+2MtMtgrLmEE38j8yX5U1qn0xVw2papFSXIGr18Ur8G08GOQ4BIt/YvaXBzyueLHy0T/VVpQaTznImgCjysTs0A4Yi7zAnTke9Kmu42crWAcDe0qSogE1DwA+SeYoUR0zPsiJ0AwtEvWLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b=r6A44KUL; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b="r6A44KUL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1741010997; x=1741615797; i=ps.report@gmx.net;
	bh=UdXdRVQm7iT1IPz6cpqQFVnLAYta9DdmlcbNVu4TO5Q=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=r6A44KULEJsbB9fJD9OZBiMYZt9Tg2ibBX12tg4TpHlIDI2IU0X3OAHc1cIFKRyX
	 vgOOxrWJe+UXgocbwptpxFE1IpdVD8mHf9272FwgX3lTxqJLEhYcW1wN/FojpNde5
	 wtfw69dkC5oDgql4MEMzDjcpN5ID0OZoV/qmjE19TqEh0bBdSqE52jbx4xI/N/Gru
	 qvn1j4OOmE+8hmrP7QTLAlxKiEnHw9fhxiLStj6P8GryvcnowGcuSZAbdBrxvwQ9T
	 DV9h67Jm4o43ZEynxr4KhtPlJQX0zmnle2vPPjQN2BfoXOuGxl6TbJ9vW8vuMX5Mo
	 3+NvWfaSlz0I1U5q2Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost ([82.135.81.38]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MC30P-1tygrg1VmP-0088ry; Mon, 03
 Mar 2025 15:09:57 +0100
Date: Mon, 3 Mar 2025 15:09:56 +0100
From: Peter Seiderer <ps.report@gmx.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Eli Schwartz <eschwartz@gentoo.org>, Junio C Hamano
 <gitster@pobox.com>
Subject: Re: [PATCH] meson: distinguish build and target host binaries
Message-ID: <20250303150956.24a1815e@gmx.net>
In-Reply-To: <20250303-pks-meson-cross-compiling-v1-1-73002ef6432e@pks.im>
References: <20250303-pks-meson-cross-compiling-v1-1-73002ef6432e@pks.im>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.48; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:AVFxnxXoxD8GBUmTTeCbI4YsB2Xb79vW/vHA+lMzcgDiXmiFXM0
 t3ZoQM6uG5ksXdxe26dlSEYMnfKG1DomF5wpDJTWaD8PRbnfPIxKoBnlovuQt2gdzzUQ+vg
 5GvTJCgJ20pHhxNbOWXZyQtp/gNtBxZMj7+yPzFdQ+EuIUTaa2MOhcn8ttDtUV7P+EGjD9D
 MFKuAv/yAH117Sl4l0g3w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:/UGEv2iqm8E=;LfN722RscwnOzNWoJD6dFvS02aU
 sRdy0K8bkgpqqj8++xgFEFmwvhiXP2N8NInyZLcGWmaVads8/Nw4BVN55jouen2qNOK1eYzPD
 tCqpdEPA0F+YzRD+BUxj6b16J2Z02xAnJb5lPzgif5hKVT+ELCkKZkwxjSI1AEodNX1bK7hI3
 CngxPxJhbf7CyqOz1orDhHh+M5315fcY3UcYwISSas67q6ZXkePf0SfgUBZ8C0olHoiN/n4ry
 8ic9i+IyVmawyKynGaMrMWAt/Ik8aPrTcJft+SeKQEUK+V2gKatCRLaJ15g22mBAWT1xF1v2T
 lva/E7EOm7bmBwd5GfhizG98pn9WrWi1YKmNLPiGio5U4l9opqGD/su2u8eZmBy0xY+6lYfoW
 W51COAJMu77QERvI8uFXIfhsldQKShmVjKcgYd6Fbpyp744Pe3uihGPqF2f5/pvwXVIf2LEJh
 i+eRdMFqS2jfn2zLtPHKF7HSM2CvBKausxA6aX9UDMXuV5MqC8ahJxofJqHoDqfplmcHruImQ
 z2FMMjYbesFX7xDwnuEVVvk08tXmW8eQiJ0drPtxME4kG6eKL5fwq06Xr1pqgj3/OE2xw7jQO
 ANjg+wFnVsSmNHyFkZHLv4IsiNk9g3KzKZSO4WuA/fCPp5u2InYIYDxZIg5yENnLEJzZaI1Y6
 L3vmeVXeh78vJEXFLuClE3aMCgjAduqHL+9LQh/BbBddWXZqt+SiS5Z4kWsd/HZKs5pTqtFRB
 9niH/+CvBQF+7KpW74UeoCmzo4t5DcR8xfKCWzXDhN6LVoB/XgtJNQSUaYnY+DCf+DB6AxkXD
 QM7Mr9j8Vg7ZP+TCIhnD2GKOiXc9NCeF7CdWEVj+dPh01gyRh6UJiXqk3fIIpZNUBIrfvDgRs
 rqcb+ujgWMQvfe8M6GZgapFizlMjqFUfKIiotRuML2CqtJaLHTxAyGRd16ax7Y/Z1ftsLiAXa
 UuTu2F0Qdh8q4e5zWYIqmXickxogqyGVlD7vvmS/lxSyCtZMM2/jYWdIxHGXUhmakjWjIeAql
 JjxHQBUIeJdyhvkjZjupdKVg7616JWXgFKnw0XmQjKTFi1GP581w2HL0POO2Hu2gUIXwhOgmF
 s9MfI0Q4gS+OnSRL2JBs/GEUsND9opPgDWbe+hqiFsyvbO8vtmcqAEp1LHCE5HQD9xruYQq4E
 opRWMlNu3Agx2cab/q1uH0QE5sV/AnpAynvjGZA2eK9PvgDTOowEM8j/Sxcf/gm0fJceiXydu
 xOlH34YrUMeXkoBHMk3L5H6m2/k3dgvcTBw5s40TX0ZSonoU2Pzg8KXpeqWzcnB3kTVh+m1XI
 KH71wdhc1jrPFlNEL7tkGHva5MAVMN8bvq029SVUyStYI5GxrGOq/Wm9pRZ2mAtf2vics5Yx6
 Qc4CS21GwW52gBoBheEJce1ldMWPgPVEsj+admPBcWFBjg1YJEEYpjRe7L

Hello Patrick,

On Mon, 03 Mar 2025 13:10:59 +0100, Patrick Steinhardt <ps@pks.im> wrote:

> Almost all of the tools we discover during the build process need to be
> native programs. There are only a handful of exceptions, which typically
> are programs whose paths we need to embed into the resulting executable
> so that they can be found on the target system when Git executes. While
> this distinction typically doesn't matter, it does start to matter when
> considering cross-compilation where the build and target machines are
> different.
>
> Meson supports cross-compilation via so-called machine files. These
> machine files allow the user to override parameters for the build
> machine, but also for the target machine when cross-compiling. Part of
> the machine file is a section that allows the user to override the
> location where binaries are to be found in the target system. The
> following machine file would for example override the path of the POSIX
> shell:
>
>     [binaries]
>     sh =3D '/usr/xpg4/bin/sh'
>
> It can be handed over to Meson via `meson setup --cross-file`.
>
> We do not handle this correctly right now though because we don't know
> to distinguish binaries for the build and target hosts at all. Address
> this by explicitly passing the `native:` parameter to `find_program()`:
>
>   - When set to `true`, we get binaries discovered on the build host.
>
>   - When set to `false`, we get either the path specified in the
>     machine file. Or, if no machine file exists or it doesn't specify
>     the binary path, then we fall back to the binary discovered on the
>     build host.
>
> As mentioned, only a handful of binaries are not native: only the system
> shell, Python and Perl need to be treated specially here.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
> Hi,
>
> this patch addresses the issue reported at [1], where it is impossible
> to specify the shell, Python and Perl paths during cross-compilation
> when using Meson.

I still believe that is is a 'misuse' of the cross-file (as stated already
here [1]) the given programs in cross-file are to be meant to run while
cross-compiling (at compile time) and not on the target (e.g. it would be
impossible to find a program (as the name find_program indicates) at
compile/configure where the target layout is yet unknown....

I believe the correct solution is an extra configure option for cross-comp=
ile
and a sane default (or find_program) in case of native build...

Regards,
Peter

[1] https://public-inbox.org/git/20250210122603.5130e309@gmx.net/

>
> The series is built on top of master at cb0ae672aea (A bit more post
> -rc0, 2025-02-27) with junio/ps/build-meson-fixes-0130 at 9350423982a
> (gitlab-ci: restrict maximum number of link jobs on Windows, 2025-02-26)
> merged into it.
>
> Thanks!
>
> Patrick
>
> [1]: <20250209133027.64a865aa@gmx.net>
> ---
>  Documentation/meson.build | 12 ++++-----
>  gitweb/meson.build        |  2 +-
>  meson.build               | 66 ++++++++++++++++++++++++++++++++++++----=
-------
>  templates/meson.build     |  4 +--
>  4 files changed, 60 insertions(+), 24 deletions(-)
>
> diff --git a/Documentation/meson.build b/Documentation/meson.build
> index 0a0f2bfa14a..63891fb4455 100644
> --- a/Documentation/meson.build
> +++ b/Documentation/meson.build
> @@ -207,9 +207,9 @@ manpages =3D {
>
>  docs_backend =3D get_option('docs_backend')
>  if docs_backend =3D=3D 'auto'
> -  if find_program('asciidoc', dirs: program_path, required: false).foun=
d()
> +  if find_program('asciidoc', dirs: program_path, native: true, require=
d: false).found()
>      docs_backend =3D 'asciidoc'
> -  elif find_program('asciidoctor', dirs: program_path, required: false)=
.found()
> +  elif find_program('asciidoctor', dirs: program_path, native: true, re=
quired: false).found()
>      docs_backend =3D 'asciidoctor'
>    else
>      error('Neither asciidoc nor asciidoctor were found.')
> @@ -217,7 +217,7 @@ if docs_backend =3D=3D 'auto'
>  endif
>
>  if docs_backend =3D=3D 'asciidoc'
> -  asciidoc =3D find_program('asciidoc', dirs: program_path)
> +  asciidoc =3D find_program('asciidoc', dirs: program_path, native: tru=
e)
>    asciidoc_html =3D 'xhtml11'
>    asciidoc_docbook =3D 'docbook'
>    xmlto_extra =3D [ ]
> @@ -246,7 +246,7 @@ if docs_backend =3D=3D 'asciidoc'
>      asciidoc_conf,
>    ]
>  elif docs_backend =3D=3D 'asciidoctor'
> -  asciidoctor =3D find_program('asciidoctor', dirs: program_path)
> +  asciidoctor =3D find_program('asciidoctor', dirs: program_path, nativ=
e: true)
>    asciidoc_html =3D 'xhtml5'
>    asciidoc_docbook =3D 'docbook5'
>    xmlto_extra =3D [
> @@ -284,7 +284,7 @@ elif docs_backend =3D=3D 'asciidoctor'
>    ]
>  endif
>
> -xmlto =3D find_program('xmlto', dirs: program_path)
> +xmlto =3D find_program('xmlto', dirs: program_path, native: true)
>
>  cmd_lists =3D [
>    'cmds-ancillaryinterrogators.adoc',
> @@ -405,7 +405,7 @@ if get_option('docs').contains('html')
>      pointing_to: 'git.html',
>    )
>
> -  xsltproc =3D find_program('xsltproc', dirs: program_path)
> +  xsltproc =3D find_program('xsltproc', dirs: program_path, native: tru=
e)
>
>    user_manual_xml =3D custom_target(
>      command: asciidoc_common_options + [
> diff --git a/gitweb/meson.build b/gitweb/meson.build
> index 89b403dc9de..88a54b4dc99 100644
> --- a/gitweb/meson.build
> +++ b/gitweb/meson.build
> @@ -1,5 +1,5 @@
>  gitweb_config =3D configuration_data()
> -gitweb_config.set_quoted('PERL_PATH', perl.full_path())
> +gitweb_config.set_quoted('PERL_PATH', target_perl.full_path())
>  gitweb_config.set_quoted('CSSMIN', '')
>  gitweb_config.set_quoted('JSMIN', '')
>  gitweb_config.set_quoted('GIT_BINDIR', get_option('prefix') / get_optio=
n('bindir'))
> diff --git a/meson.build b/meson.build
> index 516207f9cfe..0a229f44199 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -155,6 +155,37 @@
>  # These machine files can be passed to `meson setup` via the `--native-=
file`
>  # option.
>  #
> +# Cross compilation
> +# =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +#
> +# Machine files can also be used in the context of cross-compilation to
> +# describe the target machine as well as the cross-compiler toolchain t=
hat
> +# shall be used. An example machine file could look like the following:
> +#
> +#   [binaries]
> +#   c =3D 'x86_64-w64-mingw32-gcc'
> +#   cpp =3D 'x86_64-w64-mingw32-g++'
> +#   ar =3D 'x86_64-w64-mingw32-ar'
> +#   windres =3D 'x86_64-w64-mingw32-windres'
> +#   strip =3D 'x86_64-w64-mingw32-strip'
> +#   exe_wrapper =3D 'wine64'
> +#   sh =3D 'C:/Program Files/Git for Windows/usr/bin/sh.exe'
> +#
> +#   [host_machine]
> +#   system =3D 'windows'
> +#   cpu_family =3D 'x86_64'
> +#   cpu =3D 'x86_64'
> +#   endian =3D 'little'
> +#
> +# These machine files can be passed to `meson setup` via the `--cross-f=
ile`
> +# option.
> +#
> +# Note that next to the cross-compiler toolchain, the `[binaries]` sect=
ion is
> +# also used to locate a couple of binaries that will be built into Git.=
 This
> +# includes `sh`, `python` and `perl`, so when cross-compiling Git you l=
ikely
> +# want to set these binary paths in addition to the cross-compiler tool=
chain
> +# binaries.
> +#
>  # Subproject wrappers
>  # =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>  #
> @@ -173,7 +204,7 @@ project('git', 'c',
>    # The version is only of cosmetic nature, so if we cannot find a shel=
l yet we
>    # simply don't set up a version at all. This may be the case for exam=
ple on
>    # Windows systems, where we first have to bootstrap the host environm=
ent.
> -  version: find_program('sh', required: false).found() ? run_command(
> +  version: find_program('sh', native: true, required: false).found() ? =
run_command(
>      'GIT-VERSION-GEN', meson.current_source_dir(), '--format=3D@GIT_VER=
SION@',
>      capture: true,
>      check: true,
> @@ -198,16 +229,18 @@ elif host_machine.system() =3D=3D 'windows'
>    program_path =3D [ 'C:/Program Files/Git/bin', 'C:/Program Files/Git/=
usr/bin' ]
>  endif
>
> -cygpath =3D find_program('cygpath', dirs: program_path, required: false=
)
> -diff =3D find_program('diff', dirs: program_path)
> -git =3D find_program('git', dirs: program_path, required: false)
> -sed =3D find_program('sed', dirs: program_path)
> -shell =3D find_program('sh', dirs: program_path)
> -tar =3D find_program('tar', dirs: program_path)
> +cygpath =3D find_program('cygpath', dirs: program_path, native: true, r=
equired: false)
> +diff =3D find_program('diff', dirs: program_path, native: true)
> +git =3D find_program('git', dirs: program_path, native: true, required:=
 false)
> +sed =3D find_program('sed', dirs: program_path, native: true)
> +shell =3D find_program('sh', dirs: program_path, native: true)
> +tar =3D find_program('tar', dirs: program_path, native: true)
> +
> +target_shell =3D find_program('sh', dirs: program_path, native: false)
>
>  # Sanity-check that programs required for the build exist.
>  foreach tool : ['cat', 'cut', 'grep', 'sort', 'tr', 'uname']
> -  find_program(tool, dirs: program_path)
> +  find_program(tool, dirs: program_path, native: true)
>  endforeach
>
>  script_environment =3D environment()
> @@ -706,7 +739,7 @@ libgit_c_args =3D [
>    '-DGIT_LOCALE_PATH=3D"' + get_option('localedir') + '"',
>    '-DGIT_MAN_PATH=3D"' + get_option('mandir') + '"',
>    '-DPAGER_ENV=3D"' + get_option('pager_environment') + '"',
> -  '-DSHELL_PATH=3D"' + fs.as_posix(shell.full_path()) + '"',
> +  '-DSHELL_PATH=3D"' + fs.as_posix(target_shell.full_path()) + '"',
>  ]
>  libgit_include_directories =3D [ '.' ]
>  libgit_dependencies =3D [ ]
> @@ -761,6 +794,7 @@ endif
>  build_options_config.set_quoted('X', executable_suffix)
>
>  python =3D import('python').find_installation('python3', required: get_=
option('python'))
> +target_python =3D find_program('python3', native: false, required: pyth=
on.found())
>  if python.found()
>    build_options_config.set('NO_PYTHON', '')
>  else
> @@ -790,9 +824,11 @@ endif
>  # which we can do starting with Meson 1.5.0 and newer, or we have to
>  # match against the minor version.
>  if meson.version().version_compare('>=3D1.5.0')
> -  perl =3D find_program('perl', dirs: program_path, required: perl_requ=
ired, version: '>=3D5.26.0', version_argument: '-V:version')
> +  perl =3D find_program('perl', dirs: program_path, native: true, requi=
red: perl_required, version: '>=3D5.26.0', version_argument: '-V:version')
> +  target_perl =3D find_program('perl', dirs: program_path, native: fals=
e, required: perl.found(), version: '>=3D5.26.0', version_argument: '-V:ve=
rsion')
>  else
> -  perl =3D find_program('perl', dirs: program_path, required: perl_requ=
ired, version: '>=3D26')
> +  perl =3D find_program('perl', dirs: program_path, native: true, requi=
red: perl_required, version: '>=3D26')
> +  target_perl =3D find_program('perl', dirs: program_path, native: fals=
e, required: perl.found(), version: '>=3D26')
>  endif
>  perl_features_enabled =3D perl.found() and get_option('perl').allowed()
>  if perl_features_enabled
> @@ -843,7 +879,7 @@ else
>    build_options_config.set('NO_PTHREADS', '1')
>  endif
>
> -msgfmt =3D find_program('msgfmt', dirs: program_path, required: false)
> +msgfmt =3D find_program('msgfmt', dirs: program_path, native: true, req=
uired: false)
>  gettext_option =3D get_option('gettext').disable_auto_if(not msgfmt.fou=
nd())
>  if not msgfmt.found() and gettext_option.enabled()
>    error('Internationalization via libintl requires msgfmt')
> @@ -1975,9 +2011,9 @@ foreach key, value : {
>    'GIT_TEST_TEMPLATE_DIR': meson.project_build_root() / 'templates',
>    'GIT_TEST_TEXTDOMAINDIR': meson.project_build_root() / 'po',
>    'PAGER_ENV': get_option('pager_environment'),
> -  'PERL_PATH': perl.found() ? perl.full_path() : '',
> -  'PYTHON_PATH': python.found () ? python.full_path() : '',
> -  'SHELL_PATH': shell.full_path(),
> +  'PERL_PATH': target_perl.found() ? target_perl.full_path() : '',
> +  'PYTHON_PATH': target_python.found () ? target_python.full_path() : '=
',
> +  'SHELL_PATH': target_shell.full_path(),
>    'TAR': tar.full_path(),
>    'TEST_OUTPUT_DIRECTORY': test_output_directory,
>    'TEST_SHELL_PATH': shell.full_path(),
> diff --git a/templates/meson.build b/templates/meson.build
> index 1faf9a44cea..02e6eebe80b 100644
> --- a/templates/meson.build
> +++ b/templates/meson.build
> @@ -1,6 +1,6 @@
>  template_config =3D configuration_data()
> -template_config.set('PERL_PATH', perl.found() ? fs.as_posix(perl.full_p=
ath()) : '')
> -template_config.set('SHELL_PATH', fs.as_posix(shell.full_path()))
> +template_config.set('PERL_PATH', target_perl.found() ? fs.as_posix(targ=
et_perl.full_path()) : '')
> +template_config.set('SHELL_PATH', fs.as_posix(target_shell.full_path())=
)
>  template_config.set('GITWEBDIR', fs.as_posix(get_option('prefix') / get=
_option('datadir') / 'gitweb'))
>
>  configure_file(
>
> ---
> base-commit: af208620eecbe9b4655e06a28d5146a40738150e
> change-id: 20250303-pks-meson-cross-compiling-7bad3078b9e8
>

