From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] git diff -q option removal
Date: Wed, 17 Jul 2013 11:06:38 -0700
Message-ID: <CAPc5daVaOuGD73a=jK7RhOpBnBcUPmL5XnuoXLWYqMs=AoDk0A@mail.gmail.com>
References: <20130714220739.GC13444@google.com> <1373970487-32595-1-git-send-email-stefanbeller@googlemail.com>
 <7vvc496ruf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, jrnieder@gmail.com, trast@student.ethz.ch
To: Stefan Beller <stefanbeller@googlemail.com>
X-From: git-owner@vger.kernel.org Wed Jul 17 20:07:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UzW82-00041o-DN
	for gcvg-git-2@plane.gmane.org; Wed, 17 Jul 2013 20:07:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932207Ab3GQSHA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Jul 2013 14:07:00 -0400
Received: from mail-la0-f45.google.com ([209.85.215.45]:44672 "EHLO
	mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932160Ab3GQSHA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jul 2013 14:07:00 -0400
Received: by mail-la0-f45.google.com with SMTP id ev20so23096lab.32
        for <git@vger.kernel.org>; Wed, 17 Jul 2013 11:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type;
        bh=f4xknqKTLBxKydYXPuwrtxwE33V0f1RmyNSy5LyA8G4=;
        b=EkJQtXIHPmoISDDakeiBygBOnCEcwB4BPmkAnC56l6oMsLH+BhVnNORyTgN4uU8m/L
         GfiOmMHDxc0xPctH8zgVeFxU41y1v+wUyWxF4roNy0J0q7vKH1A1WNyvXLgs9xm7Tr7Q
         xfS2W+NATknhY1qPeUiyrhgRqGMKO3AY7Th1mVp3vejHenVDe2dxLLBBLaZ/g8ez6aYK
         hCkRF5YOf4A8qLPyHvFP59IJ6q4PzO8DJNHHkKxMAXdx5HC+4yRGYZY5miniNYuH10aZ
         0fzbVQFAPkrjGKEhHwsA6deUWqMgcZFgJcnis2kzBwkolGXfGmE1HRpizn5qYZV0iizP
         X8eA==
X-Received: by 10.152.170.162 with SMTP id an2mr3503949lac.3.1374084418576;
 Wed, 17 Jul 2013 11:06:58 -0700 (PDT)
Received: by 10.112.64.73 with HTTP; Wed, 17 Jul 2013 11:06:38 -0700 (PDT)
In-Reply-To: <7vvc496ruf.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: e48Yp24icaLbUJN3g6vpc6WdxpQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230640>

On Wed, Jul 17, 2013 at 10:04 AM, Junio C Hamano <gitster@pobox.com> wrote:
> If we wanted to make "-q" follow the spirit of its original addition
> to "show-diff" again, we could internally add a diff-filter when the
> "-q" option is parsed.

Having said all that, I do not mean to advocate to retain "-q". Most
likely nobody uses it, and "-q" is grossly misnamed ("why is it so
special to be "quiet" only for removals?"). As long as we mention its
removal in the release notes (and possibly tell those miniscule
minority that wants to ignore deleted files to use --diff-filter
instead), we should be OK.

Independently, we might want to enhance --diff-filter parser to make
it easier to say "I want everything but D", perhaps use lowercase
letter to subtract from what have been specified so far (or if there
is no uppercase letter, start from "everything"), so that we can say
--diff-filter=d
or something.
