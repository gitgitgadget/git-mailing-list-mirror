From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [RFC 03/11] Allow programs to not depend on remotes having urls
Date: Wed, 29 Jul 2009 10:57:37 +0200
Message-ID: <81b0412b0907290157y56255296qd3374f22ec3c7883@mail.gmail.com>
References: <1248656659-21415-1-git-send-email-johan@herland.net>
	 <1248656659-21415-4-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Cc: git@vger.kernel.org, Daniel Barkalow <barkalow@iabervon.org>,
	gitster@pobox.com
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Wed Jul 29 10:57:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MW4yv-0006Pf-Jn
	for gcvg-git-2@gmane.org; Wed, 29 Jul 2009 10:57:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751266AbZG2I5i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jul 2009 04:57:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751189AbZG2I5i
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Jul 2009 04:57:38 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:46202 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751006AbZG2I5h (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jul 2009 04:57:37 -0400
Received: by fxm18 with SMTP id 18so249783fxm.37
        for <git@vger.kernel.org>; Wed, 29 Jul 2009 01:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=RVM0HH8har0X3tzLY/vkHxj0JSXZwhoUXieBk4Y70eo=;
        b=uhMP0ogLaQQSYrtWZFJVOE2g5O7ORy2MQXCOZ186RVe+JX26JX6j1INQQ7RB+zk0AX
         PsnV7M40WOE5OTNN3ugKDKXVzpuIR7pUf5NnUvGf4bv8OX9ZK9sVKmP45BipCppELg6T
         IyMGTsl4NmUlXy+N3fXloNAezSb6K+Wlyba/8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=hnVnM9l5ptigu7RNvInkxfNcjxKjOhdzqVutqDd6KgNmTK4SC+2GDijtfg9dbHHtsb
         fJmT8xmTEqJLbnVfK+Shr+fSZlbdPjqPmj/Vgrwnrp54vpIx5R9PwS2kgR6TkoPn4beO
         DivTxDBwdIuzqycjOI3A9Liv7EpO+yNTeatY4=
Received: by 10.204.101.13 with SMTP id a13mr5132172bko.89.1248857857100; Wed, 
	29 Jul 2009 01:57:37 -0700 (PDT)
In-Reply-To: <1248656659-21415-4-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124331>

T24gTW9uLCBKdWwgMjcsIDIwMDkgYXQgMDM6MDQsIEpvaGFuIEhlcmxhbmQ8am9oYW5AaGVybGFu
ZC5uZXQ+IHdyb3RlOgo+IGRpZmYgLS1naXQgYS9idWlsdGluLWZldGNoLmMgYi9idWlsdGluLWZl
dGNoLmMKPiBpbmRleCA4MTdkZDZiLi4zZjMyZGI2IDEwMDY0NAo+IC0tLSBhL2J1aWx0aW4tZmV0
Y2guYwo+ICsrKyBiL2J1aWx0aW4tZmV0Y2guYwo+IEBAIC0zNDYsMTIgKzM0NiwxNyBAQCBzdGF0
aWMgaW50IHN0b3JlX3VwZGF0ZWRfcmVmcyhjb25zdCBjaGFyICpyYXdfdXJsLCBjb25zdCBjaGFy
ICpyZW1vdGVfbmFtZSwKPiArIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGlmICh1cmwpIHsKPiArIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHVybF9sZW4gPSBzdHJsZW4odXJsKTsKPiAr
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGZvciAoaSA9IHVybF9sZW4gLSAxOyB1
cmxbaV0gPT0gJy8nICYmIDAgPD0gaTsgaS0tKQo+ICsgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgOwo+ICsgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgdXJsX2xlbiA9IGkgKyAxOwo+ICsgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
aWYgKDQgPCBpICYmICFzdHJuY21wKCIuZ2l0IiwgdXJsICsgaSAtIDMsIDQpKQo+ICsgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgdXJsX2xlbiA9IGkgLSAzOwo+
ICsgwqAgwqAgwqAgwqAgwqAgwqAgwqAgfSBlbHNlIHsKPiArIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIHVybCA9ICJmb3JpZWduIjsKClR5cG8uIFNob3VsZCBiZSAiZm9yZWlnbiIu
Cg==
