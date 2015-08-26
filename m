From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git's inconsistent command line options
Date: Wed, 26 Aug 2015 13:48:54 -0700
Message-ID: <xmqq1tep3he1.fsf@gitster.dls.corp.google.com>
References: <mrh7ck$r0g$1@ger.gmane.org>
	<CAPc5daUdVQSAhrig046qGopVuxCDagZg3v9bwXOaC3SvC2MRnw@mail.gmail.com>
	<CA+P7+xrYugueYYrrJV0pduAHCg7CLknE_0QYcU8mO6idntz=VA@mail.gmail.com>
	<CAGZ79kZ6KK0qVtzrxmmsBQqmz-dgamC4f6W0zVTQLcuYi==0fw@mail.gmail.com>
	<xmqqa8tfvsr9.fsf@gitster.dls.corp.google.com>
	<CAE1pOi3e8KS9x5yD7CZLESvhXy1oXmQEgUnEFjww7L6JOdZ1Jg@mail.gmail.com>
	<xmqqio822atc.fsf@gitster.dls.corp.google.com>
	<CA+P7+xoV=NZvcUyqbdOpjcD1ykrpU7zrWB4JDVMSdBVC7EHEgw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Hilco Wijbenga <hilco.wijbenga@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Graeme Geldenhuys <graemeg@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jacob Keller <jacob.keller@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 26 22:49:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZUhcz-0000q5-4l
	for gcvg-git-2@plane.gmane.org; Wed, 26 Aug 2015 22:49:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752527AbbHZUs5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Aug 2015 16:48:57 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:35056 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752089AbbHZUs4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Aug 2015 16:48:56 -0400
Received: by pacdd16 with SMTP id dd16so171618621pac.2
        for <git@vger.kernel.org>; Wed, 26 Aug 2015 13:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=A2Zs+VmlSjCTQrnh1Fw9KVCg2AWl7dGfwrIwa3BqcJw=;
        b=RcScwOdiXqKYdvFaIpLHcs9UKUBmoy2dJ/4w415nqt6hhDpDQqh0f0pLYcurg/mR//
         kCLOt2ka/9rO6XmDj6+RJUDCER10HVn74WBTm087cKUtcfOBwrl5KpR/RmxFwnR/utLr
         tBD8Pfyvqi73JoQLRUBjyqGF/41pNRDZbo55oMbw6P4P6Q+c/XSTBHdHS0vdpRsnWlw7
         JPl9fQ4ZLBSOwSlQKDFC8M6bVSgg4Oos/tx8BmkFEevgXHsKXHt2bzDj2oK/YjT/dVTN
         StgIrICLXu/9r4t+1ch8UtR/IRyPy+RIfBRAYFpfxxLdHb7ukJK8NeHCbikiBzpkfD5V
         18og==
X-Received: by 10.68.212.35 with SMTP id nh3mr896319pbc.78.1440622135974;
        Wed, 26 Aug 2015 13:48:55 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:ac9b:ef8c:b4db:d257])
        by smtp.gmail.com with ESMTPSA id kj8sm2615132pab.2.2015.08.26.13.48.55
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Wed, 26 Aug 2015 13:48:55 -0700 (PDT)
In-Reply-To: <CA+P7+xoV=NZvcUyqbdOpjcD1ykrpU7zrWB4JDVMSdBVC7EHEgw@mail.gmail.com>
	(Jacob Keller's message of "Wed, 26 Aug 2015 11:10:42 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276638>

Jacob Keller <jacob.keller@gmail.com> writes:

> On Wed, Aug 26, 2015 at 10:56 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> But notice that I said "if you really want to".  I personally think
>> it is a road to madness.
>
> Agreed. I don't believe in command line API here. I think we'd need a
> better solution.
>
> My gut says: Live with the warts on old commands and try to make
> people use command words for new commands.

A transition to make everybody to use subsubcommands (thereby
changing what "git tag delete master" means) is impossible in
practice.  On the other hand, a transition to make everybody use
command mode options (thereby allowing "git worktree list" to be
also spelled as "git worktree --list") _is_ possible.

Has anybody created a handy catalog of Git commands with subcommands
and command mode options?  If we see such a list and replace the
column of subcommands with command mode options, we might find that
such a "command mode option only" world a pleasant future for us to
live in, or an unpleasant one that we have to keep typing two extra
dashes all the time.  I cannot tell offhand.
