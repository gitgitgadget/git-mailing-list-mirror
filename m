From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: t6392 broken on pu (Mac OS X)
Date: Sat, 7 May 2016 18:15:19 +0200
Message-ID: <dea0877d-fe83-fb47-4df3-21fd69d8421d@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Karthik Nayak <karthik.188@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat May 07 18:19:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1az4t8-0007Pv-E9
	for gcvg-git-2@plane.gmane.org; Sat, 07 May 2016 18:15:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750755AbcEGQP0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 May 2016 12:15:26 -0400
Received: from mout.web.de ([212.227.15.3]:52556 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750744AbcEGQPZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 May 2016 12:15:25 -0400
Received: from macce.local ([195.252.60.88]) by smtp.web.de (mrweb003) with
 ESMTPSA (Nemesis) id 0MeSLv-1bHYpz3zpf-00QCu4; Sat, 07 May 2016 18:15:21
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:45.0)
 Gecko/20100101 Thunderbird/45.0
X-Provags-ID: V03:K0:20kBpg/o5JVqlh8zDSHicgumlmuu9ysxUBx8L1yLPg2p5TmrDp2
 v4fFkh9B+ZzHuhoBDoFm+6bLbu/m/kxs5rfRFfF8omEvQXmbgXSf2o+Z9fiBXTjhCz/8Ii1
 CC7pHh2RQq8x0ZeXDsAz/l0s7bnMKBJKbiJHDaill74hc6vN0oNIfeJFbpGuxe+kxqGyZAB
 +CUfLF7FovVZJAVmkhxNw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Fqw/ignQ4LY=:JeGtkxhhCdkDm+CdY/LnzQ
 qcltyIZa6mUwlO49qblYVmdjy36J4XXBowY7Fq839DJK9oL+XhTF0DwPtV7pedP4VJOM7Awxr
 h8B+M2NIf1SVR8Jj4SywwfizBSV1+KglzzesbT3vvs7AOTIWmbY/I50gc5Cq0VXMOlI7nyPXR
 dSfHQ/WlxC6L2svxgl5VyL1Bar6m37R2yzs0OM3rwxclWHWfwkUFVHhWNWTBDO6A6rqis668H
 lE3Hme+4REnZmvWfcezp4l5Rasdo4jiCuY9aEwG7n49wgq7yBLvu4+h66cF8i8YAGQ40b1i4X
 /kwA0CPj5xE2lPqvpNjBLUhei4163LsPaDF8qhqff48SSchUgC3xHE5r4v3wb2oLbCPKqzs3r
 p6TquEzbflhp5qxZP8UHIy2mqbhusqIFZvxHEicGJq2N0Z8AtSArIf6KNaLz/2ELyf6gpH+Q+
 ks3lgiUl6/axsgAZkpbombBZJhixYZd6bmNkM3kuSivtCuLuF7taIC1CdR8NduFfqE7hJuhO3
 GlgbmOY2I9n9b8B53dcyHlS2vzyT38W6Q/Sd3DPUUNE1i4hYPLbSagQxYMSG9lhoVwcTcKWrq
 kvNAk9KH+Mgi8rQzPRdTF1dWxcmPGuRi4HC8s2KHZhoPcWpZjEYqA0DhRhOUPJCCukWq/5ZZG
 DetToPc/tmAOEZ6+CSHwOYLjIlfBvA+HKvFamJ/a3CI1xyGADmYp1p+lUi5eASeWZT/fJ4oEZ
 W7W51lLXaogFvASvpOdgTPXfF1KG1GAAdAx1pJIVs4ZjpqTgQ/bquHxGG5ehlE3GtEgSFZVN 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293901>

These tests fail here under Mac OS,
they pass under Linux:
commit ff3d9b660a4b6e9d3eeb664ce1febe717adff737
I haven't had a chance to dig further.


expecting success:
	git for-each-ref --format="%(if)%(authorname)%(then)%(authorname):
%(refname)%(end)" >actual &&
	cat >expect <<-\EOF &&
	A U Thor: refs/heads/master
	A U Thor: refs/heads/side
	A U Thor: refs/odd/spot



	A U Thor: refs/tags/foo1.10
	A U Thor: refs/tags/foo1.3
	A U Thor: refs/tags/foo1.6
	A U Thor: refs/tags/four
	A U Thor: refs/tags/one

	A U Thor: refs/tags/three
	A U Thor: refs/tags/two
	EOF
	test_cmp expect actual

--- expect	2016-05-07 16:08:32.000000000 +0000
+++ actual	2016-05-07 16:08:32.000000000 +0000
@@ -3,12 +3,10 @@
 A U Thor: refs/odd/spot


-
 A U Thor: refs/tags/foo1.10
 A U Thor: refs/tags/foo1.3
 A U Thor: refs/tags/foo1.6
 A U Thor: refs/tags/four
 A U Thor: refs/tags/one
-
 A U Thor: refs/tags/three
 A U Thor: refs/tags/two
not ok 34 - check %(if)...%(then)...%(end) atoms
#	
#		git for-each-ref --format="%(if)%(authorname)%(then)%(authorname):
%(refname)%(end)" >actual &&
#		cat >expect <<-\EOF &&
#		A U Thor: refs/heads/master
#		A U Thor: refs/heads/side
#		A U Thor: refs/odd/spot
#	
#	
#	
#		A U Thor: refs/tags/foo1.10
#		A U Thor: refs/tags/foo1.3
#		A U Thor: refs/tags/foo1.6
#		A U Thor: refs/tags/four
#		A U Thor: refs/tags/one
#	
#		A U Thor: refs/tags/three
#		A U Thor: refs/tags/two
#		EOF
#		test_cmp expect actual
#	

expecting success:
	git for-each-ref --format="%(if)%(authorname)%(then)%(authorname)%(else)No
author%(end): %(refname)" >actual &&
	cat >expect <<-\EOF &&
	A U Thor: refs/heads/master
	A U Thor: refs/heads/side
	A U Thor: refs/odd/spot
	No author: refs/tags/annotated-tag
	No author: refs/tags/doubly-annotated-tag
	No author: refs/tags/doubly-signed-tag
	A U Thor: refs/tags/foo1.10
	A U Thor: refs/tags/foo1.3
	A U Thor: refs/tags/foo1.6
	A U Thor: refs/tags/four
	A U Thor: refs/tags/one
	No author: refs/tags/signed-tag
	A U Thor: refs/tags/three
	A U Thor: refs/tags/two
	EOF
	test_cmp expect actual

--- expect	2016-05-07 16:08:32.000000000 +0000
+++ actual	2016-05-07 16:08:32.000000000 +0000
@@ -3,12 +3,10 @@
 A U Thor: refs/odd/spot
 No author: refs/tags/annotated-tag
 No author: refs/tags/doubly-annotated-tag
-No author: refs/tags/doubly-signed-tag
 A U Thor: refs/tags/foo1.10
 A U Thor: refs/tags/foo1.3
 A U Thor: refs/tags/foo1.6
 A U Thor: refs/tags/four
 A U Thor: refs/tags/one
-No author: refs/tags/signed-tag
 A U Thor: refs/tags/three
 A U Thor: refs/tags/two
not ok 35 - check %(if)...%(then)...%(else)...%(end) atoms
#	
#		git for-each-ref --format="%(if)%(authorname)%(then)%(authorname)%(else)No
author%(end): %(refname)" >actual &&
#		cat >expect <<-\EOF &&
#		A U Thor: refs/heads/master
#		A U Thor: refs/heads/side
#		A U Thor: refs/odd/spot
#		No author: refs/tags/annotated-tag
#		No author: refs/tags/doubly-annotated-tag
#		No author: refs/tags/doubly-signed-tag
#		A U Thor: refs/tags/foo1.10
#		A U Thor: refs/tags/foo1.3
#		A U Thor: refs/tags/foo1.6
#		A U Thor: refs/tags/four
#		A U Thor: refs/tags/one
#		No author: refs/tags/signed-tag
#		A U Thor: refs/tags/three
#		A U Thor: refs/tags/two
#		EOF
#		test_cmp expect actual
#	

expecting success:
	git for-each-ref --format="%(refname:short): %(if)%(HEAD)%(then)Head
ref%(else)Not Head ref%(end)" >actual &&
	cat >expect <<-\EOF &&
	master: Head ref
	side: Not Head ref
	odd/spot: Not Head ref
	annotated-tag: Not Head ref
	doubly-annotated-tag: Not Head ref
	doubly-signed-tag: Not Head ref
	foo1.10: Not Head ref
	foo1.3: Not Head ref
	foo1.6: Not Head ref
	four: Not Head ref
	one: Not Head ref
	signed-tag: Not Head ref
	three: Not Head ref
	two: Not Head ref
	EOF
	test_cmp expect actual

--- expect	2016-05-07 16:08:32.000000000 +0000
+++ actual	2016-05-07 16:08:32.000000000 +0000
@@ -3,12 +3,10 @@
 odd/spot: Not Head ref
 annotated-tag: Not Head ref
 doubly-annotated-tag: Not Head ref
-doubly-signed-tag: Not Head ref
 foo1.10: Not Head ref
 foo1.3: Not Head ref
 foo1.6: Not Head ref
 four: Not Head ref
 one: Not Head ref
-signed-tag: Not Head ref
 three: Not Head ref
 two: Not Head ref
not ok 36 - ignore spaces in %(if) atom usage
#	
#		git for-each-ref --format="%(refname:short): %(if)%(HEAD)%(then)Head
ref%(else)Not Head ref%(end)" >actual &&
#		cat >expect <<-\EOF &&
#		master: Head ref
#		side: Not Head ref
#		odd/spot: Not Head ref
#		annotated-tag: Not Head ref
#		doubly-annotated-tag: Not Head ref
#		doubly-signed-tag: Not Head ref
#		foo1.10: Not Head ref
#		foo1.3: Not Head ref
#		foo1.6: Not Head ref
#		four: Not Head ref
#		one: Not Head ref
#		signed-tag: Not Head ref
#		three: Not Head ref
#		two: Not Head ref
#		EOF
#		test_cmp expect actual
#	
