From: Luke Kenneth Casson Leighton <luke.leighton@gmail.com>
Subject: git pack/unpack over bittorrent - works!
Date: Wed, 1 Sep 2010 15:36:16 +0100
Message-ID: <AANLkTik-w6jWgrt_kwAk2uNGhF_=3tMEpTZs3nyF_zGA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Sep 01 16:36:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OqoQK-0005H8-BM
	for gcvg-git-2@lo.gmane.org; Wed, 01 Sep 2010 16:36:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755168Ab0IAOgS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Sep 2010 10:36:18 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:33073 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752634Ab0IAOgR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Sep 2010 10:36:17 -0400
Received: by pzk9 with SMTP id 9so2846950pzk.19
        for <git@vger.kernel.org>; Wed, 01 Sep 2010 07:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=NEuJRG91E4EDmONmf6Xe2hBppy3b69WW9yvkKTBJJIM=;
        b=pO2ZAPurPAuQc/DCw0/BftRMaantZZXcTAaHXvSFY/+6zsMAsll9VIxDnvZ+viiNWj
         SP5rq9DDp4moXQoVejQAxdsjdUf3ulHTtjeYMmslRF6PNO/0l4yo14P99iG1hoXuuhVy
         xbUx/WFMdjRwcf/WhLCjBYyn7CXoEChVzAyjU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=eT1do9Y+tvjnaECrOazLz5TVp8R2J7KZyzvF1AuAvZPzBwxAMI3KMbxYr86rtVlVgS
         MRTIZn5iM2F1oYBCKoO1MTneFQ0F9v9PYStjaNueOE6hiWnz5g0nQpzytICd8fdUPSJ1
         rl5lZcMpoZ0dNe5uhwDhS8j7gmz9Q0f6Y2oCg=
Received: by 10.114.38.6 with SMTP id l6mr5007834wal.132.1283351776186; Wed,
 01 Sep 2010 07:36:16 -0700 (PDT)
Received: by 10.220.98.14 with HTTP; Wed, 1 Sep 2010 07:36:16 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155045>

http://gitorious.org/python-libbittorrent/pybtlib

hurrah - success!  git fsck shows a "dangling commit"!

so, as a proof-of-concept, 400 lines of python code plus a bittorrent
library shows that it's possible to create a peer-to-peer distributed
version of "git fetch", by treating the pack objects as "files to be
shared".

as this code has only existed for less than three days, there are a
lot of loose ends.  such as the pack object files being cached
in-memory, and it being strictly speaking unnecessary to obtain
absolutely every single pack object from the git repository at
start-up time, but to optimise that to being "on-demand" requires some
ferreting around in the bittorrent library, etc. etc.

if anyone is interested in helping out, or knows of a way to get this
sponsored and completed, please speak up.  especially the sponsorship
bit because i am in a severely critical and ridiculous financial
situation and am in urgent and immediate need of money.

l.
