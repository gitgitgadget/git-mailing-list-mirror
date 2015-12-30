From: Andy Lutomirski <luto@kernel.org>
Subject: Feature request: git bisect merge to usable base
Date: Wed, 30 Dec 2015 02:40:12 -0800
Message-ID: <CALCETrUgsawpwkkjO_BpPHyOaH7NsJNU-4mF97a6NAxCMB5aUA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 30 11:40:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aEEBK-0006Se-4A
	for gcvg-git-2@plane.gmane.org; Wed, 30 Dec 2015 11:40:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754417AbbL3Kkf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Dec 2015 05:40:35 -0500
Received: from mail.kernel.org ([198.145.29.136]:36096 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754309AbbL3Kkd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Dec 2015 05:40:33 -0500
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 00A6F202EC
	for <git@vger.kernel.org>; Wed, 30 Dec 2015 10:40:33 +0000 (UTC)
Received: from mail-ob0-f170.google.com (mail-ob0-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id 5391E2027D
	for <git@vger.kernel.org>; Wed, 30 Dec 2015 10:40:32 +0000 (UTC)
Received: by mail-ob0-f170.google.com with SMTP id 18so268756594obc.2
        for <git@vger.kernel.org>; Wed, 30 Dec 2015 02:40:32 -0800 (PST)
X-Gm-Message-State: ALoCoQmJI3R7qsDGM4d/BX2BUd6XbZZrdOt5uaxxAXXqxzWejiNNxUuu810jmFWJjTNwgoQ5ecJ94bqdWT1WBVKYopFnMtO7Vw==
X-Received: by 10.182.171.105 with SMTP id at9mr43051929obc.49.1451472031737;
 Wed, 30 Dec 2015 02:40:31 -0800 (PST)
Received: by 10.202.102.231 with HTTP; Wed, 30 Dec 2015 02:40:12 -0800 (PST)
X-Gmail-Original-Message-ID: <CALCETrUgsawpwkkjO_BpPHyOaH7NsJNU-4mF97a6NAxCMB5aUA@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,UNPARSEABLE_RELAY
	autolearn=unavailable version=3.3.1
X-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on mail.kernel.org
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283174>

Hi-

I'm currently bisecting a Linux bug on my laptop.  The starting good
commit is v4.4-rc3 and the starting bad commit is v4.4-rc7.
Unfortunately, anything much older than v4.4-rc3 doesn't boot at all.

I'd like to say:

$ git bisect merge-to v4.4-rc3

or similar.  The effect would be that, rather than testing commits in
between the good and bad commits, it would test the result of merging
those commits with v4.4-rc3.

Obviously the syntax could be tweaked a lot, but I think the concept
could be quite handy.

Thanks,
Andy
