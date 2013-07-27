From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] commit: correct advice about aborting a cherry-pick
Date: Sat, 27 Jul 2013 13:49:42 +0530
Message-ID: <CALkWK0m7iypFRHaW-Wt4GQBGh0Kypss7FE8MxPGYU-sG86Dfsg@mail.gmail.com>
References: <1374862320-22637-1-git-send-email-artagnon@gmail.com>
 <20130726191631.GD29799@sigill.intra.peff.net> <CALkWK0=qYF=r+Ocb1Z1E=Oteau=AAXR7wnKakt-8Cejwz6Usrg@mail.gmail.com>
 <20130726212438.GA1388@sigill.intra.peff.net> <20130726213705.GJ14690@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 27 10:20:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V2zjt-00018B-I5
	for gcvg-git-2@plane.gmane.org; Sat, 27 Jul 2013 10:20:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750898Ab3G0IU2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Jul 2013 04:20:28 -0400
Received: from mail-ob0-f178.google.com ([209.85.214.178]:63559 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750862Ab3G0IUZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Jul 2013 04:20:25 -0400
Received: by mail-ob0-f178.google.com with SMTP id fb19so6195101obc.9
        for <git@vger.kernel.org>; Sat, 27 Jul 2013 01:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=KEheZHHcA7/4hC12XPvzVHA4JkaqZ6PGICWxDHD5ttk=;
        b=WBXnVWx8LF4MI89YdYFr5bsid6vMqO0dS7xy395lWO0U0CKSxeMd7Ff1VVoAQsnGke
         Y33NzbmDILgKRfHsw8/Esq5HXTD9Ckyl9A+11uu9jkQqyV2zoE38JDHcAR6bej//pXNZ
         byXy3NDFv+kqEMJ5unu8gYId+xQPkS+o3FmONknDHoGXeiYRvD76wxEZ0wrgr4gFzc7b
         zE5SOYYoPBx2IIt03JZzeUoD603e9khF+7RQA0X52QFgsvhdfJqvV5ZMzOalbX7Sq8s3
         cvoaDu/A2FGh0hL/SLVg23DuuygxQJ9NTmvcTLRV88+q8/GBPcT6tAvSZNFvKkr2rfVf
         UgCg==
X-Received: by 10.42.76.5 with SMTP id c5mr21019441ick.91.1374913223809; Sat,
 27 Jul 2013 01:20:23 -0700 (PDT)
Received: by 10.64.37.130 with HTTP; Sat, 27 Jul 2013 01:19:42 -0700 (PDT)
In-Reply-To: <20130726213705.GJ14690@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231228>

Jonathan Nieder wrote:
>> Your patch is just swapping out "git reset" for "cherry-pick --abort",
>> so I think that is a good improvement in the meantime.
>
> Um, wasn't the idea of the original message that you can run "git
> reset" and then "git cherry-pick --continue"?

No, and I don't know where you got that idea.  Certainly not by
reading the history.

37f7a85 (Teach commit about CHERRY_PICK_HEAD, 2011-02-19) introduced
that string.  This happened before I introduced cherry-pick --continue
in 5a5d80f (revert: Introduce --continue to continue the operation,
2011-08-04).

A proper solution to the problem would involve polishing sequencer.c,
and probably getting --skip-empty so it behaves more like rebase.  In
case you missed it, one person already did that work and posted the
code to the list [1].

[1]: http://article.gmane.org/gmane.comp.version-control.git/226982
