From: Joerg Sonnenberger <joerg@britannica.bec.de>
Subject: git fast-import --import-marks broken
Date: Fri, 22 Jul 2011 22:07:30 +0200
Message-ID: <20110722200730.GA3972@britannica.bec.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 22 22:08:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QkM1o-0000GL-Pa
	for gcvg-git-2@lo.gmane.org; Fri, 22 Jul 2011 22:08:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755321Ab1GVUIv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jul 2011 16:08:51 -0400
Received: from mo-p00-ob.rzone.de ([81.169.146.161]:45970 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755132Ab1GVUIv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jul 2011 16:08:51 -0400
X-RZG-AUTH: :JiIXek6mfvEEUpFQdo7Fj1/zg48CFjWjQv0cW+St/nW/afgnrylriWJEJ0cPGum2
X-RZG-CLASS-ID: mo00
Received: from britannica.bec.de
	(ip-109-42-219-134.web.vodafone.de [109.42.219.134])
	by smtp.strato.de (klopstock mo11) (RZmta 26.2)
	with (DHE-RSA-AES128-SHA encrypted) ESMTPA id 0004e0n6MJX8bB
	for <git@vger.kernel.org>; Fri, 22 Jul 2011 22:07:31 +0200 (MEST)
Received: by britannica.bec.de (sSMTP sendmail emulation); Fri, 22 Jul 2011 22:07:30 +0200
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177662>

Hi,
I'm trying to incremental updates of larger repositories (> 100MB) into
git to provide a mirror. First run uses

git fast-import --export-marks=import-0

...and the second run

git fast-import --import-marks=import-0 --export-marks=import-1

After a while, when it hits the actual commits in the input stream, I
get

error: unable to find d17263cb13b181e16217c7b18b0c47a6c30f02ae
fatal: object not found: d17263cb13b181e16217c7b18b0c47a6c30f02ae
fast-import: dumping crash report to .git/fast_import_crash_28817

Crash report is attached. The interesting part is that the mark with
this hash does exist in import-0, so why doesn't it find the object?
I'm running git 1.7.6.

Joerg
