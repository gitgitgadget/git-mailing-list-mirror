From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH 3/6] bisect: use refs infrastructure for BISECT_START
Date: Thu, 25 Jun 2015 16:29:34 -0400
Organization: Twitter
Message-ID: <1435264174.7900.2.camel@twopensource.com>
References: <1435173388-8346-1-git-send-email-dturner@twopensource.com>
	 <1435173388-8346-4-git-send-email-dturner@twopensource.com>
	 <xmqqr3ozzq6k.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, mhagger@alum.mit.edu
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 25 22:29:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z8DmJ-0000wn-0C
	for gcvg-git-2@plane.gmane.org; Thu, 25 Jun 2015 22:29:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751201AbbFYU3j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Jun 2015 16:29:39 -0400
Received: from mail-ig0-f173.google.com ([209.85.213.173]:33433 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751136AbbFYU3h (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jun 2015 16:29:37 -0400
Received: by igbqq3 with SMTP id qq3so23634104igb.0
        for <git@vger.kernel.org>; Thu, 25 Jun 2015 13:29:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=Yu9o88h/wiuYGsZbEtmB9u5XZFOXq+NLR5jNCUfFIvM=;
        b=hP3876RicX12kxI1fm7WSley2VFRf8horZMMmub4LrOwq9r84bm3/4aNW+Ixb9o6mw
         wGbOaDD9PLPH+Bib6KDwymLQ/XiOIcGH1Bpu9gmhKRgcgPiB9q689Bs+HqO/j6RjTgYi
         L7y48yn5JckNZN/zZfdV2QeMev1eN26JBtFf4pMxvegG9YvA7BSpb8kgfgLsV5kqz+5i
         nDMJXZLlCrCFPjWsna2EqaQjdNp/3tDgBj+lF/wOYNZqcSES8ksZJRAC+78cCtYRsJ1q
         FgkC7t5C63pqwfD0EHGbZ7ERBNFtlllnNlXzq7leyhGTvSfTBEcMAmVbjmXxnInT/rU+
         JcOQ==
X-Gm-Message-State: ALoCoQkGRyo+gDkQzaCzas3ULPGecXS4dbdBrdyWZchZ+zv34vs7uDvcYCcrUXqH/5sAL4KL6q+a
X-Received: by 10.50.138.76 with SMTP id qo12mr6477083igb.38.1435264177116;
        Thu, 25 Jun 2015 13:29:37 -0700 (PDT)
Received: from ubuntu (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com. [207.38.164.98])
        by mx.google.com with ESMTPSA id a139sm20284894ioa.14.2015.06.25.13.29.35
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Jun 2015 13:29:35 -0700 (PDT)
In-Reply-To: <xmqqr3ozzq6k.fsf@gitster.dls.corp.google.com>
X-Mailer: Evolution 3.12.10-0ubuntu1~14.10.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272723>

On Thu, 2015-06-25 at 09:52 -0700, Junio C Hamano wrote:
> David Turner <dturner@twopensource.com> writes:
> 
> > This ref needs to go through the refs backend, since some code assumes
> > that it can be written and read as a ref.
> 
> And BISECT_HEAD should no longer be a ref because...?

I can't remember now why I did this.  I guess we'll find out as we work
on the remaining patches.  I'll take it out for now.
