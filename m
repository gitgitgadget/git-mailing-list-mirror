From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: git-am failed, what's next ?
Date: Thu, 22 Feb 2007 11:13:42 +0000
Message-ID: <200702221113.44338.andyparkins@gmail.com>
References: <38b2ab8a0702220022wab25519hbb57629934e7f104@mail.gmail.com> <7v8xeqh6bj.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>,
	"Francis Moreau" <francis.moro@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 22 12:13:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HKBte-0003r7-0a
	for gcvg-git@gmane.org; Thu, 22 Feb 2007 12:13:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945973AbXBVLNy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Feb 2007 06:13:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945974AbXBVLNy
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Feb 2007 06:13:54 -0500
Received: from nf-out-0910.google.com ([64.233.182.189]:33478 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1945973AbXBVLNx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Feb 2007 06:13:53 -0500
Received: by nf-out-0910.google.com with SMTP id o25so494577nfa
        for <git@vger.kernel.org>; Thu, 22 Feb 2007 03:13:52 -0800 (PST)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=H1s65iY9GUZfOvNR7z6aXRsgy6thfadecFAIB8Qvq/pwinv4KcpPolJtKufpXLEfefMebF76CT4zVJC8pX4OzwUz2UVBRx1cpVoD8swujlrZY4oStgG6QlNUgcY/QC56xdYy4b3HqUf2tb1rYJgQ//wh6ZFLerECZHycNjuQOoI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=qFKI6fiRdUZxV6oCsCNoQn/4+oljJQCP0A7+O7p1eTqRASauKw77lbRq90Osz/05QBbAf0uiflXsgKs6astqylxYWbM6109Wy8RRz1DWJVQb6ERC7VhXnXhClAFqgy8JaA6Iw3cybu3ajRUXJUyzw6Ddt1CoxSRbnXGqwud+a8Y=
Received: by 10.49.57.12 with SMTP id j12mr3315381nfk.1172142831989;
        Thu, 22 Feb 2007 03:13:51 -0800 (PST)
Received: from 360run094l ( [194.70.53.227])
        by mx.google.com with ESMTP id p72sm5425799nfc.2007.02.22.03.13.49;
        Thu, 22 Feb 2007 03:13:49 -0800 (PST)
User-Agent: KMail/1.9.5
In-Reply-To: <7v8xeqh6bj.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40348>

On Thursday 2007 February 22 09:47, Junio C Hamano wrote:

> If you have the pre-image blobs the patch was created against,
> and the patch was created with git and records "index" lines
> like these correctly:
>
>         diff --git a/builtin-config.c b/builtin-config.c
>         index 0f9051d..f1433a4 100644
>
> then you can tell git to fall back on 3-way merge to apply the
> patch.  After seeing "git am ./mbox" fail, you could try

Magic.  I had no idea about this.  Could it be made even more magical by doing 
this for you?

git-am would know if the patch that failed is a git-generated patch, so when 
things go wrong, before bombing out it could try a 3-way merge.  It's much 
easier to resolve faults with the usual conflict markers than reading 
patches.  It's also possible that the 3-way merge will succeed and git-am 
will continue without ever needing to worry the user.


Andy
-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
