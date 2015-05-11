From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 01/18] t1404: new tests of ref D/F conflicts within transactions
Date: Mon, 11 May 2015 11:52:25 -0700
Message-ID: <xmqqpp672bh2.fsf@gitster.dls.corp.google.com>
References: <1431357920-25090-1-git-send-email-mhagger@alum.mit.edu>
	<1431357920-25090-2-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon May 11 20:52:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yrsoc-0006Ph-MG
	for gcvg-git-2@plane.gmane.org; Mon, 11 May 2015 20:52:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932629AbbEKSw3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 May 2015 14:52:29 -0400
Received: from mail-ig0-f169.google.com ([209.85.213.169]:36098 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755863AbbEKSw2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 May 2015 14:52:28 -0400
Received: by igbpi8 with SMTP id pi8so78958544igb.1
        for <git@vger.kernel.org>; Mon, 11 May 2015 11:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=OCnh3vEPg2xWNk+IhVVT8jKL9eZSscMGKfPVVQJ8LIw=;
        b=ihQgFLzS0R6QygZeD6cRS/9h8ohA/Qxkyr51poRhXfeIIbYrI6L/PjkzoGE/JJc2Iu
         ytXlkTgOLcLfV83BBeUhaPGOTcGyZwlLaKeLGOhZkTLUrQTgW5jqlPEMjH6c6ssgwMtJ
         55liMuUwzXBLkFIeJxJFKWlLBManW+ZeJGEVBbxDU+9H16HGnlwNT/U8IeYpKa+XiTyQ
         o94tOwP+MlbMFbqpWlVlmr4+J2uQw22aVa3kzeG0p5IQfktaR1kDYCB3jX1wUkQdALMG
         nVLgfvgh2Z1IBXfs9QZx2CQilHleDT78e8XI1XOYKeuqxTQRhjUFplNpsZ3MY4b+iwp7
         wySQ==
X-Received: by 10.107.136.158 with SMTP id s30mr14979441ioi.65.1431370347347;
        Mon, 11 May 2015 11:52:27 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:e888:82ed:a88f:f5e4])
        by mx.google.com with ESMTPSA id vk8sm442471igb.4.2015.05.11.11.52.26
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 11 May 2015 11:52:26 -0700 (PDT)
In-Reply-To: <1431357920-25090-2-git-send-email-mhagger@alum.mit.edu> (Michael
	Haggerty's message of "Mon, 11 May 2015 17:25:03 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268815>

Michael Haggerty <mhagger@alum.mit.edu> writes:

>  t/t1404-update-ref-df-conflicts.sh | 107 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 107 insertions(+)
>  create mode 100755 t/t1404-update-ref-df-conflicts.sh
>
> diff --git a/t/t1404-update-ref-df-conflicts.sh b/t/t1404-update-ref-df-conflicts.sh
> new file mode 100755
> index 0000000..ed1b93e
> --- /dev/null
> +++ b/t/t1404-update-ref-df-conflicts.sh
> @@ -0,1 +1,107 @@

Where does this "-0,1" come from???

After fixing it up and then running "format-patch" (or "show"), I
would get

    diff --git a/t/t1404-update-ref-df-conflicts.sh b/t/t1404-update-ref-df-conflicts.sh
    new file mode 100755
    index 0000000..2541a23
    --- /dev/null
    +++ b/t/t1404-update-ref-df-conflicts.sh
    @@ -0,0 +1,107 @@
    ...

which is more in line with what I would expect.
