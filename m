From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH 14/17] http*: add http_get_info_packs
Date: Wed, 3 Jun 2009 19:55:09 +0800
Message-ID: <be6fef0d0906030455p7b3b4d20p609adbb68093e988@mail.gmail.com>
References: <20090530015933.030ad46b.rctay89@gmail.com>
	 <20090530015937.c402e5f2.rctay89@gmail.com>
	 <20090531150256.GA27958@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Mike Hommey <mh@glandium.org>
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Wed Jun 03 13:55:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MBp3u-000788-H7
	for gcvg-git-2@gmane.org; Wed, 03 Jun 2009 13:55:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754301AbZFCLzI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jun 2009 07:55:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753588AbZFCLzI
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Jun 2009 07:55:08 -0400
Received: from wf-out-1314.google.com ([209.85.200.171]:6457 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753339AbZFCLzH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jun 2009 07:55:07 -0400
Received: by wf-out-1314.google.com with SMTP id 26so3140739wfd.4
        for <git@vger.kernel.org>; Wed, 03 Jun 2009 04:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=1243BmPmOAVqR634+wHY7Ngfd8zJOkCVABl0YUgYUYA=;
        b=VYa0UgfmwEwGadWwKgZlSTVJRY5GROyZuxSk8wxKCDNwLkLK9284xmCQhQ2gLjjRRB
         OuO4J/QzUl3L2kdfRTllWToQDZXfzber/q1Rb5yA5m+WOKACWQujGRD4obbABx9P887N
         vajSbNb4yRGZ9x5+7FJ6FXdDLnUyDYareDCAA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=mci9zZp+4WcwmcdXc5DaRw/AHcKrU/tvoqFcxoysBuGfR4iRsThi+ras/2A1h17xAz
         PP1zdCvHwIonIO+mqeT0BAp8i6XZUVUlsxFcBTOe/PUSySVImUE7qIBqORYCeouQRaDQ
         0/4RppLOZMm1oqGQw4Msi4d8Eea2HXTb0R+Go=
Received: by 10.142.154.9 with SMTP id b9mr297741wfe.151.1244030109283; Wed, 
	03 Jun 2009 04:55:09 -0700 (PDT)
In-Reply-To: <20090531150256.GA27958@localhost>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120604>

Hi,

On Sun, May 31, 2009 at 11:02 PM, Clemens Buchacher <drizzd@aon.at> wrote:
> fetch_indices() used to return 0 if the pack info was missing. Now it
> returns an error.

Thanks for noticing this.

> I also think we could get rid of repo->has_info_packs.
> This could easily be handled within fetch_indices().

Indeed, sending out somewhat redundant HEAD requests is done pretty
often; a separate patch/patch series should handle those.

-- 
Cheers,
Ray Chuan
