From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/7] Documentation/git-push.txt: Document when --signed may fail
Date: Fri, 14 Aug 2015 16:10:05 -0700
Message-ID: <xmqqr3n5fovm.fsf@gitster.dls.corp.google.com>
References: <1439492451-11233-1-git-send-email-dborowitz@google.com>
	<1439492451-11233-2-git-send-email-dborowitz@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Dave Borowitz <dborowitz@google.com>
X-From: git-owner@vger.kernel.org Sat Aug 15 01:10:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZQO79-00005a-Bc
	for gcvg-git-2@plane.gmane.org; Sat, 15 Aug 2015 01:10:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752990AbbHNXKJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Aug 2015 19:10:09 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:35938 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752609AbbHNXKH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Aug 2015 19:10:07 -0400
Received: by pacrr5 with SMTP id rr5so69090277pac.3
        for <git@vger.kernel.org>; Fri, 14 Aug 2015 16:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=9J5cA3BguNrBDczU/OM97NVLh1T9pgQBBqnJ9WKv97k=;
        b=RgITsUucFcQ5WxdmjGW5ezZcc3IvcOXOVswt+vn/6fBf8OyuTnlYvGGAjVJy/yawL9
         mUASQoRx5VuyOfN50wPLrqqLf7eCatc8FWDH2N1b6dFfDQrh2skeiHSteGdDpvMpo/6s
         5SaxKS2EFmDiPS4pw4ynOwKENqx4u4djF3uH6eCXxuAhNrbRFPxP5TIrVbRSa595zNmU
         HMfS/2TGjZqcBO+Vba6MSV1VfFfXkWj3fgjbGWAZ66BbP4bFyp5jvq5VTcTbYDoDjmX3
         yz01IDBn0OE/Guc01Mdpd0CZf0ieedR2n0bClvlGibXr/1/4/mrpRPlHLgnq/4x5PwvM
         gmaw==
X-Received: by 10.66.232.68 with SMTP id tm4mr27919597pac.157.1439593806743;
        Fri, 14 Aug 2015 16:10:06 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:a820:aa0d:2b52:954f])
        by smtp.gmail.com with ESMTPSA id pi4sm7194644pdb.60.2015.08.14.16.10.05
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 14 Aug 2015 16:10:06 -0700 (PDT)
In-Reply-To: <1439492451-11233-2-git-send-email-dborowitz@google.com> (Dave
	Borowitz's message of "Thu, 13 Aug 2015 15:00:45 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275974>

Dave Borowitz <dborowitz@google.com> writes:

> Like --atomic, --signed will fail if the server does not advertise the
> necessary capability. In addition, it requires gpg on the client side.
>
> Signed-off-by: Dave Borowitz <dborowitz@google.com>
> ---
>  Documentation/git-push.txt | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
> index 135d810..f8b8b8b 100644
> --- a/Documentation/git-push.txt
> +++ b/Documentation/git-push.txt
> @@ -137,7 +137,9 @@ already exists on the remote side.
>  	GPG-sign the push request to update refs on the receiving
>  	side, to allow it to be checked by the hooks and/or be
>  	logged.  See linkgit:git-receive-pack[1] for the details
> -	on the receiving end.
> +	on the receiving end.  If the `gpg` executable is not available,
> +	or if the server does not support signed pushes, the push will
> +	fail.

Looks good.

I am wondering if another mode of failure is worth mentioning: `gpg`
available, you have _some_ keys, but signingkey configured does not
match any of the keys.

Note that I said "am wondering", which is very different from "I
think we should also describe".

Thanks.
