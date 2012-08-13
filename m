From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: Re: [PATCH 2/4] revisions passed to cherry-pick should be in
 "default" order
Date: Mon, 13 Aug 2012 13:10:24 -0700
Message-ID: <CAOeW2eENsnrPqBL795FcwMgHURS6YsPBW6FYvb=DwD-UtgPZ5g@mail.gmail.com>
References: <7vpq6ygcy1.fsf@alter.siamese.dyndns.org>
	<50289e50.a19f320a.5d99.3fdfSMTPIN_ADDED@gmr-mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 13 22:10:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T10y6-0000VD-R0
	for gcvg-git-2@plane.gmane.org; Mon, 13 Aug 2012 22:10:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752567Ab2HMUKZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Aug 2012 16:10:25 -0400
Received: from mail-gh0-f174.google.com ([209.85.160.174]:44929 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752406Ab2HMUKZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Aug 2012 16:10:25 -0400
Received: by ghrr11 with SMTP id r11so3469536ghr.19
        for <git@vger.kernel.org>; Mon, 13 Aug 2012 13:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Bv8l2/Q3pLcs7TqMF8UreTuKxDXtbCodfYvoykriflM=;
        b=H98HfG/GFAtncqUkICVg+fk9QMPlv015A7H04ncc3ZVpl+IHXKtAHYHydx+2Fh735K
         055tUuewDvD7ZGeQNPdUfSf85udTv5Vug3O+UDACeNMeDLcwO4knKr8UjZpkqgFABC3u
         Vi1WA/nV8GSg0p1aY2k76YIFHeohGoc567gyANG/yUdaUPvl975+ANVYJMYdjbU4Hstf
         lnVNOXgePSvFjB2sxY+3NVFjsMmL9deE8D86eurk3uUoh18pT/iN6+2gktVrnx6c6NrO
         USIU7gfPqbEVulkUUXv3fIUlDd2ogj68bYbi9kyFUKQhiYGtM+hamVpcdyorSL+dJRLS
         keBw==
Received: by 10.68.201.234 with SMTP id kd10mr35059019pbc.141.1344888624291;
 Mon, 13 Aug 2012 13:10:24 -0700 (PDT)
Received: by 10.68.120.112 with HTTP; Mon, 13 Aug 2012 13:10:24 -0700 (PDT)
In-Reply-To: <50289e50.a19f320a.5d99.3fdfSMTPIN_ADDED@gmr-mx.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203359>

On Sun, Aug 12, 2012 at 11:27 PM,  <y@google.com> wrote:
> From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
>
> 'git cherry-pick' internally sets the --reverse option while walking
> revisions, so that 'git cherry-pick branch@{u}..branch' will apply the
> revisions starting at the oldest one.

By the way, I can see the usefulness of --reverse when giving a range,
but I think it's a little confusing when not giving a range. So "git
cherry-pick A B" will apply B first, then A. I thought I'd mention
that explicitly in case it wasn't clear.
