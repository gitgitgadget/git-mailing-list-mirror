From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: Why not git reset --hard <path>?
Date: Tue, 29 Sep 2015 00:06:41 -0700
Message-ID: <CA+P7+xrzmDHyseGaJFkyUGUi=Uep0LLhPdZDeo3NeBBmXJTZWw@mail.gmail.com>
References: <20150928203449.29024.qmail@ns.horizon.com> <xmqq612ucm3p.fsf@gitster.mtv.corp.google.com>
 <CA+P7+xoTHFL_KU+qBz1KwytxqNTxf1JkjXK7_Ej79uLLnCWD8g@mail.gmail.com> <xmqqvbaub5s4.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: George Spelvin <linux@horizon.com>, Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 29 09:07:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zgp0G-00053L-1K
	for gcvg-git-2@plane.gmane.org; Tue, 29 Sep 2015 09:07:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755467AbbI2HHE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Sep 2015 03:07:04 -0400
Received: from mail-io0-f173.google.com ([209.85.223.173]:33608 "EHLO
	mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755304AbbI2HHC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Sep 2015 03:07:02 -0400
Received: by iofh134 with SMTP id h134so898524iof.0
        for <git@vger.kernel.org>; Tue, 29 Sep 2015 00:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Yd4KfY1rag6sv+G8TQuWMkgoMz9LXMMT3r+zWCt/ZoA=;
        b=MmJurvfX6cijxF1lkQ3bA6zODpOZp2hXSZ+tktjKa1m3CEF5FNZh9slyVeGvP4xwj3
         0826oKtXGTjqFYvxa5s7hSd1JzaGF5w2I3BToJDxSkYhO/lHUtjesyVisHGc6yXkhYVp
         aAiVQvRAPsMRyBooRbmDJhRk6Z4BOOLb7eQlMEbelWa1/BAKiQPohjJTochWqoD63k4F
         a3auKuaoO0PDl63Wvgc4zr8SXYT+q3TwHRS5rlVvRweqOLUYNspbArMUKCpUHk4vI6qm
         HVBtJkBbWIYxg6FXKc6mVlxxs9aWittId0/73htIEkZSySuXpFRextjWqIdE5OZluoSt
         yE2Q==
X-Received: by 10.107.166.201 with SMTP id p192mr28597002ioe.0.1443510421181;
 Tue, 29 Sep 2015 00:07:01 -0700 (PDT)
Received: by 10.107.132.155 with HTTP; Tue, 29 Sep 2015 00:06:41 -0700 (PDT)
In-Reply-To: <xmqqvbaub5s4.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278815>

On Mon, Sep 28, 2015 at 2:19 PM, Junio C Hamano <gitster@pobox.com> wrote:
> I agree with you if we limit the scope to "reset --hard" that does
> not mention any commit on the command line (or says "HEAD").
>
> However, for things like:
>
>     $ git reset --hard HEAD^ Makefile
>     $ git reset --hard HEAD@{4.hours.ago} Makefile
>
> I do not think "reset --hard" is a good match.  Conceptually, you
> are grabbing what was stored in a given commit and checking that out
> to your current workspace (that is, the index and the working tree).
>

Agreed. I just get used to thinking about using it against HEAD. it's
just weird to me that something which sometimes switches branches is
also the thing to grab a version of a file.

reset hard really would be weird in this case, because you really
don't know if the user meant "rewind the history, but keep everything
*except* that listed file..

That makes sense now that I think about it. Thanks.

Regards,
Jake
