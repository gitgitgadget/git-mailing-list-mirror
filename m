From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] notes: Allow treeish expressions as notes ref
Date: Mon, 13 Jul 2015 14:15:54 -0700
Message-ID: <xmqqio9nzrlh.fsf@gitster.dls.corp.google.com>
References: <CALKQrgdGJy6vtBRL413bbSHSi+=KTh4Q98hpbgg29j4J191=bA@mail.gmail.com>
	<1436517551-12172-1-git-send-email-mh@glandium.org>
	<xmqqzj30yq03.fsf@gitster.dls.corp.google.com>
	<20150713205304.GA26911@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Mon Jul 13 23:16:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZEl54-0002WB-K9
	for gcvg-git-2@plane.gmane.org; Mon, 13 Jul 2015 23:16:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752117AbbGMVP5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jul 2015 17:15:57 -0400
Received: from mail-ig0-f181.google.com ([209.85.213.181]:36478 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751892AbbGMVP4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jul 2015 17:15:56 -0400
Received: by igbij6 with SMTP id ij6so31903389igb.1
        for <git@vger.kernel.org>; Mon, 13 Jul 2015 14:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=uhWgCfX0krWvVtMdtwzfsHmcjkMbtP7CaHm0NItJCdg=;
        b=wbSjM5wOEOciBkn8Ae3Ze/Ig+t3WYW6R7pI5zNNH9lGxNBf1HLFNuVg5Wz/U4Nl29U
         GjkIiOI9qLUWtwwBF7rtk6RA5FAkEiWxzZyIYecs+VLX+p+pF2L628E6/GkR5tp3Mceu
         Lsl//1ofyzyYMFCLNs4SzHWaJX7KM/ydQDQmvgfwGlETQyHxmVVqal+KW/jFGt84E1lA
         Z/0P2Mzhw6VdGEi5W9CFmTX+471quBzPBpJeXB5JBotQiWpH9/+UGoqpM81SGjo8v1l0
         yRDFQtB4Urlqa6gA75s1jtFrMDPAMTXb9TBMHzzeMwV+Vm6S684/xNWKRWW3RxWSJRy+
         mb1g==
X-Received: by 10.50.18.43 with SMTP id t11mr15237862igd.25.1436822155762;
        Mon, 13 Jul 2015 14:15:55 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:4d10:ec6a:e89:91cb])
        by smtp.gmail.com with ESMTPSA id rs4sm6465715igb.13.2015.07.13.14.15.54
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 13 Jul 2015 14:15:55 -0700 (PDT)
In-Reply-To: <20150713205304.GA26911@glandium.org> (Mike Hommey's message of
	"Tue, 14 Jul 2015 05:53:04 +0900")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273928>

Mike Hommey <mh@glandium.org> writes:

>>  - Make sure that we show "there is no such tree-ish, no way to look
>>    up any note to any commit from there" and "I understood the tree
>>    you gave me, but there is no note for that commit" differently.
>
> How would you reconcile that with the usual "there are only a couple
> commits with a note in the hundreds you make me display"?

I am talking about the difference between "a tree exists (which may
lack notes for a given commit)" and "a tree does not even exist in
the first place".  This patch removed "a tree exists but that is not
a ref so we silently ignore", but I do not know if that change alone
covers everything---do you?

>>  - Decide if we want to "fail" the operation when the notes tree
>>    given by the user is not even a tree-ish or just "warn" and keep
>>    going.  And do so consistently.
>
> Is this something you want to be figured before merging this patch?

Depends on the definition of 'merging'.  I queued this one on 'pu',
and have no intention to merge it down to 'master' by the end of
this month; in the meantime either incremental or replacement
refinement can certainly address that inconsistency I'd hope ;-)

Thanks.
