From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 3/3] pull: introduce --[no-]autostash and pull.autostash
Date: Mon, 15 Apr 2013 20:01:46 +0530
Message-ID: <CALkWK0mLxZCr-QK2tkR9xEsocj6GAM7FZOSeiJ9SnEusfnv88g@mail.gmail.com>
References: <1365887729-9630-1-git-send-email-artagnon@gmail.com>
 <1365887729-9630-4-git-send-email-artagnon@gmail.com> <vpq38us2oov.fsf@grenoble-inp.fr>
 <7vbo9g15po.fsf@alter.siamese.dyndns.org> <vpqbo9gqcvl.fsf@grenoble-inp.fr>
 <CALkWK0nymT=wTnHpTE=uBsqoHxACFb4gStU0SGE79bc7uBVKXQ@mail.gmail.com> <vpqbo9foqld.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Apr 15 16:32:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URkSO-0007XP-3B
	for gcvg-git-2@plane.gmane.org; Mon, 15 Apr 2013 16:32:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751335Ab3DOOc1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Apr 2013 10:32:27 -0400
Received: from mail-ie0-f173.google.com ([209.85.223.173]:40405 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751014Ab3DOOc0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Apr 2013 10:32:26 -0400
Received: by mail-ie0-f173.google.com with SMTP id k13so2840817iea.32
        for <git@vger.kernel.org>; Mon, 15 Apr 2013 07:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=CVreJZoDIMcSsFfRiDAdZFFL4Dq06jG8eGHyGDBcLuc=;
        b=WI+v/1cYurayitgp1WwQVig9b/SXtlRbLKnf4xN1Fy41yR3UpDS5wuNQTwlRsao0yP
         ChhLGhCwVnN5bGHUpIK4sUJIW/GZ20ot4A5x6yZNFfASJzworYIrYmuYSB3zNcWORskg
         RJOmxtLY4DEsnWghJwF1ALv7ZsKpIknfSL58UtXZlh58xMyxb4vIyOR8sXjfaUNa/TDA
         5PIZGIOkir7EgEE2DHr29z/pLDwecK8gCeu5wgxMC2kwuB5x3Dyjkl4TAceCdVc6HLCq
         MjB0sJZT/LxD3zW4ofloxcuSwylVlVwUKgrikT6s9VWuUYI30j4WFsyoNJqG/mWFmghs
         fbdw==
X-Received: by 10.50.119.102 with SMTP id kt6mr5589098igb.12.1366036346326;
 Mon, 15 Apr 2013 07:32:26 -0700 (PDT)
Received: by 10.64.34.80 with HTTP; Mon, 15 Apr 2013 07:31:46 -0700 (PDT)
In-Reply-To: <vpqbo9foqld.fsf@grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221233>

Matthieu Moy wrote:
> I disagree. A configuration option is something you set once, and then
> forget about. A command, or a command-line option, is something you
> explicitely add when you need it.

You're making it out to be a much bigger difference than it actually
is.  Users will simply alias pull to 'pull --autostash' (a lot of them
already alias it to pull --ff-only, and I'm going to fix this soon).
The decision making process for creating a configuration variable
shouldn't be "this is potentially dangerous, and therefore therefore
it shouldn't be a configuration variable", but rather "this is a
rarely used option that users only need <50% of the time, and
therefore it shouldn't be a configuration variable".  In my case,
pull.autostash is my 90~95% usecase, and I'm not unique in this
aspect.  Therefore, it should be a configuration variable that can be
consciously turned off with a --no-autostash.

If your criticism were that git status doesn't show stash state, I
agree with you.  However, I don't agree with basing it on user
forgetfulness in having set pull.autostash a long time ago + lack of
observation skills to notice the message printed by git pull.
