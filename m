From: Michal Nazarewicz <mpn@google.com>
Subject: [PATCHv4 1/6] Git.pm: allow command_close_bidi_pipe to be called as method
Date: Tue, 12 Feb 2013 15:02:28 +0100
Message-ID: <df0bb01e70629e8170b022867c6e70a8d1b88768.1360677646.git.mina86@mina86.com>
References: <cover.1360677646.git.mina86@mina86.com>
Cc: git@vger.kernel.org
To: peff@peff.net, gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Feb 12 15:04:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U5GSy-0000kl-Cx
	for gcvg-git-2@plane.gmane.org; Tue, 12 Feb 2013 15:04:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933276Ab3BLODR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Feb 2013 09:03:17 -0500
Received: from mail-ee0-f45.google.com ([74.125.83.45]:55697 "EHLO
	mail-ee0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933262Ab3BLODO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Feb 2013 09:03:14 -0500
Received: by mail-ee0-f45.google.com with SMTP id b57so54934eek.32
        for <git@vger.kernel.org>; Tue, 12 Feb 2013 06:03:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:in-reply-to:references;
        bh=Sw/M1pqqb8cSnPqKAtCOMetWektrElXWSng6CDgniV0=;
        b=B/JeJ3IQE0diuZ9elnRavtMoVi/cp6ZcgsnLLnQStUW5ohmpxyNuWEJQ8PMvhFK9Vd
         /VdgTDllZbkrORtAkZUddpOtNgIO4ozhvAgJhpXW8pWSeHDey1cUsMXLXgh+MrRAcOin
         23XovOk89ewkpSiqDJdgDgbDKCvdABTB9LP8QB4IYPmptPF87rJynb6nUAGoon1fMMja
         tPZFzqRPxkfvP7lIEWOQtmKHPBYbcfzbT1EQjO/JklwhaB4CBPgvFgvkRmQZ5E5mOSVm
         xQ8E/Q0CLVtzUh7vUg46AmkLltm6RPAgkLMmVg96gtd1SvRdAgUdsNRN88MMiFFFKL/e
         t0lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:in-reply-to:references:x-gm-message-state;
        bh=Sw/M1pqqb8cSnPqKAtCOMetWektrElXWSng6CDgniV0=;
        b=WO+D7HkqkqTXcu4h7nQviTDvR/+C3T+yVE+jp8gks+OGJ/w05EyG2O2dOg9DSXTO4O
         dnjtDA+8wrIkypSuAE6T2jRAMMC7opl3n7kiyYEfcyxPgl41Jjwzvk/zPJxOjOYJfNjP
         XGd00KWhEdi4DklBnLjYJT9vW9XBX83A1gn7G7gKVDF7q1NtE4DS5cygidBwdUoaEOyZ
         szhFjR4LCoIQd1wRUJtaKjK9Tla397V/JZYj8Q5jxjU8WK4ORN8bYm72C6uHsTCPgiLR
         ahBL4MQFufqGcL81pus4kNTWuT1AHJWa+CLAsTLpzkSGak1Y0MXjUlGjj1QD6HK33pMf
         jzfA==
X-Received: by 10.14.194.4 with SMTP id l4mr64029486een.12.1360677779658;
        Tue, 12 Feb 2013 06:02:59 -0800 (PST)
Received: from mpn-glaptop.corp.google.com ([2620:0:105f:5:6552:be17:7596:e60d])
        by mx.google.com with ESMTPS id 44sm68000941eek.5.2013.02.12.06.02.58
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 12 Feb 2013 06:02:58 -0800 (PST)
X-Mailer: git-send-email 1.8.1.3.572.g32bae1f
In-Reply-To: <cover.1360677646.git.mina86@mina86.com>
In-Reply-To: <cover.1360677646.git.mina86@mina86.com>
References: <cover.1360677646.git.mina86@mina86.com>
X-Gm-Message-State: ALoCoQlf31lzqxOaHCAO6brH3fdi0AFCd0eNePYtM+uYT+Ht4NRRi7xF1ZA1XgMj1UZqZfgnqjB0ybKx4+LzfV1EY6Wv9vQInUAt88yA/UvZraKh7gwR4lyMl74JdMMYa3E+MW9yVprh/zHQusnGlFjGzoIuJDevUE2xgfSZqwtOqTQSxnQ1QBggylsIjBzckdTL0GMKl0aq
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216156>

From: Michal Nazarewicz <mina86@mina86.com>

The documentation of command_close_bidi_pipe() claims that it can
be called as a method, but it does not check whether the first
argument is $self or not assuming the latter.  Using _maybe_self()
fixes this.

Signed-off-by: Michal Nazarewicz <mina86@mina86.com>
---
 perl/Git.pm | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/perl/Git.pm b/perl/Git.pm
index 931047c..bbb753a 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -430,7 +430,7 @@ have more complicated structure.
 
 sub command_close_bidi_pipe {
 	local $?;
-	my ($pid, $in, $out, $ctx) = @_;
+	my ($self, $pid, $in, $out, $ctx) = _maybe_self(@_);
 	foreach my $fh ($in, $out) {
 		unless (close $fh) {
 			if ($!) {
-- 
1.8.1.3.572.g32bae1f
