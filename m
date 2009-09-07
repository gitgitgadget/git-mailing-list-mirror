From: Daniele Segato <daniele.bilug@gmail.com>
Subject: Re: how to skip branches on git svn clone/fetch when there are errors
Date: Mon, 7 Sep 2009 15:34:28 +0200
Message-ID: <9accb4400909070634oee46b78g9270586a2b0eb4b9@mail.gmail.com>
References: <9accb4400908310126v15b08c7fr425c9daff26012f3@mail.gmail.com>
	 <9accb4400909070230n413c6ecfqef8238422dd5d3b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Sep 07 15:34:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MkeMg-00014H-2H
	for gcvg-git-2@lo.gmane.org; Mon, 07 Sep 2009 15:34:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752577AbZIGNe2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 7 Sep 2009 09:34:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752441AbZIGNe2
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Sep 2009 09:34:28 -0400
Received: from mail-fx0-f217.google.com ([209.85.220.217]:48446 "EHLO
	mail-fx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750970AbZIGNe1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Sep 2009 09:34:27 -0400
Received: by fxm17 with SMTP id 17so1989977fxm.37
        for <git@vger.kernel.org>; Mon, 07 Sep 2009 06:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=QgjZKCuPJ4usIH/1+o3VHFUkuCjcCH/ZkKzJLNs2sXw=;
        b=N4pxKNvlOcQ/AJKhCqCpC6jwRREa2JcTfhM3C2wgY6bu5xh6dNwje4KyK/t1CJq98s
         BNjPwVQSpx2bgV+klrmGZydt+kkePw7mk6+wxE5JDQRLvf7MFSfgdYPQga6D3qJ0vOpg
         ApwjyrEvpJ4lfP/Plc5RxRTjvMBqvLcKCOoZ4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=w82rSGIaEq0Qw0pwT5gcl/UJXfYMsfnzxSfM0U4jndg+NwaNNAezEQvytD4x0qUYoG
         gujBETbh4Nmx0rBrVhoXO+ktlCG5I+IzNIjOwy/d42hP01gMUWpxtOZ9+rqf9zwgwsd7
         9prxRbGBXmE7Tw7IeSfaOMQ6Vh64RDJn6pY+A=
Received: by 10.204.153.24 with SMTP id i24mr12055330bkw.114.1252330468795; 
	Mon, 07 Sep 2009 06:34:28 -0700 (PDT)
In-Reply-To: <9accb4400909070230n413c6ecfqef8238422dd5d3b@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 7, 2009 at 11:30 AM, Daniele Segato<daniele.bilug@gmail.com=
> wrote:
> more info on the error (enabled the confess instead of croak to the
> Core.pm library)
>
> Use of uninitialized value in concatenation (.) or string at
> /usr/lib/perl5/SVN/Core.pm line 585.
> Authorization failed: =C2=A0at /usr/lib/perl5/SVN/Core.pm line 654
> =C2=A0 =C2=A0 =C2=A0 =C2=A0SVN::Error::confess_on_error('_p_svn_error=
_t=3DSCALAR(0x9492a50)')
> called at /usr/lib/perl5/SVN/Ra.pm line 492
> =C2=A0 =C2=A0 =C2=A0 =C2=A0SVN::Ra::AUTOLOAD('Git::SVN::Ra=3DHASH(0x9=
45dae8)',
> 'alfresco-enterprise-mirror/alfresco/BRANCHES/V2.1-A/root', 7738,
> 'SVN::Pool=3DREF(0x9492bc0)') called at /usr/bin/git-svn line 3760
> =C2=A0 =C2=A0 =C2=A0 =C2=A0Git::SVN::Ra::check_path('Git::SVN::Ra=3DH=
ASH(0x945dae8)',
> 'alfresco-enterprise-mirror/alfresco/BRANCHES/V2.1-A/root', 7738)
> called at /usr/bin/git-svn line 4045
> =C2=A0 =C2=A0 =C2=A0 =C2=A0Git::SVN::Ra::get_dir_check('Git::SVN::Ra=3D=
HASH(0x945dae8)',
> 'HASH(0x92131e0)', 'HASH(0x9388050)', 7738) called at /usr/bin/git-sv=
n
> line 4062
> =C2=A0 =C2=A0 =C2=A0 =C2=A0Git::SVN::Ra::match_globs('Git::SVN::Ra=3D=
HASH(0x945dae8)',
> 'HASH(0x92131e0)', 'HASH(0x9463c00)', 'ARRAY(0x90bbc00)', 7738) calle=
d
> at /usr/bin/git-svn line 3985
> =C2=A0 =C2=A0 =C2=A0 =C2=A0Git::SVN::Ra::gs_fetch_loop_common('Git::S=
VN::Ra=3DHASH(0x945dae8)',
> 7737, 16113, 'ARRAY(0x90bbbe0)', 'ARRAY(0x90bbc00)') called at
> /usr/bin/git-svn line 1415
> =C2=A0 =C2=A0 =C2=A0 =C2=A0Git::SVN::fetch_all('svn', 'HASH(0x9464250=
)') called at
> /usr/bin/git-svn line 372
> =C2=A0 =C2=A0 =C2=A0 =C2=A0main::cmd_fetch() called at /usr/bin/git-s=
vn line 253
> =C2=A0 =C2=A0 =C2=A0 =C2=A0eval {...} called at /usr/bin/git-svn line=
 251
>
>
> I'll keep looking at it to see if I can figure out a way to "skip" th=
e
> error myself and, eventually, provide a patch

I played a little with perl and modified the code

I attach the patch I created...
it probably sucks and doesn't take cares of a lot of thing that I
didn't thought about...

After applying it I was able to continue the git svn fetch from the
point I left skipping those problematics paths...

Still I get a lot of warnings with:
Use of uninitialized value in concatenation (.) or string at
/usr/lib/perl5/SVN/Core.pm line 584


I just want you to take a look at it
I will not be disappointed if you place this patch in the recycle bean =
:)

I cloned the git repo, checked out the v1.5.6.5 tag (which is my
current version) and modified the git-svn.perl file.

It probably wont help but I think I should share it anyway

(patch below my signature)

Bye,
Daniele

=46rom e8a1a12e83b3f0b18ce842190d8fc8eddaa77f68 Mon Sep 17 00:00:00 200=
1
=46rom: Daniele Segato <daniele.bilug@gmail.com>
Date: Mon, 7 Sep 2009 15:30:14 +0200
Subject: [PATCH] Ignore error 175007 authorization failed on checkpath

I don't know if this is the best solution to solve the issue but it doe=
s
let me download the repo skipping the problematics paths
---
 git-svn.perl |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index a366c89..0ab6453 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -3756,7 +3756,23 @@ sub check_path {
 		return $cache->{data}->{$path};
 	}
 	my $pool =3D SVN::Pool->new;
+	my $err_handler =3D $SVN::Error::handler;
+	$SVN::Error::handler =3D sub {
+		(my $err) =3D @_;
+		my $errno =3D $err->apr_err();
+		my $err_key =3D $err->expanded_message;
+		if ($errno =3D=3D 175007) {
+			warn "W: Ignoring error from SVN, path probably ",
+				"does not exist: ($errno): ",
+				$err->expanded_message,"\n";
+		}
+		return;
+	};
+
 	my $t =3D $self->SUPER::check_path($path, $r, $pool);
+
+	$SVN::Error::handler =3D $err_handler;
+
 	$pool->clear;
 	if ($r !=3D $cache->{r}) {
 		%{$cache->{data}} =3D ();
--=20
1.5.6.5
