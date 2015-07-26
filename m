From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v4 02/10] ref-filter: make the 'color' use ref_formatting_state
Date: Sun, 26 Jul 2015 11:10:10 +0530
Message-ID: <CAOLa=ZRz9LL5heW2FOhZje+=5W_Ybtm+Rcsm-RH=eKXoh5yw2Q@mail.gmail.com>
References: <1437764685-8633-1-git-send-email-Karthik.188@gmail.com>
 <1437764685-8633-3-git-send-email-Karthik.188@gmail.com> <CAPig+cQEKrjePskjSacrf3SbLZR7_ADxTLwcV7vBPcjUxBLiEg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sun Jul 26 07:40:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZJEg9-0002SV-DV
	for gcvg-git-2@plane.gmane.org; Sun, 26 Jul 2015 07:40:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932194AbbGZFkl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Jul 2015 01:40:41 -0400
Received: from mail-ob0-f180.google.com ([209.85.214.180]:35368 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932141AbbGZFkk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Jul 2015 01:40:40 -0400
Received: by obbop1 with SMTP id op1so39665505obb.2
        for <git@vger.kernel.org>; Sat, 25 Jul 2015 22:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=YxxCXE6JQx6N9ckc+Q/UHU5sZDNjkACGv1f7slqQ2TA=;
        b=y20+9j2dZVE1cRJcDi/M8PI9g0zhwXhWNMo8xJyH8ov8fFD5lSrFYPtff02nw/0+Mm
         toYbVMtiCWFpOsJV9Pnvhwo3SMzw/jIaQM3quqlON12qpFohhQ7Y1KEkmraMAbN6iN+0
         xlaxOFAcis5Xo2ejxUwS9zJpmqlnx60tPwGXoB3tt7Hd2rMUpFbu6CAucOnpXm3iKnMs
         /KCyPSoOL1WPXZcoEjyeyOieB2ODdnreE9/05Ha6gwL+Rc8l7IRqbqXfJmcs94lLER9D
         ZA+J9DRTmngYPicL87gHMXcRpxKb7Fa8X7Jxg2bBMC7Nz/oarFaMur5BsM2geTAzsuD8
         YOfg==
X-Received: by 10.182.204.38 with SMTP id kv6mr22056162obc.70.1437889239716;
 Sat, 25 Jul 2015 22:40:39 -0700 (PDT)
Received: by 10.182.26.73 with HTTP; Sat, 25 Jul 2015 22:40:10 -0700 (PDT)
In-Reply-To: <CAPig+cQEKrjePskjSacrf3SbLZR7_ADxTLwcV7vBPcjUxBLiEg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274636>

On Sun, Jul 26, 2015 at 9:42 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>
> Should 'color' should be declared 'char *' rather than 'const char *'?
> It's always assigned via xstrdup(), and if declared 'char *', you
> wouldn't have to cast away the 'const' when freeing it.
>

yes, will change.

>
> While reviewing patch 1/10, it required more effort and was
> distracting to have to separate out (mentally) changes which were
> specific to the new %(align:X) pseudo-atom and those which introduced
> the "formatting state". As such, it probably would be a good idea to
> aim for the three distinct patches suggested by Junio rather than
> aiming, up front, to merge the first two. After all, they are
> conceptually distinct changes, and keeping them separate is friendlier
> to reviewers. In the end, you may find that patch 1 is so trivial that
> it can be merged with patch 2 without making review more difficult,
> however, keeping them distinct during development helps you avoid
> conflating unrelated changes.
>

Yes! I'm doing that like Junio suggested. Thanks for bringing it up :)

-- 
Regards,
Karthik Nayak
