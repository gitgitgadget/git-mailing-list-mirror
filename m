From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH v5] git on Mac OS and precomposed unicode
Date: Mon, 25 Jun 2012 14:24:29 -0700
Message-ID: <7vehp3f5ki.fsf@alter.siamese.dyndns.org>
References: <201206241747.06525.tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Mon Jun 25 23:24:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SjGlz-0000eE-E7
	for gcvg-git-2@plane.gmane.org; Mon, 25 Jun 2012 23:24:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756270Ab2FYVYd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 Jun 2012 17:24:33 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38827 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756095Ab2FYVYc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Jun 2012 17:24:32 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F3B648843;
	Mon, 25 Jun 2012 17:24:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=IAO7E67c+MqP
	AHPWv9mpaLbcvF8=; b=A3I5UwbWfguXRkr0fc92CSTScdqQ7SxgBEXmbdYjuQT+
	pgR9OcLPmQUTjV050bvW0hah40XbAo84uaBpPCibEnEA2+eY5/L9rMJC2wA9xZJQ
	IuJ15Hf5dQ182kauMmzMGI5b1qF0WHzkmKDQSP7h3UuHkuTn0e2mto4dTexX1+A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=geJDqp
	QVpDekhilF5e8PLRptDyM9vbTg19tZOm4N43o4E0PKr5U6HcR50GwPqdAq7Leiw0
	fUmavAeia6JyPy0+oRhFxW5p2b/Nu8yvzk+5aMwVVBZqb1dgJIAuvQCPFylZtDLv
	sObFaCymc5UfHKb122r6z+vU0ZyS9j+H+eCqk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EA74C8841;
	Mon, 25 Jun 2012 17:24:31 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0EB2E8840; Mon, 25 Jun 2012
 17:24:30 -0400 (EDT)
In-Reply-To: <201206241747.06525.tboegi@web.de> ("Torsten =?utf-8?Q?B?=
 =?utf-8?Q?=C3=B6gershausen=22's?= message of "Sun, 24 Jun 2012 17:47:05
 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 26E25EB2-BF0C-11E1-BBC2-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200600>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> Knowing that Mac OS X writes file names as precomposed to disk,
> and treats precomposed and decomposed file names as equal, git under =
Mac OS X
> can be improved to revert the unicode decomposition of file names.

The basic idea looks really good, but there are a few nits.

Thanks.

> The user needs to activate this feature manually.
> She typically sets core.precomposedunicode to "true" on HFS and VFAT,
> or file systems mounted via SAMBA onto a Linux box.

What do you mean by the last part?  A Linux box that mounts a
filesystem from MacOS X box via cifs?  Or MacOS X mounts a
filesystem from a Linux box over cifs?

> +core.precomposedunicode::
> +	This option is only used by Mac OS implementation of git.
> +	When core.precomposedunicode=3Dtrue, git reverts the unicode decomp=
osition
> +	of filenames done by Mac OS. This is useful when sharing a reposito=
ry
> +	between Mac OS and Linux or	Windows.

Why this funny inter-word spacing?

> +	(Git for Windows/msysGit 1.7.10 is needed, or git under cygwin 1.7)=
=2E
> +	When false, file names are handled fully transparent by git, which =
means
> +	that file names are stored as decomposed unicode in the	repository.

I am assuming, after reading from this section, that the answer to
my earlier question is "MacOS X that mounts over cifs from whatever
file server" (i.e. the latter). =20

It often is a good idea, after writing "X , which means that Y", if
you can just drop X and go strait to Y.  The result often becomes
much more clear.

As this section is clearly labeled as "Mac OS only", I think in this
case it is OK to say "when false, file names are always stored as
decomposed unicode..." for now.

Given that your compat/precomposed_utf8.[ch] looks like it does not
use anything MacOS X specific (other than "UTF-8-MAC" given to
iconv(3) API), do you foresee that this might become useful on non
Mac build of Git in the future?

> diff --git a/builtin/init-db.c b/builtin/init-db.c
> index 0dacb8b..06953df 100644
> --- a/builtin/init-db.c
> +++ b/builtin/init-db.c
> @@ -290,6 +290,8 @@ static int create_default_files(const char *templ=
ate_path)
>  		strcpy(path + len, "CoNfIg");
>  		if (!access(path, F_OK))
>  			git_config_set("core.ignorecase", "true");
> +
> +		probe_utf8_pathname_composition(path, len);
>  	}

Probing for case-insensitiveness and probing for UTF-8 mangling are
logically related and do not deserve a separation with the extra
blank line.

> diff --git a/compat/precomposed_utf8.c b/compat/precomposed_utf8.c
> new file mode 100644
> index 0000000..f510f21
> --- /dev/null
> +++ b/compat/precomposed_utf8.c
> @@ -0,0 +1,200 @@
> +#define __PRECOMPOSED_UNICODE_C__
> +
> +#include "../cache.h"
> +#include "../utf8.h"

Do you really need "../"?  I thought we compiled with -I.. from the
Makefile.

> +#include <stdlib.h>
> +#include <string.h>
> +#include <stdio.h>
> +#include <stdint.h>

And as you are including "cache.h" (which in turn includes
"git-compat-util.h"), I doubt you would need to include these
yourself, and if you do not need them, I would prefer not to see
them.

> +#include "precomposed_utf8.h"
> +
> +const static char *repo_encoding =3D "UTF-8";
> +const static char *path_encoding =3D "UTF-8-MAC";
> +
> +
> +/* Code borrowed from utf8.c */
> +#if defined(OLD_ICONV) || (defined(__sun__) && !defined(_XPG6))
> +	typedef const char * iconv_ibp;
> +#else
> +	typedef char * iconv_ibp;
> +#endif

Seeing "defined(__sun__)" here, is this not for Mac OS X-only after
all?  If so, I'd have to ask you to come up with a better name than
"mac_os_precomposed_unicode". It is primarily about sanitizing
decomposed utf-8 and it only is a happenstance that Mac OS X is the
most likely platform people may need this feature on (iow, "mac_os"
is not the fundamental part of this issue; having to sanitize paths
of decomposed UTF-8 is).

> +static char *reencode_string_iconv(const char *in, size_t insz, icon=
v_t conv)
> +{
> +	size_t outsz, outalloc;
> +	char *out, *outpos;
> +	iconv_ibp cp;
> +
> +	outsz =3D insz;
> +	outalloc =3D outsz + 1; /* for terminating NUL */
> +	out =3D xmalloc(outalloc);
> +	outpos =3D out;
> +	cp =3D (iconv_ibp)in;
> +
> +	while (1) {
> +	...
> +	}
> +	return out;
> +}

Shouldn't this part be using a new helper function refactored out of
the utf8.c::reencode_string() function, instead of cutting and
pasting?

> +static size_t has_utf8(const char *s, size_t maxlen, size_t *strlen_=
c)
> +{
> +	const uint8_t *utf8p =3D (const uint8_t*) s;
> +	size_t strlen_chars =3D 0;
> +	size_t ret =3D 0;
> +
> +	if ((!utf8p) || (!*utf8p))
> +		return 0;
> +
> +	while((*utf8p) && maxlen) {
> +		if (*utf8p & 0x80)
> +			ret++;
> +		strlen_chars++;
> +		utf8p++;
> +		maxlen--;
> +	}
> +	if (strlen_c)
> +		*strlen_c =3D strlen_chars;
> +
> +	return ret;
> +}
> +
> +
> +void probe_utf8_pathname_composition(char *path, int len)
> +{
> +	const static char *auml_nfc =3D "\xc3\xa4";
> +	const static char *auml_nfd =3D "\x61\xcc\x88";
> +	int output_fd;
> +	if (mac_os_precomposed_unicode !=3D -1)
> +		return; /* We found it defined in the global config, respect it */
> +	path[len] =3D 0;
> +	strcpy(path + len, auml_nfc);
> +	output_fd =3D open(path, O_CREAT|O_EXCL|O_RDWR, 0600);
> +	if (output_fd >=3D0) {
> +		close(output_fd);
> +		path[len] =3D 0;
> +		strcpy(path + len, auml_nfd);
> +		/* Indicate the the user, that we can configure it to true */
> +		if (0 =3D=3D access(path, R_OK))
> +			git_config_set("core.precomposedunicode", "false");
> +		path[len] =3D 0;
> +		strcpy(path + len, auml_nfc);
> +		unlink(path);
> +	}

Now this function has figured out if the filesystem mangles composed
UTF-8 pathnames, shouldn't it flip mac_os_precomposed_unicode to
either 0 or 1 before it returns?

> +}
> +
> +
> +void precompose_argv(int argc, const char **argv)
> +{
> +	int i =3D 0;
> +	const char *oldarg;
> +	char *newarg;
> +	iconv_t ic_precompose;
> +
> +	if (mac_os_precomposed_unicode !=3D 1)
> +		return;

Could the mac_os_precomposed_unicode flag be -1 (unknown) here?
Otherwise just write

	if (!mac_os_precomposed_unicode)
        	return;

> +PRECOMPOSED_UTF_DIR * precomposed_utf8_opendir(const char *dirname)

Asterisk sticks to the identifier, i.e.

    PRECOMPOSED_UTF_DIR *precomposed_utf8_opendir(const char *dirname)

> +{
> +	PRECOMPOSED_UTF_DIR *precomposed_utf8_dir;
> +	precomposed_utf8_dir =3D xmalloc(sizeof(PRECOMPOSED_UTF_DIR));
> +
> +	precomposed_utf8_dir->dirp =3D opendir(dirname);
> +	if (!precomposed_utf8_dir->dirp) {
> +		free(precomposed_utf8_dir);
> +		return NULL;
> +	}
> +	precomposed_utf8_dir->ic_precompose =3D iconv_open(repo_encoding, p=
ath_encoding);
> +	if (precomposed_utf8_dir->ic_precompose =3D=3D (iconv_t) -1) {
> +		closedir(precomposed_utf8_dir->dirp);
> +		free(precomposed_utf8_dir);
> +		return NULL;

Hrm, I wonder what value the "errno" variable should be set to when
this happens.

> +	}
> +
> +	return precomposed_utf8_dir;
> +}
> +
> +struct dirent * precomposed_utf8_readdir(PRECOMPOSED_UTF_DIR *precom=
posed_utf8_dirp)

Likewise.

> +{
> +	struct dirent *res;
> +	size_t namelen =3D 0;
> +
> +	res =3D readdir(precomposed_utf8_dirp->dirp);
> +	if (res && (mac_os_precomposed_unicode =3D=3D 1) && has_utf8(res->d=
_name, (size_t)-1, &namelen)) {

Likewise.

> +		int ret_errno =3D errno;
> +		size_t outsz =3D sizeof(precomposed_utf8_dirp->dirent_nfc.d_name) =
- 1; /* one for \0 */

A few issues:

 - Why (-1)?  Don't you need terminating NUL at the end of the
   output anyway?

 - sizeof(d_name) is most likely incorrect (Cf.
   http://pubs.opengroup.org/onlinepubs/9699919799/basedefs/dirent.h.ht=
ml)

 - Is the reason why it is appropriate to update "res" in-place
   because turning a decomposed name into precomposed form will
   always yield a shorter result?  Is that guaranteed?


> +		/* Copy all data except the name */
> +		memcpy(&precomposed_utf8_dirp->dirent_nfc, res,
> +		       sizeof(precomposed_utf8_dirp->dirent_nfc)-sizeof(precompose=
d_utf8_dirp->dirent_nfc.d_name));
> +		errno =3D 0;
> +
> +		cnt =3D iconv(precomposed_utf8_dirp->ic_precompose, &cp, &insz, &o=
utpos, &outsz);
> +		if (cnt < sizeof(precomposed_utf8_dirp->dirent_nfc.d_name) -1) {

s/-1)/- 1)/;

Can't this iconv() fail and return -1 here, which would be smaller
than the size of the structure minus one?

> +			*outpos =3D 0;
> +			errno =3D ret_errno;
> +			return &precomposed_utf8_dirp->dirent_nfc;
> +		}
> +		errno =3D ret_errno;
> +	}
> +	return res;
> +}

> diff --git a/compat/precomposed_utf8.h b/compat/precomposed_utf8.h
> new file mode 100644
> index 0000000..79e65e7
> --- /dev/null
> +++ b/compat/precomposed_utf8.h
> @@ -0,0 +1,30 @@
> +#ifndef __PRECOMPOSED_UNICODE_H__
> +#include <sys/stat.h>
> +#include <sys/types.h>
> +#include <dirent.h>
> +#include <iconv.h>

The same comments for #include applies here.

> +typedef struct {
> +	iconv_t ic_precompose;
> +	DIR *dirp;
> +	struct dirent dirent_nfc;
> +} PRECOMPOSED_UTF_DIR;

Note that "struct dirent" can be defined with d_name[1]; aren't you
risking the memory after this structure to be overwritten with a
longer name?
