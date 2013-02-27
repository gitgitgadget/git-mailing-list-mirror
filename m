From: Adam Mercer <ramercer@gmail.com>
Subject: Re: post-receive-email hook with custom_showrev
Date: Wed, 27 Feb 2013 08:30:29 -0600
Message-ID: <CA+mfgz3XsVB9hk+0rG0VnJQL9P9oD-wrrTX35xpsF2kM9GqJMQ@mail.gmail.com>
References: <CA+mfgz1jrSbbZc7+asxfZivemYSvbB3+UxYx4sm3BwLmR0ELEA@mail.gmail.com>
 <512DB8D6.9010109@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Feb 27 15:31:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UAi2w-0006WV-35
	for gcvg-git-2@plane.gmane.org; Wed, 27 Feb 2013 15:31:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760091Ab3B0ObM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Feb 2013 09:31:12 -0500
Received: from mail-qe0-f41.google.com ([209.85.128.41]:46684 "EHLO
	mail-qe0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759975Ab3B0ObL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Feb 2013 09:31:11 -0500
Received: by mail-qe0-f41.google.com with SMTP id 6so469735qeb.14
        for <git@vger.kernel.org>; Wed, 27 Feb 2013 06:31:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=g4yQ996Z5cRXPUHWnQeufG8p4Z6LkM/1i0yVzkK7sOQ=;
        b=bJcqVq7JNLH9J+9hyJv1KkudUqWQRfP+5AucotRfL//YjIZDtutqmSijFpCxhniDnV
         r/qe63oJchtxqE7C/2Vkb8mhkKHq9hTNawjBKB0+K+5yc4BN0kQs2ssnurXAdGljbBBY
         j/ym7ney2h/h/Ml5T6olNiTz/r95hR2WEO1lgAT0sM2htzcyw+CNjQe2J4x3GGtfy+xu
         0ydJZFcinY6Dgp+rjLuJo+Va71PHQQk3uuN+adSbIY0B0jAwGJO+CQSCkIQ+o50J8XAD
         tYwd7cDKihBAtXDQftDvlCqC1pG+8KM8wfbIXNTF5a1eGqk72Q6A0PMwHta5HrDYXTLw
         uKlg==
X-Received: by 10.49.24.45 with SMTP id r13mr4242688qef.3.1361975470247; Wed,
 27 Feb 2013 06:31:10 -0800 (PST)
Received: by 10.49.63.136 with HTTP; Wed, 27 Feb 2013 06:30:29 -0800 (PST)
In-Reply-To: <512DB8D6.9010109@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217206>

On Wed, Feb 27, 2013 at 1:42 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:

> If I type that into my .git/config file then type "git config
> hooks.showrev" I get "bad config file line 7 in .git/config" due to the
> "\$".  I think the quoting in the comment in post-receive-email is
> written as if it would be passed via the command line to "git config"; i.e.,
>
>     git config hooks.showrev "t=%s; printf 'http://.../?id=%%s' \$t;
> echo;echo; git show -C \$t; echo"
>
> Granted, the docs don't make that clear.  See git-config(1) for the
> details of the config file syntax.

Thanks a lot that did the trick! I imagined it'd be some quoting issue.

Cheers

Adam
