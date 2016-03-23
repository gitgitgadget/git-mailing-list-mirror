From: Mehul Jain <mehul.jain2029@gmail.com>
Subject: Re: git-apply does not work in a sub-directory of a Git repository
Date: Wed, 23 Mar 2016 22:54:19 +0530
Message-ID: <CA+DCAeSE4CS8zg1tHP5kYOs-CbGk0uAzWX9Zh9Fk3O7mYwYTMQ@mail.gmail.com>
References: <CA+DCAeQQQH59Lb43Y4Bi1xktPNoODV11KkUBbKNG1OZ7mDb-UQ@mail.gmail.com>
	<CAGZ79kYmoKX1w5X8jE5_yGb3VKricHEwxAianTyt4VUd71qH-A@mail.gmail.com>
	<CACsJy8DCk5YintK3PoO1BWdNmsiSLpAcGL4pU7QgNEG6S41CsQ@mail.gmail.com>
	<xmqqbn65dxtl.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Duy Nguyen <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 23 18:24:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aimW8-0004dx-V7
	for gcvg-git-2@plane.gmane.org; Wed, 23 Mar 2016 18:24:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753752AbcCWRYV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Mar 2016 13:24:21 -0400
Received: from mail-qg0-f49.google.com ([209.85.192.49]:35982 "EHLO
	mail-qg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750820AbcCWRYU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Mar 2016 13:24:20 -0400
Received: by mail-qg0-f49.google.com with SMTP id u110so17688714qge.3
        for <git@vger.kernel.org>; Wed, 23 Mar 2016 10:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=iA6MuKCSyygZE9hokJDFv4YOVGShrZXLPRktYZVXR6Y=;
        b=uqHb9xEiogvIFqONuEwmOwoEZr+PlNHWfLmYGsUU0cxad7/Ik2wPQaNqubw6KCZA9Q
         WQx6WfjyJdNkCRGocXdNOYHiSH99zKL5N+c+FY+0UjPKFRR/Xrc4jjisekPw+Fq4gpBy
         DmovLzVk+fD6rz7XWe+M/VE6N3qaE5OEGa5q0i8t2lYPc5pcVDH5VIWCFIiPkD42lWDy
         iQKkec2HsxzMxMqgFyxUPMuRDgY72TpICNSLMejrzeeTpxNBvAU3oT1EUd3zHGc9hISn
         AQKj6IUQC4/LdPnFdo3UMYhj3KWzyzIdXNIRBm/QWf4KCGr2WrJW8qDHtVHHeQ0oIY3t
         R1HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=iA6MuKCSyygZE9hokJDFv4YOVGShrZXLPRktYZVXR6Y=;
        b=i3/a2X8nqeYvhOwrWuYYezy4XUX9Jrp7/U1Y+Y3t3fEUou580BWH2NPr9/FlFKnzpl
         iThgt6EBVxZO7Nn1cC8TD5i+H4eLE9gMXhcveiQqAHaKNoYtkFntJhaUiM/w1iFR5OtK
         ILjCflifcmAQHbIn1l3lnW6smgYmBXGcSkgXcu9w3SB/D9FKlwlCbt3faFTw2kAR7U4+
         s9as1r9mpAxQOuLSqrXb6rlmMwDygAsce6PtwJVuucsv8k/QCE/jmYTJhaKNiAXc99ty
         DNybVxebDPI+lyC3eh9xZXmgild9BkdWSTrrrY3GHcDFq//kLyPjEUg5NhUOHE3787Vp
         IPZw==
X-Gm-Message-State: AD7BkJI2hnlEo/Up7Fn+MjHCK5vUo5ojFotcxHkDmMLXmzCYXF8ajzKa7msI9o19iHvHYtpRngCENSm6+Y7QHQ==
X-Received: by 10.140.195.203 with SMTP id q194mr5457742qha.45.1458753859749;
 Wed, 23 Mar 2016 10:24:19 -0700 (PDT)
Received: by 10.55.188.7 with HTTP; Wed, 23 Mar 2016 10:24:19 -0700 (PDT)
In-Reply-To: <xmqqbn65dxtl.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289670>

On Wed, Mar 23, 2016 at 8:51 PM, Junio C Hamano <gitster@pobox.com> wrote:
> I think we do have --no-index (which is why I am largely ignoring
> the rest of your message as uninformed speculation for now).

--no-index command line flag is there for git-apply but unfortunately not
documented.

Also *auto-completion* for "git apply --no-index" doesn't work.

That is

    git apply --no-i<tab><tab>

should be auto completed and give

   git apply --no-index.

Probably following change will remove this problem.

diff --git a/contrib/completion/git-completion.bash
b/contrib/completion/git-completion.bash
index 45ec47f..860dae0 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -886,7 +886,7 @@ _git_apply ()
                ;;
        --*)
                __gitcomp "
-                       --stat --numstat --summary --check --index
+                       --stat --numstat --summary --check --index --no-index
                        --cached --index-info --reverse --reject --unidiff-zero
                        --apply --no-add --exclude=
                        --ignore-whitespace --ignore-space-change
