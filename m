From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 3/3] pull: introduce --[no-]autostash and pull.autostash
Date: Mon, 15 Apr 2013 18:59:44 +0530
Message-ID: <CALkWK0nymT=wTnHpTE=uBsqoHxACFb4gStU0SGE79bc7uBVKXQ@mail.gmail.com>
References: <1365887729-9630-1-git-send-email-artagnon@gmail.com>
 <1365887729-9630-4-git-send-email-artagnon@gmail.com> <vpq38us2oov.fsf@grenoble-inp.fr>
 <7vbo9g15po.fsf@alter.siamese.dyndns.org> <vpqbo9gqcvl.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Apr 15 15:30:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URjUN-0004v0-KM
	for gcvg-git-2@plane.gmane.org; Mon, 15 Apr 2013 15:30:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751541Ab3DONa1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Apr 2013 09:30:27 -0400
Received: from mail-ia0-f172.google.com ([209.85.210.172]:55228 "EHLO
	mail-ia0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751361Ab3DONa0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Apr 2013 09:30:26 -0400
Received: by mail-ia0-f172.google.com with SMTP id k38so4382827iah.31
        for <git@vger.kernel.org>; Mon, 15 Apr 2013 06:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=jfCMMtehukT7NR/dOrA2hjIWiYe09p8nK9FESyHqeDI=;
        b=BFnenZ2U/oKO6+TlMRYvV12qfRnu3qH4nCrAhh1NUB8SBUYJQtYOZAHCD9Yzlo3ife
         4xSmnodNetVomvWktUsKb/VBvsNW6WAeYpo+mXXz/3Ch1ZiAoyWqhXmg89bFewRNCLgr
         7W0JR7A6xIgLyE9hegsSDMHY9WzQELfRpIrZhxDG7Hd8pZy/7ueDfLu6B3VRnI8jBI9C
         Nv1r/WUagia0ySduErS/sH9qDOElWFFfYYoi0xBWhKkMJvkgD9jtvxrcDv7RcZDntqg6
         3di0l2vjUcyWrWictbsrHaMLo79qAgeRzU405anLnv9PdDBTLECy3EG3cBojrM2XnQX5
         op3A==
X-Received: by 10.42.50.202 with SMTP id b10mr11915224icg.7.1366032625135;
 Mon, 15 Apr 2013 06:30:25 -0700 (PDT)
Received: by 10.64.34.80 with HTTP; Mon, 15 Apr 2013 06:29:44 -0700 (PDT)
In-Reply-To: <vpqbo9gqcvl.fsf@grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221228>

Matthieu Moy wrote:
> I tend to agree that pull.autostash is harmful. At least in its current
> form, it is really too easy to overlook the "Please run 'git stash pop'
> after commiting the conflict resolution." message:
>
> <do some important changes>
> $ git pull
> <fix conflicts>
> $ git status
> <tells me to commit>
> $ git commit
> <WTF, where are my important changes?!?>

First, this is not why Junio said pull.autostash is harmful: he had a
completely different objection.

Second, this makes no sense.  The user consciously made the decision
to set pull.autostash to true: it isn't turned on by default, and
there's no magic that's turning it on without the user knowing.  This
case is roughly equivalent to the user executing 'git stash' and
suddenly waking up one day and complaining "WTF, where are my
important changes?!?".  Sure, it might be a good idea to teach git
status to show the stash state, but that's an orthogonal topic.
