From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2 8/9] sha1_name: simplify track finding
Date: Thu, 10 Apr 2014 17:27:07 -0500
Message-ID: <53471abb6fa76_d696b12f0b0@nysa.notmuch>
References: <1397156686-31349-1-git-send-email-felipe.contreras@gmail.com>
 <1397156686-31349-9-git-send-email-felipe.contreras@gmail.com>
 <CALkWK0kRAYpZxDkZ6nVPcfo4pqJuTLNFekpQ+tLPPRFJZKUMuw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>,
	Matthieu Moy <matthieu.moy@imag.fr>, Jeff King <peff@peff.net>,
	John Szakmeister <john@szakmeister.net>
To: Ramkumar Ramachandra <artagnon@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 11 00:37:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WYNb5-0006Uj-SF
	for gcvg-git-2@plane.gmane.org; Fri, 11 Apr 2014 00:37:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161187AbaDJWhS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Apr 2014 18:37:18 -0400
Received: from mail-ob0-f182.google.com ([209.85.214.182]:60148 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759193AbaDJWhK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Apr 2014 18:37:10 -0400
Received: by mail-ob0-f182.google.com with SMTP id uz6so5211556obc.13
        for <git@vger.kernel.org>; Thu, 10 Apr 2014 15:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=URYiWhKZ8Nfx+Zs20eU2UTWrzLi/40AwR3ZA/5851+M=;
        b=n4Wv/WezWlDOEdYCK2WwXtkUKBCqDPLOJ4ohfJ0Wr+mKqsF2sMCM+/8qKkLgVZfr2b
         Pbe5nC2JqO0B8rK0GRfHXa5kakyOb9X+R/lYdN+wdT04qEHaw29N5xZkbsNfggMvvpYW
         t22u6KyaczogN4CPSYkyIah7lBRMDzmsAcvge/AHdEv2qelpUHp5yAZRbZLh8Pbf7M8t
         1Wp6DDuT1NaCHrazLe/JAHixaT3IIlBbKeuFuaj4Y+vs8p6i3uEOX69c0mAMcN6sZbqH
         KRq+2rzlRVyWV55ztAkin/ikeQ2U2RTp27CfbeAwtLkzvpTIFRGXoJAM2Yejct3TdUcq
         lXDg==
X-Received: by 10.60.45.35 with SMTP id j3mr3406252oem.68.1397169430214;
        Thu, 10 Apr 2014 15:37:10 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id bj8sm9217346obb.7.2014.04.10.15.37.04
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Apr 2014 15:37:07 -0700 (PDT)
In-Reply-To: <CALkWK0kRAYpZxDkZ6nVPcfo4pqJuTLNFekpQ+tLPPRFJZKUMuw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246061>

Ramkumar Ramachandra wrote:
> Felipe Contreras wrote:
> > It's more efficient to check for the braces first.
> 
> Why is it more efficient? So you can error out quickly in the case of
> a malformed string?

That's one reason. The other is that get_sha1_basic() calls upstream_mark()
when we _already_ know there's a @{foo}.

-- 
Felipe Contreras
