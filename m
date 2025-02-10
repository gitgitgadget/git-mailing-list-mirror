Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79AAB1E04AE
	for <git@vger.kernel.org>; Mon, 10 Feb 2025 11:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739186769; cv=none; b=JyE296Ltmbuo6OFvGSECMZdxoLRtlfF9NCLh5ZgYo/5EGVertjxQl5YfoQ8R4t04BVUBBYz/2S6eqC8E0+E1QGE77ZhdA39FdhsDzAkgL7zQxF+QTAU8/qIBcvF+Xq6ULDRuvifXlXKlJeyb8NkoFNXqhZpeAvBk1EvY9CZJ8wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739186769; c=relaxed/simple;
	bh=WvknAMsBtEfCwHDccpQRmiyliOg1Cv7GJK+AEeQ8k58=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GyJMmZ9OLye81Mq2455IpLynS4w4m4T9MUODOUZNxmQgqutcgl9MebEJEWxBw/ZQHzdM5ETQ/UGYYx3V/1xGeCCVtb6UQiGiZUi6qSYpFZQWrQVt8qlFuW2vtQV4ZV+blA+xyL+KiuOWZnUT4CcXLw9ePGULPC9EmjmiTowKrvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b=eo8A2q9u; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b="eo8A2q9u"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1739186764; x=1739791564; i=ps.report@gmx.net;
	bh=33DPZs0ey3ZJF7rJ7xRMsx43vxPviX9esn8uqUK6D8o=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=eo8A2q9uhNQ0GQOfo5BE7m84wIQ7ueTt5TbXErTPP3YpXvXDylbf7dnOmZZtDUEU
	 cl64TJBZjEI5k1MXWbtV2vidXHwuHTaSqJzinuBlO4P65uDYE+oF5welDl12bHPoS
	 uKBkxgOSfdN18FFucb0IyCQWKy+SIFGtBgkDAi00hoBboWozRywJ2WuLtYrAea29y
	 0XvRua8tYCQIGGsZybmzfOaCTkQ4mXo1Y9W65H18p/ODwybDmhc5F6euYIAHji7qi
	 o3a9lKVhgQctJTzxZrVwQC5z90kf42SF6wJV4fDVsc7AM0Ym/L8PI3AMSACO7XgjH
	 ZgIHcdkb02Gt9QUq9A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost ([82.135.81.18]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M9Wys-1tmyEq23XQ-003sfH; Mon, 10
 Feb 2025 12:26:04 +0100
Date: Mon, 10 Feb 2025 12:26:03 +0100
From: Peter Seiderer <ps.report@gmx.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: Meson build leaks host 'sh' path to target build when
 cross-compiled
Message-ID: <20250210122603.5130e309@gmx.net>
In-Reply-To: <Z6mtnmvKMsIOEVz5@pks.im>
References: <20250209133027.64a865aa@gmx.net>
	<Z6mtnmvKMsIOEVz5@pks.im>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:9RtmCvtWtlpPh/9uirwXYl1CcyJSEq69etip/dvdUaI2lVRA7Tz
 enqwL2cesSS8gc+snID/7az1K1O+VL0zscKrutPED42IEZHirX6PZs/k5h9Na8YG8inJdCv
 WkHHrIyl/tf01KBp/MG89JcxJViA08QgUg4KF9numU3m/SRUMKzVj1ihbycMRt2xzPs96oc
 rEJXfcM3xPW4Y2YYeUf6g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:nbT9WScZyXM=;w2M3tQMLwB5R6MvSHsYrA2JBH8A
 I/UtAff2L4+UxF2kBLhPFLp4rzzLG8e8ZoyGDJDUlMLOAt0upLVOjG5EgdMkS2xHor38w8WA5
 GS1cL7YAgaAFHKowSl1MMjCdAIrAmqsAxh66tNzlfmGS8vcr+DZy3loRwz8gykwfdLTClZ08U
 d2tQ22CUw0NyS59iTrhwU11fRuZxH8Cy5O97IE3J5uZhYga5E4gNEt4imkJCW4mJSbaz6QBZo
 iE62dp8/aNrt1y6TzkMuZ2Gigl23AmJVGQggsFF1xLxXJqQvpBbxmZZKq/NhykEdhXuwnSakC
 PIB3VO3tA5GcGEDY2dK7kO41QBfuzr3vQ+sQBEuRnalqu+7PS8b95avzCndk73wMAICExaT4W
 GoiytR4l+0SnS0tk30edkNgZxUE6Ie7ggv5QnpBiFryDZwFkO56PFpdxPKU7VBipJa1OdpGZN
 3qv81LsLVMoqMmr+VW7rqWqHKR5HRsj7YfNAGUXI3TWfvxJpHsEABBkBz0Bcxydc3a6/0RJMH
 vBxifsVV6cw7LIarFfh0M97Lln5/LVZrdh0b1dUmYv62LxxabVeyDJCvO1j+JAwo7AcY7Y8OU
 xTQe0loiO/LXkziVmzfrt3886/S7pNjGDfOpUMcZNCNe7kop9J6Deb+vOyDBJsaWVF2HP2P1D
 vKZaYjlgro0pQ+GvgceKRTRMCg0W2Q9XJBw31w/h4ayii9p9Ja30XFayMZyo3kmLcitV4xN5H
 4HHDnxyFqRxw+hXBFFpCrVwyV8avkP/FpjszSngKOA+JmAHal/CvTBK4UUjwmvnwy4LbnTYvv
 wW3/Ca2aGpQ6SJ0QJ/rm2wygsvy3e9lRTiqJA9/Vpr2x3aemnRndyLh4lyMPZ4aHZI7F7ECV5
 ZUyPbSCB928bjhFJ2cOJulhlF1w14WbFRVkTOgyDBTpOStYsRWmk5+M7q9zUOrpy17V8rX6Xr
 A8RlNWht8OUKyPRfXtESkUXWmCeS/X26un658pK1wjY5S0BTiEAPYpb9xYRjX8GI3bPL2D3lp
 fRFrKarGbH2UlluMf4HdoyjMK4OVTpI06osZzcZpj+jIAWjl2GZ/TZzUr6alY+/FOnVJkvgrK
 BoVnxP28mFf2J5f6EeVfhqRmTAi/3xftIReF1qwpj4yQZ4rho/xUH2nK9YIKKVA/uIj0pzJxX
 Jo3Mf0iYdpDHHkrtvXW8LJaa8J7rISNHUq84516EAWJ//HeGqGqJeg7J47HkLi4GXEE317oTi
 /XgniFPYtbpALiuOgf6ulfqiR4zo7NKxfYq6ImWwMPAygzJijP9QJ9K7jaWkgvK/S2kxegBAL
 h/TU06wy7IkqAcBwjxD37+B2jS/811wusF3LaqKLCLgbMElxMssY0unV38/0R4tZ5sEYBwPaR
 oIHjmJ6MCD9e+wC46ynW+UGCcknEWGIOw1fFAB6ZhfQpp2ny/VDfx049Cu

Hello Patrick,

On Mon, 10 Feb 2025 08:41:18 +0100, Patrick Steinhardt <ps@pks.im> wrote:

> On Sun, Feb 09, 2025 at 01:30:27PM +0100, Peter Seiderer wrote:
> [snip]
> >   The meson build tries to execute the non-existent '/usr/bin/sh' (ins=
tead of
> >   '/bin/sh' as the autoconf build), 'which sh' on the host returns
> >   '/usr/bin/sh'...
> >
> >   From meson.build
> >
> >    [...]
> >    186 shell =3D find_program('sh', dirs: program_path)
> >    [...]
> >    685   '-DSHELL_PATH=3D"' + fs.as_posix(shell.full_path()) + '"',
> >
> >   Do not use the result of 'find_program('sh',...)' for '-DSHELL_PATH=
=3D'
> >   (at least not for cross-compile), use fix '/bin/sh' instead or make =
it
> >   configurable via a meson option?
>
> Hm, very true. We're mixing up concerns here by treating the build
> environment and the target environment the same.
>
> I guess the proper fix is to wire up the "native:" parameter when we
> call `find_program()`, which allows us to tell Meson whether it should
> find an executable for the build or the target host. And then, for those
> binaries where we actually need to know about both the build and target
> host's locations, we'd end up calling `find_program()` twice.
>
> For executables that are supposed to be used on the target host Meson
> would then know to first consult the cross file, which could look like
> this:
>
>     [binaries]
>     sh =3D '/target/path/to/sh'
>     perl =3D '/target/path/to/perl'
>
> Meson would then pick up that file via `meson setup --cross-file
> <CROSSFILE_PATH> <BUILDDIR>`.

Sorry, I believe this will not work..., the description of the native
parameter in find_program ([2]) on the first sight sounds like doing the
right thing, but as far as I read the 'Cross compilation' page ([3], [4]) =
the
tools under the '[binaries]' section are the tools used while cross-compil=
ing
(running on the build machine) and not the paths/tools on the target
(or as meson nomenclature host/target)...

One tiny finding below...

>
> The patch should look somewhat like the attached patch, but it conflicts
> with my in-flight patch series at [1]. I'll wait for that series to be
> merged to `next` before sending out the fix.
>
> Thanks for your report!
>
> Patrick
>
> [1]: <20250129-b4-pks-meson-improvements-v1-0-ab709f0be12c@pks.im>
>
> -- >8 --
>
> diff --git a/Documentation/meson.build b/Documentation/meson.build
> index c6117366ff..b033f4a93a 100644
> --- a/Documentation/meson.build
> +++ b/Documentation/meson.build
> @@ -206,9 +206,9 @@ manpages =3D {
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
> @@ -216,7 +216,7 @@ if docs_backend =3D=3D 'auto'
>  endif
>
>  if docs_backend =3D=3D 'asciidoc'
> -  asciidoc =3D find_program('asciidoc', dirs: program_path)
> +  asciidoc =3D find_program('asciidoc', native: true, dirs: program_pat=
h)
>    asciidoc_html =3D 'xhtml11'
>    asciidoc_docbook =3D 'docbook'
>    xmlto_extra =3D [ ]
> @@ -245,7 +245,7 @@ if docs_backend =3D=3D 'asciidoc'
>      asciidoc_conf,
>    ]
>  elif docs_backend =3D=3D 'asciidoctor'
> -  asciidoctor =3D find_program('asciidoctor', dirs: program_path)
> +  asciidoctor =3D find_program('asciidoctor', native: true, dirs: progr=
am_path)
>    asciidoc_html =3D 'xhtml5'
>    asciidoc_docbook =3D 'docbook5'
>    xmlto_extra =3D [
> @@ -283,7 +283,7 @@ elif docs_backend =3D=3D 'asciidoctor'
>    ]
>  endif
>
> -xmlto =3D find_program('xmlto', dirs: program_path)
> +xmlto =3D find_program('xmlto', dirs: program_path, native: true)
>
>  cmd_lists =3D [
>    'cmds-ancillaryinterrogators.txt',
> @@ -404,7 +404,7 @@ if get_option('docs').contains('html')
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
> index 89b403dc9d..88a54b4dc9 100644
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
> index e153a43918..5a5662bc02 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -173,7 +173,7 @@ project('git', 'c',
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
> @@ -198,16 +198,18 @@ elif host_machine.system() =3D=3D 'windows'
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
> @@ -758,6 +760,7 @@ endif
>  build_options_config.set_quoted('X', executable_suffix)
>
>  python =3D import('python').find_installation('python3', required: get_=
option('python'))
> +target_python =3D find_program('python3', native: false, required: pyth=
on.found())
>  if python.found()
>    build_options_config.set('NO_PYTHON', '')
>  else
> @@ -775,7 +778,8 @@ endif
>
>  # Note that we only set NO_PERL if the Perl features were disabled by t=
he user.
>  # It may not be set when we have found Perl, but only use it to run tes=
ts.
> -perl =3D find_program('perl', version: '>=3D5.8.1', dirs: program_path,=
 required: perl_required)
> +perl =3D find_program('perl', version: '>=3D5.8.1', dirs: program_path,=
 native: true, required: perl_required)
> +target_perl =3D find_program('perl', version: '>=3D5.8.1', native: fals=
e, required: perl.found())
>  perl_features_enabled =3D perl.found() and get_option('perl').allowed()
>  if perl_features_enabled
>    build_options_config.set('NO_PERL', '')
> @@ -825,7 +829,7 @@ else
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
> @@ -1954,9 +1958,9 @@ foreach key, value : {
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
> index 1faf9a44ce..986c2e03be 100644
> --- a/templates/meson.build
> +++ b/templates/meson.build
> @@ -1,6 +1,6 @@
>  template_config =3D configuration_data()
> -template_config.set('PERL_PATH', perl.found() ? fs.as_posix(perl.full_p=
ath()) : '')
> -template_config.set('SHELL_PATH', fs.as_posix(shell.full_path()))
> +template_config.set('PERL_PATH', perl.found() ? fs.as_posix(target_perl=
.full_path()) : '')

Above should read (perl.found() vs. target_perl.found()):

   +template_config.set('PERL_PATH', target_perl.found() ? fs.as_posix(tar=
get_perl.full_path()) : '')

> +template_config.set('SHELL_PATH', fs.as_posix(target_shell.full_path())=
)
>  template_config.set('GITWEBDIR', fs.as_posix(get_option('prefix') / get=
_option('datadir') / 'gitweb'))
>
>  configure_file(

Regards,
Peter

[2] https://mesonbuild.com/Reference-manual_functions.html#find_program
[3] https://mesonbuild.com/Cross-compilation.html
[4] https://mesonbuild.com/Machine-files.html

