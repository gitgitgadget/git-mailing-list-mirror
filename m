From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 2/4] completion: introduce __gitcomp_2 ()
Date: Fri, 3 Jan 2014 13:21:17 +0530
Message-ID: <CALkWK0mgqJFz1Lf_UVX8fdvnT+u+rp705dak7kXVFFBSr2bTQA@mail.gmail.com>
References: <1388415138-11011-1-git-send-email-artagnon@gmail.com>
 <1388415138-11011-3-git-send-email-artagnon@gmail.com> <xmqqeh4qndxs.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 03 08:52:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VyzY2-000772-I5
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jan 2014 08:52:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751099AbaACHv7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jan 2014 02:51:59 -0500
Received: from mail-ie0-f171.google.com ([209.85.223.171]:36382 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750999AbaACHv6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jan 2014 02:51:58 -0500
Received: by mail-ie0-f171.google.com with SMTP id ar20so15736880iec.2
        for <git@vger.kernel.org>; Thu, 02 Jan 2014 23:51:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=vv05onEXXn6+w1+mY/w2bZvMisEZnZ8oLyJ1jmzGNBY=;
        b=qXEER81QQH8s9MGoKBjCJDx+YLEHETrRXrwHbrESKMDuLIyRdMIraWMUp2wSUhiZfC
         66oxLvWH/k9D7CYhHslfSQ/gboZP1T/VQ7TcgldVYhn3irZJpMcqi1frc2ozYBrieu6Y
         TQyR4eN9tZd6Dk9wHkyKa9m+r54HFrOamGq1Tg7I7HDF+eu6xtX7REFoWc4ISmORA0cS
         4GuzRMjsv3zveggvho/PfY40zhi7gnxNmo/WnDUgfxHmQ657OPGVGu0XyJgEeUG8SD3C
         NJGI5BOQ6e6QNzdSjls9iCdtlhIAWVuQzGIL1bokX2BLnsy0OYveDg6N2aooHhf3UDm+
         5vYA==
X-Received: by 10.50.150.174 with SMTP id uj14mr1339422igb.16.1388735517875;
 Thu, 02 Jan 2014 23:51:57 -0800 (PST)
Received: by 10.64.195.9 with HTTP; Thu, 2 Jan 2014 23:51:17 -0800 (PST)
In-Reply-To: <xmqqeh4qndxs.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239905>

Junio C Hamano wrote:
>         __gitcomp_nl "$(__git_heads)" "$pfx" "$cur_" "."
>         __gitcomp_nl_append $"autosetupmerge\nautosetuprebase\n" "$pfx" "$cur_" " "

This is not a bad idea at all. I'm just afraid that we might be
leaving open ends: What happens if the $pfx isn't the same in both
cases? Who keeps track of the index "i" of COMPREPLY (it's currently a
local variable)? If we make it global, doesn't every function that
deals with COMPREPLY be careful to reset it?

More importantly, can you see a usecase for more than two completion classes?
