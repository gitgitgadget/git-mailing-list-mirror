From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 4/4] lock_ref_sha1_basic: do not die on locking errors
Date: Tue, 18 Nov 2014 18:05:03 -0800
Message-ID: <20141119020503.GS6527@google.com>
References: <20141119013532.GA861@peff.net>
 <20141119014112.GA2305@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stefan Beller <sbeller@google.com>, sahlberg@google.com,
	gitster@pobox.com, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Nov 19 03:05:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xqudo-00013y-1e
	for gcvg-git-2@plane.gmane.org; Wed, 19 Nov 2014 03:05:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754226AbaKSCFD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Nov 2014 21:05:03 -0500
Received: from mail-ig0-f181.google.com ([209.85.213.181]:55161 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753801AbaKSCFB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Nov 2014 21:05:01 -0500
Received: by mail-ig0-f181.google.com with SMTP id l13so210623iga.2
        for <git@vger.kernel.org>; Tue, 18 Nov 2014 18:05:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=jubUxKlJBiu5ufvasfBP909rNrF9ayQwmZ/d7sViAIk=;
        b=Y9iLSWv0b1xY2wQo2ejkoln+g5yaYjmPWx17NoxEGMBelrHP9wKLA5MwlNk7i71bAm
         BMaIs812feC61VNVfRTOmq7kripYCCTKCeQkup7gGHoftmDXX4Dd90QaD+tUiTNZeyCM
         Vj4lEs0fJwqkCjsHDe/86NcOpbHmlQBvIsUV33uLbPQ+bdE42WVi5pe1eFqcIb9XJWqE
         Y/EQsEQVqRAmmbL0EOQ6JiPUpDDJBx09igFZO67xHFTI9djMzal/1EPTB6Zu6hCDYYos
         7lJeZ/ZI8SCUUuYWh7IXbhwIRc2KYT2uHGqKTUwH9qLX5huOOKCPjGlmripZ4DdtUpNq
         APIg==
X-Received: by 10.43.89.8 with SMTP id bc8mr433683icc.35.1416362700807;
        Tue, 18 Nov 2014 18:05:00 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:48de:79f7:30eb:4507])
        by mx.google.com with ESMTPSA id o8sm121601igh.18.2014.11.18.18.04.59
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 18 Nov 2014 18:05:00 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20141119014112.GA2305@peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:

> From: Ronnie Sahlberg <sahlberg@google.com>
>
> lock_ref_sha1_basic is inconsistent about when it calls
> die() and when it returns NULL to signal an error. This is
> annoying to any callers that want to recover from a locking
> error.

And in addition to the modern transaction stuff, rename_ref() has been
such a caller for a long time.

Thanks for a pleasant explanation.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

[...]
> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>

No need for my sign-off here --- it was just an artifact of my
forwarding the patch to the list before.
