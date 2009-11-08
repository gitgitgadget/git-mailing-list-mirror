From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH] Add intermediate build products to .gitignore
Date: Sun, 8 Nov 2009 16:07:16 -0600
Message-ID: <20091108220716.GA29035@progeny.tock>
References: <20091108112009.GA23790@progeny.tock>
 <7vvdhkdect.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Chris Johnsen <chris_johnsen@pobox.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 08 22:57:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N7FlN-0008QC-KP
	for gcvg-git-2@lo.gmane.org; Sun, 08 Nov 2009 22:57:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755267AbZKHV5W convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 Nov 2009 16:57:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755188AbZKHV5V
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Nov 2009 16:57:21 -0500
Received: from mail-gx0-f212.google.com ([209.85.217.212]:57832 "EHLO
	mail-gx0-f212.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750881AbZKHV5V (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Nov 2009 16:57:21 -0500
Received: by gxk4 with SMTP id 4so2549316gxk.8
        for <git@vger.kernel.org>; Sun, 08 Nov 2009 13:57:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=C0bFhaUsda3e1MJqswY6EkYLHkNjjbKflssX6QQCyww=;
        b=hqoOk3ebrSnBd0nH6una9vX9i9zAAqc6GUTqNZceeBVzkjk3t9x8cSEsXZmCqHe/Ud
         cIptlpplfirQ05m0dAw2pGaAY2NHCueBV+hF2ULcgFDnZj21mXKPJUhp/a+sNXH5yLui
         4SMlfq/j23wrD0IlB9VaROag7DTgelvTr/TUU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=b3Gcv6lvjp9n1hrSoy+DwWyGmb6iT5HGmq92WbO5AVLafR84cW6MOXLYUCVoywmC4A
         1pxHFe+81/H+KC468vasDuEm6CfhNuxI+JBCsrIZUGO6cBf9Vsbr4JKiaZGvpNnhhm4d
         GhlPWEpMce7fstpwoygT68a7hQv2iLaKBYSHc=
Received: by 10.91.54.8 with SMTP id g8mr13547181agk.83.1257717446525;
        Sun, 08 Nov 2009 13:57:26 -0800 (PST)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 15sm953731yxh.4.2009.11.08.13.57.25
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 08 Nov 2009 13:57:26 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7vvdhkdect.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132421>

Temporaries such as configure.ac+ and Documentation/*.xml+
sometimes remain after an interrupted build.  Tell git not to
track them.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:
=20
>> Some of these files appeared in the "git status" output after an
>> interrupted build.  I hope I caught them all.
>=20
> Thanks; I think "*+" would suffice, though.

That=E2=80=99s much better.  Here=E2=80=99s an updated patch.

 .gitignore |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/.gitignore b/.gitignore
index 51a37b1..f0d2e96 100644
--- a/.gitignore
+++ b/.gitignore
@@ -168,6 +168,7 @@ git.spec
 *.exe
 *.[aos]
 *.py[co]
+*+
 config.mak
 autom4te.cache
 config.cache
--=20
1.6.5.2
