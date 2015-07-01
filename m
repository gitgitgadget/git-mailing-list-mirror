From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/7] pack-protocol.txt: Mark all LFs in push-cert as required
Date: Wed, 01 Jul 2015 13:00:08 -0700
Message-ID: <xmqqfv578x87.fsf@gitster.dls.corp.google.com>
References: <1435774099-21260-1-git-send-email-dborowitz@google.com>
	<1435774099-21260-4-git-send-email-dborowitz@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Dave Borowitz <dborowitz@google.com>
X-From: git-owner@vger.kernel.org Wed Jul 01 22:00:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZAOB8-0005sE-4h
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jul 2015 22:00:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751250AbbGAUAM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jul 2015 16:00:12 -0400
Received: from mail-ig0-f173.google.com ([209.85.213.173]:37434 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751901AbbGAUAL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jul 2015 16:00:11 -0400
Received: by igblr2 with SMTP id lr2so42484020igb.0
        for <git@vger.kernel.org>; Wed, 01 Jul 2015 13:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=E2fZiz2VeLAHAW4TAhB7YCsJA/rfzFrqchU0ljbKMXU=;
        b=mWzQT9PhZuhW6rH/azk0NJ5byjy3cpum1E6TISZlbDOc41P+eql8TLs7xYWvLvPt/W
         CjE9afy4+uYXxpnCL4z7qecCQrMdyViaacKldoeF7mlS7b8LIr+290rhTPfggi2Y1M3k
         RCffQTKS8YgvsOE0oLW1pyIb4aBnG0IUxjdd8kEictygHADDdP3biuhp7qzzjRNudZXf
         JqqnMY8ELklIeV80wJ9Br4dsgSwxayMdNaMQdjU5oz/RrXuNw+DPZmWymMhntb/IA6Yr
         fPllNHDnY+/iRbxCaT7Zp4DgIhpfNkH+DD2jg63NtVzeVULOlmFX0U9K901wY7BXNTgS
         QcAA==
X-Received: by 10.43.34.205 with SMTP id st13mr6902602icb.4.1435780810757;
        Wed, 01 Jul 2015 13:00:10 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:64b9:4225:baa1:c97c])
        by mx.google.com with ESMTPSA id u35sm2131192iou.7.2015.07.01.13.00.09
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 01 Jul 2015 13:00:10 -0700 (PDT)
In-Reply-To: <1435774099-21260-4-git-send-email-dborowitz@google.com> (Dave
	Borowitz's message of "Wed, 1 Jul 2015 11:08:15 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273194>

Dave Borowitz <dborowitz@google.com> writes:

> Signed-off-by: Dave Borowitz <dborowitz@google.com>
> ---
>  Documentation/technical/pack-protocol.txt | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/Documentation/technical/pack-protocol.txt
> b/Documentation/technical/pack-protocol.txt
> index 1386840..2d8b1a1 100644
> --- a/Documentation/technical/pack-protocol.txt
> +++ b/Documentation/technical/pack-protocol.txt
> @@ -534,6 +534,9 @@ A push certificate begins with a set of header
> lines.  After the
>  header and an empty line, the protocol commands follow, one per
>  line.
>  
> +Note that (unlike other portions of the protocol), all LFs in the
> +`push-cert` specification above MUST be present.
> +
>  Currently, the following header fields are defined:
>  
>  `pusher` ident::

I am moderately negative about this; wouldn't it make the end result
cleaner to fix the implementation?
