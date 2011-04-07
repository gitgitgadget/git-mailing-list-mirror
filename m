From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 1/4] magic pathspec: add tentative ":/path/from/top/level"
 pathspec support
Date: Thu, 7 Apr 2011 20:09:43 +0700
Message-ID: <BANLkTinkXVSFYqqZ+pHK0w8ij5YtPMfKEA@mail.gmail.com>
References: <1302138996-10006-1-git-send-email-gitster@pobox.com>
 <1302138996-10006-2-git-send-email-gitster@pobox.com> <7v62qqhm9h.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 07 15:10:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q7oyo-0004lY-0f
	for gcvg-git-2@lo.gmane.org; Thu, 07 Apr 2011 15:10:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751418Ab1DGNKQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Apr 2011 09:10:16 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:57318 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751087Ab1DGNKP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Apr 2011 09:10:15 -0400
Received: by bwz15 with SMTP id 15so1983293bwz.19
        for <git@vger.kernel.org>; Thu, 07 Apr 2011 06:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=WaxRdWTVEUX2SBvjgUh+ctXsrQurw3M/NM2YmkmqtrI=;
        b=Rmw0yLomu/5VJAcLVsYLslt1NacgHuso3fh9ecqpWaoLwYmN1B2oVmT/4Elh5hga3C
         TK4TzC/6WXHhA9QpJps5vYQfdSf/J3fvMH8Fa98lY90SVHwEy7xs2L37uUGlX4+IbMat
         +ZdQC1vuUZgq7Iqzx6OZrU9nYIkkGwImeo7MI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=bxQuWADS8ieOI+EKV15wRVt+4vl1CjualfJOqHgVPMgT6GgV4QsBPgO8HX2ZaaqZs4
         HupnMr4Hfyw9oS4kcKNiAMAFQKZaezi3UpobYoxiE/PPiQUqqjfcC/yR/4SnLtFz4Dqc
         7m69IvRc++PB1MUqLEjrpGxbegaS2ioyR6QoE=
Received: by 10.204.189.76 with SMTP id dd12mr698236bkb.206.1302181813813;
 Thu, 07 Apr 2011 06:10:13 -0700 (PDT)
Received: by 10.204.37.195 with HTTP; Thu, 7 Apr 2011 06:09:43 -0700 (PDT)
In-Reply-To: <7v62qqhm9h.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171057>

MjAxMS80LzcgSnVuaW8gQyBIYW1hbm8gPGdpdHN0ZXJAcG9ib3guY29tPjoKPiArIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGlmICgoJ2EnIDw9IGNoICYmIGNoIDw9ICd6JykgfHwK
PiArIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgICgnQScgPD0gY2ggJiYg
Y2ggPD0gJ1onKSkgewo+ICsgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgc3RyYnVmX2FkZGYoJnNiLCAiWyVjJWNdIiwKPiArIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHRvbG93ZXIoY2gpLCB0
b3VwcGVyKGNoKSk7CgpOaWNlIHRyeS4gWW91IGtub3cgeW91IGFyZSBnb2luZyB0byBwYXkgYSBo
aWdoIHBlcmZvcm1hbmNlIHByaWNlIGZvcgp0aGF0LCBkb24ndCB5b3UgOykgTWF5YmUgYWxzbyB3
b3J0aCBtZW50aW9uaW5nIGluIGRvY3VtZW50IHRoYXQgdGhpcwphcHBsaWVzIHRvIEFTQ0lJIGNo
YXJzZXQgb25seSAoYXMgb3Bwb3NlZCB0byBVbmljb2RlKS4KLS0gCkR1eQo=
