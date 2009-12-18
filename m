From: Eugene Sajine <euguess@gmail.com>
Subject: repo corruption - Egit's fault?
Date: Fri, 18 Dec 2009 13:06:49 -0500
Message-ID: <76c5b8580912181006p2aef9d2fj95bb4c8456d965b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Dec 18 19:06:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NLhE9-0001bI-AA
	for gcvg-git-2@lo.gmane.org; Fri, 18 Dec 2009 19:06:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932312AbZLRSGv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 18 Dec 2009 13:06:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932265AbZLRSGv
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Dec 2009 13:06:51 -0500
Received: from mail-iw0-f171.google.com ([209.85.223.171]:59743 "EHLO
	mail-iw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932264AbZLRSGu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Dec 2009 13:06:50 -0500
Received: by iwn1 with SMTP id 1so2331323iwn.33
        for <git@vger.kernel.org>; Fri, 18 Dec 2009 10:06:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=RRhw6RJ7ejHfDhyFC/wI+ZR9bmM2Fwsn7I9rO2YY7cs=;
        b=R203VQppxm3AN1epBJhHPOwRsyp0AsMcVzhum+YCyOHmZ+n3bkrN5kUzGO+9GN/zj6
         S5wp3vMXZF7AIdn4cI2FAuJViLylxHr3fD075WsDTpTr2GgDn/X32qOkaW2rl37WVXAW
         TZMNdM+qplhZE8XC0Is4yF9QwPPJ8wmtsvSaM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=oEZBZDtvNjGs4SKKFmBt0xYxqruxRDOTn/2mTBLmMbF3PH5MwBBuwRfqc/exYuYjJ7
         dDkhA35YP9YIrNT7pfRjQDJ7/9ZF0sC0wdZwf42Avv89uBqiRSj4V1VU1S4gEYhnJ03F
         lMRYz7QNynWX3fGCKVIcTwaagu5UI3MpfIr/Q=
Received: by 10.231.61.195 with SMTP id u3mr435368ibh.12.1261159609848; Fri, 
	18 Dec 2009 10:06:49 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135422>

Hi,

We have imported a project from CVS. Then created a bare repo and
placed on the central server. From the server repos are served via git
protocol for push and pull operations (no SSH is involved for intranet
set up)
After this operations there were several extensive changes made (3
commits but they were pretty big) in development branch which were
then pushed to the server. So the branch was pushed too.
All changes and commits and pushes were performed under eclipse 3.5
using Egit plugin v0.5.

After it I could not clone this repo from the server as it was giving
me an error like this (I will shorten it up a bit using =E2=80=9C=E2=80=
=A6=E2=80=9D as I have
no way to copy paste):

$git clone git://server/repo.git
Initialized empty git=E2=80=A6
remote:counting=E2=80=A6done
remote:compressing=E2=80=A6done
remote: aborting due to possible repository corruption on the remote si=
de.
Receiving object: 100% =E2=80=A6done
Resolving deltas: 100% =E2=80=A6done
error: waitpid (async) failed
fatal: error in sideband demultiplexer (I know right words to curse now=
;))

When I=E2=80=99m looking at the bare repo in CGit =C2=A0it shows me =C2=
=A0Bad object:
and object SHA-1 instead of =C2=A0the tree.

As the only difference between this project and about 30 others was
that there was an additional branch pushed via Egit I suspect that
this is what screwed up things, but I =E2=80=98m not sure=E2=80=A6 I=E2=
=80=99m in progress of
testing it I don=E2=80=99t know if I will be able to reproduce.

Please, advise if this can be fixed and which options I have if it
will happen again (how to properly and quickly restore bare repo)

Thanks,
Eugene
