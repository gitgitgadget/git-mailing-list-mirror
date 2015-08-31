From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] git-p4: add "--path-encoding" option
Date: Mon, 31 Aug 2015 16:13:04 -0700
Message-ID: <xmqqk2sbt5kv.fsf@gitster.mtv.corp.google.com>
References: <1441059026-66814-1-git-send-email-larsxschneider@gmail.com>
	<1441059026-66814-2-git-send-email-larsxschneider@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, luke@diamand.org, tboegi@web.de
To: larsxschneider@gmail.com
X-From: git-owner@vger.kernel.org Tue Sep 01 01:13:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWYGG-00045f-K9
	for gcvg-git-2@plane.gmane.org; Tue, 01 Sep 2015 01:13:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752816AbbHaXNH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Aug 2015 19:13:07 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:32992 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752308AbbHaXNG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Aug 2015 19:13:06 -0400
Received: by paczk9 with SMTP id zk9so5619941pac.0
        for <git@vger.kernel.org>; Mon, 31 Aug 2015 16:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=8HzlunsdGaWrNTjZkXAZOsQTipuuDDnA6nVFAdSR7BE=;
        b=EJhUfwvdXhU31NKRkm6vbh8bTmRgc2xgwm4eOoUWLBzpRLB9uKc65D01R9h6NVXMbN
         Z4ThlchmWHGRAtZiYTESXOoYjiz9mxFBqoI5jlFPYfCYwIE5s1nMbJVkVfbTtd/wOjL9
         XuuSs6sjlWG/UCmtWe1F02cTnGOLyaDE19RnD24oRC/1ZOCM9OprnXrABj7Vl2L1pveN
         Vm7I4aX42FC7EgTkxWXv+CrwPH8sK3xbXpVpJ9uzPIwpnF14ZssVC/DlLO8fJcBcyIxA
         BA33KcSXOSZSx9/Zy6lk7CO4sKi4iJTjW5KvkF8+88tmQCB1OqkyiYVaHA1Ax6Fb+WJl
         3Tlw==
X-Received: by 10.68.102.225 with SMTP id fr1mr41791007pbb.65.1441062785682;
        Mon, 31 Aug 2015 16:13:05 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:1937:16f4:ede1:6d38])
        by smtp.gmail.com with ESMTPSA id v3sm15790155pdf.42.2015.08.31.16.13.04
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 31 Aug 2015 16:13:05 -0700 (PDT)
In-Reply-To: <1441059026-66814-2-git-send-email-larsxschneider@gmail.com>
	(larsxschneider@gmail.com's message of "Tue, 1 Sep 2015 00:10:26
	+0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276953>

larsxschneider@gmail.com writes:

> From: Lars Schneider <larsxschneider@gmail.com>
>

Here is a space for you to describe what it does and why it is a
good idea to have it.

> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
> ---
>  Documentation/git-p4.txt        |  5 +++++
>  git-p4.py                       |  6 ++++++
>  t/t9821-git-p4-path-encoding.sh | 38 ++++++++++++++++++++++++++++++++++++++

I'll move this to 9822, as 9821 is taken by another git-p4 test,
while queuing.

> diff --git a/Documentation/git-p4.txt b/Documentation/git-p4.txt
> index 82aa5d6..14bb79c 100644
> --- a/Documentation/git-p4.txt
> +++ b/Documentation/git-p4.txt
> @@ -252,6 +252,11 @@ Git repository:
>  	Use a client spec to find the list of interesting files in p4.
>  	See the "CLIENT SPEC" section below.
>  
> +--path-encoding <encoding>::
> +	The encoding to use when reading p4 client paths. With this option
> +	non ASCII paths are properly stored in Git. For example, the encoding
> +	'cp1252' is often used on Windows systems.
> +

Is this something that needs to be consistently given while
interacting with the same P4 depot (in which case you may want to
allow this to be given only once, record the value in the config and
never allow it to be updated once it is set, or something)?

Thanks.
