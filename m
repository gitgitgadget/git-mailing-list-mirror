From: =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: Re: [PATCH 05/38] refs: create a base class "ref_store" for
 files_ref_store
Date: Thu, 9 Jun 2016 23:54:48 +0200
Message-ID: <5759E5A8.9060000@web.de>
References: <cover.1464983301.git.mhagger@alum.mit.edu>
 <8ee7d7359f6763cba29dc788aba2f236204bb76e.1464983301.git.mhagger@alum.mit.edu>
 <xmqqfusprmeq.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	David Turner <dturner@twopensource.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 09 23:59:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bB7vk-0001lu-UX
	for gcvg-git-2@plane.gmane.org; Thu, 09 Jun 2016 23:56:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161002AbcFIVz2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jun 2016 17:55:28 -0400
Received: from mout.web.de ([212.227.15.14]:50749 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751936AbcFIVzY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jun 2016 17:55:24 -0400
Received: from [192.168.178.36] ([79.237.50.251]) by smtp.web.de (mrweb002)
 with ESMTPSA (Nemesis) id 0Lgpcs-1bqDTx2OpC-00oBb4; Thu, 09 Jun 2016 23:54:59
 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.2
In-Reply-To: <xmqqfusprmeq.fsf@gitster.mtv.corp.google.com>
X-Provags-ID: V03:K0:VxD5sOei8/ZqYR/jKcW4cYE0AknjEj6NVjXT80vjA9fxm0lNnHr
 +8tMGh9ws4gxdh02YL+LVUg8XCalBgCWl+xI27caHjlvaYEBw29LgyI/vq7v+z7rs3NWla1
 0c1fu9AY8TcAkPxbZKo1BDIn6lgBJOhbsp9ulkXpkjMBfBlfo3ciPZw/J4ywLB8W7XMcV+q
 dB40j/4vXMN5bKNhv6H6A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Gy+ldIp4nIM=:V1BC5wOK5PPzuy/3ya0N16
 6xz6LWVqBfeCMnatrqYfPB3PpwIwwU8C2gnNZ/h6EJg64vjST1NlgD+ICvX1kH9+OXvdMEh3T
 os5Qs41vQpA14vQ/3s31M80RHaJnmT32tE1Xn67wQZ/aTujqBcLNgiILQg7q9NJvfBKgqbj4D
 M40HDqXawDxeJngnkCBkvEnHZzeBp90VFfebIMvqFBru1ZWyOUSdK4ZEx2P2IrFS9XdUuhutP
 VjymLKIvrwgE5eBGXrQVx3yALfZw222dyOTDfqYeBmC8vL8yYAXEdGycDNRflhqvW1wghxfXt
 E9SsvmyLg0NlNX11FPQcnD2UBsqEpdZ8fJ4BUe40DFNPop9kaG5740IfBSEFM6WMAR9N1t7w8
 wL/gmHK1igkk+ocy8I8moUq26k23DSObORcOepwjJAKz6CtBv7n76eegjGIBxaxTySJbhJVv2
 qXt0Vq56DXxdH4TZHCSpJlAoOdmDntNw7K8dd6wNc9jyUcFZXSLo9noUu+/PTinTKlL1VnT9L
 jrOo0mBZqc9d1GcQYO5QdxKIWTIYsEiiw0sbBXMSbXcg9T5fxxAME7DlaV/mle7uC7sBMXDp3
 KLEfjPeRB3m3L/Hw7tCAl6xwv4imJjn8FFw2OEzW2NDm5I/aqzn4ULjjnwqKulU7jwSYJTYR5
 SzkS8Pw8HOJgm1WNA9Z+tlBLTbyK1l0xVs6EdDpIdIL8QDeGxFKxWd++hTos9VrBko4g/zH1v
 Gi2Tl0+9lEx/vcGbr/kvCadGf3+Sp7YAMnomBi3kvMKQEIYrOljbTj68meI0tRyG2KGak5KC 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296933>

Am 07.06.2016 um 18:31 schrieb Junio C Hamano:
> This is a tangent, but your series that ends at 4aa2c475 (grep: -W:
> don't extend context to trailing empty lines, 2016-05-28) does not
> seem to have much effect when viewing the change to refs.c this
> patch makes (it modifies a function in an early part, and then adds
> bunch of new functions at the end) with "git show -W".
> 
> Thanks.

Good catch, thanks!

-- >8 --
Subject: [PATCH] xdiff: fix merging of appended hunk with -W

When -W is given we search the lines between the end of the current
context and the next change for a function line.  If there is none then
we merge those two hunks as they must be part of the same function.

If the next change is an appended chunk we abort the search early in
get_func_line(), however, because its line number is out of range.  Fix
that by searching from the end of the pre-image in that case instead.

Reported-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 t/t4051-diff-function-context.sh | 24 +++++++++++++++++++++++-
 xdiff/xemit.c                    |  3 ++-
 2 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/t/t4051-diff-function-context.sh b/t/t4051-diff-function-context.sh
index b6bb04a..b79b877 100755
--- a/t/t4051-diff-function-context.sh
+++ b/t/t4051-diff-function-context.sh
@@ -64,7 +64,13 @@ test_expect_success 'setup' '
 
 	grep -v "Begin of second part" <file.c >file.c.new &&
 	mv file.c.new file.c &&
-	commit_and_tag long_common_tail file.c
+	commit_and_tag long_common_tail file.c &&
+
+	git checkout initial &&
+	grep -v "delete me from hello" <file.c >file.c.new &&
+	mv file.c.new file.c &&
+	cat "$dir/appended1.c" >>file.c &&
+	commit_and_tag changed_hello_appended file.c
 '
 
 check_diff changed_hello 'changed function'
@@ -157,4 +163,20 @@ test_expect_success ' context does not include preceding empty lines' '
 	test "$(first_context_line <long_common_tail.diff.diff)" != " "
 '
 
+check_diff changed_hello_appended 'changed function plus appended function'
+
+test_expect_success ' context includes begin' '
+	grep "^ .*Begin of hello" changed_hello_appended.diff &&
+	grep "^[+].*Begin of first part" changed_hello_appended.diff
+'
+
+test_expect_success ' context includes end' '
+	grep "^ .*End of hello" changed_hello_appended.diff &&
+	grep "^[+].*End of first part" changed_hello_appended.diff
+'
+
+test_expect_success ' context does not include other functions' '
+	test $(grep -c "^[ +-].*Begin" changed_hello_appended.diff) -le 2
+'
+
 test_done
diff --git a/xdiff/xemit.c b/xdiff/xemit.c
index bfa53d3..49aa16f 100644
--- a/xdiff/xemit.c
+++ b/xdiff/xemit.c
@@ -246,7 +246,8 @@ int xdl_emit_diff(xdfenv_t *xe, xdchange_t *xscr, xdemitcb_t *ecb,
 			 * its new end.
 			 */
 			if (xche->next) {
-				long l = xche->next->i1;
+				long l = XDL_MIN(xche->next->i1,
+						 xe->xdf1.nrec - 1);
 				if (l <= e1 ||
 				    get_func_line(xe, xecfg, NULL, l, e1) < 0) {
 					xche = xche->next;
-- 
2.8.3
