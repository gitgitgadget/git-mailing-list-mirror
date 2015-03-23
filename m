From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: [PATCH 4/5] Add tests for git-log --merges=show|hide|only
Date: Mon, 23 Mar 2015 06:14:24 +0100
Message-ID: <550FA130.1030402@web.de>
References: <1427048921-28677-1-git-send-email-koosha@posteo.de>	<1427048921-28677-4-git-send-email-koosha@posteo.de>	<550F1E9F.40801@web.de>	<550F3D3B.7080104@posteo.de> <CAPig+cT-EJMBZN72N=DREZjn=c1rxgMsnJ=HNS4R3sGTUPUu0A@mail.gmail.com> <550F450F.6070207@posteo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>,
	Git List <git@vger.kernel.org>
To: Koosha Khajehmoogahi <koosha@posteo.de>,
	Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Mar 23 06:14:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YZuhJ-0002M2-TJ
	for gcvg-git-2@plane.gmane.org; Mon, 23 Mar 2015 06:14:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753470AbbCWFOk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Mar 2015 01:14:40 -0400
Received: from mout.web.de ([212.227.17.11]:49487 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752848AbbCWFOj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Mar 2015 01:14:39 -0400
Received: from [192.168.88.199] ([194.47.243.242]) by smtp.web.de (mrweb103)
 with ESMTPSA (Nemesis) id 0LdmyV-1ZGuoD0ZwB-00j4os; Mon, 23 Mar 2015 06:14:34
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:31.0) Gecko/20100101 Icedove/31.5.0
In-Reply-To: <550F450F.6070207@posteo.de>
X-Provags-ID: V03:K0:dA8O9KzxDE+kezVjJzwUUHoNIfoC3kVak4rQEgnyKPfnu+vGa1+
 hWO6Un8GThl3e9xk2grHtNeGO+k/DWMAcqeJ7F8wXGJ0coELojZL6lYQA5Qg72he2bOXKwn
 o7lkQDmSRPNk4MRLOMR4yUDHdF6WpLxsjcQ+9QUXfcrpkMWC68ikR0fGCcLomLaTKF7Bq/P
 bAsWxCq+4I/O1XE3n8kKw==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266126>

Back to the original discussion:

+test_expect_success 'log with config log.merges=show' '
+    git config log.merges show &&
+    git log --pretty=tformat:%s >actual &&
+    test_cmp both_commits_merges actual &&
+    git config --unset log.merges

These days I would probably shorten the code, the review time and
the execution time of the test and increase the clean-ness with 50%
by simply writing

+test_expect_success 'log with config log.merges=show' '
+	git -c log.merges=show log --pretty=tformat:%s >actual &&
+	test_cmp both_commits_merges actual
+	'
