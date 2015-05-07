From: Paul Tan <pyokagan@gmail.com>
Subject: Re: [PATCH v2 07/12] t4013: call git-merge instead of git-pull
Date: Fri, 8 May 2015 00:55:51 +0800
Message-ID: <CACRoPnTMgZBfeneMCZSJVowmSCGf2Ufpt-J461+w9Lh1aN-rhA@mail.gmail.com>
References: <1430988248-18285-1-git-send-email-pyokagan@gmail.com>
	<1430988248-18285-8-git-send-email-pyokagan@gmail.com>
	<a2c6df723ca5237c094ab4002e45a834@www.dscho.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Cc: Git List <git@vger.kernel.org>, Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu May 07 18:55:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YqP5a-0007Lu-N3
	for gcvg-git-2@plane.gmane.org; Thu, 07 May 2015 18:55:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751740AbbEGQzy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 May 2015 12:55:54 -0400
Received: from mail-lb0-f170.google.com ([209.85.217.170]:34463 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751259AbbEGQzx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 May 2015 12:55:53 -0400
Received: by lbcga7 with SMTP id ga7so35645067lbc.1
        for <git@vger.kernel.org>; Thu, 07 May 2015 09:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=pPBASSgeJW0NMs3T8XfHxWjx0GDhZfA9ItjEyBOEOQQ=;
        b=oR4G0/3LYGLyD66fyvHPgeF8xtw61PakraqqMY0Rldij0WfLMQRjkm+eTyXhP9yCmg
         z2dP8oSp3fYDwVyUwke6MxdetyqFqs/OJkqLzErrcRry5KEK8PNhBQiL4YqZ6v2UxVSw
         dDS7W4L9RVR1KE6bM6VH6vIdfJj2yTDwQsqV4AWjox0HqnJWndEW0iE5YvhJ7MJSvhl/
         x3xSlAf9XvRzX3TUhWy5IrlXYvFMlTdEQmlsEBODKCcq1Cujlsn2l4yHdv/MbdvTQOxL
         d5Sjj5K+XE8e+qe9m66FSTm30N0Rd3mclBma9QU4l2ExHQ/sO0l3OQLRtj4PzRglIbfT
         S0BQ==
X-Received: by 10.152.120.70 with SMTP id la6mr3833496lab.65.1431017752092;
 Thu, 07 May 2015 09:55:52 -0700 (PDT)
Received: by 10.112.74.133 with HTTP; Thu, 7 May 2015 09:55:51 -0700 (PDT)
In-Reply-To: <a2c6df723ca5237c094ab4002e45a834@www.dscho.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268550>

Hi Dscho,

On Fri, May 8, 2015 at 12:26 AM, Johannes Schindelin
<johannes.schindelin@gmx.de> wrote:
> Both this patch and 9/12 change `git pull` invocations to equivalent non-pull ones, but I wonder whether it would not be a better idea to leave them as-are, so that we can make sure that scripts out there that might use similar `git pull` invocations would be unaffected by the rewrite?

In the current state[1], I'm aiming for the git-pull rewrite patch
series to break all git-pull tests in the first patch, and then
subsequently make them pass again in later smaller patches by
implementing back the old features. This will make reviewing the code
much easier, as opposed to dumping a huge patch every single re-roll
;-).

For both patches and test suites, if the "setup" tests fail, the whole
test suite fails. Given that the test suites are about testing the
diff formatting options and submodules update implementation, which is
mostly irrelevant to git-pull, I think it would be better if the test
suite was not affected by the rewrite, especially since it only
requires changing one line.

[1] https://github.com/pyokagan/git/commit/bfdf5039d1627c9599051faf2ce34b007d4bfbea

Thanks,
Paul
