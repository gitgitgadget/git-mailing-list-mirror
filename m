From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC PATCH v3 8/8] --sparse for porcelains
Date: Sun, 16 Aug 2009 01:37:24 +0200
Message-ID: <200908160137.30384.jnareb@gmail.com>
References: <1250005446-12047-1-git-send-email-pclouds@gmail.com> <200908142223.07994.jnareb@gmail.com> <7veird4yyi.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 16 01:38:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1McSpM-0000LK-34
	for gcvg-git-2@gmane.org; Sun, 16 Aug 2009 01:38:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751375AbZHOXhh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Aug 2009 19:37:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751204AbZHOXhg
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Aug 2009 19:37:36 -0400
Received: from fg-out-1718.google.com ([72.14.220.156]:63667 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751060AbZHOXhg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Aug 2009 19:37:36 -0400
Received: by fg-out-1718.google.com with SMTP id e21so503161fga.17
        for <git@vger.kernel.org>; Sat, 15 Aug 2009 16:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=goZ4S36jzCzbP3yrLgL1Yz+5ev83HROxagvmqeBv5p4=;
        b=JQSGYfRNA+OhB9xZ33soV0ffuZt9Y4YECxX0qsa+Djl8/jYrPRXrOoqy+gWZ2v0NiB
         oT9s6K7DfKv+UNd17haZ0QKHkdtgwVv3r81E/9GYoBg+PxfxLaHp3fMTUNfwmlj+j4Xl
         mIOB98pcnVcN9qUJi1fbUUFFqTKbEw5dUz/B0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=YJY78pVckc+4R5ZXq0SR0M3wM/hr0tmkJvXKysPq1OW6joJbHyRy9U1oK1HD7bKMBw
         OnFX+/Wjsu1nJsXe6Ps3YbKuN7ve3HwD3cNM6Z8aaRjX9N/F3t9o7qVtUcxLXD853GE3
         S3qT8sjSrXxnMgu0YEE14TgvfG9foyAJ84V3U=
Received: by 10.86.231.15 with SMTP id d15mr1764598fgh.74.1250379456514;
        Sat, 15 Aug 2009 16:37:36 -0700 (PDT)
Received: from ?192.168.1.13? (abwi212.neoplus.adsl.tpnet.pl [83.8.232.212])
        by mx.google.com with ESMTPS id 12sm4428458fgg.1.2009.08.15.16.37.34
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 15 Aug 2009 16:37:35 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <7veird4yyi.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126044>

On Sat, 15 Aug 2009, Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
>>>> Hmmm... this looks like either argument for introducing --full option
>>>>  to git-checkout (ignore CE_VALID bit, checkout everything, and clean
>>>>  CE_VALID (?))...
>>>>
>>>>  ...or for going with _separate_ bit for partial checkout, like in the
>>>>  very first version of this series, which otherwise functions like
>>>>  CE_VALID, or is just used to mark that CE_VALID was set using sparse.
> 
> How would a separate bit help?  Just like you need to clear CE_VALID bit
> to revert the index into a normal (or "non sparse") state somehow, you
> would need to have a way to clear that separate bit anyway.
> 
> A separate bit would help only if you want to handle assume-unchanged and
> sparse checkout independently. But my impression was that the recent lstat
> reduction effort addressed the issue assume-unchanged were invented to
> work around in the first place.

Well, if we assume that we don't need (don't want) to handle
assume-unchanged and sparse checkout independently, then of course the
idea of having separate or additional bit for sparse doesn't make sense.
 
-- 
Jakub Narebski
Poland
