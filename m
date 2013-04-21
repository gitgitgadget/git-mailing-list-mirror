From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH/RFC] glossary: a revision is just a commit
Date: Sun, 21 Apr 2013 01:17:05 -0700
Message-ID: <20130421081705.GG10429@elie.Belkin>
References: <1366458313-7186-1-git-send-email-artagnon@gmail.com>
 <1366458313-7186-4-git-send-email-artagnon@gmail.com>
 <20130420222528.GA10043@elie.Belkin>
 <CALkWK0n7e-GQ8eBjgd4pnB5AzLGN0bik-n8_McbK68CvJh6P=A@mail.gmail.com>
 <20130421074118.GE10429@elie.Belkin>
 <CAPc5daVcovqrHP-YWnkcQWwev5TW5S8ioX-bWyAnNG2PTg_XMw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Thomas Ackermann <th.acker@arcor.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Apr 21 10:17:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UTpSc-0005ke-F1
	for gcvg-git-2@plane.gmane.org; Sun, 21 Apr 2013 10:17:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752477Ab3DUIRQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Apr 2013 04:17:16 -0400
Received: from mail-da0-f41.google.com ([209.85.210.41]:36998 "EHLO
	mail-da0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752359Ab3DUIRP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Apr 2013 04:17:15 -0400
Received: by mail-da0-f41.google.com with SMTP id p8so2463200dan.14
        for <git@vger.kernel.org>; Sun, 21 Apr 2013 01:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=OX0GK+4MhWbpC/8RNDK5JjgLlkM7COkw2FR8XV8r2tE=;
        b=TwoWzVgK+pUjBNxuiJhNaVF4MlWRR7UEBEQPgE1cnuXHoynpgeEbTO+BwEHj0OL26B
         Dn2mWtQeIFeP6fguQP6+eMrkmkvjZ6U3bUfwOKzUXTVeiZRmGRrPn8WYdDQ4lAO+LiDg
         rJ6r2bfBPX12kRYGyU3BL3b0A9mEYanPFjoORFAlPj0DyYBWegtHUZHPrM1HK1nfR70j
         FWaHlkikzzv/ZZxV/f/3DrFm9u3sWGfQm/VKmpRhzHHqZmiTlMO5mCLONXWrFReQWQPZ
         /+xiSa4mOgENmyZCsAsExRYaRSGgTVf4k29AGOzJ70E5zmD9RCBtYxh+Ppkw8lPt54kR
         W6iw==
X-Received: by 10.66.119.5 with SMTP id kq5mr10225507pab.193.1366532234398;
        Sun, 21 Apr 2013 01:17:14 -0700 (PDT)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id l4sm14660292pbo.6.2013.04.21.01.17.12
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 21 Apr 2013 01:17:13 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAPc5daVcovqrHP-YWnkcQWwev5TW5S8ioX-bWyAnNG2PTg_XMw@mail.gmail.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221918>

The current definition of 'revision' sounds like it is saying that a
revision is a tree object.  In reality it is just a commit.

This should be especially useful for people used to other revision
control systems trying to see how familiar concepts translate into git
terms.

Reported-by: Ramkumar Ramachandra <artagnon@gmail.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Junio C Hamano wrote:
> On Apr 21, 2013 12:41 AM, "Jonathan Nieder" <jrnieder@gmail.com> wrote:

>>> revision:: A particular state of files and directories which was
>>> stored in the object database. It is referenced by a commit object.
>>
>> So a revision is a tree?
[...]
> That's a historical misnomer. Some places in the documentation use revision
> as if the word were interchangeable with object name, and HEAD:path listed
> in specifying revision section is a prime example of it. What the section
> lists is historically called extended SHA-1 expression, essentially what
> get_sha1() can grok down to a single object name (as opposed to a slice of
> history, which is a revision range).

Thanks.

 Documentation/glossary-content.txt | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/Documentation/glossary-content.txt b/Documentation/glossary-content.txt
index eb7ba84f..521fceeb 100644
--- a/Documentation/glossary-content.txt
+++ b/Documentation/glossary-content.txt
@@ -430,9 +430,7 @@ should not be combined with other pathspec.
 	<<def_merge,merge>> left behind.
 
 [[def_revision]]revision::
-	A particular state of files and directories which was stored in the
-	<<def_object_database,object database>>. It is referenced by a
-	<<def_commit_object,commit object>>.
+	Synonym for <<def_commit,commit>> (the noun).
 
 [[def_rewind]]rewind::
 	To throw away part of the development, i.e. to assign the
-- 
1.8.2.1
