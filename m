From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: A possible fmt-merge-msg update?
Date: Sun, 4 Mar 2012 21:24:41 -0800
Message-ID: <CA+55aFzQ3+EFBVyE9PWOyH0XEC_oW+kUaBTYfixmi2wgMmiZvw@mail.gmail.com>
References: <7vvcmj68iz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 05 06:25:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S4QQ1-0002nX-Pv
	for gcvg-git-2@plane.gmane.org; Mon, 05 Mar 2012 06:25:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751508Ab2CEFZE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Mar 2012 00:25:04 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:65128 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751267Ab2CEFZD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Mar 2012 00:25:03 -0500
Received: by wgbdr13 with SMTP id dr13so3148666wgb.1
        for <git@vger.kernel.org>; Sun, 04 Mar 2012 21:25:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type;
        bh=LsjsZXO9vP7+xxJEgYt7/x48dAyQuWE31wlO1cagMhI=;
        b=nvwVhMWPczJdTex5LxLPhD49wdW5TT6a2eGC1l4kAU9xx5tjuLbRcflhw4begzEBES
         emWmLSyla1vfo09LBR8d1dIgADIEOt0VPC4BA1FR/RuwBOPJmp7W4OKzbTM3/kpF2qbt
         I2vgrif8ay5A3pgM/kBQ9CYZfm7TzIiObjBaarFtvNoxm2TNwK2Vg45IoS2WyuchNLA3
         iragNQdsFUnFaUWZOqXwUmd6tdxthOrylTE1oyMJhpI5OfGJlvK+5tGpi0tB349srzL1
         8/Tn3948t5keCypDTbNjMWHK+7r79t7ScUHooEu3pVIHUcnX+wEUoP3PJ6dnfhr+TWFv
         OWSQ==
Received: by 10.180.85.35 with SMTP id e3mr9935605wiz.6.1330925101224; Sun, 04
 Mar 2012 21:25:01 -0800 (PST)
Received: by 10.180.81.166 with HTTP; Sun, 4 Mar 2012 21:24:41 -0800 (PST)
In-Reply-To: <7vvcmj68iz.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: dL1ApWyHn-AHKsVSQgOpjIaI3nE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192207>

On Sun, Mar 4, 2012 at 7:17 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
> Having observed a handful of your recent merge messages, I am wondering if
> it would help to teach fmt-merge-msg to include "from Wim Van Sebroeck" in
> its output by taking the committer of the MERGE_HEAD into account.
>
> Not worth the trouble?

Hmm. Maybe worth it.

So the reason I've started to try to do it is that I had a person
email me about appreciating the new merge messages, but he also said
he wanted to know who I pulled from. And I agree that that makes sense
as a real piece of information.

It's not *necessarily* the same person as the committer info, though.
It probably matches a very high percentage of the time, but the pull
request doesn't always come from the person doing the commits. The x86
people have this "tip" thing, and while branches tend to be owned by
the people doing the pull request, it's not a given. And sometimes you
have a submaintainer who pulled from *his* submaintainer, and didn't
have any work of his own, so he asks me to pull something where the
top is not him, but his submaintainer.

So I really dunno.

It might be interesting if the pre-written commit message had the top
committer in a comment (the same way pulling a tag has the tag author
in the comment about the tag verification). That way the information
would be right there when I edit the message, and since it's correct
99% of the time it would make it easier to just edit it in the editor
than have to cut-and-paste it from the email. But because it's not a
sure thing, it would be a comment-only thing where I can choose to
remove the '# ' in front of it. Maybe that would be the best of both
worlds - helping write a merge message without assuming it has to be
that way..

                       Linus
