From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: [PATCH v5 0/5] allow more sources for config values
Date: Fri, 12 Jul 2013 00:36:14 +0200
Message-ID: <20130711223614.GA26477@book-mint>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jens Lehmann <jens.lehmann@web.de>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 12 00:36:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UxPTU-00032X-CH
	for gcvg-git-2@plane.gmane.org; Fri, 12 Jul 2013 00:36:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756281Ab3GKWg2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Jul 2013 18:36:28 -0400
Received: from smtprelay02.ispgateway.de ([80.67.29.24]:53601 "EHLO
	smtprelay02.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754329Ab3GKWg2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jul 2013 18:36:28 -0400
Received: from [85.16.23.209] (helo=book-mint)
	by smtprelay02.ispgateway.de with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1UxPTI-0008Ea-Ks; Fri, 12 Jul 2013 00:36:20 +0200
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230143>

Hi,

I finally got around rerolling this series.

The fourth iteration can be found here[1]. You can also find these patches as a
branch on my github[2].

There is not many changes since the last iteration. I have added some
documentation for the --blob option and now there is no rename of the
do_config_from() function anymore.

Cheers Heiko

[1] http://article.gmane.org/gmane.comp.version-control.git/223964
[2] https://github.com/hvoigt/git/commits/hv/strbuf_config_parsing-series5


Heiko Voigt (5):
  config: factor out config file stack management
  config: drop cf validity check in get_next_char()
  config: make parsing stack struct independent from actual data source
  teach config --blob option to parse config from database
  do not die when error in config parsing of buf occurs

 Documentation/git-config.txt |   7 ++
 builtin/config.c             |  31 ++++++-
 cache.h                      |   6 +-
 config.c                     | 217 +++++++++++++++++++++++++++++++++----------
 t/t1307-config-blob.sh       |  70 ++++++++++++++
 5 files changed, 278 insertions(+), 53 deletions(-)
 create mode 100755 t/t1307-config-blob.sh

-- 
1.8.3.2.773.gcfaae5b
