Received: from wfhigh7-smtp.messagingengine.com (wfhigh7-smtp.messagingengine.com [64.147.123.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F06131735
	for <git@vger.kernel.org>; Thu, 15 Feb 2024 13:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708004975; cv=none; b=eNlDc/xmi9af4XhoUobjpF1DyBCCLRhn65vii3VhKdBXU3W/y8tPgKCvK43odfCuSpPh9GQstIXiLls5RCny9KRKhW+mz7VbpdjanZdjBuF+zU042+YylZ3tO38SQd7s5npnLYiBFOZOe+P0k7PcygWM9Cv1smk+yF5XO/3dY10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708004975; c=relaxed/simple;
	bh=8WuuG49eUi7l7iBQ9ycoCYDRA57eYFQiTfGCfbFkUiY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e1lgAnIoMbkk3Hkp+VynpRX0GTc0oZNrXNr6vYi/7i5EmV3jASTYJjhLcwoItD1Ht0Hwxsf47bMZl1WufGcVKhyC0h17dgEEzKQ6c1KRFHSWLVjhHbjj0samEhAo+q32hrl0iX41rUy+pDhXnyPRFXvFsQLRGabQhOGdSmmJYYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=mSqkzqHK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZkZKRQSZ; arc=none smtp.client-ip=64.147.123.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="mSqkzqHK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZkZKRQSZ"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.west.internal (Postfix) with ESMTP id BD25218000A7;
	Thu, 15 Feb 2024 08:49:31 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 15 Feb 2024 08:49:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1708004971; x=1708091371; bh=xs+gLYk3cA
	JaWkJUgNE9qCVUTBqdYKNAHacycjJeHG0=; b=mSqkzqHKo5KOgjFhYCX8eP4h9o
	RPxI3C8BW06x8aEv+UoSljgeQj7rQsh44hy2OrdVjw/U9TypWPUCcmf2mux2r3Aa
	Zqxqq83wjEEDEZPr3PiJ135pevV8TKxfcUXIptuOXv1u0Uofqj8EZUqDKXVcvsma
	tMf7JYtiRT6SvEMDqDtlG1tLLcz7zA1QT8DmYjgPUjNcG323x8xRaX4VgYZ355Yh
	ndPNBJQTRX0QWakmr+8NqOpGxQ7LW7O+Ds+GHpf88/Ph3NI5Lw+E2QvA0+M+CK0i
	S7CgdpUvhy5v2f9AGpIrOz6W/uFDV/tQ6Fev2mRrzioKWEjKV2GH4Ej7T7DA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1708004971; x=1708091371; bh=xs+gLYk3cAJaWkJUgNE9qCVUTBqd
	YKNAHacycjJeHG0=; b=ZkZKRQSZEW+/qAbGRyHOfo2PX0f/EJrTpCBVuVINeM91
	/Vn49H1D/12C7+gki855giAE9roCbkt7g7uNqTxITNTuYIrLAS8Dd4h34NHf3K+G
	KmSuXebt0z4e5mvgS9l65OhlvHwX4517QmlQC4fM2A36PvEgksFReyq2EuIpWzBN
	PMeB4Sr/B1F2iYY7EqtBYV28uuE/JyanjVBtFGeaxmr0cET2w0M1iZbvL5t13Lps
	dZvd2lrQh3bWdnsLR9M+Efgy5U7KqrHWUWybQogn5+aPKTVt7njYUJfus2APucwC
	GRhoZV42HULeFOnSCwlIc3AEZHpHjIHq3U3gwe4A2g==
X-ME-Sender: <xms:ahbOZfBZiaH4SmhF-3BNmJ435UoIIGOzK-X3ORsLYds_NHFP4b8Lkw>
    <xme:ahbOZVgHf38mr-w0TMZ8l3KWgOqlr6G6GADceekf0ztn-nu_EMER5lUo43yAVL-Tj
    lOTab3WkE1jNeIGiQ>
X-ME-Received: <xmr:ahbOZamIL3aVKVglEt7rESngZ49-LaXeOzV4WP8zKIsBlUjH2kVQPHStPDO3PPLnS-NIk2uoqdc109_s0KOFROpq4HKAGEksVeSd_sZrVF9M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddtgdehjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeefgeeggfekfeeiieeiieduleeuheetgeelheeljeekjeffueeuudetvefgffetleen
    ucffohhmrghinhepmhgrnhejrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:axbOZRxytNUXork3DVuucXzqicjvT9Ai5UQL7t1TLe9nB8DTcE2Z6w>
    <xmx:axbOZUSCbdK70t-bY7BJ4r7h2lxmWwQ45z5cT27Tvmd8f0BPaROD_w>
    <xmx:axbOZUYrQItBZtNNG_RUFLPZB6kVDaXrQIHd77_MTFcuPk7xuDDsEw>
    <xmx:axbOZd9Rev2wNU0HdWDluViOreeQ0x5Gi7K9-l0S2qTw50JLvFQQ_E5bLRY>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Feb 2024 08:49:29 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id fd7d2449 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 15 Feb 2024 13:45:36 +0000 (UTC)
Date: Thu, 15 Feb 2024 14:49:27 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Eric DeCosta via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, "Eric Sunshine [ ]" <sunshine@sunshineco.com>,
	=?iso-8859-1?B?xnZhciBBcm5mavZy8CBCamFybWFzb24gWyBd?= <avarab@gmail.com>,
	"Glen Choo [ ]" <chooglen@google.com>,
	"Johannes Schindelin [ ]" <Johannes.Schindelin@gmx.de>,
	"Taylor Blau [ ]" <me@ttaylorr.com>, marzi <m.ispare63@gmail.com>,
	Eric DeCosta <edecosta@mathworks.com>
Subject: Re: [PATCH 2/7] fsmonitor: determine if filesystem is local or remote
Message-ID: <Zc4WZ2EkrVrHzs43@tanuki>
References: <pull.1667.git.git.1707992978.gitgitgadget@gmail.com>
 <d26de10866662a5bcd16d562cd1063dedd21cf02.1707992978.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="DxEZM6cXx6pmhlrh"
Content-Disposition: inline
In-Reply-To: <d26de10866662a5bcd16d562cd1063dedd21cf02.1707992978.git.gitgitgadget@gmail.com>


--DxEZM6cXx6pmhlrh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 15, 2024 at 10:29:33AM +0000, Eric DeCosta via GitGitGadget wro=
te:
> From: Eric DeCosta <edecosta@mathworks.com>
>=20
> Compare the given path to the mounted filesystems. Find the mount that is
> the longest prefix of the path (if any) and determine if that mount is on=
 a
> local or remote filesystem.

It would be nice to motivate this change in the commit message. Right
now it only explains what the commit does, but it does not mention at
all why that would be a good idea in the first place. Explaining that
this is part of the interface that the existing fsmonitor infrastructure
expects to exist would help.

> Signed-off-by: Eric DeCosta <edecosta@mathworks.com>
> ---
>  Makefile                                |   4 +
>  compat/fsmonitor/fsm-path-utils-linux.c | 195 ++++++++++++++++++++++++
>  compat/fsmonitor/fsm-path-utils-linux.h |  91 +++++++++++
>  config.mak.uname                        |  11 ++
>  4 files changed, 301 insertions(+)
>  create mode 100644 compat/fsmonitor/fsm-path-utils-linux.c
>  create mode 100644 compat/fsmonitor/fsm-path-utils-linux.h
>=20
> diff --git a/Makefile b/Makefile
> index 78e874099d9..0f36a0fd83a 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -2088,6 +2088,10 @@ ifdef HAVE_CLOCK_GETTIME
>  	BASIC_CFLAGS +=3D -DHAVE_CLOCK_GETTIME
>  endif
> =20
> +ifdef HAVE_LINUX_MAGIC_H
> +	BASIC_CFLAGS +=3D -DHAVE_LINUX_MAGIC_H
> +endif
> +
>  ifdef HAVE_CLOCK_MONOTONIC
>  	BASIC_CFLAGS +=3D -DHAVE_CLOCK_MONOTONIC
>  endif
> diff --git a/compat/fsmonitor/fsm-path-utils-linux.c b/compat/fsmonitor/f=
sm-path-utils-linux.c
> new file mode 100644
> index 00000000000..c21d1349532
> --- /dev/null
> +++ b/compat/fsmonitor/fsm-path-utils-linux.c
> @@ -0,0 +1,195 @@
> +#include "git-compat-util.h"
> +#include "abspath.h"
> +#include "fsmonitor.h"
> +#include "fsmonitor-path-utils.h"
> +#include "fsm-path-utils-linux.h"
> +#include <errno.h>
> +#include <mntent.h>
> +#include <sys/mount.h>
> +#include <sys/vfs.h>
> +#include <sys/statvfs.h>
> +
> +static int is_remote_fs(const char *path)
> +{
> +	struct statfs fs;
> +
> +	if (statfs(path, &fs))
> +		return error_errno(_("statfs('%s') failed"), path);
> +
> +	switch (fs.f_type) {
> +	case ACFS_SUPER_MAGIC:
> +	case AFS_SUPER_MAGIC:
> +	case CEPH_SUPER_MAGIC:
> +	case CIFS_SUPER_MAGIC:
> +	case CODA_SUPER_MAGIC:
> +	case FHGFS_SUPER_MAGIC:
> +	case GFS_SUPER_MAGIC:
> +	case GPFS_SUPER_MAGIC:
> +	case IBRIX_SUPER_MAGIC:
> +	case KAFS_SUPER_MAGIC:
> +	case LUSTRE_SUPER_MAGIC:
> +	case NCP_SUPER_MAGIC:
> +	case NFS_SUPER_MAGIC:
> +	case NFSD_SUPER_MAGIC:
> +	case OCFS2_SUPER_MAGIC:
> +	case PANFS_SUPER_MAGIC:
> +	case SMB_SUPER_MAGIC:
> +	case SMB2_SUPER_MAGIC:
> +	case SNFS_SUPER_MAGIC:
> +	case VMHGFS_SUPER_MAGIC:
> +	case VXFS_SUPER_MAGIC:
> +		return 1;
> +	default:
> +		return 0;
> +	}
> +}

This list doesn't feel all that maintainable to me, but so be it if
there is no better interface available.

> +static int find_mount(const char *path, const struct statvfs *fs,
> +			struct mntent *entry)

I don't quite understand why `find_mount()` is required in the first
place. Why can't we statfs(2) the path directly? This syscall provides
the fsid and should be sufficient for us to fill in `struct fs_info`.

Explaining details like this in the commit message would help guide the
reader's expectations.

Patrick

> +{
> +	const char *const mounts =3D "/proc/mounts";
> +	char *rp =3D real_pathdup(path, 1);
> +	struct mntent *ment =3D NULL;
> +	struct statvfs mntfs;
> +	FILE *fp;
> +	int found =3D 0;
> +	int ret =3D 0;
> +	size_t dlen, plen, flen =3D 0;
> +
> +	entry->mnt_fsname =3D NULL;
> +	entry->mnt_dir =3D NULL;
> +	entry->mnt_type =3D NULL;
> +
> +	fp =3D setmntent(mounts, "r");
>=20
> +	if (!fp) {
> +		free(rp);
> +		return error_errno(_("setmntent('%s') failed"), mounts);
> +	}
> +
> +	plen =3D strlen(rp);
> +
> +	/* read all the mount information and compare to path */
> +	while ((ment =3D getmntent(fp))) {
> +		if (statvfs(ment->mnt_dir, &mntfs)) {
> +			switch (errno) {
> +			case EPERM:
> +			case ESRCH:
> +			case EACCES:
> +				continue;
> +			default:
> +				error_errno(_("statvfs('%s') failed"), ment->mnt_dir);
> +				ret =3D -1;
> +				goto done;
> +			}
> +		}
> +
> +		/* is mount on the same filesystem and is a prefix of the path */
> +		if ((fs->f_fsid =3D=3D mntfs.f_fsid) &&
> +			!strncmp(ment->mnt_dir, rp, strlen(ment->mnt_dir))) {
> +			dlen =3D strlen(ment->mnt_dir);
> +			if (dlen > plen)
> +				continue;
> +			/*
> +			 * look for the longest prefix (including root)
> +			 */
> +			if (dlen > flen &&
> +				((dlen =3D=3D 1 && ment->mnt_dir[0] =3D=3D '/') ||
> +				 (!rp[dlen] || rp[dlen] =3D=3D '/'))) {
> +				flen =3D dlen;
> +				found =3D 1;
> +
> +				/*
> +				 * https://man7.org/linux/man-pages/man3/getmntent.3.html
> +				 *
> +				 * The pointer points to a static area of memory which is
> +				 * overwritten by subsequent calls to getmntent().
> +				 */
> +				free(entry->mnt_fsname);
> +				free(entry->mnt_dir);
> +				free(entry->mnt_type);
> +				entry->mnt_fsname =3D xstrdup(ment->mnt_fsname);
> +				entry->mnt_dir =3D xstrdup(ment->mnt_dir);
> +				entry->mnt_type =3D xstrdup(ment->mnt_type);
> +			}
> +		}
> +	}
> +
> +done:
> +	free(rp);
> +	endmntent(fp);
> +
> +	if (!found)
> +		return -1;
> +
> +	return ret;
> +}
> +
> +int fsmonitor__get_fs_info(const char *path, struct fs_info *fs_info)
> +{
> +	int ret =3D 0;
> +	struct mntent entry;
> +	struct statvfs fs;
> +
> +	fs_info->is_remote =3D -1;
> +	fs_info->typename =3D NULL;
> +
> +	if (statvfs(path, &fs))
> +		return error_errno(_("statvfs('%s') failed"), path);
> +
> +	if (find_mount(path, &fs, &entry) < 0) {
> +		ret =3D -1;
> +		goto done;
> +	}
> +
> +	trace_printf_key(&trace_fsmonitor,
> +			 "statvfs('%s') [flags 0x%08lx] '%s' '%s'",
> +			 path, fs.f_flag, entry.mnt_type, entry.mnt_fsname);
> +
> +	fs_info->is_remote =3D is_remote_fs(entry.mnt_dir);
> +	fs_info->typename =3D xstrdup(entry.mnt_fsname);
> +
> +	if (fs_info->is_remote < 0)
> +		ret =3D -1;
> +
> +	trace_printf_key(&trace_fsmonitor,
> +				"'%s' is_remote: %d",
> +				path, fs_info->is_remote);
> +
> +done:
> +	free(entry.mnt_fsname);
> +	free(entry.mnt_dir);
> +	free(entry.mnt_type);
> +	return ret;
> +}
> +
> +int fsmonitor__is_fs_remote(const char *path)
> +{
> +	int ret =3D 0;
> +	struct fs_info fs;
> +
> +	if (fsmonitor__get_fs_info(path, &fs))
> +		ret =3D -1;
> +	else
> +		ret =3D fs.is_remote;
> +
> +	free(fs.typename);
> +
> +	return ret;
> +}
> +
> +/*
> + * No-op for now.
> + */
> +int fsmonitor__get_alias(const char *path, struct alias_info *info)
> +{
> +	return 0;
> +}
> +
> +/*
> + * No-op for now.
> + */
> +char *fsmonitor__resolve_alias(const char *path,
> +		const struct alias_info *info)
> +{
> +	return NULL;
> +}
> diff --git a/compat/fsmonitor/fsm-path-utils-linux.h b/compat/fsmonitor/f=
sm-path-utils-linux.h
> new file mode 100644
> index 00000000000..49bdb3c4728
> --- /dev/null
> +++ b/compat/fsmonitor/fsm-path-utils-linux.h
> @@ -0,0 +1,91 @@
> +#ifndef FSM_PATH_UTILS_LINUX_H
> +#define FSM_PATH_UTILS_LINUX_H
> +#endif
> +
> +#ifdef HAVE_LINUX_MAGIC_H
> +#include <linux/magic.h>
> +#endif
> +
> +#ifndef ACFS_SUPER_MAGIC
> +#define ACFS_SUPER_MAGIC 0x61636673
> +#endif
> +
> +#ifndef AFS_SUPER_MAGIC
> +#define AFS_SUPER_MAGIC 0x5346414f
> +#endif
> +
> +#ifndef CEPH_SUPER_MAGIC
> +#define CEPH_SUPER_MAGIC 0x00c36400
> +#endif
> +
> +#ifndef CIFS_SUPER_MAGIC
> +#define CIFS_SUPER_MAGIC 0xff534d42
> +#endif
> +
> +#ifndef CODA_SUPER_MAGIC
> +#define CODA_SUPER_MAGIC 0x73757245
> +#endif
> +
> +#ifndef FHGFS_SUPER_MAGIC
> +#define FHGFS_SUPER_MAGIC 0x19830326
> +#endif
> +
> +#ifndef GFS_SUPER_MAGIC
> +#define GFS_SUPER_MAGIC 0x1161970
> +#endif
> +
> +#ifndef GPFS_SUPER_MAGIC
> +#define GPFS_SUPER_MAGIC 0x47504653
> +#endif
> +
> +#ifndef IBRIX_SUPER_MAGIC
> +#define IBRIX_SUPER_MAGIC 0x013111a8
> +#endif
> +
> +#ifndef KAFS_SUPER_MAGIC
> +#define KAFS_SUPER_MAGIC 0x6b414653
> +#endif
> +
> +#ifndef LUSTRE_SUPER_MAGIC
> +#define LUSTRE_SUPER_MAGIC 0x0bd00bd0
> +#endif
> +
> +#ifndef NCP_SUPER_MAGIC
> +#define NCP_SUPER_MAGIC 0x564c
> +#endif
> +
> +#ifndef NFS_SUPER_MAGIC
> +#define NFS_SUPER_MAGIC 0x6969
> +#endif
> +
> +#ifndef NFSD_SUPER_MAGIC
> +#define NFSD_SUPER_MAGIC 0x6e667364
> +#endif
> +
> +#ifndef OCFS2_SUPER_MAGIC
> +#define OCFS2_SUPER_MAGIC 0x7461636f
> +#endif
> +
> +#ifndef PANFS_SUPER_MAGIC
> +#define PANFS_SUPER_MAGIC 0xaad7aaea
> +#endif
> +
> +#ifndef SMB_SUPER_MAGIC
> +#define SMB_SUPER_MAGIC 0x517b
> +#endif
> +
> +#ifndef SMB2_SUPER_MAGIC
> +#define SMB2_SUPER_MAGIC 0xfe534d42
> +#endif
> +
> +#ifndef SNFS_SUPER_MAGIC
> +#define SNFS_SUPER_MAGIC 0xbeefdead
> +#endif
> +
> +#ifndef VMHGFS_SUPER_MAGIC
> +#define VMHGFS_SUPER_MAGIC 0xbacbacbc
> +#endif
> +
> +#ifndef VXFS_SUPER_MAGIC
> +#define VXFS_SUPER_MAGIC 0xa501fcf5
> +#endif
> diff --git a/config.mak.uname b/config.mak.uname
> index dacc95172dc..80d7e2a2e68 100644
> --- a/config.mak.uname
> +++ b/config.mak.uname
> @@ -68,6 +68,17 @@ ifeq ($(uname_S),Linux)
>  	ifneq ($(findstring .el7.,$(uname_R)),)
>  		BASIC_CFLAGS +=3D -std=3Dc99
>  	endif
> +	ifeq ($(shell test -f /usr/include/linux/magic.h && echo y),y)
> +		HAVE_LINUX_MAGIC_H =3D YesPlease
> +	endif
> +	# The builtin FSMonitor on Linux builds upon Simple-IPC.  Both require
> +	# Unix domain sockets and PThreads.
> +	ifndef NO_PTHREADS
> +	ifndef NO_UNIX_SOCKETS
> +	FSMONITOR_DAEMON_BACKEND =3D linux
> +	FSMONITOR_OS_SETTINGS =3D linux
> +	endif
> +	endif
>  endif
>  ifeq ($(uname_S),GNU/kFreeBSD)
>  	HAVE_ALLOCA_H =3D YesPlease
> --=20
> gitgitgadget
>=20
>=20

--DxEZM6cXx6pmhlrh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXOFmYACgkQVbJhu7ck
PpQbwBAAncDepd4vLrBmiqv5xiOQHAITHtrXRWlM45hdNAhsmvFSUHTvYtbPgFcK
UZLrEvWFOlD7IejSGt/oJ2PYoReRUM1RmbmsJHSE8hv7lcJyUzhN7DLM9nu6T0Kk
KrD/eJaUuI4l2L26X7xr4Exh/Nst0gNzIpF6i8uVIu2ZhriF/Zy+Q4QKjSpNWC7K
FV9tx6XN0RLcSSUk+LlNnK4u0DJXxFXThOCzA73Fwm9w/m+YvczcDLeGfe+GTxy3
B3IR98CAlsSTWBHvH7Iei0TthUkgnG7AwI0/aGcQGmwfFjwWCkBrsdsttA1/zSBL
172ttlwYqMeWm4ybR0Wt2rWHr/FYNfSd/gFIoi4a6GVeYbpPSvJSjXo6RUi95v9W
zuo1PhLI4S9oUnjqxwIO9S6pC44E+AqmGgLGBpbhDMGv5nGGobeLmxVExJ1J8DU5
WBGyAbUhECctsoVUpiwVlwvOzGbGiJDOFzAG0fJ7i+c9+P1SZ18BBzxbKrFuqKEQ
n6CZtaRqO5IIIqxgX8tRDPdsGOo3Cfr6tVyVXB9UbRNAqCT13HfmJDSY3EBoF/jn
Hei7udYRhZFhuUX+5Uy8qBnCwRVbu9C2xGgMejHFoqedvBU6NneaTh1QC9zCcEL4
c07xxWX9PvLjoal1MWbGRq6ZYUiAzDN4b8FQ5rlRt4mTeSfcrKE=
=9rvU
-----END PGP SIGNATURE-----

--DxEZM6cXx6pmhlrh--
