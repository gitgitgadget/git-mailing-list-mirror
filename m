From: bdowning@lavos.net (Brian Downing)
Subject: Re: Preferring shallower deltas on repack
Date: Mon, 9 Jul 2007 15:23:04 -0500
Message-ID: <20070709202304.GP4087@lavos.net>
References: <20070709044326.GH4087@lavos.net> <7v1wfixhvk.fsf@assigned-by-dhcp.cox.net> <alpine.LFD.0.999.0707090954550.26459@xanadu.home> <7vir8tv8dr.fsf@assigned-by-dhcp.cox.net> <20070709185353.GL4087@lavos.net> <alpine.LFD.0.999.0707091503000.26459@xanadu.home> <20070709192403.GM4087@lavos.net> <20070709194931.GO4087@lavos.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Mon Jul 09 22:23:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I7zlS-00061T-EI
	for gcvg-git@gmane.org; Mon, 09 Jul 2007 22:23:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760153AbXGIUXP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Jul 2007 16:23:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754887AbXGIUXP
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jul 2007 16:23:15 -0400
Received: from gateway.insightbb.com ([74.128.0.19]:44490 "EHLO
	asav06.insightbb.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760231AbXGIUXO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jul 2007 16:23:14 -0400
Received: from 74-134-246-243.dhcp.insightbb.com (HELO mail.lavos.net) ([74.134.246.243])
  by asav06.insightbb.com with ESMTP; 09 Jul 2007 16:23:13 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AnA9AAE2kkZKhvbzR2dsb2JhbACBSoVdiAMBAT8B
Received: by mail.lavos.net (Postfix, from userid 1000)
	id 5714D309F31; Mon,  9 Jul 2007 15:23:04 -0500 (CDT)
Content-Disposition: inline
In-Reply-To: <20070709194931.GO4087@lavos.net>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52018>

On Mon, Jul 09, 2007 at 02:49:32PM -0500, Brian Downing wrote:
> The results with both your patch and mine are exactly the same as
> yours applied to master (c956395e).

Sorry, that's not quite right.  The statistics were close enough that my
vdiff failed, though.  :)

Here are all the diffs through my pack analyzer.  There's amazingly few
and they very nearly cancel each other out:

--- treetree-nico	2007-07-09 15:19:10.000000000 -0500
+++ treetree-nicobd	2007-07-09 15:18:45.000000000 -0500
@@ -25392,12 +25392,15 @@
   0 commit 7cde9fabcd145901785a468a87108f7d9c4291fc      544      544 
 
   0   blob 7ce2b21be4ac425a8423ec69c6036a53311df5cb     2347     2347 
+  1    blob 25140bfb264e7b9c8fe4b97318297630cc93b112      313     2660 
+  2     blob ba80ac333acefc68362e66d6f8e61531263e135a       15     2675 
+  3      blob 6f18434f6815a037d6fa15c38d3f460b530e585b      161     2836 
   1    blob 4dbd333da74ad866f0bff154d6cffea11b9a841a        9     2356 
   2     blob ddb93ae086bf0393c9d53247732a2c29af33c80c      313     2669 
   3      blob d34e346a0f2ea6fdb2acc414d10635dc4d326d25       11     2680 
   4       blob 368243c09993f7ee8b56c7ba184bef134a91607c       11     2691 
-     size: count 5 total 2691 min 9 max 2347 mean 538.20 median 11 std_dev 911.97
-path size: count 5 total 12743 min 2347 max 2691 mean 2548.60 median 2669 std_dev 161.11
+     size: count 8 total 3180 min 9 max 2347 mean 397.50 median 161 std_dev 747.23
+path size: count 8 total 20914 min 2347 max 2836 mean 2614.25 median 2675 std_dev 160.58
 
   0 commit 7ce2c42adf3d62f03086de940adaee48e6161a40      579      579 
 
@@ -47249,6 +47252,9 @@
   0 commit d5319592583dda6833b74b34b52dbd2aa3109948      468      468 
 
   0   tree d53239e82aaed72745097f00b32807f2eb71997d      104      104 
+  1    tree 9c01548d14e5b766397e6d5595566269094057bb        5      109 
+     size: count 2 total 109 min 5 max 104 mean 54.50 median 104 std_dev 49.50
+path size: count 2 total 213 min 104 max 109 mean 106.50 median 109 std_dev 2.50
 
   0 commit d5393dd736972a5c84cd97fec9892cd3da80b669      450      450 
 
@@ -48702,9 +48708,6 @@
 path size: count 16 total 111347 min 6404 max 7298 mean 6959.19 median 7142 std_dev 333.27
 
   0   tree df1a6239457293813f34eee001187d725e718062      104      104 
-  1    tree 9c01548d14e5b766397e6d5595566269094057bb        5      109 
-     size: count 2 total 109 min 5 max 104 mean 54.50 median 104 std_dev 49.50
-path size: count 2 total 213 min 104 max 109 mean 106.50 median 109 std_dev 2.50
 
   0 commit df1eebdf125384f3bf7eb2b15b874043504797e6      364      364 
 
@@ -49407,10 +49410,14 @@
   0   blob e4285f4b5739d4a2385b28c4e4fd60cc40beb2a1      217      217 
 
   0   blob e42a4ea85cbac543f20fba2e1cb95b35c3a8a553     1021     1021 
+  1    blob 9a7565236131c7c2b0f4bc5ae8ddb79cfc0eb418      112     1133 
+  2     blob 9d8583de4217d0515125464300321f20539355e1       65     1198 
+  2     blob f8994669d23fa5c008cfdf58ea63a0b88e46f651       14     1147 
+  3      blob 3eec762b65518ffe72ffb29cd30a1bb481f6e898       19     1166 
   1    blob ae1a1001c0d71a8407a3432ff9e2ba7dab59166b       43     1064 
   2     blob 3127f77e001d0b45359254ca59af9f6a62401d77       12     1076 
-     size: count 3 total 1076 min 12 max 1021 mean 358.67 median 43 std_dev 468.51
-path size: count 3 total 3161 min 1021 max 1076 mean 1053.67 median 1064 std_dev 23.61
+     size: count 7 total 1286 min 12 max 1021 mean 183.71 median 43 std_dev 343.41
+path size: count 7 total 7805 min 1021 max 1198 mean 1115.00 median 1133 std_dev 58.30
 
   0   blob e431cf36086c97b6e22eb741e7566100d3133c42     4766     4766 
   1    blob 344136d826427f400d93240f12b8c070d700ece2      448     5214 
@@ -52503,13 +52510,9 @@
   2     blob 651668cdb7db56dba200db8a53732ac984aaac04       12     4524 
   3      blob b31d0f38830ff8fdcdfd81b386993bc2b2216a38       16     4540 
   4       blob ec7899967381c5993e45df411077b598c7d25831       12     4552 
-  1    blob 9a7565236131c7c2b0f4bc5ae8ddb79cfc0eb418      112     4567 
-  2     blob 9d8583de4217d0515125464300321f20539355e1       65     4632 
-  2     blob f8994669d23fa5c008cfdf58ea63a0b88e46f651       14     4581 
-  3      blob 3eec762b65518ffe72ffb29cd30a1bb481f6e898       19     4600 
   1    blob e8a23b634fef5a9d906e3185d65fae8979612851       20     4475 
-     size: count 60 total 7628 min 11 max 4455 mean 127.13 median 20 std_dev 569.75
-path size: count 60 total 298378 min 4455 max 5455 mean 4972.97 median 5017 std_dev 318.40
+     size: count 56 total 7418 min 11 max 4455 mean 132.46 median 20 std_dev 589.29
+path size: count 56 total 279998 min 4455 max 5455 mean 4999.96 median 5031 std_dev 312.48
 
   0   tree ee1ece9ab33edbe7ec1eebcbe9b259c7a9dded4c      196      196 
 
@@ -54809,16 +54812,13 @@
   0 commit fb76e3acd8b8a53cdadaa65bce1d090d99e004a0      324      324 
 
   0   blob fb7b9c91f11921e2d3ac5b20d2c10728dd5ba173     2417     2417 
-  1    blob 25140bfb264e7b9c8fe4b97318297630cc93b112      313     2730 
-  2     blob ba80ac333acefc68362e66d6f8e61531263e135a       15     2745 
-  3      blob 6f18434f6815a037d6fa15c38d3f460b530e585b      161     2906 
   1    blob f0d45243029e1e1a9ef4d499dcb5934de4c523b9       11     2428 
   2     blob c9eab11115a061a457bb84e0a4b0fa1a140cf0da       41     2469 
   3      blob b54b3745c995f8284d1700a8f9b61eed0ed7548e        7     2476 
   1    blob fb107f406660f5faff8d00d060af1478ad21a6bf       15     2432 
   2     blob 829950c079edad38eeaeb4663ea8e96b4d6fedb7        7     2439 
-     size: count 9 total 2987 min 7 max 2417 mean 331.89 median 15 std_dev 743.62
-path size: count 9 total 23042 min 2417 max 2906 mean 2560.22 median 2469 std_dev 172.26
+     size: count 6 total 2498 min 7 max 2417 mean 416.33 median 15 std_dev 894.80
+path size: count 6 total 14661 min 2417 max 2476 mean 2443.50 median 2439 std_dev 21.61
 
   0 commit fb8533122551bbb7aea669f40bc91c1211809b58      778      778 
 
@@ -56646,7 +56646,7 @@
   0 commit ffe8d65266ed7c2c67a0a6ce7ff0de633000037e      474      474 
 
       all sizes: count 46829 total 30253345 min 0 max 1012295 mean 646.04 median 45 std_dev 9555.49
- all path sizes: count 46829 total 1518730701 min 0 max 1012295 mean 32431.41 median 10819 std_dev 54751.35
+ all path sizes: count 46829 total 1518716755 min 0 max 1012295 mean 32431.12 median 10819 std_dev 54751.51
      tree sizes: count 6442 total 30253345 min 0 max 1012295 mean 4696.27 median 422 std_dev 28603.08
-tree path sizes: count 6442 total 1518730701 min 0 max 306510684 mean 235754.53 median 458 std_dev 4198348.32
+tree path sizes: count 6442 total 1518716755 min 0 max 306510684 mean 235752.37 median 458 std_dev 4198348.25
          depths: count 46829 total 3694511 min 0 max 699 mean 78.89 median 12 std_dev 141.53
