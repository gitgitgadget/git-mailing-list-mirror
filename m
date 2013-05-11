From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] patch-ids.c: cache patch IDs in a notes tree
Date: Sat, 11 May 2013 14:10:01 -0700
Message-ID: <CA+55aFyn0+Q4CA6yQZipaCRB0w9cW4YpuL3XuxU2JR5QPp98XQ@mail.gmail.com>
References: <9d9e56d323b40fe9ea2a6484e35f0afcd3a3a85b.1368301939.git.john@keeping.me.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Sat May 11 23:10:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UbH3S-00050Y-Jf
	for gcvg-git-2@plane.gmane.org; Sat, 11 May 2013 23:10:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754402Ab3EKVKE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 May 2013 17:10:04 -0400
Received: from mail-vc0-f177.google.com ([209.85.220.177]:50700 "EHLO
	mail-vc0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753906Ab3EKVKD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 May 2013 17:10:03 -0400
Received: by mail-vc0-f177.google.com with SMTP id ha12so4577518vcb.36
        for <git@vger.kernel.org>; Sat, 11 May 2013 14:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=2gcA2hv5BjTF6FCIwgmbo5ZX0TIuQWPqkePuYp+AjYE=;
        b=i7Y3l70QQJqGlgVA2P2qOm30+Engg7TxtVTfF6KuG1vAX0KZQk7xDGINjSKiA7t36m
         Nf/BBcTd/rFnMGkTBLZQlpEwy1ugtf6BIXWQW4uZRmW5kP6OK+CMLkxyJx9E5A51wnu2
         sV6IUn7y8NFzNyy+ZJXD1DumBSua6eURK6TrT+K4Zl/jawpzotWRaW2YgKIE92Qe/iPZ
         IpBPAONdzDkaYOoe6xSfhHXkSGO+M5fffPZGpMT3scytVBC7yen20Z1aRVLi135rw9me
         b/Zdl86LN2Qtp7au2skyhqizs+93iYTpthhor1bwlHVCRggELr/58wiWkWWmkF5XFIXn
         nr5A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:x-received:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=2gcA2hv5BjTF6FCIwgmbo5ZX0TIuQWPqkePuYp+AjYE=;
        b=aIOca1dNzjaD0s192o2Fjct0BgmJCFcpzgoTMQJA/hU5yDDVeJmlrc7pcJGyAMthQu
         7F4DVJlvxwpGaPkOWiqHQ+9JHocnHiXjM1O70d26Mx2xncgsRPpetvq470qHOipudqwU
         METi//bd/2Ae332WtrAOSP04QKeSnOiD9PO7o=
X-Received: by 10.220.188.201 with SMTP id db9mr14434034vcb.30.1368306601868;
 Sat, 11 May 2013 14:10:01 -0700 (PDT)
Received: by 10.220.8.71 with HTTP; Sat, 11 May 2013 14:10:01 -0700 (PDT)
In-Reply-To: <9d9e56d323b40fe9ea2a6484e35f0afcd3a3a85b.1368301939.git.john@keeping.me.uk>
X-Google-Sender-Auth: mYk-U5BdILJzaM-Y20E_hHzGOkw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224011>

On Sat, May 11, 2013 at 12:54 PM, John Keeping <john@keeping.me.uk> wrote:
> This adds a new configuration variable "patchid.cacheRef" which controls
> whether (and where) patch IDs will be cached in a notes tree.

Patch ID's aren't stable wrt different diff options, so I think this
is potentially a very bad idea.

           Linus
