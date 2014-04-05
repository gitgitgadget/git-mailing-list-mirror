From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH 0/2] status/commit: do not ignore staged submodules
Date: Sat, 05 Apr 2014 18:57:59 +0200
Message-ID: <53403617.7050506@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Ronald Weiss <weiss.ronald@gmail.com>,
	Sergey Sharybin <sergey.vfx@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Apr 05 18:58:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WWTva-0002gG-96
	for gcvg-git-2@plane.gmane.org; Sat, 05 Apr 2014 18:58:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753138AbaDEQ6K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Apr 2014 12:58:10 -0400
Received: from mout.web.de ([212.227.17.11]:54276 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753102AbaDEQ6J (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Apr 2014 12:58:09 -0400
Received: from [192.168.178.41] ([84.132.155.8]) by smtp.web.de (mrweb103)
 with ESMTPSA (Nemesis) id 0MORqb-1WcEfo20wP-005tBa; Sat, 05 Apr 2014 18:58:06
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.4.0
X-Enigmail-Version: 1.6
X-Provags-ID: V03:K0:5BGjmV/hXec1UMfxR/g1u4ihgw64trupFdRZCS2/eRUfv2Jjc7r
 uQI0h/AGYXBHk6DN/iTjFspoWWKV5BAGlOnoyJPTyEAFEAVwC0PHxRhzDXZ0lNHNwkTwQJs
 Tc/7i7dcr11qWXnpxYiFvASRL7AqFWGqeFJq+l4GRal4vJUKPQ+2VtlOtchEo4GcVMgWYff
 1oeKgQbCzfZJ//LG+tc/w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245781>

This series fixes the problem that ignored but staged submodules do not show
up in status and commit. Even though we do change default behavior here, I
believe this is the Right Thing to do (and remember all interested parties in
the discussion that raised this issue agreed on that [1]).

[1] http://article.gmane.org/gmane.comp.version-control.git/238173

Jens Lehmann (2):
  status/commit: show staged submodules regardless of ignore config
  commit -m: commit staged submodules regardless of ignore config

 Documentation/config.txt     |  8 +++--
 Documentation/gitmodules.txt |  4 ++-
 builtin/commit.c             | 18 +++++++++--
 t/t7508-status.sh            | 74 ++++++++++++++++++++++++++++++++++++++++++--
 wt-status.c                  | 12 ++++++-
 5 files changed, 108 insertions(+), 8 deletions(-)

-- 
1.9.1.476.g510abc7
