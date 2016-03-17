From: Stefan Beller <sbeller@google.com>
Subject: [PATCH] send-email: ignore trailing whitespace in mailrc alias file
Date: Thu, 17 Mar 2016 15:08:16 -0700
Message-ID: <1458252496-4118-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: peff@peff.net, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Mar 17 23:08:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agg5l-0003EC-HO
	for gcvg-git-2@plane.gmane.org; Thu, 17 Mar 2016 23:08:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1032107AbcCQWI0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Mar 2016 18:08:26 -0400
Received: from mail-pf0-f172.google.com ([209.85.192.172]:34659 "EHLO
	mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932621AbcCQWIY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Mar 2016 18:08:24 -0400
Received: by mail-pf0-f172.google.com with SMTP id x3so137945890pfb.1
        for <git@vger.kernel.org>; Thu, 17 Mar 2016 15:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=5Oe2TLacUZkFWKBwonP2BOD6pPIDKxwtMq1CuHwGGks=;
        b=VpgZd6wE/JBsk9R/1Cr0vdyGvucMUMjuH02AyyOlmschG7ZmW+WZXLWlyPxFRwjUOC
         gMHY9gwejYDcVOkmXv204T4tQHy2lsHITrWtd5nXZbcNt9PtoIF38ZiiIpg5a2yVnSW0
         TGK7xYsTWtTW51XZUKUUrPXy4Uoxrnhe/6PvL2hL3t6/ybzcq+fUVTvyWl+SS+Hf5gQl
         4yvoumz53EZ5EGHzjlOTZ94HNcCc1Ql4LN+lgkfL8SteGmoHy/qD/6zfIq3VZNmBpgut
         QRxl63Hl1bamIjWzYOVrvvPrEntKc/wgQeY6wLeR3de6NCbSxTmpwuOrlX4dKsjHkp0i
         rxTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=5Oe2TLacUZkFWKBwonP2BOD6pPIDKxwtMq1CuHwGGks=;
        b=iNDfhCN0B4A7RC4vvDT8EpWLVUZMG//CcL6EiLOKGjIg44iumBIGwe6rZW0iiIuzZ0
         NmjIiSodTjzFP9cspYvKO/Z3sKh/zsATuaXgG775t6yVnWJxmpqUlqrCwhE/h9QJ3i3f
         19W3e9jSS/GFNdCDzDJlvjJ6Z+8kn42GH7Ijh5Rsze4nSCyFUh2qnXz2OBp74xLEPV6K
         OMTbft0eTzjDtd9cT/UTUPsVxpJ5XTlXUEszl/ESoFfzMiwLk8AefAzdkrFdOvLk66Z5
         Y17RnYjmUgQ+W0t1IgHkDhugpOT5KL63I5JhXYSucWfIw97wazVv3RDRozJbgeIqL3po
         hQPA==
X-Gm-Message-State: AD7BkJJdIcoQLrYQYQ3gwe/tYAX86waI5dsQJMSkCDUkslswsboB5TkHNTkPtQIKWZbR1nMv
X-Received: by 10.98.18.28 with SMTP id a28mr18427911pfj.145.1458252503274;
        Thu, 17 Mar 2016 15:08:23 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:d62:319:527b:e183])
        by smtp.gmail.com with ESMTPSA id 17sm15691348pfs.40.2016.03.17.15.08.22
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 17 Mar 2016 15:08:22 -0700 (PDT)
X-Mailer: git-send-email 2.8.0.rc3.2.ga804a9e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289163>

From: Jeff King <peff@peff.net>

This fixes send-email which would not work with mailrc alias files
which had trailing whitespaces.

Signed-off-by: Stefan Beller <sbeller@google.com>
---

> On Thu, Mar 17, 2016 at 10:47:50AM -0700, Stefan Beller wrote:
>
> sent from git-send-email with a corrupt .mailrc file.
> 
> Great, but could probably use a better commit message. ;P
> 
> -Peff

Uhm, yes. Why do you ask? ;) 
I forgot again that it is too late to edit the patch when send-email asks:
> Send this email? ([y]es|[n]o|[q]uit|[a]ll): 
as it has read the patch from disk and keeps it in memory I assume?

I just wrote the commit message as I would do, but offer you to claim authorship
for that perl stuff. So in case you'd want to reword that, I'd ask you to that.
Also asking for your signoff. (But apart from that I consider this patch final.)

Thanks,
Stefan

diff --git a/git-send-email.perl b/git-send-email.perl
index d356901..c45b22a 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -533,7 +533,7 @@ my %parse_alias = (
 			$aliases{$alias} = \@addr
 		}}},
 	mailrc => sub { my $fh = shift; while (<$fh>) {
-		if (/^alias\s+(\S+)\s+(.*)$/) {
+		if (/^alias\s+(\S+)\s+(.*?)\s*$/) {
 			# spaces delimit multiple addresses
 			$aliases{$1} = [ quotewords('\s+', 0, $2) ];
 		}}},
