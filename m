From: =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: Re: [PATCH v2.5 1/8] t4051: rewrite, add more tests
Date: Tue, 31 May 2016 22:15:36 +0200
Message-ID: <574DF0E8.8060908@web.de>
References: <xmqqh9e5mvjs.fsf@gitster.mtv.corp.google.com>
 <xmqq4ma5msrd.fsf@gitster.mtv.corp.google.com> <5740AC28.6010202@web.de>
 <5749AF59.2070704@web.de> <5749B1EA.10707@web.de>
 <xmqqinxwpgfn.fsf@gitster.mtv.corp.google.com> <574DED66.6050008@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Ramsay Jones <ramsay@ramsayjones.plus.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 31 22:15:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b7q4z-0004qD-Sl
	for gcvg-git-2@plane.gmane.org; Tue, 31 May 2016 22:15:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756413AbcEaUPx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 May 2016 16:15:53 -0400
Received: from mout.web.de ([217.72.192.78]:50195 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756398AbcEaUPw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 May 2016 16:15:52 -0400
Received: from [192.168.178.36] ([79.213.120.243]) by smtp.web.de (mrweb101)
 with ESMTPSA (Nemesis) id 0LpwB1-1bkSoj1frb-00ffN1; Tue, 31 May 2016 22:15:42
 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.2
In-Reply-To: <574DED66.6050008@web.de>
X-Provags-ID: V03:K0:YylIHGplAq9iw3j0vEK4Gbcu6GmVKyIfCafyxfjNXdvRTnll0mT
 WwPfphXTthMtoZClqECyT0KnF/J9AqeBH0GccOqoUfYP/pwBI/X5ybnbQvPsuyAbdvPxQHA
 RRp/jHqZb9LA7fAP7Dn1ozMSc4k8HDfzRfUQEgVlJ7PefKjAcZsHdEQxSSv7MZJDMhBl4Vk
 3R0B/WNroExzWvC9Oxz8Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:qU+IYIYVAX8=:UffC3WQsm5bNX6/8JNeLDR
 bLuH4cjE+hhwbJm6+SbDfHewtoKuc+G9nRtHpuUBHBN7xpzoj7f7nNhVhhNoHw2N2TOK236hC
 MtKmJTE/nlf9n8e9gxy2qHIUVgnVpcFww4LGffgxLFvHhBr/pI/zemwDMY4aPx2JZJfjdag8M
 UT87guo8lQkZ8OY807flhyqqxHfVdKvhuWuuXPmw8rkTW1dBRiZj93O1xPLtRwxmr2QhL8s0W
 v9XhB+yB6eZgtCPbMvpJhQmW1d7X1wKDfKiuRBa6NnRIklOy5q2g33z/yQQ4mDjdInVgWWp77
 bM/vugswQ/j1fKpUUv9Gtj8DPNEYMMDpkk8KqssK7JEvg6NbWipvsVXVIUHubRkvkwfYXkgbR
 LtZQg9xwMaSPQ7mByULTaXVyKuhxmLNmUl8ykDtHjYO0+F5+ipqM2rKG6fpOXyq1j5OdJ8vNK
 aIXoaSaXN4GCambGtB4fjDGZge+kfFj1vW9lFgh2/RO2NVI9VTvdlP6GrXLvR4VCowjfyfIIv
 s3+3/XAusvkGqsiNUXFee9pJk8Dt/oJEOFS03GCKIN4qNUK+UVu+G6x0yrDxLotACWv4vZmAh
 XQKaJR7Wr/9Bv49C/daOCpkEbciydZ4SyeK+sYVJTOpIF9eT9DC4G/N5NtLzHvP2BlHeAy+VX
 gWdpOAlO/qmYYma0Fo4Kll58vou6OPYAyEQxqWbIehOEAL5KvbdxSugzEyh0U2Uiivbutn9+Z
 kQhGnsagd+LEg8lgENOO08FDC90ToVVMZoridGHBMRKYQbP3xO3jc0AIWz9jOeQFm0x6zxSV 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296011>

Interdiff between v2 and v2.5:
- Rename $message to $tag, as that fits its purpose better, and quote it.
- Quote $@.
- Use the most common sed invocation from t/ for getting the last line of
  a file, for consistency.
- Use apply --index to make sure we notice if the generated diff adds or
  deletes files unintendedly.
---
 t/t4051-diff-function-context.sh | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/t/t4051-diff-function-context.sh b/t/t4051-diff-function-context.sh
index 88a3308..b6bb04a 100755
--- a/t/t4051-diff-function-context.sh
+++ b/t/t4051-diff-function-context.sh
@@ -7,12 +7,12 @@ test_description='diff function context'
 dir="$TEST_DIRECTORY/t4051"
 
 commit_and_tag () {
-	message=$1 &&
+	tag=$1 &&
 	shift &&
-	git add $@ &&
+	git add "$@" &&
 	test_tick &&
-	git commit -m $message &&
-	git tag $message
+	git commit -m "$tag" &&
+	git tag "$tag"
 }
 
 first_context_line () {
@@ -23,7 +23,7 @@ first_context_line () {
 }
 
 last_context_line () {
-	sed -n '$ p'
+	sed -ne \$p
 }
 
 check_diff () {
@@ -38,7 +38,7 @@ check_diff () {
 	test_expect_success ' diff applies' '
 		test_when_finished "git reset --hard" &&
 		git checkout --detach "$name^" &&
-		git apply "$name.diff" &&
+		git apply --index "$name.diff" &&
 		git diff --exit-code "$name"
 	'
 }
