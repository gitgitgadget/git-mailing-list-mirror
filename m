From: Miles Bader <miles@gnu.org>
Subject: Re: [RFC] deprecating and eventually removing "git relink"?
Date: Mon, 14 Nov 2011 15:06:37 +0900
Message-ID: <buomxbzutjm.fsf@dhlpc061.dev.necel.com>
References: <7v4ny7mtbx.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 14 07:06:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RPpgt-0002fy-Bm
	for gcvg-git-2@lo.gmane.org; Mon, 14 Nov 2011 07:06:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751693Ab1KNGGn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Nov 2011 01:06:43 -0500
Received: from relmlor3.renesas.com ([210.160.252.173]:39170 "EHLO
	relmlor3.renesas.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751309Ab1KNGGm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Nov 2011 01:06:42 -0500
Received: from relmlir1.idc.renesas.com ([10.200.68.151])
 by relmlor3.idc.renesas.com ( SJSMS)
 with ESMTP id <0LUM00349ZN57T70@relmlor3.idc.renesas.com> for
 git@vger.kernel.org; Mon, 14 Nov 2011 15:06:41 +0900 (JST)
Received: from relmlac4.idc.renesas.com ([10.200.69.24])
 by relmlir1.idc.renesas.com (SJSMS)
 with ESMTP id <0LUM008RJZN4NKE0@relmlir1.idc.renesas.com> for
 git@vger.kernel.org; Mon, 14 Nov 2011 15:06:41 +0900 (JST)
Received: by relmlac4.idc.renesas.com (Postfix, from userid 0)
	id EEA304807B; Mon, 14 Nov 2011 15:06:40 +0900 (JST)
Received: from relmlac4.idc.renesas.com (localhost [127.0.0.1])
	by relmlac4.idc.renesas.com (Postfix) with ESMTP id E8A3048070; Mon,
 14 Nov 2011 15:06:40 +0900 (JST)
Received: from relmlii1.idc.renesas.com [10.200.68.65]	by
 relmlac4.idc.renesas.com with ESMTP id RAA14665; Mon,
 14 Nov 2011 15:06:40 +0900
X-IronPort-AV: E=Sophos;i="4.69,506,1315148400";   d="scan'208";a="54602139"
Received: from unknown (HELO relay41.aps.necel.com) ([10.29.19.9])
 by relmlii1.idc.renesas.com with ESMTP; Mon, 14 Nov 2011 15:06:40 +0900
Received: from dhlpc061 (dhlpc061.dev.necel.com [10.114.96.242])
	by relay41.aps.necel.com (8.14.4+Sun/8.14.4) with ESMTP id pAE66dII014861;
 Mon, 14 Nov 2011 15:06:39 +0900 (JST)
Received: by dhlpc061 (Postfix, from userid 31295)	id 7500252E245; Mon,
 14 Nov 2011 15:06:38 +0900 (JST)
System-Type: x86_64-unknown-linux-gnu
Blat: Foop
In-reply-to: <7v4ny7mtbx.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185365>

Junio C Hamano <gitster@pobox.com> writes:
>  (2) allowing two repositories that started independently to share objects
>      using the alternates mechanism after the fact.

Can they not already?

I mean, it works great right now to do:

  cd $REP2
  echo $REP1/.git/objects > .git/objects/info/alternates
  git gc

Do you mean a more elaborate UI that does this nicely...? or something
else?

It might be nice to have a mechanism where new objects would update
the _alternate_ rather than the object-store in the tree where the
command was run... then you could easily have a bunch of trees using a
central object store without needing to update the central store
occasionally by hand (and do gc in its "clients")...

-Miles

-- 
"Most attacks seem to take place at night, during a rainstorm, uphill,
 where four map sheets join."   -- Anon. British Officer in WW I
