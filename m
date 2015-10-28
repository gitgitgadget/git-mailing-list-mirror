From: Peter Wu <peter@lekensteyn.nl>
Subject: [PATCH 0/3] bash-completion fixes for global git options handling
Date: Wed, 28 Oct 2015 18:21:22 +0100
Message-ID: <1446052885-11173-1-git-send-email-peter@lekensteyn.nl>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 28 18:47:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZrUp5-0001Pu-9m
	for gcvg-git-2@plane.gmane.org; Wed, 28 Oct 2015 18:47:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754294AbbJ1Rrj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Oct 2015 13:47:39 -0400
Received: from lekensteyn.nl ([178.21.112.251]:45282 "EHLO lekensteyn.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751237AbbJ1Rri (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Oct 2015 13:47:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lekensteyn.nl; s=s2048-2015-q1;
	h=Message-Id:Date:Subject:To:From; bh=KeeWdjWMWqjOXfisfubzeM6lVZ/Pixoq9rssZ71Jv3g=;
	b=phc290xAPImMhWLjAVUIrUOD0BQH/qL4D0U8MeUR7OXubsyrY9fGv7C90Cq5KmvgTOfyy6JwA8gIRpLsoexfXQM9TFFLr6fduaZU7eW9UOy2gtGnHEQ1ZryKLz4rV9q5efnI17WyaPAjuU4XLGNtgRHGYf6I8s7zrDER1dQP1NRM3a9VXyIYHDvk9mkvGc/hasMbfheI4c/OM6RXG6dSrkhZmhaae34JVvMwWY+MV2qOt0dDyWQc1QZFUpVzwIj840B6DIs3F8S69CBMtSkkxMWMGeLpk9EGeDqGCbFXyBsZ7m6K34eDsMBVRpNOtvBVuy5NW4kbBdH6ulm7TB186g==;
Received: by lekensteyn.nl with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA256:128)
	(Exim 4.84)
	(envelope-from <peter@lekensteyn.nl>)
	id 1ZrUPl-00064K-Cu; Wed, 28 Oct 2015 18:21:33 +0100
X-Mailer: git-send-email 2.6.1
X-Spam-Score: -0.0 (/)
X-Spam-Status: No, hits=-0.0 required=5.0 tests=NO_RELAYS=-0.001 autolearn=no autolearn_force=no
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280381>

Hi,

These patches improve bash-completion when global git options are present.
Consider this problem:

    bash-4.3$ git -C ../linux sta<TAB>error: invalid key: alias.../linux

This happens because the current script is unaware of the -C option. In general,
global options are not handled well (patch 001 fixes this).

Patch 2 makes the completions more aware of the --git-dir option.

Patch 3 builds on previous patches and makes completions aware of the -C option.

Kind regards,
Peter

Peter Wu (3):
  completion: ignore git options for subcommand completion
  completion: pass --git-dir to more commands
  completion: handle git -C option

 contrib/completion/git-completion.bash | 119 ++++++++++++++++++++-------------
 1 file changed, 72 insertions(+), 47 deletions(-)

-- 
2.6.1
