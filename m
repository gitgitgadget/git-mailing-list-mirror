From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 1/3] pretty: support "mboxrd" output format
Date: Fri, 3 Jun 2016 20:19:07 -0400
Message-ID: <CAPig+cQ7y7J02+PVtdJywGEudOGXsy1jgadvVwBg5creiUv6zA@mail.gmail.com>
References: <20160530232142.21098-1-e@80x24.org> <20160530232142.21098-2-e@80x24.org>
 <CAPig+cQrSJe03_RtSyf5KO2vE3Rri7t70-he8SXA9Y4oBYY_Ww@mail.gmail.com>
 <20160531074506.GA8911@dcvr.yhbt.net> <CAPig+cQrQfxWrGhpvtb-GKYfK0tMLsx9JJ+eWRRx00F8mNXrLg@mail.gmail.com>
 <20160531182932.GA27021@dcvr.yhbt.net> <20160602075125.GA19551@dcvr.yhbt.net>
 <CAPig+cTLVXJBn00aco0vC9oFvZuchTgtNXtGGjpLPx1LwRZz4Q@mail.gmail.com>
 <xmqqlh2loq6p.fsf@gitster.mtv.corp.google.com> <CAPig+cQXA3mgYC3rCTx2h93rB6djdKvYJ+oCXUP24-xk2PqW=Q@mail.gmail.com>
 <xmqqzir1zvo2.fsf@gitster.mtv.corp.google.com> <CAPig+cTQkEb6K95aeJ9vNyJ=S+8x+JnCQAYSEzydXKzbq-+Yyg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Eric Wong <e@80x24.org>, Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 04 02:23:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8zJA-0003Qv-3l
	for gcvg-git-2@plane.gmane.org; Sat, 04 Jun 2016 02:19:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751228AbcFDATL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jun 2016 20:19:11 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:34648 "EHLO
	mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751195AbcFDATJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jun 2016 20:19:09 -0400
Received: by mail-io0-f196.google.com with SMTP id l9so12905473ioe.1
        for <git@vger.kernel.org>; Fri, 03 Jun 2016 17:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=0Jga9x84fsX/BDOqFpPDyzTAZRTjodJeNVUz3ZU7Npg=;
        b=dqFbjqjFjlfeXNUNW4QfdOi7zT0QcvxzMY7QZkDcIljnOY5JTmDyiJB4qVhGWXWUiJ
         fdg2XrWKPId33bITGapRrUg/dI9c1Qe70iihOMAibQI1epD9eW53IBGTyh/b/B5hy8c+
         VR5BYnqZTmtuqA937x28wNcfh4R/azZ0gt6TLqi2ljuDbS8lswlK/IQcF/DnS5Tt9U8K
         T10ZpiYT2w1dnGm+1FPh1FwCeKI+/3kcZI+dEo4aSw+hNyhUewjqdRMpuoEA/ud49nIu
         Wy0mGftzuo2wIwF3LrXz0e86mdF69SrnkDK/mdRyQp3rFKFxj5vNUb4iJCORuAyS29xw
         xKUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=0Jga9x84fsX/BDOqFpPDyzTAZRTjodJeNVUz3ZU7Npg=;
        b=ln2LqFfnKBdX6RrZH9SPRcPN3HUdoD6es/XVtxqV9WyK/N2eMWGUarSDR4YRT+nr2/
         Zi7KhE7uAHDIUwgM0jZSkbC+wFtBbDP8SmncfoL05MUZ3Xks3t7eXx/dS7ssVif9SorE
         p7zFvulvXgSPMzlG8ERvzVcm03s/MwYjJUCQ0/04xjxzNvhBGo4bL+CqrubEqe43DEkm
         tClc+w4kG1LhMueEFz/nXVwxGSDt91cLA9Q1xL4BvDC41MYNF+Ejdwpo2FMLdlGmGrtH
         FwcFerhpFgHCwZ1GuTMrDxN2ls0Rm6TX3E01T04pXiw4DasqnkMEPBEHomjnOcvAFMGh
         9XmQ==
X-Gm-Message-State: ALyK8tLtW13QKQlg6ntru3rk/ZSD4OpmlhWXWECmEnvaHviv4J/hlZWCTLF2mUA9CrSF/Co1FZB5RsHcuCCCoA==
X-Received: by 10.107.25.13 with SMTP id 13mr8815952ioz.104.1464999548692;
 Fri, 03 Jun 2016 17:19:08 -0700 (PDT)
Received: by 10.79.0.30 with HTTP; Fri, 3 Jun 2016 17:19:07 -0700 (PDT)
In-Reply-To: <CAPig+cTQkEb6K95aeJ9vNyJ=S+8x+JnCQAYSEzydXKzbq-+Yyg@mail.gmail.com>
X-Google-Sender-Auth: qECPjNwSsUSgcO_aOXvj03Cl0XQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296435>

On Fri, Jun 3, 2016 at 8:02 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Fri, Jun 3, 2016 at 7:42 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Eric Sunshine <sunshine@sunshineco.com> writes:
>>
>>>>         static int is_mboxrd_from(const char *line) {
>>>>                 return starts_with(line + strspn(line, ">"), "From ");
>>>>         }
>>>>
>>>> is sufficiently high-level that no longer is scary, hopefully?
>>>
>>> That's nice and concise but unfortunately not useful for this case
>>> where we must respect the logical end-of-line (within the larger
>>> buffer), represented by line+linelen.
>>
>> Hmph, none of ">", "F", "r", "o", "m", or " " is "\n"; would eol
>> still be an issue?
>
> Ah right. Sorry for being slow.
>
> Your concise version of is_mboxrd_from() is a nice alternative, as well.

My only minor reservation is that it your concise version is still
subtle with regard to not taking 'linelen' into account. At first
glance, it looks like a bug that it doesn't consider the logical
end-of-line, and someone reading the code has to put in extra effort
to convince himself that the code works as intended.

For that reason, I have a bit of a preference for a version of
is_mboxrd_from() which does take 'linelen' into account explicitly.
