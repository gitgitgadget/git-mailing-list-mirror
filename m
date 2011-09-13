From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH/RFC] bash: add --word-diff option to diff auto-completion
Date: Tue, 13 Sep 2011 14:14:48 -0500
Message-ID: <20110913191448.GC14917@elie>
References: <4E6F720A.3020103@yahoo.com.br>
 <20110913165847.GB11076@elie>
 <4E6FA541.7000100@yahoo.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Rodrigo Rosenfeld Rosas <lbocseg@yahoo.com.br>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Tue Sep 13 21:15:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R3YRf-00020l-1u
	for gcvg-git-2@lo.gmane.org; Tue, 13 Sep 2011 21:14:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932373Ab1IMTOy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 13 Sep 2011 15:14:54 -0400
Received: from mail-yi0-f46.google.com ([209.85.218.46]:39103 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932328Ab1IMTOx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Sep 2011 15:14:53 -0400
Received: by yie30 with SMTP id 30so749630yie.19
        for <git@vger.kernel.org>; Tue, 13 Sep 2011 12:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=GWQGhcRWsvJXzISnsWrvWaFWVVDJJYeI2raus6cnjYY=;
        b=o6fdyRUdw2M4l9OvRPUGgfT6KJY6p26fsPd1I0GfYYVpVKJ5U3Ss6MaRD5smVEqH16
         QtpqdI3RNS17yBpVJIDxZc2FridGrGxA2KMnHYJGJa/5Ej3nMGTxb6/GWYE63q/6zw5w
         QEHKLBVSF8ykjsdEh0fyg7629+5NoFndK7KWM=
Received: by 10.150.47.17 with SMTP id u17mr1359845ybu.32.1315941292948;
        Tue, 13 Sep 2011 12:14:52 -0700 (PDT)
Received: from elie (99-120-124-35.lightspeed.cicril.sbcglobal.net [99.120.124.35])
        by mx.google.com with ESMTPS id u13sm3874502anf.14.2011.09.13.12.14.51
        (version=SSLv3 cipher=OTHER);
        Tue, 13 Sep 2011 12:14:52 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4E6FA541.7000100@yahoo.com.br>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181303>

=46rom: Rodrigo Rosenfeld Rosas <rr.rosas@gmail.com>
Date: Tue, 13 Sep 2011 15:24:38 -0300

Add "--word-diff" to diff completion, since this is a common
desired option when looking at diffs.

Signed-off-by: Rodrigo Rosenfeld Rosas <rr.rosas@gmail.com>
---
Hi G=C3=A1bor,

Here's a patch.  What do you think?

I was thinking it would be nice to complete --word-diff-regex, too,
and to be able to do

	git diff --color-words=3D<TAB>
	git diff --word-diff=3D<TAB>

but I couldn't find any examples of the latter to crib from, so I've
left the patch unmangled except for stealing a patch description from
a separate email.

Rodrigo Rosenfeld Rosas wrote:

> I use Thunderbird, but couldn't find all options as instructed in 'gi=
t help
> format-patch'.

Indeed, sending patches unmangled seems to be a common difficult step
when starting to contribute to projects like linux and git.  I wonder
if it would make sense to include some sort of
patch-sending-reviewing-tweaking-and-receiving tutorial to point to in
the documentation.

Thanks for keeping the completion code in good shape.
Jonathan

 contrib/completion/git-completion.bash |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index 8648a36..f4aaffe 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1300,7 +1300,7 @@ _git_describe ()
=20
 __git_diff_common_options=3D"--stat --numstat --shortstat --summary
 			--patch-with-stat --name-only --name-status --color
-			--no-color --color-words --no-renames --check
+			--no-color --color-words --word-diff --no-renames --check
 			--full-index --binary --abbrev --diff-filter=3D
 			--find-copies-harder
 			--text --ignore-space-at-eol --ignore-space-change
--=20
1.7.5.4
