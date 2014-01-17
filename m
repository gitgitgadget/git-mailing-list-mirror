From: Roman Kagan <rkagan@mail.ru>
Subject: Re: [PATCH v2] git-svn: workaround for a bug in svn serf backend
Date: Fri, 17 Jan 2014 15:32:01 +0400
Message-ID: <CANiYKX4VhxZsuwKMfaMToner-+ipYmsFy_T6Bgxwj_a950PA3A@mail.gmail.com>
References: <20131226202805.GV20443@google.com>
	<1388131515-3015-1-git-send-email-rkagan@mail.ru>
	<20131227200708.GD20443@google.com>
	<20131227203443.GA9189@dcvr.yhbt.net>
	<7veh4yj5mm.fsf@alter.siamese.dyndns.org>
	<CANiYKX4fjYYRneqPxFDmpPg7e5ge9-hNktBvXVLQ=JxtM56tAQ@mail.gmail.com>
	<xmqq4n5qrume.fsf@gitster.dls.corp.google.com>
	<CANiYKX5aUYWV2Kt_yMmAxeC07SuNcs-tJEe8e2SY4p1NHBPKUA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Eric Wong <normalperson@yhbt.net>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Benjamin Pabst <benjamin.pabst85@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 17 12:32:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W47ei-0000qR-AO
	for gcvg-git-2@plane.gmane.org; Fri, 17 Jan 2014 12:32:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752068AbaAQLcE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Jan 2014 06:32:04 -0500
Received: from mail-qc0-f181.google.com ([209.85.216.181]:42249 "EHLO
	mail-qc0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751274AbaAQLcC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jan 2014 06:32:02 -0500
Received: by mail-qc0-f181.google.com with SMTP id e9so3492959qcy.12
        for <git@vger.kernel.org>; Fri, 17 Jan 2014 03:32:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=y67buu1cEPt3pG0YeNAKrcof7fjkQlawU9UpHPBudFM=;
        b=LhgpVL/zGp6vmziIiEzwlg5V5nFpiIAIpctchtk9F+pirVl2qXZ1P/gwLPwsaRBnGA
         kq8nfW/qPbAxxE8k5lm/vkINCvQ9rlumlSYojzu2qVDF0aJbZtRQNKlKDIiLiO5Y4le4
         hzYiWB+wvGP9k+Qy56fodJUeNomKE1ovJ7Hzy3T7g6fC1JLvT0+XHl5RdlKFoCX1QU02
         TBKYBw9g6/u4BV48gqRc+lCw1v0cxrOcr2+/nKlSr0kDv951zR07hZ2kqA/mmy5HQBJd
         5Ldd12tEUFA2EQaXeN8jA665AdnNw0hyP58k98ei9HQp6DIFBxYnlFbMGdezrvT+Oq8J
         ye2g==
X-Received: by 10.140.94.44 with SMTP id f41mr2097426qge.18.1389958321655;
 Fri, 17 Jan 2014 03:32:01 -0800 (PST)
Received: by 10.224.165.131 with HTTP; Fri, 17 Jan 2014 03:32:01 -0800 (PST)
In-Reply-To: <CANiYKX5aUYWV2Kt_yMmAxeC07SuNcs-tJEe8e2SY4p1NHBPKUA@mail.gmail.com>
X-Google-Sender-Auth: _VRioqFfrcOc7lexOujlnUZEGMc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240594>

2013/12/31 Roman Kagan <rkagan@mail.ru>:
> 2013/12/30 Junio C Hamano <gitster@pobox.com>:
>> Roman Kagan <rkagan@mail.ru> writes:
>>> I'd like to note that it's IMO worth including in the 'maint' branch
>>> as it's a crasher.  Especially so since the real fix has been merged
>>> in the subversion upstream and nominated for 1.8 branch, so the
>>> workaround may soon lose its relevance.
>>
>> I do not quite get this part, though.
>>
>> If they refused to fix it for real, it would make it likely that
>> this workaround will stay relevant for a long time, in which case it
>> would be worth cherry-picking to an older maintenance track.  But if
>> this workaround is expected to lose its relevance shortly, I see it
>> as one less reason to cherry-pick it to an older maintenance track.
>>
>> Confused...
>
> I thought it was exactly the other way around.  By the time the next
> feature release reaches users, chances are they'd already have
> subversion with the fix.  OTOH the workaround would benefit those who
> get their maintenance release of git (e.g. through their Linux distro
> update) before they get their maintenance release of subversion.

So this actually happened: 1.8.5.3 is out, and some distributions are
shipping it (Arch, Debian), but the workaround didn't make it there.

Could you please consider including it in 'maint', so that 1.8.5.4
brings them a working combination of git and subversion?

Roman.
