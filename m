From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] rebase -i -p: document shortcomings
Date: Tue, 1 Jun 2010 03:50:05 -0500
Message-ID: <20100601085005.GA32320@progeny.tock>
References: <20100601014335.GA21970@progeny.tock>
 <AANLkTimjcHpbbpfwNoZGq3_1TjfLAzJL3C8Jcp6LeyW0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Thomas Rast <trast@student.ethz.ch>,
	Florian Weimer <fw@deneb.enyo.de>,
	=?iso-8859-1?Q?J=F6rg?= Sommer <joerg@alea.gnuu.de>
To: Greg Price <price@ksplice.com>
X-From: git-owner@vger.kernel.org Tue Jun 01 10:50:29 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJNB6-0005uH-JD
	for gcvg-git-2@lo.gmane.org; Tue, 01 Jun 2010 10:50:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755523Ab0FAIuS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Jun 2010 04:50:18 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:52034 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754167Ab0FAIuP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jun 2010 04:50:15 -0400
Received: by gwaa12 with SMTP id a12so3358179gwa.19
        for <git@vger.kernel.org>; Tue, 01 Jun 2010 01:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=MxwOIJsF9pChRjCEGKLDwl6t4SVgdlj+yYg1YPt3BSs=;
        b=O8d6OdH3LbCydqbFSNTkLfL44P41WrSttkRus8D5mxImu05k/pHUkIGPSmVfJvf6zD
         DBJClLHpgomHWBQFb7pT5SUAU0Ig2ZoooedwsbLDZxZiLCEeRbpfvTJumsqxRfIfS+Lz
         fv+9frVFwOkzzDTVSuPk5423PGksI4jQXj+80=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=TNcQw47EIuNA9pNbUbb7ahQepvpR1JHzXqNwYnBq0gwP9qm5AbBs7ZxvBSEdDAOWAE
         1OEjck/J7c8X2Ye5HLXbtBOup4iVZfOT+skVZ3vXRilxDQesBQOX2tFTUPUYMqmTI2W2
         pd0d0uq2lQxOFAPq6UcaJ/LZE92CyRsX37mm4=
Received: by 10.231.174.201 with SMTP id u9mr7421362ibz.17.1275382214841;
        Tue, 01 Jun 2010 01:50:14 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id t28sm30381914ibg.12.2010.06.01.01.50.12
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 01 Jun 2010 01:50:13 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTimjcHpbbpfwNoZGq3_1TjfLAzJL3C8Jcp6LeyW0@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148092>

Hi Greg,

Greg Price wrote:

> The combination "rebase -i -p" does work correctly in one common use
> case:
[...]
> I suggest s/instruction sheet/todo list/, as the latter terminology
> seems more natural to me

Here=E2=80=99s a rough patch to squash in.  Thanks for the ideas.

Sleepily,
Jonathan

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.tx=
t
index 330e9ea..e27099e 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -309,7 +309,7 @@ link:howto/revert-a-faulty-merge.txt[revert-a-fault=
y-merge How-To] for details).
 +
 This uses the `--interactive` machinery internally, but combining it
 with the `--interactive` option explicitly is generally not a good
-idea (see BUGS below).
+idea unless you know what you are doing (see BUGS below).
=20
=20
 --root::
@@ -614,9 +614,10 @@ case" recovery too!
=20
 BUGS
 ----
-The instruction sheet presented by `--preserve-merges --interactive`
-does not represent the topology of the revision graph.  Attempts to
-reorder it tend to produce counterintuitive results.
+The todo list presented by `--preserve-merges --interactive` does not
+represent the topology of the revision graph.  Editing commits and
+rewording their commit messages should work fine, but attempts to
+reorder commits tend to produce counterintuitive results.
=20
 For example, an attempt to rearrange
 ------------
--=20
1.7.1.246.g2fc1b.dirty
