From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 8/9] Support signing pushes iff the server supports it
Date: Wed, 19 Aug 2015 12:58:36 -0700
Message-ID: <xmqqpp2j82z7.fsf@gitster.dls.corp.google.com>
References: <1439998007-28719-1-git-send-email-dborowitz@google.com>
	<1439998007-28719-9-git-send-email-dborowitz@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Dave Borowitz <dborowitz@google.com>
X-From: git-owner@vger.kernel.org Wed Aug 19 21:58:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZS9VS-0006RX-Jn
	for gcvg-git-2@plane.gmane.org; Wed, 19 Aug 2015 21:58:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751940AbbHST6i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Aug 2015 15:58:38 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:35069 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751574AbbHST6h (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Aug 2015 15:58:37 -0400
Received: by pacdd16 with SMTP id dd16so1522858pac.2
        for <git@vger.kernel.org>; Wed, 19 Aug 2015 12:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=WgPMPewcLG7IzKcmJYvw5ajZNc8C6QplfaE1ihWg7LI=;
        b=gwwpqVscBaRGPMzGvUm5JaYGDVMSEg4qkQbwUeuKffUvjehFIl9JqWUq0rm1Acybd7
         hZ5uoKDBq6Ixby/4j2WpiCpZTscdBwW65bi7JtsGPuyX8ffMl3dCKxGWLcGtuCe1xC+a
         iY+/E/I72vc9wLylyk2E5iBGpJY68G/DVgEkpQ6Kp93cTtXqK2MA7jmGRgNgYm19RtRk
         iLsEQIlV1MEZU2dhW2eVMFZAz6Wm7GhwNaDZ62X9GcMBxpD40IY4p421UAON1aVqWTkk
         Vlz58MK5N/lDpzzGYgpXeETRecHJ0cG2I0r/zYtOMqF9eeruqtNGFja1iFc/MqDARwLK
         x3iA==
X-Received: by 10.68.137.7 with SMTP id qe7mr28242726pbb.103.1440014317189;
        Wed, 19 Aug 2015 12:58:37 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:a5d7:91a5:eac5:b635])
        by smtp.gmail.com with ESMTPSA id nj9sm1773732pdb.77.2015.08.19.12.58.36
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 19 Aug 2015 12:58:36 -0700 (PDT)
In-Reply-To: <1439998007-28719-9-git-send-email-dborowitz@google.com> (Dave
	Borowitz's message of "Wed, 19 Aug 2015 11:26:46 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276220>

Dave Borowitz <dborowitz@google.com> writes:

> Add a new flag --signed-if-possible to push and send-pack that sends a
> push certificate if and only if the server advertised a push cert
> nonce. If not, at least warn the user that their push may not be as
> secure as they thought.
>
> Signed-off-by: Dave Borowitz <dborowitz@google.com>
> ---

Obviously, the above description needs updating.  Here is what I've
queued tentatively.

Thanks.

commit 32d273dfabb0a70b2839971f5afff7fa86a8f4c2
Author: Dave Borowitz <dborowitz@google.com>
Date:   Wed Aug 19 11:26:46 2015 -0400

    push: support signing pushes iff the server supports it
    
    Add a new flag --sign=true (or --sign=false), which means the same
    thing as the original --signed (or --no-signed).  Give it a third
    value --sign=if-asked to tell push and send-pack to send a push
    certificate if and only if the server advertised a push cert nonce.
    
    If not, warn the user that their push may not be as secure as they
    thought.
    
    Signed-off-by: Dave Borowitz <dborowitz@google.com>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>
