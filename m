From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH v2 0/7] clarify 'git merge' documentation
Date: Sat, 23 Jan 2010 03:25:51 -0600
Message-ID: <20100123092551.GA7571@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Rast <trast@student.ethz.ch>, Petr Baudis <pasky@suse.cz>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 23 10:26:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NYcFl-0003p5-8r
	for gcvg-git-2@lo.gmane.org; Sat, 23 Jan 2010 10:26:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753624Ab0AWJZz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 23 Jan 2010 04:25:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752915Ab0AWJZz
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Jan 2010 04:25:55 -0500
Received: from mail-iw0-f186.google.com ([209.85.223.186]:38213 "EHLO
	mail-iw0-f186.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750770Ab0AWJZx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Jan 2010 04:25:53 -0500
Received: by iwn16 with SMTP id 16so815041iwn.33
        for <git@vger.kernel.org>; Sat, 23 Jan 2010 01:25:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:mime-version:content-type:content-disposition
         :content-transfer-encoding:user-agent;
        bh=XhPCC7O+Pta0ikZ0qXVIyoXxiKJVpjlGIGxoStIuaGI=;
        b=HW0hoGCyp3ZwnzYelbYv3ShN+bzfqAEuZnvMEWpBPHHHxvLnaGtXyTU4L09bo5WEva
         uGpBYOhIi2+baxztUpaoSGO1nKA8EWohtZKqkqDWd9uGJOwiNRSXeLB9hrYqglOPw3zl
         Zkg0nGlZ0eXemjA46LVwbO6Bh96BaOS7oj4dw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:content-transfer-encoding:user-agent;
        b=K3uQlDxUkYUg6dO+oyuIU44KcV3OZzGa0a5GD54yzFaiFGiPijqdnt0dWs/jv3SQDZ
         mTPO5scDMQvObGIc5b23s4kyIJ3jeMxla0bUZnT1wV30X7/RZBFDUz4SpKiCnxQduilO
         VSmyVjvR3/sSs4dF/9Yo+StTdlrukTM7wVX6A=
Received: by 10.231.154.77 with SMTP id n13mr3774502ibw.11.1264238752585;
        Sat, 23 Jan 2010 01:25:52 -0800 (PST)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 23sm2563244iwn.11.2010.01.23.01.25.51
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 23 Jan 2010 01:25:51 -0800 (PST)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137818>

=46or the previous round [1], I wrote something like this to clarify wh=
y
merging with dirty trees is safe.  I hope it also makes git-merge.1
more useful for other purposes.  I have not changed the warning in
question, which belongs to a different topic.

Patches 1-3 move some material towards the end of the 'merge' manual,
to make the manpage easier to read straight through.

Patch 4 adds a brief introduction for the reader who might not yet be
familiar with branching and merging.  I am especially interested in
feedback on this one.  My writing tends not to be as clear as I would
like.  Already some advice from Junio helped a great deal.

Patches 5-7 organize the material on how the merge works into short,
digestible pieces.  Patch 5 explains how a merge can abort without
doing anything, patch 6 the fast-forward merge, and patch 7 the true
merge, all from the point of view of what matters for the person
invoking =E2=80=98git merge=E2=80=99.  Patch 7 is basically rewritten u=
sing Thomas=E2=80=99s
advice.

The patches are against doc-style/for-next of Thomas=E2=80=99s repo at
git://repo.or.cz/git/trast .

The advice from last round was very helpful.  Apologies for taking so
long to respond to it.

Enjoy,
Jonathan Nieder (7):
  Documentation: merge: move configuration section to end
  Documentation: suggest `reset --merge` in How Merge Works section
  Documentation: merge: move merge strategy list to end
  Documentation: merge: add an overview
  Documentation: emphasize when git merge terminates early
  Documentation: merge: add a section about fast-forward
  Documentation: simplify How Merge Works

 Documentation/git-merge.txt |  164 ++++++++++++++++++++++++-----------=
--------
 1 files changed, 92 insertions(+), 72 deletions(-)

[1] http://thread.gmane.org/gmane.comp.version-control.git/136356/focus=
=3D136617
