From: Roman Kagan <rkagan@mail.ru>
Subject: Re: [PATCH v2] git-svn: workaround for a bug in svn serf backend
Date: Tue, 31 Dec 2013 11:20:28 +0400
Message-ID: <CANiYKX5aUYWV2Kt_yMmAxeC07SuNcs-tJEe8e2SY4p1NHBPKUA@mail.gmail.com>
References: <20131226202805.GV20443@google.com>
	<1388131515-3015-1-git-send-email-rkagan@mail.ru>
	<20131227200708.GD20443@google.com>
	<20131227203443.GA9189@dcvr.yhbt.net>
	<7veh4yj5mm.fsf@alter.siamese.dyndns.org>
	<CANiYKX4fjYYRneqPxFDmpPg7e5ge9-hNktBvXVLQ=JxtM56tAQ@mail.gmail.com>
	<xmqq4n5qrume.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Eric Wong <normalperson@yhbt.net>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Benjamin Pabst <benjamin.pabst85@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 31 08:20:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VxtdA-0000qq-CF
	for gcvg-git-2@plane.gmane.org; Tue, 31 Dec 2013 08:20:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751830Ab3LaHUa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Dec 2013 02:20:30 -0500
Received: from mail-qc0-f171.google.com ([209.85.216.171]:65359 "EHLO
	mail-qc0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751757Ab3LaHU3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Dec 2013 02:20:29 -0500
Received: by mail-qc0-f171.google.com with SMTP id c9so11541002qcz.16
        for <git@vger.kernel.org>; Mon, 30 Dec 2013 23:20:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=Q0C3B9BO7DbN9M5ndbyuazR34fvsMDAt5X1rPqSRn3k=;
        b=LM3c6nt4nBg7Nq5C1o3s/cu6ZQyST7bdVT0hwEI010HzkfEsRoWJkiXLDDwNwXxFGp
         fLEUyWAqraCsi+DgK3Bww2f8svZoi0VKu4tbEsvWX4EU+S03LxdMdK4gyqVQPC6XINLf
         rmvVNR466p3QwHiIZyBcjmAH8ReB0Y68vFITlBEDG+iGmepTSeQ1xKIfKTbJ7cOfxNjY
         fk8/LdlsjfHO+WyZWDV0p422T886MGnP+uiOL1jxyQkRvUc9xz6RcJY1RxhPm+6bj7W1
         PwprMiaS9dXPE/D86cYps7CBVVtH0crC1zAyej3b9xSmn1O331c1Z3+is7XZdhkshuWQ
         Mh1Q==
X-Received: by 10.49.84.195 with SMTP id b3mr118086762qez.32.1388474428702;
 Mon, 30 Dec 2013 23:20:28 -0800 (PST)
Received: by 10.224.98.146 with HTTP; Mon, 30 Dec 2013 23:20:28 -0800 (PST)
In-Reply-To: <xmqq4n5qrume.fsf@gitster.dls.corp.google.com>
X-Google-Sender-Auth: pzYnvl2ESPOT9T8hiOwxBqF4An0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239833>

2013/12/30 Junio C Hamano <gitster@pobox.com>:
> Roman Kagan <rkagan@mail.ru> writes:
>> I'd like to note that it's IMO worth including in the 'maint' branch
>> as it's a crasher.  Especially so since the real fix has been merged
>> in the subversion upstream and nominated for 1.8 branch, so the
>> workaround may soon lose its relevance.
>
> I do not quite get this part, though.
>
> If they refused to fix it for real, it would make it likely that
> this workaround will stay relevant for a long time, in which case it
> would be worth cherry-picking to an older maintenance track.  But if
> this workaround is expected to lose its relevance shortly, I see it
> as one less reason to cherry-pick it to an older maintenance track.
>
> Confused...

I thought it was exactly the other way around.  By the time the next
feature release reaches users, chances are they'd already have
subversion with the fix.  OTOH the workaround would benefit those who
get their maintenance release of git (e.g. through their Linux distro
update) before they get their maintenance release of subversion.

Documentation/SubmittingPatches also suggests to submit bugfixes
against 'maint'.

But I might have got it wrong...

Roman.
