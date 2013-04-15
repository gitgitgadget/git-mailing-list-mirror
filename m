From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [RFC/PATCH] clone: introduce clone.submoduleGitDir to relocate $GITDIR
Date: Mon, 15 Apr 2013 15:17:52 +0530
Message-ID: <CALkWK0nPhXhv64t7tDwLudFgi7NnanVsnYQPqWhYiAp-y9Z90w@mail.gmail.com>
References: <1365881007-25731-1-git-send-email-artagnon@gmail.com>
 <7vy5ck4m6b.fsf@alter.siamese.dyndns.org> <CALkWK0mvtRhFc0_4883ATNaYpb+kDwpV9VxeAoqJy5HxNQ6vgg@mail.gmail.com>
 <CACsJy8Cx0QA_epns2WNWjBBSG6zpXVaTebybiTRuVt+OARupAg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Jeff King <peff@peff.net>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 15 11:48:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URg1e-00006W-RQ
	for gcvg-git-2@plane.gmane.org; Mon, 15 Apr 2013 11:48:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753136Ab3DOJsf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Apr 2013 05:48:35 -0400
Received: from mail-ia0-f173.google.com ([209.85.210.173]:64695 "EHLO
	mail-ia0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753094Ab3DOJse (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Apr 2013 05:48:34 -0400
Received: by mail-ia0-f173.google.com with SMTP id j5so3642769iaf.32
        for <git@vger.kernel.org>; Mon, 15 Apr 2013 02:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=5TMdqWw94V5uuCaQFYCitn0/e6DkQZSt1TmBRwudvx4=;
        b=O3ZE3LoTYNibjZGuynmUk+5aW85rMOje5QBguhblxuOlTvIH42Qk3bhFeTxmWV9Llf
         giY3yjyqNe1PMHyoA4LIuoyjasaFmRbFgRn2ktJ2C+apFFDuDimmMbht/cYfA1D79oie
         geEZtt7qKQ4M6y2fOXdee2HORqpW6zGtaotA6EmI6soPrxAp7NqxIOwkKrfzUBPd8IGM
         7826OoRrkLpJnMd2BTdDjnpK8k58EUJ6C56xMiw+1J43G/iW9KqXtydAJxGSeDrhQI9j
         lVXKdogVj+VvaUOJZyC6vIl6B3p2rQ3j+DiZvToeSy0CkI8niWRMKNUcRkKfJkUP8y4y
         XH2g==
X-Received: by 10.50.17.166 with SMTP id p6mr4775115igd.12.1366019312753; Mon,
 15 Apr 2013 02:48:32 -0700 (PDT)
Received: by 10.64.34.80 with HTTP; Mon, 15 Apr 2013 02:47:52 -0700 (PDT)
In-Reply-To: <CACsJy8Cx0QA_epns2WNWjBBSG6zpXVaTebybiTRuVt+OARupAg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221215>

Duy Nguyen wrote:
> If a user is inside .git, I believe setup_git_directory() will also
> find correct gitdir. In that case, we do not want magic (i.e. only do
> your magic when you are inside worktree). Still I'd rather see no
> magic (i.e. command line option) first. Let people try it out for a
> while. If people like it and find it inconvenient, magic can come
> later. I suspect you might want more magic in other places. Maybe if
> you hold it back  until you see full picture, you'll only need a few
> new config keys (instead of one per separate magic).

Good suggestion.  I'll make it a command-line option for now.

> Just do what scripts do: spawn a process to run rev-parse so that it
> does not mess up the main process. You might be able to introduce
> "dry-run" mode for setup_git_directory(), but that won't be easy.

Okay, thanks.
