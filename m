From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 00/19]  convert test -a/-o to && and || patch series
Date: Tue, 20 May 2014 11:22:36 -0700
Message-ID: <20140520182236.GQ12314@google.com>
References: <1400593832-6510-1-git-send-email-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Elia Pinto <gitter.spiros@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 20 20:22:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WmogX-0003gM-Iu
	for gcvg-git-2@plane.gmane.org; Tue, 20 May 2014 20:22:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751374AbaETSWk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 May 2014 14:22:40 -0400
Received: from mail-pd0-f182.google.com ([209.85.192.182]:54924 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750807AbaETSWj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 May 2014 14:22:39 -0400
Received: by mail-pd0-f182.google.com with SMTP id r10so556307pdi.13
        for <git@vger.kernel.org>; Tue, 20 May 2014 11:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=cbncqsBSKuyIrrJLZW4ENiaLZIk5NziMkMW1aLytRxI=;
        b=TV6hr95sfEUOWcXsxRR4139xMqZC6xyBP3uJ9aMgjrLmWq5vKPD4FBihRrRClpctF4
         OlVbNJkobJDtFxd0fMpXa46NI5f0lumTPfvoWpvE7EUM3MqWgILBGUjQsPjndDaOTI97
         LuBQzs/vVdwRI850dnPRMt3OzwjiuDCAYF95vND348Flv1YWKWRZKSjpCz1zEnlbPVFi
         NFv6Ecyo94D6ZtGu93Hi5+c38WIGMrVn6R5mAWmIF3EzvLkjpycDbo5Un6jz8jOFHQC2
         T+NCOTjH7gHzs3xBDUfo9HCLc2etn8VLApb4MKqDvf4m8HxzUiNL6wz09Qzc05hAS1nV
         t+vw==
X-Received: by 10.68.249.100 with SMTP id yt4mr52366560pbc.20.1400610159279;
        Tue, 20 May 2014 11:22:39 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id op3sm4265962pbc.40.2014.05.20.11.22.38
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 20 May 2014 11:22:38 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1400593832-6510-1-git-send-email-gitter.spiros@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249717>

Hi,

Elia Pinto wrote:

> These patch series  convert test -a/-o to && and ||.

Should this come with a new check in t/check-non-portable-shell.pl so
we don't regress in the future?

> Elia Pinto (19):
[...]
>  check_bindir                    |    2 +-
>  contrib/examples/git-clone.sh   |    2 +-
>  contrib/examples/git-commit.sh  |    4 ++--
>  contrib/examples/git-merge.sh   |    4 ++--
>  contrib/examples/git-repack.sh  |    4 ++--
>  contrib/examples/git-resolve.sh |    2 +-
>  git-bisect.sh                   |    2 +-
>  git-mergetool.sh                |    4 ++--
>  git-rebase--interactive.sh      |    2 +-
>  git-submodule.sh                |   29 +++++++++++++++++------------
>  t/t0025-crlf-auto.sh            |    6 +++---
>  t/t0026-eol-config.sh           |    8 ++++----
>  t/t4102-apply-rename.sh         |    2 +-
>  t/t5000-tar-tree.sh             |    2 +-
>  t/t5403-post-checkout-hook.sh   |    8 ++++----
>  t/t5537-fetch-shallow.sh        |    2 +-
>  t/t5538-push-shallow.sh         |    2 +-
>  t/t9814-git-p4-rename.sh        |    4 ++--
>  t/test-lib-functions.sh         |    4 ++--
>  19 files changed, 49 insertions(+), 44 deletions(-)

I still think one patch per file is too many patches for this.  It would
be easier to read with, e.g., whichever ones were most complex as
separate patches and the rest (the "easy" ones) as a single patch.

Thanks,
Jonathan
