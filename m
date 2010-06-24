From: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
Subject: Re: What's cooking in git.git (Jun 2010, #04; Wed, 23)
Date: Thu, 24 Jun 2010 22:51:03 +0200
Message-ID: <40D1B374-E80A-4BA2-B3A2-142E8256C23E@gmail.com>
References: <7viq59e6zn.fsf@alter.siamese.dyndns.org> <20100624111757.GB3453@pvv.org> <7veifwchb6.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Finn Arne Gangstad <finnag@pvv.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 24 22:51:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ORtOD-0004J9-Tw
	for gcvg-git-2@lo.gmane.org; Thu, 24 Jun 2010 22:51:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755802Ab0FXUvI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jun 2010 16:51:08 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:34797 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755189Ab0FXUvG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 Jun 2010 16:51:06 -0400
Received: by wyi11 with SMTP id 11so2032785wyi.19
        for <git@vger.kernel.org>; Thu, 24 Jun 2010 13:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:mime-version
         :content-type:from:in-reply-to:date:cc:content-transfer-encoding
         :message-id:references:to:x-mailer;
        bh=HqhdeMcV2IJTJRAPrCRJ147NiPfqMjX+OxdSKLFPNJ0=;
        b=IsPvRMUNmUI7Iur3xR5+N/A5GzWaxWKt8PknQruW+xYX3zu7PJlfLopSwXQPxQcLrU
         Jdt4YJ0GVJJ4L99SwnaEGeO0WuE3EgIC+fkjIgFaWc2u55ML7m5aidw4qdXw2aTsTSeb
         Dm5Hk3HSmmvFL6klaB07Qp7vPSx/Py3NKnMGs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:mime-version:content-type:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to:x-mailer;
        b=DoT8EaSUu4LIg5UISRVy1dwv1bzoSC0IupnZJiPXCBURML+pa/4oOqOR3o+FjmNrSY
         ++FzxrwBvU0El6eJC5jk0W/G6DhRQ6CX+bfjadKaFkAmEyM2pxy4uvQlFNwYv8/IzpJk
         fZw1eZ2jfaP/eGRjxegJlnLpCCnYaSgHjX6I8=
Received: by 10.216.159.20 with SMTP id r20mr7791274wek.62.1277412665068;
        Thu, 24 Jun 2010 13:51:05 -0700 (PDT)
Received: from [172.16.3.204] (eyvind.bernhardsens.net [84.49.224.5])
        by mx.google.com with ESMTPS id l70sm922717weq.0.2010.06.24.13.51.04
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 24 Jun 2010 13:51:04 -0700 (PDT)
In-Reply-To: <7veifwchb6.fsf@alter.siamese.dyndns.org>
X-Mailer: Apple Mail (2.1081)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149647>

On 24. juni 2010, at 22.21, Junio C Hamano wrote:

> Finn Arne Gangstad <finnag@pvv.org> writes:
> 
>> If .gitattributes is different on the different sides, or if you
>> enable autocrlf, the current repo contents may change after
>> git-to-worktree and worktree-to-git again.
> 
> IOW, g2w-then-w2g may not be an identity function.
> 
> If we were to encourage use of this codepath to wider audiences, we may
> need to have a document for people who write smudge/clean filters.  In
> order for the result to be stable, applying g2w-then-w2g once again on top
> of the result of running g2w-then-w2g on anything should be no-op, no?

Hm.  Isn't that already a requirement?  If a clean filter doesn't clean to something normalized, simply touching a file could result in spurious differences (much like pre-safe-autocrlf autocrlf).  I could well be missing something here, though.
-- 
Eyvind
