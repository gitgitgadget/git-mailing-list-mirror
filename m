From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v3 05/44] refs.c: move update_ref to refs.c
Date: Tue, 13 Oct 2015 16:40:17 -0400
Organization: Twitter
Message-ID: <1444768817.7234.17.camel@twopensource.com>
References: <1444686725-27660-1-git-send-email-dturner@twopensource.com>
	 <1444686725-27660-6-git-send-email-dturner@twopensource.com>
	 <561C7D7B.8020807@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Ronnie Sahlberg <sahlberg@google.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Oct 13 22:41:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zm6NX-0003oj-PJ
	for gcvg-git-2@plane.gmane.org; Tue, 13 Oct 2015 22:41:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753080AbbJMUky (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Oct 2015 16:40:54 -0400
Received: from mail-qg0-f53.google.com ([209.85.192.53]:34352 "EHLO
	mail-qg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752784AbbJMUkU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Oct 2015 16:40:20 -0400
Received: by qgez77 with SMTP id z77so26045123qge.1
        for <git@vger.kernel.org>; Tue, 13 Oct 2015 13:40:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=CRMKLXnSj9sWuWSZqX1++LcIMQPDN0R7AwfR4dvA0l0=;
        b=LzWBzW4xUjxpbwdsdm8c+HiH4hlJeTNwLHGP3adPA8A2Fkp6tF33EQjLDrTovUs9S8
         4b4K/ptRQemSMeSw+WVEP5AVy1Ci5TLmU2YJ/Aitz2SkzPV5BnR62WU8U0s0PWNgK8NB
         9vTW6pb0fDbgBr1aw0w9C13D/gQ77+Dkx1fr/LeY5EfBtwkQztFlF81DnxRCbJ9G+3lg
         YrFZczAHiJYxHf5kLyVnOm82xuqGXhieolTkdjEU/G0TlqCQDONNq7mg7nHX1tbSHt+y
         aE8lOTb0Yiz9XrupeTenrhj0g1/VLFLJOVi2+YWAJiwe5kPE/2eXa3IdDtfjiCd6z0kr
         G+Ww==
X-Gm-Message-State: ALoCoQkHjINtE+j2926hdt5XvXgkXwNZU+7HSovpnVqAV9WsYeQBCjJ17YP9NzmZQ0KcDUqSSa1V
X-Received: by 10.140.234.212 with SMTP id f203mr44858086qhc.10.1444768819056;
        Tue, 13 Oct 2015 13:40:19 -0700 (PDT)
Received: from ubuntu ([192.133.79.147])
        by smtp.gmail.com with ESMTPSA id w32sm1912446qgd.45.2015.10.13.13.40.17
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Oct 2015 13:40:18 -0700 (PDT)
In-Reply-To: <561C7D7B.8020807@alum.mit.edu>
X-Mailer: Evolution 3.12.11-0ubuntu3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279518>

On Tue, 2015-10-13 at 05:41 +0200, Michael Haggerty wrote:

> If its removal was intentional, it deserves a careful explanation (and
> should probably be done as a separate commit). If it was an accident,
> please consider how this accident arose and try to think about whether
> similar accidents might have happened elsewhere in this series.

This was an accident. I think it must have happened when I
forward-ported Ronnie's changes over my change that introduced that
check.  Usually, when there were conflicts during this process
(indicating that the moved code had changed in the meantime), I did the
move by copy-pasting the code (rather than by choosing the old version).
Apparently, I missed this one.

Will fix.

> > [...]
> 
> Michael
> 
