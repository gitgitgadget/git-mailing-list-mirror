From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2 2/3] remote-helpers: move out of contrib
Date: Wed, 23 Apr 2014 16:00:13 -0500
Message-ID: <535829dd861b1_24448772ece1@nysa.notmuch>
References: <1398112633-23604-1-git-send-email-felipe.contreras@gmail.com>
 <1398112633-23604-3-git-send-email-felipe.contreras@gmail.com>
 <38F8C9C6-E186-4C42-B3F0-931AE73400FA@quendi.de>
 <xmqqa9bbzwc0.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>, Max Horn <max@quendi.de>
X-From: git-owner@vger.kernel.org Wed Apr 23 23:10:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wd4RL-0003Yi-AY
	for gcvg-git-2@plane.gmane.org; Wed, 23 Apr 2014 23:10:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756078AbaDWVKm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Apr 2014 17:10:42 -0400
Received: from mail-oa0-f47.google.com ([209.85.219.47]:51405 "EHLO
	mail-oa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752767AbaDWVKl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Apr 2014 17:10:41 -0400
Received: by mail-oa0-f47.google.com with SMTP id i11so1672132oag.34
        for <git@vger.kernel.org>; Wed, 23 Apr 2014 14:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=5FQWEKf8ZSpKET7PXa4DIyKpPV+kNLu2NVKVQYk3Sik=;
        b=N4R6Vt9GEbCPMtHEdcov53iWVsslf81AHTnahqkpEmXj6BsIs8iAGED1+X7rgT9Szn
         U4uBRSY2mz1C6sPTpMdMUakd9ivVMmAcIt0EQiONjBdHX9NiFWKy0N+Zk7SC1VFkQP54
         /uwBkUMpKw6JsP/ibfCBDN41CbCHz0nVUm+JzpN7lmf42dlGXOFayEMYdQjXo0fDQEoM
         II99qxiY+W4O5OcvfKKKUORfXGXalaOabbk1Ja+eJeoCSG3bRgKyMDoq7ma2iFUoC7f5
         WZdjSRxukmJB7gw4qZcwkywUI0EKuScB96S+lMz1YOPu1ajwWHPVnRjEfTDKMVSYI+64
         7Lmw==
X-Received: by 10.182.55.3 with SMTP id n3mr9591702obp.55.1398287440956;
        Wed, 23 Apr 2014 14:10:40 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id 10sm4063383obq.18.2014.04.23.14.10.36
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Apr 2014 14:10:37 -0700 (PDT)
In-Reply-To: <xmqqa9bbzwc0.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246896>

Junio C Hamano wrote:
> Max Horn <max@quendi.de> writes:
> 
> > Perhaps it is OK to move an undocumented remote-helper
> > with known bugs out of contrib.
> 
> We should strive to apply the same criteria as new submission to the
> main part of the system.  And inputs from people like you who have
> more experiences than others on the list in dealing with hg-to-git
> bridging are very much welcomed to identify and document what kind
> of breakages there are, and to come up with the solution to them.

FTR. There are no "known brakages", at least to me. Max Horn tends to hoard
these issues and never report them (unless an opportunity to criticize
git-remote-hg comes, apparently).

The very unlikely issue that nobody has reported about hg multiple heads and gc
I just fixed, and the issue he just reported about 'foo' and 'foo/bar' is newly
reported, and there's no easy way to fix this. My proposal would be to have
some sort of branch mapping mechanism in fast-import, but hardly something that
should prevent the move out of contrib.

-- 
Felipe Contreras
