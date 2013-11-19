From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v4 2/2] Rename suffixcmp() to ends_with() and invert its
 result
Date: Tue, 19 Nov 2013 11:13:23 -0800
Message-ID: <20131119191322.GA4212@google.com>
References: <20131117083930.4177.79411.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Avery Pennarun <apenwarr@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>, Max Horn <max@quendi.de>,
	Andreas Ericsson <ae@op5.se>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Tue Nov 19 20:13:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Viqk0-0004r9-PN
	for gcvg-git-2@plane.gmane.org; Tue, 19 Nov 2013 20:13:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753522Ab3KSTNc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Nov 2013 14:13:32 -0500
Received: from mail-yh0-f49.google.com ([209.85.213.49]:34380 "EHLO
	mail-yh0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753496Ab3KSTNa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Nov 2013 14:13:30 -0500
Received: by mail-yh0-f49.google.com with SMTP id z20so2021384yhz.8
        for <git@vger.kernel.org>; Tue, 19 Nov 2013 11:13:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=bZEJWArrKWyTJQqfccByyYuRvWRCNVVbWDvIrDeSiy4=;
        b=yFkGzdrlXlCcc5h6ik2XL/sc2opgF8z3sijG3ED0hRNx+4pNqqLWgNKKOY0K/pwSJ0
         tVnJTJAPdwTXWmitt+NyEOjh+9ukfqW8Ocj26lJYN9m57bGEMdxHOyxmBFRECtf3HWWQ
         kuqRrXK7tfRZBpcirYXpCXhNP1KpirzD0TENuFaKWw3Jk2SD83zkyYO2VB9WLBz1aUP1
         iXj8QE5q25+FLSEK8ZEDge8gk3VP6ujzP3Uox3T4l26T6CFUzt1xp2C9jMs4d8REIk0q
         6kiyePt1XF2qCrT1BvnfcE/U6akicwzf7F27L+AAOtr5Kq3Dp+XezCsGsWejZhQvAkrx
         Y1sQ==
X-Received: by 10.236.102.200 with SMTP id d48mr24165640yhg.38.1384888410189;
        Tue, 19 Nov 2013 11:13:30 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id 48sm37373857yhq.11.2013.11.19.11.13.28
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 19 Nov 2013 11:13:29 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20131117083930.4177.79411.chriscool@tuxfamily.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238037>

Christian Couder wrote:

> Now ends_with() returns 1 when the suffix is present and 0 otherwise.

Sounds good.

[...]
> And in vcs-svn/fast_export.c there was already an ends_with()
> function that did the same thing. Let's used the renamed one
> while at it.

Yes, despite the change in signature this shouldn't slow anything
down.  Thanks.

For what it's worth,
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
