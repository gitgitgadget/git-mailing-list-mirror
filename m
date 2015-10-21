From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Poor git write performance to NFS
Date: Wed, 21 Oct 2015 11:20:17 -0700
Message-ID: <xmqqlhaw5bj2.fsf@gitster.mtv.corp.google.com>
References: <56278FD3.3010103@lrz.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Daniel Steinborn <daniel.steinborn@lrz.de>
X-From: git-owner@vger.kernel.org Wed Oct 21 20:20:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zoxzu-0001BP-Sx
	for gcvg-git-2@plane.gmane.org; Wed, 21 Oct 2015 20:20:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754665AbbJUSUV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Oct 2015 14:20:21 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:36835 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753586AbbJUSUU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Oct 2015 14:20:20 -0400
Received: by pacfv9 with SMTP id fv9so64083229pac.3
        for <git@vger.kernel.org>; Wed, 21 Oct 2015 11:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=v//aQuilyzL4s+BHdbNmF2b7VnSku3SN28/ickjkh/A=;
        b=be+3tHqI/XGTSz/3p+pcGtI9yYy72WdkAs4/tMmq3++qNfhwb2/hIlOYVVPJ3zNixD
         ODZOF3BTMD0YARSOc5krMZnK+f1JYRJZjiT7LMGdzOzZeXgLZtFl3MUSCevaaM87r9Db
         EbKpAD1LCm31ORyiV/dXByS9E+wJWwa0P22WH3qqovx6GNeEHBFqxGnG1P6drMb8PeFc
         2X6SwB6kVU0KTkyrDxxoARqKfWrDQ5XEEnCh8XrrcIZJVQmI+kvisU/vEv7GbVg8NfSB
         Tbsw6NAW2fFi/X8azlPfJ+ba5tU0s2LaM+GxBHypRu+p01bj10fofGSF+j0IxUyi/0xO
         +q4A==
X-Received: by 10.68.69.15 with SMTP id a15mr12373160pbu.62.1445451619403;
        Wed, 21 Oct 2015 11:20:19 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:f0a2:278f:6a7e:e323])
        by smtp.gmail.com with ESMTPSA id kw10sm10337793pbc.25.2015.10.21.11.20.18
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 21 Oct 2015 11:20:18 -0700 (PDT)
In-Reply-To: <56278FD3.3010103@lrz.de> (Daniel Steinborn's message of "Wed, 21
	Oct 2015 15:14:59 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279996>

Daniel Steinborn <daniel.steinborn@lrz.de> writes:

> currently we are experiencing poor write performance when a repository
> is pushed to a nfs volume. Interestingly, this seems to be a problem
> in newer git versions:
>
> v1.7.12.4: Very good performance
>
> v2.1.4: Bad performance, up to 6 times slower
>
> Are there any changed default settings or new features that can be the
> reason for that problem?
>
> Please ask for specific details if they are neccessary.

Between 1.7.12.x series and v2.1.4, there are more than two years'
worth of changes, so it is unreasonable for anybody to expect that
such a question can be answered in a meaningful way.

Have you tried more recent versions yet?  2.1.x series is over a
year old, and I am reasonably sure there have been tons of "earlier
we did X for correctness, which unfortunately made things slower,
and this ensures the same correctness in a different way that is
much more performant" fixes since then.
