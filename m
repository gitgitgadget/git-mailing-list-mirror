From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Diagnosing stray/stale .keep files -- explore what is in a pack?
Date: Thu, 16 Jan 2014 08:14:56 +0700
Message-ID: <CACsJy8Bx4n7DSfA9JFZd_EcfN3baMtVtHHPVVKKq97jx=byigw@mail.gmail.com>
References: <CACPiFCLa3X-Xt5GwrHHA-PFj-Bi9_sW+=y2xidZ7tDbFfM26rA@mail.gmail.com>
 <CACPiFCJVx0dkkPQ=LosbAAKq7CvK6_yQL5QDHMYr5oJAS6wb6Q@mail.gmail.com>
 <201401141236.44393.mfick@codeaurora.org> <CACPiFCLxiCOqv=wLeq9LxisWn5T62hk8xDYwXmeFRNT05HY0iQ@mail.gmail.com>
 <20140115091220.GB14335@sigill.intra.peff.net> <CACPiFCKeOYHUb22d_Ea0PcbU-uAn=fVAn0QP1qbLAiNh1KEoqQ@mail.gmail.com>
 <xmqqr4892l0u.fsf@gitster.dls.corp.google.com> <CACPiFC+koU1Fan+tbE2YgOstWGsDtDihpK-7CMOct7XAEpwJ2A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Martin Fick <mfick@codeaurora.org>,
	Git Mailing List <git@vger.kernel.org>
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 16 02:15:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W3bYU-0007RQ-4n
	for gcvg-git-2@plane.gmane.org; Thu, 16 Jan 2014 02:15:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752194AbaAPBPb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jan 2014 20:15:31 -0500
Received: from mail-qe0-f44.google.com ([209.85.128.44]:62259 "EHLO
	mail-qe0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751964AbaAPBP3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jan 2014 20:15:29 -0500
Received: by mail-qe0-f44.google.com with SMTP id 1so1924952qee.17
        for <git@vger.kernel.org>; Wed, 15 Jan 2014 17:15:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=hTYLprswSTn2EYJrcO72+/7Qgs6RXfveuwTQq7RkGOs=;
        b=UBr0y3UcHcEnuNtL4WR06bFdR6Do1l9GJOWsNJ2tkeMFEDmZlNqz/jzadPmPd5N7Ld
         Murd7CsTYn39ygI2U/wbXRVWyHSRmLePg8Vb1O+EX/oM/Bs+YyCenfmb/cesd7GbcSd6
         9k9b01Bf5NGVr+R5iX/tJ/t1lS/jSDkErn+UwJjUDT/vYDC2SS1JvdnJl25M17P35Te8
         In86IQBmiNMLJns4cwVcyP/AqUPViY6bsrbwn4fqiHa4Y4iBoTaNAbS8cF2zeOE7tGMH
         wPhWYcK27GdJPLP6SseiUUM032tGdlgi2fJQUeSxSz1BzlZ3uUFUU0Zt5/sFp8w8xMWd
         OM8g==
X-Received: by 10.224.165.12 with SMTP id g12mr9815168qay.89.1389834927018;
 Wed, 15 Jan 2014 17:15:27 -0800 (PST)
Received: by 10.96.136.98 with HTTP; Wed, 15 Jan 2014 17:14:56 -0800 (PST)
In-Reply-To: <CACPiFC+koU1Fan+tbE2YgOstWGsDtDihpK-7CMOct7XAEpwJ2A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240497>

On Thu, Jan 16, 2014 at 6:50 AM, Martin Langhoff
<martin.langhoff@gmail.com> wrote:
> On Wed, Jan 15, 2014 at 12:49 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> As long as we can reliably determine that it is safe to do so
>> without risking races, automatically cleaning .lock files is a good
>> thing to do.
>
> If the .lock file is a day old, it seems to me that it should be safe
> to call it stale.

Perhaps report those stale locks (and stale .keep files as well if you
can detct them) as garbage in count-objects too.
-- 
Duy
