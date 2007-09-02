From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [ANNOUNCE] GIT 1.5.3
Date: Sun, 02 Sep 2007 15:13:09 -0700
Message-ID: <7v4picpvgq.fsf@gitster.siamese.dyndns.org>
References: <7vodglr32i.fsf@gitster.siamese.dyndns.org>
	<46DA5F33.2020005@zytor.com> <85odgltrtj.fsf@lola.goethe.zz>
	<46DA88EF.7080103@zytor.com>
	<20070902133803.1b46f599.seanlkml@sympatico.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "H. Peter Anvin" <hpa@zytor.com>, David Kastrup <dak@gnu.org>,
	git@vger.kernel.org, linux-kernel@vger.kernel.org
To: Sean <seanlkml@sympatico.ca>
X-From: git-owner@vger.kernel.org Mon Sep 03 00:13:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IRxh4-0001SF-GD
	for gcvg-git@gmane.org; Mon, 03 Sep 2007 00:13:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754187AbXIBWNR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Sep 2007 18:13:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754000AbXIBWNR
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Sep 2007 18:13:17 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:41956 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752467AbXIBWNQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Sep 2007 18:13:16 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id B009012D3C1;
	Sun,  2 Sep 2007 18:13:32 -0400 (EDT)
In-Reply-To: <20070902133803.1b46f599.seanlkml@sympatico.ca>
	(seanlkml@sympatico.ca's message of "Sun, 2 Sep 2007 13:38:03 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57395>

Sean <seanlkml@sympatico.ca> writes:

> On Sun, 02 Sep 2007 10:57:03 +0100
> "H. Peter Anvin" <hpa@zytor.com> wrote:
>
>>  From the looks of it, there is still a git-p4, it just moved to contrib 
>> and uses fast-import, so removing its rpm package was probably broken in 
>> the first place.
> ...
> As an aside, when I sent the patch removing git-p4import from the spec
> file I mentioned that I had no way to test it and asked for testers.
> Git needs a spec file maintainer so that issues like this can be caught
> before release.  Without a maintainer, it should probably be demoted
> to contrib itself.

For majority of general public, I thought the spec file _I_
ship, along with RPM files _I_ build, are contrib status
already.  Don't distro people do their own RPM packages, instead
of using what I placed on k.org?

Assuming that we do not give the old git-p4import script
packaged in "git-p4 package", would the following patch be all
that is needed, or do we need other things in the spec file?

-- snipsnap clipcrap --

diff --git a/git.spec.in b/git.spec.in
index fe7b3d8..3d56e17 100644
--- a/git.spec.in
+++ b/git.spec.in
@@ -13,6 +13,7 @@ Source: 	http://kernel.org/pub/software/scm/git/%{name}-%{version}.tar.gz
 BuildRequires:	zlib-devel >= 1.2, openssl-devel, curl-devel, expat-devel  %{!?_without_docs:, xmlto, asciidoc > 6.0.3}
 BuildRoot:	%{_tmppath}/%{name}-%{version}-%{release}-root-%(%{__id_u} -n)
 Requires:	git-core, git-svn, git-cvs, git-arch, git-email, gitk, git-gui, perl-Git
+Obsoletes:	git-p4
 
 %description
 Git is a fast, scalable, distributed revision control system with an
