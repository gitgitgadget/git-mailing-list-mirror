From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 01/12] git submodule update: Announce skipping submodules on stderr
Date: Fri, 16 Oct 2015 13:37:37 -0700
Message-ID: <xmqqbnbyeei6.fsf@gitster.mtv.corp.google.com>
References: <1444960333-16003-1-git-send-email-sbeller@google.com>
	<1444960333-16003-2-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Oct 16 22:37:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZnBl8-0004IY-Tx
	for gcvg-git-2@plane.gmane.org; Fri, 16 Oct 2015 22:37:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753458AbbJPUhq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Oct 2015 16:37:46 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:35304 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751904AbbJPUhp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Oct 2015 16:37:45 -0400
Received: by padcn9 with SMTP id cn9so14858542pad.2
        for <git@vger.kernel.org>; Fri, 16 Oct 2015 13:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=iMqm2JC3uggTexORYCaUDxLuBV5SJirtfouUWQm4hsg=;
        b=FlF0wuFZPV2QBKrdxPeBOa4QtO6A96hKTUcwMSVuF/ljRyVIp1Ifd5R+Md8LLlLdQB
         TbZ1mNOjzjS32/qpmbmAQu+lRiqZe2n0cBnIg24+SPQVQIVAzAXTuQlUfHnVTNAcY8jT
         SAaS7nE9SVX2k2T5znmgDQdugqO6jvkfaNIIHAwQM/cdCaG3J6pe8WgeAjqgYhvNJ7Ru
         W6aMG6aYnsdwQ8dxstDRRHJRSqAiexJtXn83omFcbqkier2+WT46eJ0E4I9O/Fv0cvvR
         aNPotxkLopELC7yyL4P3Y2wSZsBKahjDOW05tnqPksmgZh9RF947LERWny9/ab2EXv2l
         jZKQ==
X-Received: by 10.68.192.9 with SMTP id hc9mr18575673pbc.57.1445027865460;
        Fri, 16 Oct 2015 13:37:45 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:b1ee:7c8f:ac32:e39f])
        by smtp.gmail.com with ESMTPSA id xs2sm4099949pbb.75.2015.10.16.13.37.43
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 16 Oct 2015 13:37:43 -0700 (PDT)
In-Reply-To: <1444960333-16003-2-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Thu, 15 Oct 2015 18:52:02 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279766>

Stefan Beller <sbeller@google.com> writes:

> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  git-submodule.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/git-submodule.sh b/git-submodule.sh
> index 8b0eb9a..578ec48 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -684,7 +684,7 @@ cmd_update()
>  
>  		if test "$update_module" = "none"
>  		then
> -			echo "Skipping submodule '$displaypath'"
> +			echo >&2 "Skipping submodule '$displaypath'"
>  			continue
>  		fi

Makes sense, but see 02/12.
