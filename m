From: Daniele Segato <daniele.bilug@gmail.com>
Subject: Re: how to skip branches on git svn clone/fetch when there are errors
Date: Mon, 7 Sep 2009 11:30:58 +0200
Message-ID: <9accb4400909070230n413c6ecfqef8238422dd5d3b@mail.gmail.com>
References: <9accb4400908310126v15b08c7fr425c9daff26012f3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Sep 07 11:31:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MkaZ1-000856-0C
	for gcvg-git-2@lo.gmane.org; Mon, 07 Sep 2009 11:31:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752048AbZIGJa6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 7 Sep 2009 05:30:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752021AbZIGJa6
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Sep 2009 05:30:58 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:59693 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751649AbZIGJa5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Sep 2009 05:30:57 -0400
Received: by bwz19 with SMTP id 19so1449018bwz.37
        for <git@vger.kernel.org>; Mon, 07 Sep 2009 02:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=smv6uQQRCdgQbmWesZHA15kNaCqAFnEzeUotPEAl5XU=;
        b=Dt+LRAZQIp/uXvgpK0VKEeEviPmi72LzwkxahFpmwzFTjkEj0ol7eDAciYnz2tMU/5
         AE5m9S5sgRMkFV2tQwxh5GK662vT77f2aGePHmPYaSTXJhxbcqWnFJ4gsftXYbyxHXHb
         6RpKu0wEO0b8YlOmz56IerLaUDFWcpqKU+Fwg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=br8kFnVD2Lbl3KId4u/64PV/flL3DyvI9UBI+gtcl9WF1D8L/bS0kgGLjnK5CFoOut
         /jKfw5t+eM+s8BzipYmnaykvbsyoYSBStx7L3lognor7rtU/jkb9rqtaO8jL+0r5UYnP
         sXIvhVF5p9oC2b4LowftZZyBI/JlOD3O8tIn8=
Received: by 10.204.152.22 with SMTP id e22mr11935999bkw.93.1252315858487; 
	Mon, 07 Sep 2009 02:30:58 -0700 (PDT)
In-Reply-To: <9accb4400908310126v15b08c7fr425c9daff26012f3@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127916>

On Mon, Aug 31, 2009 at 10:26 AM, Daniele
Segato<daniele.bilug@gmail.com> wrote:>
> git init
> git svn init svn://svn.mydomain.com/path/to/repo -T HEAD -b BRANCHES =
-t TAGS
> $ git svn fetch
> Use of uninitialized value in concatenation (.) or string at
> /usr/lib/perl5/SVN/Core.pm line 584.
> Authorization failed: =C2=A0at /usr/bin/git-svn line 1415
>

more info on the error (enabled the confess instead of croak to the
Core.pm library)

Use of uninitialized value in concatenation (.) or string at
/usr/lib/perl5/SVN/Core.pm line 585.
Authorization failed:  at /usr/lib/perl5/SVN/Core.pm line 654
	SVN::Error::confess_on_error('_p_svn_error_t=3DSCALAR(0x9492a50)')
called at /usr/lib/perl5/SVN/Ra.pm line 492
	SVN::Ra::AUTOLOAD('Git::SVN::Ra=3DHASH(0x945dae8)',
'alfresco-enterprise-mirror/alfresco/BRANCHES/V2.1-A/root', 7738,
'SVN::Pool=3DREF(0x9492bc0)') called at /usr/bin/git-svn line 3760
	Git::SVN::Ra::check_path('Git::SVN::Ra=3DHASH(0x945dae8)',
'alfresco-enterprise-mirror/alfresco/BRANCHES/V2.1-A/root', 7738)
called at /usr/bin/git-svn line 4045
	Git::SVN::Ra::get_dir_check('Git::SVN::Ra=3DHASH(0x945dae8)',
'HASH(0x92131e0)', 'HASH(0x9388050)', 7738) called at /usr/bin/git-svn
line 4062
	Git::SVN::Ra::match_globs('Git::SVN::Ra=3DHASH(0x945dae8)',
'HASH(0x92131e0)', 'HASH(0x9463c00)', 'ARRAY(0x90bbc00)', 7738) called
at /usr/bin/git-svn line 3985
	Git::SVN::Ra::gs_fetch_loop_common('Git::SVN::Ra=3DHASH(0x945dae8)',
7737, 16113, 'ARRAY(0x90bbbe0)', 'ARRAY(0x90bbc00)') called at
/usr/bin/git-svn line 1415
	Git::SVN::fetch_all('svn', 'HASH(0x9464250)') called at
/usr/bin/git-svn line 372
	main::cmd_fetch() called at /usr/bin/git-svn line 253
	eval {...} called at /usr/bin/git-svn line 251


I'll keep looking at it to see if I can figure out a way to "skip" the
error myself and, eventually, provide a patch

Bye,
Daniele
