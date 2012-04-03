From: Adam Monsen <haircut@gmail.com>
Subject: Re: [PATCH 0/3] "commit --template" fixes
Date: Tue, 03 Apr 2012 10:11:17 -0700
Message-ID: <4F7B2F35.40807@gmail.com>
References: <7vaa2ylzrm.fsf@alter.siamese.dyndns.org> <1333136719-12657-1-git-send-email-gitster@pobox.com> <4F775ACF.50007@gmail.com> <7vaa2vhyso.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Ivan Heffner <iheffner@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 03 19:11:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SF7GR-000060-D3
	for gcvg-git-2@plane.gmane.org; Tue, 03 Apr 2012 19:11:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753890Ab2DCRLX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Apr 2012 13:11:23 -0400
Received: from mail-qc0-f174.google.com ([209.85.216.174]:39824 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753001Ab2DCRLV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Apr 2012 13:11:21 -0400
Received: by qcro28 with SMTP id o28so1008092qcr.19
        for <git@vger.kernel.org>; Tue, 03 Apr 2012 10:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        bh=Q4ecbWy1CdHb6sVyHT2GZZtnBaTNDutvTG0lLPT8Uac=;
        b=0N9eByYgRw+G1OJopoLfudRAX/mXRO5JHNmsh1VGxwYnqwoJNwD9qGYPpLuQ6Ty19j
         kVt25arIhYUzWOfgZOLqNZ6PLakF5g0OR7Aem/VTv7FsPL9z9Gsd9M+waPoQZVWXm9Qr
         GFfCupFpcVkXopp9RxMPTHQd/bgQSGvMBDLu2tomXZfYgb4B53CU8gpwdRS+olMzAPt6
         wUJWqi3yA4Wv/HLE//Oz0U3doml0KF6M3aOUY982MFnGGnvO/OA6Z+x0Ez8PyM3gSl1K
         +p3MfjgkO9VIy5No0+X7bRqccq6jfVYgvmujNxEQ8yc2fViXlEgEUBgGXfx6u7eZP+i3
         rksw==
Received: by 10.229.111.66 with SMTP id r2mr5410542qcp.140.1333473080136;
        Tue, 03 Apr 2012 10:11:20 -0700 (PDT)
Received: from [192.168.13.92] (c-67-183-137-177.hsd1.wa.comcast.net. [67.183.137.177])
        by mx.google.com with ESMTPS id 1sm40517212qac.3.2012.04.03.10.11.18
        (version=SSLv3 cipher=OTHER);
        Tue, 03 Apr 2012 10:11:19 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:11.0) Gecko/20120310 Thunderbird/11.0
In-Reply-To: <7vaa2vhyso.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194633>

On 04/01/2012 03:28 PM, Junio C Hamano wrote:
> One established way to do this is to have a discussion like the above
> (mostly elided), followed by a "scissors" line...

I can do that. Thanks!

> When rewording or clarifying only a handful of words in the documentation,
> it is often better to avoid reflowing lines in the same patch.

I thought of that, but it made the right margin jagged. :)
My new suggestion (below) isolates the changes a bit better.

> This is a tangent, but we might want to rephrase the first sentence
> without using the word "version"; every time I read this paragraph, the
> "initial version" makes me go "Huh?" because the word sounds as if it is
> talking about commits in the context of SCM, which is not the case here.

Yeah, that bugs me too.

How about this? I'm a little bummed it doesn't include why
commit --template exists at all, but it reads well: terse and to the
point like (IMHO) a manpage should.

-- >8 --
Subject: [PATCH v4] git-commit.txt: clarify -t requires editing message

Make it clear that, when using commit --template, the message *must* be
changed or the commit will be aborted.

Also, remove the words "initial version" to avoid confusion. Commit
messages are not versioned independently of commits.

Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Ivan Heffner <iheffner@gmail.com>
Signed-off-by: Adam Monsen <haircut@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
Replaces b0ad5e27803cd of jc/commit-unedited-template. I'm assuming that's ok
since the branch isn't merged into maint or master.

 Documentation/git-commit.txt |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index 5cc84a1..bd82431 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -132,9 +132,9 @@ OPTIONS
 
 -t <file>::
 --template=<file>::
-	Use the contents of the given file as the initial version
-	of the commit message. The editor is invoked and you can
-	make subsequent changes. If a message is specified using
+	Use the contents of the given file as the commit message. The
+	editor is invoked so you can make subsequent changes. If you make no
+	changes, the commit is aborted. If a message is specified using
 	the `-m` or `-F` options, this option has no effect. This
 	overrides the `commit.template` configuration variable.
 
-- 
1.7.5.4
