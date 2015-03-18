From: Graham Hay <grahamrhay@gmail.com>
Subject: Fwd: Seems to be pushing more than necessary
Date: Wed, 18 Mar 2015 10:55:26 +0000
Message-ID: <CAABECY1_L34sq0VPmD9UwRcwb3Fuh95OFcF26LM2eX1z-+8vkQ@mail.gmail.com>
References: <CAABECY3HbZ4q3uo82outUmCyQLXO39H+Fd2m8bLwkaubE9gJCw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 18 11:55:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YYBdN-0005YQ-Cr
	for gcvg-git-2@plane.gmane.org; Wed, 18 Mar 2015 11:55:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755822AbbCRKz2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Mar 2015 06:55:28 -0400
Received: from mail-ob0-f182.google.com ([209.85.214.182]:33086 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755424AbbCRKz1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Mar 2015 06:55:27 -0400
Received: by obcxo2 with SMTP id xo2so28836735obc.0
        for <git@vger.kernel.org>; Wed, 18 Mar 2015 03:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        bh=q5/nWVua2MDp3VRgx9tPI5uCL40zG9m5/8g6trvoO3k=;
        b=b18AsnuQcb++2xWRbAymGfT8WSagnNRuS0hZ6ZN++cYM1kRUlBRRAq3nmWKM3lrE8X
         Cr5EXpxbveebIbDu1GxOkM/ng9jncvruYJE0Z2A9CRL95VCeIpJXIF5sQVN2TzifxrUb
         VCcRG6g4EZpyviHFyPzC9MVwhuB0KDFmBiuaGgIqYCwMW4RAVnmjMwjNkcznC6bx9wn9
         GSyAQVl0mcCVylOfd16vLQD3wOHpvYYKfRUXAmLOSoZqWOsI29YjQYJ85Vh01CHAaEXR
         w4nFQB/9BD02ONyrXORPEB073XFHS3LY5YdtB6mgxq6VsJZiRwA2ph8t+8m0uqu6rARs
         G33A==
X-Received: by 10.202.102.96 with SMTP id a93mr6505497oic.36.1426676126913;
 Wed, 18 Mar 2015 03:55:26 -0700 (PDT)
Received: by 10.76.13.8 with HTTP; Wed, 18 Mar 2015 03:55:26 -0700 (PDT)
In-Reply-To: <CAABECY3HbZ4q3uo82outUmCyQLXO39H+Fd2m8bLwkaubE9gJCw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265716>

We have a fairly large repo (~2.4GB), mainly due to binary resources
(for an ios app). I know this can generally be a problem, but I have a
specific question.

If I cut a branch, and edit a few (non-binary) files, and push, what
should be uploaded? I assumed it was just the diff (I know whole
compressed files are used, I mean the differences between my branch
and where I cut it from). Is that correct?

Because when I push, it grinds to a halt at the 20% mark, and feels
like it's trying to push the entire repo. If I run "git diff --stat
--cached origin/foo" I see the files I would expect (i.e. just those
that have changed). If I run "git format-patch origin/foo..foo" the
patch files total 1.7MB, which should upload in just a few seconds,
but I've had pushes take over an hour. I'm using git 2.2.2 on Mac OS X
(Mavericks), and ssh (git@github.com).

Am I "doing it wrong"? Is this the expected behaviour? If not, is
there anything I can do to debug it?

Any help gratefully received.

Thanks,

Graham
