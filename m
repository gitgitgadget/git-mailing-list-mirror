From: Jay Soffian <jaysoffian@gmail.com>
Subject: how to list commits on branch since last merge
Date: Tue, 8 Mar 2011 02:24:44 -0500
Message-ID: <AANLkTi=zW9hOhnddw6HsjQwV2qLf_R_qeNna+XeN6U6x@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Mar 08 08:25:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PwrIO-0002yO-5h
	for gcvg-git-2@lo.gmane.org; Tue, 08 Mar 2011 08:25:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751732Ab1CHHZW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Mar 2011 02:25:22 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:61556 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753168Ab1CHHZU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Mar 2011 02:25:20 -0500
Received: by iyb26 with SMTP id 26so4608270iyb.19
        for <git@vger.kernel.org>; Mon, 07 Mar 2011 23:25:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:from:date:message-id:subject:to
         :content-type;
        bh=F1rh/8GD5w4urpWRhy0lJs3l2NIJzedr0xwtZnuoI+g=;
        b=LZ5/zeXydEAg1Q5uFcWQ1tbE4KVVzr6WQW9FSVEL7BpYQWZGPatvBL7G/E3+8nByTN
         Io8W/uL+7OCouPlup0Kn4cA+MD0Rkmp9IF0o5mLt2FsCxaG3I+tRi6F3aPGc1f4ENp7f
         ReAIDZZ8rWo1Vfci8EdHprPChvg6Y9Of9iSQw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        b=tTyhjT5jUpdC43IsWfiVezRhYjB6iWrp03fqVAzOQbyFc70dOHnvrHL2FRyk5eR2N2
         +v5nVNPmOkvNm/rC9ifGXJ0zP7GHoRU/Rh/i5N8yjaApB2efYB34b+GtxvDx1x5Yoeh4
         PHLE0TTOD7iMeJFLdsqHNPz2jFUs77ODI3m7M=
Received: by 10.42.137.198 with SMTP id z6mr6094790ict.261.1299569114061; Mon,
 07 Mar 2011 23:25:14 -0800 (PST)
Received: by 10.231.34.7 with HTTP; Mon, 7 Mar 2011 23:24:44 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168634>

Given this history:

o---o---x---o---...    foo
 \       \
  o---o---m---o---...  bar

I want to list the commits on bar newer than merge m (the last merge
from foo). merge-base returns x.

I feel like I'm going to face-palm upon reply, but the only way I see
to do it is:

  $ git rev-list --ancestry-path $(git merge-base foo bar)..bar

Or by greping the output of rev-list --merges --parents foo..bar
looking for the merge base.

I must be missing something obvious, since this feels like it should
be a common operation. :-)

j.
