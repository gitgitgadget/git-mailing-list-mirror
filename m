From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] bisect: improve output when bad commit is found
Date: Tue, 12 May 2015 16:24:00 -0700
Message-ID: <xmqqwq0dcrcf.fsf@gitster.dls.corp.google.com>
References: <1431472751-20974-1-git-send-email-tbsaunde@tbsaunde.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>
To: Trevor Saunders <tbsaunde@tbsaunde.org>
X-From: git-owner@vger.kernel.org Wed May 13 01:24:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YsJWz-0005Ga-QK
	for gcvg-git-2@plane.gmane.org; Wed, 13 May 2015 01:24:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964929AbbELXYF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 May 2015 19:24:05 -0400
Received: from mail-ig0-f169.google.com ([209.85.213.169]:35120 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964922AbbELXYC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 May 2015 19:24:02 -0400
Received: by igbyr2 with SMTP id yr2so123495692igb.0
        for <git@vger.kernel.org>; Tue, 12 May 2015 16:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=aGrH0ZDx6x3s/B+63wrWKRl72kAtYxHHM3s8wPnjngk=;
        b=BIwYrnxRyBNXfu3OK0TLMkKZVtk3wXncGXJRybeyfclvtZNvfHvObIQY3fCas/PZXq
         NGEcBGwLLxTfgHjiRfuNn6/U8z3st0z9pi8csBVv39e7K0ObhiybpuR91QbdCl5xn/FR
         hsLQGY+PQW9i0A/XPUZFGSse4DWHSQ5dCNDRWlZcwOEwBs4J0btXsJ4cSMZ083G95+FS
         UniNOHjgfNjM6A3QQNihx+kBdobvQVXuJyQCeqPI7hXlxgskm2esRbjOP5kdgj1Lm/zj
         NgIelMS9EwhiwjczeRAGuUXe6sMjxwXh85GPrTLM+CPC/GG2q5ijKOMw1CATkXv13OTo
         Womw==
X-Received: by 10.50.73.198 with SMTP id n6mr24426307igv.32.1431473042195;
        Tue, 12 May 2015 16:24:02 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:3cfa:54ee:8e48:89ad])
        by mx.google.com with ESMTPSA id l1sm12945681ioe.32.2015.05.12.16.24.01
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 12 May 2015 16:24:01 -0700 (PDT)
In-Reply-To: <1431472751-20974-1-git-send-email-tbsaunde@tbsaunde.org> (Trevor
	Saunders's message of "Tue, 12 May 2015 19:19:11 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268905>

Trevor Saunders <tbsaunde@tbsaunde.org> writes:

> When the first bad commit has been found git bisect prints something
> like this:
>
> 	<40 char sha1> is the first bad commit
> 	Commit <40 char sha1>
> 	...
>
> 	:100644 100644 10f5e57... a46cfeb... M  bisect.c
> 	:100755 100755 ae3fec2... 65a19fa... M  git-bisect.sh
>
> The raw diff output is not really useful, and its kind of silly to print
> the sha1 twice.  Instead lets print something like this:
>
> 	The first bad commit is
> 	Commit <sha1>
> 	...

According to +CCouder, this change will break existing people's use
cases.

See $gmane/268881
