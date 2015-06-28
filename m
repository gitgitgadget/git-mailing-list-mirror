From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [RFC/PATCH 1/9] ref-filter: add %(refname:lalignX) option
Date: Sun, 28 Jun 2015 12:29:13 +0530
Message-ID: <CAOLa=ZRdwoVrEh5igD-T5CPSOzOF8+k4pF6PE99wCqQo_q6+6g@mail.gmail.com>
References: <CAOLa=ZSsVqFy4OrSt295qAZdjKTC7z44EVsx3cPEd2jb8Y-sHw@mail.gmail.com>
 <1435232596-27466-1-git-send-email-karthik.188@gmail.com> <CAP8UFD1gT_2RKYc1vvBO9goGwPzFxhu9uMan5+cLO7eWxwwB_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 28 09:01:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z96aa-00005l-2q
	for gcvg-git-2@plane.gmane.org; Sun, 28 Jun 2015 09:01:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752090AbbF1HBE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Jun 2015 03:01:04 -0400
Received: from mail-ob0-f172.google.com ([209.85.214.172]:35132 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752295AbbF1G7n (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Jun 2015 02:59:43 -0400
Received: by obbop1 with SMTP id op1so88227876obb.2
        for <git@vger.kernel.org>; Sat, 27 Jun 2015 23:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=hAOjGRhlO9s+NnO7VSWILHafp+TW2myZjFdBHPSDEZo=;
        b=wPldazi7KK8qixmgtG4YotQw1z04MKLOIxT1B/rOa9pURQ83ONaaiD2D0Vjacn/bIy
         UoQ/17sOPRNjFpd49lqDH/8P96AllD0vQ4wmRZ30j3c8OG/0Mcv9PFWOhP9eOcdth7L6
         OpIKfkSxQrmBs1tJZbhwuB1kg8NIwJ+FNl6m/st1TKreaTb7E5rLj0mNWGa7hI7nS1pe
         8igsi9XrW5d7HJMk3/zkaGwPT8HQsiFPJqmPaOzzOLAFP23tJ0ifrc7iD+XJljBi6CCT
         ZNfLM4pW/1j0bE3+AsmZ1gGbLLGgqmKUY5RC2J5hPIYmoTVHO7t7aogCxXYJD+tzZRWq
         Q/Cg==
X-Received: by 10.182.33.38 with SMTP id o6mr6015377obi.41.1435474783174; Sat,
 27 Jun 2015 23:59:43 -0700 (PDT)
Received: by 10.182.95.165 with HTTP; Sat, 27 Jun 2015 23:59:13 -0700 (PDT)
In-Reply-To: <CAP8UFD1gT_2RKYc1vvBO9goGwPzFxhu9uMan5+cLO7eWxwwB_w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272870>

Hey Christian,
On Sun, Jun 28, 2015 at 1:32 AM, Christian Couder
<christian.couder@gmail.com> wrote:
>
> After thinking about such code, I wonder if it would be better to
> support %(refname:lalign=X) instead of %(refname:lalignX).
>
> The reason why it might be interesting to require an = sign between
> "align" and the number X is that if we later want to introduce another
> option with a name that starts with "lalign", for example
> %(refname:lalignall=X) that would truncate the refname if it is bigger
> than X), we might be more backward compatible with old git versions
> that implement %(refname:lalign=X) but not %(refname:lalignall=X).
>
> We will be more backward compatible because the above call to
> starts_with() would probably be something like:
>
>                        if (starts_with(formatp, "lalign=")) {
>
> which means that old git versions would ignore something like "lalignall=X".
>

Good point! I agree with what you said, including an "=" sign would mean more
compatibility in the future as we could have lalign* options. Will
change this, thanks.

-- 
Regards,
Karthik Nayak
