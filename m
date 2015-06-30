From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/3] rebase -i: drop, missing commits and static checks
Date: Tue, 30 Jun 2015 10:09:38 -0700
Message-ID: <xmqqmvzh6s31.fsf@gitster.dls.corp.google.com>
References: <1435609232-14232-1-git-send-email-remi.galan-alfonso@ensimag.grenoble-inp.fr>
	<1435655961-31263-1-git-send-email-Matthieu.Moy@imag.fr>
	<1849903896.89424.1435676774069.JavaMail.zimbra@ensimag.grenoble-inp.fr>
	<xmqq7fql8949.fsf@gitster.dls.corp.google.com>
	<70428267.93232.1435683724659.JavaMail.zimbra@ensimag.grenoble-inp.fr>
	<vpqy4j12knh.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Remi Galan Alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	git@vger.kernel.org,
	remi lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	guillaume pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	louis--alexandre stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	antoine delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	sunshine@sunshineco.com
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Jun 30 19:09:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z9z2Y-0001qI-Mx
	for gcvg-git-2@plane.gmane.org; Tue, 30 Jun 2015 19:09:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753099AbbF3RJm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Jun 2015 13:09:42 -0400
Received: from mail-ig0-f180.google.com ([209.85.213.180]:38842 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752134AbbF3RJl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jun 2015 13:09:41 -0400
Received: by igrv9 with SMTP id v9so17087520igr.1
        for <git@vger.kernel.org>; Tue, 30 Jun 2015 10:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=KrqbAY8P4gJ0+dxZR30AhCzzmo20wJ8NjG6fmow/NAA=;
        b=YOjtNTc8O1M7YdS3dtOCANiItoOe6g8w3AMhQBsRsgOT1CEZn+PTYey5GYH8x/Nmz7
         o4+F4lmggSUprjex6s1RRDv/7p9/mNHJZdM9GykXNyw5szOOtOv2zdiwbashqxmG4W4j
         BFo7smV+0/XE75i/IXCj44I4iyQiAtyCQcs8+w1rNJpSN8P/b0m+FpNS/r0qcHistmup
         P5OMovcqu5E+fncc2viw2mOD7wV86efsUXU5T834sbN+kyqxLY4fI+9oADmHHzGcmcnZ
         sKA/9UP1L3pTZuqHDPiNJJCyPJuYGq03tw+LNAnNppylxgEbFBtP5F6gksotKUg9UUCR
         QzIg==
X-Received: by 10.42.161.74 with SMTP id s10mr28255803icx.5.1435684180709;
        Tue, 30 Jun 2015 10:09:40 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:502c:1da0:e16d:2d77])
        by mx.google.com with ESMTPSA id lr1sm8132122igb.10.2015.06.30.10.09.39
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 30 Jun 2015 10:09:40 -0700 (PDT)
In-Reply-To: <vpqy4j12knh.fsf@anie.imag.fr> (Matthieu Moy's message of "Tue,
	30 Jun 2015 19:03:46 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273086>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> There's an alternative:
>
> $ git rebase --edit-todo
> # Make mistakes, save and quit
> Your todo-list has the following issues:
> - ...
> Do you want to edit again (no aborts the rebase) [Y/n]?
>
> There's a precedent with the 'e' command of "git add -p". I have a
> slight preference for non-interactive commands so I prefer not going
> this way though.

edit-todo (and "rebase -i" in general) is all about going
interactive, isn't it?  I was almost going to suggest to keep
spawning the editor until the user gets it right, but that would
infinitely repeat when GIT_EDITOR is set to a broken script, so
I didn't ;-).
