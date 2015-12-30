From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH v4 08/10] dir: simplify untracked cache "ident" field
Date: Wed, 30 Dec 2015 12:47:47 +0100
Message-ID: <5683C463.9010003@web.de>
References: <1451372974-16266-1-git-send-email-chriscool@tuxfamily.org>
 <1451372974-16266-9-git-send-email-chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	David Turner <dturner@twopensource.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?Q?Torsten_B=c3=b6gershause?= =?UTF-8?Q?n?= 
	<tboegi@web.de>, Christian Couder <chriscool@tuxfamily.org>
To: Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 30 12:48:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aEFFL-0000Fd-Tj
	for gcvg-git-2@plane.gmane.org; Wed, 30 Dec 2015 12:48:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754524AbbL3LsT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Dec 2015 06:48:19 -0500
Received: from mout.web.de ([212.227.17.11]:52556 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754312AbbL3LsR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Dec 2015 06:48:17 -0500
Received: from [192.168.2.107] ([79.223.108.227]) by smtp.web.de (mrweb101)
 with ESMTPSA (Nemesis) id 0M41Bm-1ZvtMs2rX0-00rbZ3; Wed, 30 Dec 2015 12:47:57
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:38.0)
 Gecko/20100101 Thunderbird/38.5.0
In-Reply-To: <1451372974-16266-9-git-send-email-chriscool@tuxfamily.org>
X-Provags-ID: V03:K0:dkDkEqXJx/2cWQmp7YK06Zzgy0ruwSwkQgE8Ff5J5+WZ1utoFfd
 MrLtB3H86OFAaCFmj7pf3Y6990ay6b/Qfvu4QJpavmUOtwCW+J2h+PuKfYrtUShH8Ze8XDS
 qfxNKbIu1bldDRdc9ZwtBMXQC91nXbxkBwZ7QaWisTqXBkZ+bEC58AxuEgIWkCNvmJHOpw/
 Z7lkjcZyNVu4rYK70N7jQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:rVs58x6lBZA=:y3oP0P0Dj98WEdfM1OVry3
 mukBU+Dz0a67blsFV5K7adUbLzg6k8Knc8qtJOYMVNVfstYAYChWnn2jZTxuvrUJXlcR5yFsg
 ejjiWkXnKpPqTNnVEn71pYzPbHikdCtFAPq+ng4BmoqSSItjfFPG2tT2fMowRGVxuL5hHHrpY
 e1Leoi2Nuozrne/teGp6fC7jmKu81IH7fLSCkISfyVl2YFBz1b6yeJHVDhhGdZOUK5ovh/U/R
 BRHZ6gyi+dvjvtCJkNhpi43/ljIl9zPnCXeVLdDREvr4pZqq/GPykzDu+jdokjh12gxiU7BTB
 nPsjWypZJNJ9ypE0/Z/XyeIUs76AnyLmNkkz3XX8tMlIhHIniCn0zQ+iMECPzICwvAkq5QlQI
 vets1QFudS5mEwqOlktLPDvwWUsJzdlw3cXsk+xImQJV5FyRiwZdYqJYdAEqHmPBoT8oFulhD
 Cc5qbG3bLiXQve9HeKx4mywRHCRamEBpv15PxlRRbKlS0oAlnZumBMePCAiGAyOd/dh/ePzOv
 8W4xAiZgT+PC6LgvwfG5E31DHxCymlGubI5cCks5J4rlBZZfED8ZY+uVrO8J7oirUxm1sOIOL
 tM7woeAzqdn2gvnTMW+W6AekLLdlwqsTzvYDXlvs3Zb0ixBDuSjrFsTMXjZielfMLvih1QjX3
 pZHulm/YWTzcP2TGpikPAvSpyttrVRoDkEZxmsXuv69TzMYVfnUeUUnWE8Au8cdctQ+rGsLpU
 +Z8I0/NdrT7U4+mXKsalNyyJJcFeUujySw8E4pnNHYLzqvOI//NpCz8gpimB6jGiQt9sf211 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283178>

On 2015-12-29 08.09, Christian Couder wrote:
> It is not a good idea to compare kernel versions and disable
> the untracked cache if it changes as people may upgrade and
> still want the untracked cache to work. So let's just
> compare work tree locations to decide if we should disable
> it.
OK with that.
> 
> Also it's not useful to store many locations in the ident
> field and compare to any of them. It can even be dangerous
> if GIT_WORK_TREE is used with different values. So let's
> just store one location, the location of the current work
> tree.
I don't think I fully agree in all details.
The list is there to distinguish between different clients when sharing
a Git workspace over a network to different clients:

A file system is exported from Linux to Linux via NFS,
including a Git workspace)
The same Workspace is exported via SAMBA to Windows and, in an extreme case,
AFS to Mac OS.

Other combinations could be
Linux - SAMBA - Linux
Linux - AFP - Linux

Mac OS - NFS - Linux
Mac OS - AFP - Mac OS
Mac OS - SMB - Linux, Mac OS, Windows
The list is incomplete (BSD and other Unix is missing),
there are other combinations of network protocols,
there are NAS boxes which mostly Linux under the hood, but
may have vendor specific tweaks.

Now we want to know, which of the combinations work.
The different clients need to test separately.
E.g. for a given server:

NFS - Linux
SMB - Linux
SMB Windows.

At this point I would agree that the old code from dir.c:

static const char *get_ident_string(void)
{
	static struct strbuf sb = STRBUF_INIT;
	struct utsname uts;

	if (sb.len)
		return sb.buf;
	if (uname(&uts) < 0)
		die_errno(_("failed to get kernel name and information"));
	strbuf_addf(&sb, "Location %s, system %s %s %s", get_git_work_tree(),
		    uts.sysname, uts.release, uts.version);
	return sb.buf;
}
------------------
is unneccessary picky, and the sysname should be enough:

strbuf_addf(&sb, "Location %s, system %s", get_git_work_tree(),
uts.sysname);


The old code did not find out, which network protocol that we used,
(you need to call "mount", and grep for the directory, and try to get
the FS information, which may be ext4, btrfs, smbfs, nfs....)
This is unnecessary complicated, so we endet up in using the path.

If I was a system administrator, (I sometimes am), I would set up a
bunch of Linux boxes in a similar way, so that the repo is under
/nfs/server1/projects/myproject
(and the same path is used for all Linux boxes)

The Windows machines may use something like
N:/projects/myproject
or
//server1/projects/myproject

and Mac OS may use
/Volumes/projects/myproject
(If mounted from the finder)
or
/nfs/projects/myproject
(When autofs is used)


I may have missed the discussion somewhat, could you explain why having
different uname/location combinations are not usable at your site ?

How much burden is actually put on your system, and is there a way to keep a
list of different clients ?


What I understand is that a kernel update of a Linux machine shouldn't matter,
but if a machine runs Windows or Linux should matter.
