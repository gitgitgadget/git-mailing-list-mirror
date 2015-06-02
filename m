From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFCv2 03/16] connect: rewrite feature parsing to work on string_list
Date: Tue, 02 Jun 2015 11:48:08 -0700
Message-ID: <xmqqk2vm2bh3.fsf@gitster.dls.corp.google.com>
References: <1433203338-27493-1-git-send-email-sbeller@google.com>
	<1433203338-27493-4-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, pclouds@gmail.com, peff@peff.net
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Jun 02 20:48:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YzrEW-0001Ke-5N
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jun 2015 20:48:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754468AbbFBSsM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jun 2015 14:48:12 -0400
Received: from mail-ie0-f171.google.com ([209.85.223.171]:36573 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754112AbbFBSsK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jun 2015 14:48:10 -0400
Received: by ieclw1 with SMTP id lw1so44910541iec.3
        for <git@vger.kernel.org>; Tue, 02 Jun 2015 11:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=vvU7XIIYAQ6Ck9LVmH9vBJGazDEJ5yTw+S9UHgQMPy0=;
        b=M5uxMc8dir/qCcf2GMHhWnX/tZY/9CHRINyOz6swjcNONXRNNTs01WQXIRR1ya2GBM
         Rp1YuGazx94TVaaMNlSPaiL1qIET7X3pMRFMIvbVtLtV79olCbUq+QNiy+/V5P7VuEZ1
         D4/EG1fWRooNCi9SAQ1/pzgeIKM4razWHdRC9jYyho+BdibZET5E6QTvr8veEjt8lqDx
         bbDd8L9lxQNTgp5jaAVQfDWubKEQwWcSO6XvVJSbNr5OhF4URcriJUzpz6NCNTaYBjPk
         QFbGj+GAe90D621yvjw861kezK10TwHid9n/WwEdEnoHwS1A/YrWaP8ek9G2uz4WO0dP
         rNHg==
X-Received: by 10.42.120.66 with SMTP id e2mr36068807icr.37.1433270890072;
        Tue, 02 Jun 2015 11:48:10 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:3140:53f3:e8c0:89b0])
        by mx.google.com with ESMTPSA id f10sm10496091igt.7.2015.06.02.11.48.09
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 02 Jun 2015 11:48:09 -0700 (PDT)
In-Reply-To: <1433203338-27493-4-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Mon, 1 Jun 2015 17:02:05 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270582>

Stefan Beller <sbeller@google.com> writes:

> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---

The change in 2/16 to extract something into a helper was sort-of
guessable without any comment (i.e. perhaps it will gain new callers
in later patches), but a change like this needs to hint why this is
a good thing to do, I would think.

I think you'll be rerolling this anyway due to droppage of 1/16, so
hopefully we'll see the next version a bit better explained than
this round ;-)

Thanks.

>  builtin/receive-pack.c | 13 +++++----
>  connect.c              | 79 ++++++++++++++++++++++----------------------------
>  connect.h              |  2 +-
>  upload-pack.c          | 11 +++++--
>  4 files changed, 51 insertions(+), 54 deletions(-)
