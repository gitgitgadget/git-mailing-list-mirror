From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Specifying N revisions after the initial commit
Date: Tue, 22 Sep 2015 12:55:30 -0700
Message-ID: <xmqqpp1a2pql.fsf@gitster.mtv.corp.google.com>
References: <CA+5PVA40x8bxW63X+b77FDO8btRBaVOg=fq+ZyX=bdJ+uEm9gA@mail.gmail.com>
	<20150922214037.b6b48059f051fcd4060a5a85@domain007.com>
	<CA+5PVA6YWJizRjseeJ4EpRya0Mpyrv3DoNsB3=Gi=dOiAoDfHg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Konstantin Khomoutov <kostix+git@007spb.ru>,
	Git Mailing List <git@vger.kernel.org>
To: Josh Boyer <jwboyer@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 22 21:55:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZeTfH-0001eD-5r
	for gcvg-git-2@plane.gmane.org; Tue, 22 Sep 2015 21:55:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758251AbbIVTzn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Sep 2015 15:55:43 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:35847 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756639AbbIVTzm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Sep 2015 15:55:42 -0400
Received: by pablk4 with SMTP id lk4so2303394pab.3
        for <git@vger.kernel.org>; Tue, 22 Sep 2015 12:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=nQ+6qgfm/+DVPmNi9LsFdeEPdG3d6dzWZ3pIGp3Ck2I=;
        b=bV/ckaAULkbcs1l1Bt8iD7FxyLiPgqqm2IPqs3xkQSM7L4uJtgn3biaPRAmeL+bweQ
         V2mcyTCmceMgzUzU76bWibMQOhyuPYRarDopX/lMoHIy3cK0SxaWiPon33EukS87xeZg
         J3B99flur8jR7jw+x9fE4KkZ6lIe9oAj8Ru1r2x349FICTMBlA0Gh34A85wkE9SLm1xm
         ImSwvavgrD/vqbpm1jJB9z9d7s1yYqatcN/ZutAV9ucKbh3Y1qQlzu2FAsvpPp4Nk6cZ
         uMzgQ5hd83IyakjxVUQQWrYnllV2ugAYAT09dUSk+ohoPKFSXGnt4wMgPsrT9DeNTIfF
         u4ow==
X-Received: by 10.66.193.162 with SMTP id hp2mr32871619pac.108.1442951731425;
        Tue, 22 Sep 2015 12:55:31 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:fd7e:7071:2eda:9c63])
        by smtp.gmail.com with ESMTPSA id ip1sm3834228pbc.30.2015.09.22.12.55.30
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Tue, 22 Sep 2015 12:55:30 -0700 (PDT)
In-Reply-To: <CA+5PVA6YWJizRjseeJ4EpRya0Mpyrv3DoNsB3=Gi=dOiAoDfHg@mail.gmail.com>
	(Josh Boyer's message of "Tue, 22 Sep 2015 15:10:42 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278426>

Josh Boyer <jwboyer@gmail.com> writes:

> On Tue, Sep 22, 2015 at 2:40 PM, Konstantin Khomoutov
> ...
>> Hence, given any particular commit, you're able to trace all of its
>> ancestry, but the reverse is not possible.
>
> That makes sense.  I suppose I will have to resort to parsing output
> of git-rev-list or something.  Thanks for the reminder.

I think Konstantin explained why it fundamentally does not make
sense to ask "which one is the Nth one after the root".  I am not
sure how running rev-list and count its output would help, unless
you are now solving a different problem (perhaps "find all the ones
that are Nth after some root", which does have an answer).
