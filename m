From: Junio C Hamano <jch@google.com>
Subject: Re: Solved: why cloning my repo always got the wrong default branch; possibly missing featurette?
Date: Sat, 21 Apr 2012 12:28:22 -0700
Message-ID: <xmqq7gx8zxyh.fsf@junio.mtv.corp.google.com>
References: <4F926B02.3050104@diamand.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Users <git@vger.kernel.org>
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Sat Apr 21 21:28:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SLfyw-0000SO-1a
	for gcvg-git-2@plane.gmane.org; Sat, 21 Apr 2012 21:28:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751359Ab2DUT2Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Apr 2012 15:28:25 -0400
Received: from mail-ee0-f74.google.com ([74.125.83.74]:57646 "EHLO
	mail-ee0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750798Ab2DUT2Y (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Apr 2012 15:28:24 -0400
Received: by eekc41 with SMTP id c41so505867eek.1
        for <git@vger.kernel.org>; Sat, 21 Apr 2012 12:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=Ox7n2bLv+RTisj+dZgp3pqMiIn1yqOtqd2LlmT2rw+o=;
        b=pDOIcXz3dUAXdl+lPOLjzaldI6dfqtcbDBZauX/tn8ZWqSkT53FC1dX9E1gBb9aJzP
         oYiBWiV2LGnhRxBG2aRmRGyVE7aME+C0LMwRdXJHdJYcWn0CrJRSGgIWllToSIGZj+pU
         +V7oFplSrpujRvZ9r1TRXyn3Y8Zlm5YWKbmZzQ3Hp0pgYZ94NVO9DP+R8nhqn+tHNMuG
         sWZHSZbQAPZEZeq/8BxFZUHHcktwOheN41NL51wnyr2VMzNCSlFn8x+bqTdidgsZv+RL
         CWT/00xdbeBt9S3yepWegFK6hJdcflbxQXEeyTAl81afiAdTH9dX3nMAeJAzPUmEjFOh
         Yxcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:x-gm-message-state;
        bh=Ox7n2bLv+RTisj+dZgp3pqMiIn1yqOtqd2LlmT2rw+o=;
        b=buzHBH4vq2mDLlqp3LzWvntgj5VenScinOcaeaW9mls/IYS1Ycv4VzynnEVd+leb5s
         49JNv62a7pyh8twKQeMyIq6CJSpxKapIb/VFseqN+3EX4J99pKl7pMbgQcGhje2rokhq
         rT2eyjsU+1T2pUC7+2lH3RKh4X8BHTka9jdAVA9xsTGZA4HeNuCIWcylXanIQWUoLPBD
         JVAtNcc+8jBFSNDC/9ZJNeWl+QSKn8NyFOhU0YKnRFBVcD7u9hx6Hmk0KEotxu+5Ify4
         r6Lcj7EsCT+PuPslGCGBGjl1edESGAjVumkq+7O9sGukk49wuRXhc+LzzsN4dGHlVuON
         hoUA==
Received: by 10.14.199.133 with SMTP id x5mr2818461een.7.1335036503249;
        Sat, 21 Apr 2012 12:28:23 -0700 (PDT)
Received: by 10.14.199.133 with SMTP id x5mr2818454een.7.1335036503088;
        Sat, 21 Apr 2012 12:28:23 -0700 (PDT)
Received: from hpza10.eem.corp.google.com ([74.125.121.33])
        by gmr-mx.google.com with ESMTPS id y52si9247116eef.2.2012.04.21.12.28.23
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Sat, 21 Apr 2012 12:28:23 -0700 (PDT)
Received: from junio.mtv.corp.google.com (junio.mtv.corp.google.com [172.27.69.24])
	by hpza10.eem.corp.google.com (Postfix) with ESMTP id DF6DC20004E;
	Sat, 21 Apr 2012 12:28:22 -0700 (PDT)
Received: by junio.mtv.corp.google.com (Postfix, from userid 110493)
	id 3C5AFE120A; Sat, 21 Apr 2012 12:28:22 -0700 (PDT)
In-Reply-To: <4F926B02.3050104@diamand.org> (Luke Diamand's message of "Sat,
	21 Apr 2012 09:08:34 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
X-Gm-Message-State: ALoCoQn8QcbtlgtROtLs2FsqQ65Bj/9bTg8yGMvxJIPvYECBx+e9JxCjvyjAC88t3Uwo99cEl7GiTJJj9anlv6Sn2dp7fNtorZeXYpukWQAKHqreFJLziYTE6dA2oDnpW0YlehczXu6RmBGX+uRg7D6EEEQ0GJI+2Hp0MOxiGpRyDy77PVG1/gQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196057>

Luke Diamand <luke@diamand.org> writes:

> At a guess, the protocol would need to be changed to put the symbolic
> ref information in somehow (upload-pack.c, send-refs() ?).
>
> Is this a bug, or a feature?

Known protocol limitation, as you already seem to have discovered.
I think I outlined a possible protocol extension in a message a few
years ago, but nobody seemed to be interested/motivated enough, so...
