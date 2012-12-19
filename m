From: Junio C Hamano <gitster@pobox.com>
Subject: [RFC/PATCH] compat/fnmatch: update old-style definition to ANSI
Date: Wed, 19 Dec 2012 09:08:45 -0800
Message-ID: <7vvcby9dgi.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 19 18:09:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TlN8k-0002Pc-E8
	for gcvg-git-2@plane.gmane.org; Wed, 19 Dec 2012 18:09:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755644Ab2LSRIt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Dec 2012 12:08:49 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45374 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755431Ab2LSRIs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Dec 2012 12:08:48 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6D2D8B721;
	Wed, 19 Dec 2012 12:08:47 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=I
	7WMF+3WiD1zhWbnQIThZtxg77Y=; b=cuykUAnWqlDwCQqhdAMIZZfHk6e4T0DrS
	hQuygTjF41GQXJsdUGPJJEm5RGMo4avU36AsvfwQDEteLbjvHPBb5fTFVv7h0NRY
	MBVVfJo1UNSCNJESCVVSkb/D9WxKcfopDR+WfgYQLVUCjgtmAa45kg/jSJFyGaZX
	W1m58kJ1ZU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=SQt
	SipgXAJLeqouJ/lwu9ug+NlCXd2Np/1ZJBA32zRsFXaTBVc+yatAW9Uelw32+NZH
	hZerhAPO7ulGidFbi2yE8D0tUcmZEmad9fNrsryvqnjLdSMnLeImY0KkLrPES4TI
	hsyNNdfZ3eLPuqfGjyXTa6oAYxZ2+6pRAk2xV2rM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 59415B720;
	Wed, 19 Dec 2012 12:08:47 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A3B6CB71D; Wed, 19 Dec 2012
 12:08:46 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C0098606-49FE-11E2-AE8C-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211835>

We usually try to avoid touching borrowed code, but we encourage
people to code without old-style definition these days and compile
with -Werror, and on platforms that need to use NO_FNMATCH, these
three functions make the compilation fail.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 compat/fnmatch/fnmatch.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/compat/fnmatch/fnmatch.c b/compat/fnmatch/fnmatch.c
index 0ff1d27..b8b7dc2 100644
--- a/compat/fnmatch/fnmatch.c
+++ b/compat/fnmatch/fnmatch.c
@@ -135,9 +135,9 @@ extern int errno;
 
 # if !defined HAVE___STRCHRNUL && !defined _LIBC
 static char *
-__strchrnul (s, c)
-     const char *s;
-     int c;
+__strchrnul (const char *s, int c)
+
+
 {
   char *result = strchr (s, c);
   if (result == NULL)
@@ -159,11 +159,11 @@ static int internal_fnmatch __P ((const char *pattern, const char *string,
      internal_function;
 static int
 internal_function
-internal_fnmatch (pattern, string, no_leading_period, flags)
-     const char *pattern;
-     const char *string;
-     int no_leading_period;
-     int flags;
+internal_fnmatch (const char *pattern, const char *string, int no_leading_period, int flags)
+
+
+
+
 {
   register const char *p = pattern, *n = string;
   register unsigned char c;
@@ -481,10 +481,10 @@ internal_fnmatch (pattern, string, no_leading_period, flags)
 
 
 int
-fnmatch (pattern, string, flags)
-     const char *pattern;
-     const char *string;
-     int flags;
+fnmatch (const char *pattern, const char *string, int flags)
+
+
+
 {
   return internal_fnmatch (pattern, string, flags & FNM_PERIOD, flags);
 }
-- 
1.8.1.rc2.196.g654d69e
