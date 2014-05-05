From: Timo Teras <timo.teras@iki.fi>
Subject: git fast-import: how to prevent incremental commit with no changes
Date: Mon, 5 May 2014 11:53:20 +0300
Message-ID: <20140505115320.395edd2e@vostro>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 06 19:14:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Whhv5-0005Yp-NT
	for gcvg-git-2@plane.gmane.org; Tue, 06 May 2014 18:08:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755135AbaEEIxV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 May 2014 04:53:21 -0400
Received: from mail-la0-f47.google.com ([209.85.215.47]:50372 "EHLO
	mail-la0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755027AbaEEIxU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 May 2014 04:53:20 -0400
Received: by mail-la0-f47.google.com with SMTP id e16so1670005lan.6
        for <git@vger.kernel.org>; Mon, 05 May 2014 01:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:subject:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=f8zKg+u50+GZL7hunF4JItzLoGLfK5Na74+7dwpMWWg=;
        b=K8iLubp6S21buviN2Uj8CQ1eMRNx3VKjGEoG0S86TjBBq86+T2fYKLAs+P3N6p+HAO
         3d6BT/FhiE22R6l8024NcWicg9Uswk12/l1OhI3C2ew5IShJeHpz2wX78JQVf4iFB5x3
         7sCeThId/KTqiKMbj+ID2P1e3TwnJXSzfpHOAU++duMxZW1pl1HEoU5e78JuVLGUFwvl
         beUkG2dn2Zb9Nw1Gep5Xwaim9XjBCIf78bkg7SdwsQgSoHdu1xsLOm4V+tcvXhLvNJn+
         rq/WqEIrXhOUKkkxdaUHyFldYFiorZ3S17drFjE2KKHXA1AUeBuiB4HLPRcEEJfuf+hv
         RpIg==
X-Received: by 10.152.242.164 with SMTP id wr4mr1144282lac.38.1399279998810;
        Mon, 05 May 2014 01:53:18 -0700 (PDT)
Received: from vostro ([83.145.235.199])
        by mx.google.com with ESMTPSA id mw10sm8869178lbb.24.2014.05.05.01.53.18
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 May 2014 01:53:18 -0700 (PDT)
X-Mailer: Claws Mail 3.9.3 (GTK+ 2.24.23; i486-alpine-linux-musl)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248176>

Hi,

I'm trying to script a setup that would periodically import a tarball
to git with fast-import. But things do not always change, so I'd like
fast-import to be able to not do the commit in case there is no change.

That is, I'm constructing the commit with "deleteall" + importing each
object by mark after that. Now, in case nothing changed, fast-import
will happily create an empty commit for me.

Would it be possible to add some flag that would make commit fail in
case nothing changed?

Any suggestions how to do this?

Thanks,
Timo
