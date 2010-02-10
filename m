From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: git rebase -i and the reflog
Date: Wed, 10 Feb 2010 23:19:59 +0100
Message-ID: <fabb9a1e1002101419x40844a42s21108aaa849430c1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Feb 10 23:20:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NfKv9-0007wN-SZ
	for gcvg-git-2@lo.gmane.org; Wed, 10 Feb 2010 23:20:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756619Ab0BJWUV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Feb 2010 17:20:21 -0500
Received: from mail-pz0-f178.google.com ([209.85.222.178]:64931 "EHLO
	mail-pz0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756559Ab0BJWUT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Feb 2010 17:20:19 -0500
Received: by pzk8 with SMTP id 8so585836pzk.22
        for <git@vger.kernel.org>; Wed, 10 Feb 2010 14:20:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:from:date:message-id
         :subject:to:content-type;
        bh=qbNUS+v0jYgYP0VBkBanCGDk2Y+ONRkYKdO63XW0sLk=;
        b=XPNYoaWx5S1zDVZKFrrAuToAX7zF67NffXBmZlcTmRHVvUnc/5EnTxcJ+ppCELpq5g
         soMis2omKPgBN69oZWbJc1Ac03TKmmOwAx32i8hKbcHWePfIYrna4Ql7fnKMzaqT3fpX
         PjCjcO46qP6N7d7ZmCWbwh4XReTwWIDrwOPz0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        b=ibOvm0AjLSNdmYutwRHsvsKkF7Hbyrg8UkbW8SsWub6s/Sh4UqNs2njOkRkjSW2BML
         CS3uf7VWWiv4XIlTZH63rhZofj9g1wfXIpwBweme8hVOJaQ1sZIp4kugCxKbaAHve6RF
         W1aBsni/DyWvht6m40q7WoqOnWe11GS9ZxXgk=
Received: by 10.142.67.24 with SMTP id p24mr544128wfa.265.1265840419104; Wed, 
	10 Feb 2010 14:20:19 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139558>

Heya,

I use "git rebase -i" a lot, and as a result the output from 'git log
-g' and 'git reflog' is a tad messy. That is, it's (afaik) not
possible to check that after my rebasing did not mess things up using
something like 'git diff HEAD@{1}'. I could of course tag the old head
or something, but that's not the only problem, due to the clutter it's
hard to find genuine commits. What I want is a way to see HEAD's
movement _excluding_ any rebase activity. So if I change history from
A-o-B-C to A-o-B'-C', I want to see C and C' in the reflog, but not
B', since B' is often actually identical to B, the only reason that it
changed is that I did 'git rebase -i' on some far-back commit.

Is there an existing solution to this?

-- 
Cheers,

Sverre Rabbelier
