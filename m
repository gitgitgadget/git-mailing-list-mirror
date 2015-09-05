From: Junio C Hamano <gitster@pobox.com>
Subject: Re: More builtin git-am issues..
Date: Sat, 05 Sep 2015 09:01:15 -0700
Message-ID: <xmqqoahgdfec.fsf@gitster.mtv.corp.google.com>
References: <CA+55aFzN4SnenchxPScn61_apzitGAPtoYEd49iLZPxgK0KQGw@mail.gmail.com>
	<CA+55aFw2bnhSQYk4FaHfp4ED0Y611NWyQs05TMQtFj=2As1=nA@mail.gmail.com>
	<xmqqh9n9ele4.fsf@gitster.mtv.corp.google.com>
	<CA+55aFw-PObyj2boqpeA9DDcKeAuCGouT7Qd2Zw02+sxvd2CgA@mail.gmail.com>
	<xmqq613pek1b.fsf@gitster.mtv.corp.google.com>
	<CA+55aFw9BmBKEbibwVs+LuVQR2=PKt+hh5LAhdmVC-OkgBB3eg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Paul Tan <pyokagan@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Sep 05 18:01:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZYFu7-0007kg-C5
	for gcvg-git-2@plane.gmane.org; Sat, 05 Sep 2015 18:01:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752266AbbIEQBU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Sep 2015 12:01:20 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:35250 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752016AbbIEQBT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Sep 2015 12:01:19 -0400
Received: by pacfv12 with SMTP id fv12so53764439pac.2
        for <git@vger.kernel.org>; Sat, 05 Sep 2015 09:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=WVxxij+zQwnuUNNNKMT2J3g6AjlQ799JP/PBI8NK9tI=;
        b=ZRQlYAOV/ddyLV6ZEVGTMMMIPfWlGez74zWaKy+Scvsj0gaFVMjqb+PXvbkaGOW6+p
         Uqw17lF+EvIAEK9BWVlrbOUTfGgl3yMtGhrrH5naYHGRZtvc82/OGToCxg3ihbxRMCg3
         zkzmmuwnOnu1fg63+eclMAvj48GhGFnvTe64BakMBvdTZ4Ru5Npk707eynAClkpUL4V9
         UalcfYKEhYQXwYhbfQEvoAF1qVjVXDpKGAGipZe2uLER8bbZWlI7g8cWVFYvQ85A1TP4
         7vY+UkC0RwzO5xeyd6JJ8WcPLCLv/6DxSmLAIuBw7u6iUeiRTh0VDWNQqiA8IEBVX7Sl
         sfCQ==
X-Received: by 10.68.212.35 with SMTP id nh3mr22739150pbc.78.1441468878544;
        Sat, 05 Sep 2015 09:01:18 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:20fa:dab1:6d64:e4c9])
        by smtp.gmail.com with ESMTPSA id ff4sm6260132pab.2.2015.09.05.09.01.16
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Sat, 05 Sep 2015 09:01:16 -0700 (PDT)
In-Reply-To: <CA+55aFw9BmBKEbibwVs+LuVQR2=PKt+hh5LAhdmVC-OkgBB3eg@mail.gmail.com>
	(Linus Torvalds's message of "Fri, 4 Sep 2015 18:35:46 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277386>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> That said, the original "git am" rules actually seem to be rather
> straightforward: it's never an issue about "last block of text", and
> it's simply an issue of "is there a sign-ff _anywhere_ in the text".
>
> That simplicity has a certain appeal to me. I don't think it was
> necessarily written that way because it was "well designed" - I
> suspect it is more an issue of "easy to implement in a shell-script".

Guilty as pointed out.

> Four out of 119 emails may not be a big percentage, but it does mean
> that it's not horribly unusual either..

Sure.  Thanks for these examples.  I was aware that people do
strange things with the footer, but with the first example of [akpm]
comment at the very beginning alone, I wouldn't have guessed why
intermixing one-liner comments directly in the chain of
Signed-of-by: lines made any sense.  Call it lack of imagination,
but each sign-off optionally prefixed by a single-liner summary of
what change was done makes sense why people do want to use these
lines that way.
