From: Andrew Ardill <andrew.ardill@gmail.com>
Subject: Re: Why does "git config" output nothing instead of the default value
 for unset variables?
Date: Sun, 14 Apr 2013 22:47:31 +1000
Message-ID: <CAH5451nL0cmTy+vwEsJnvX7OP1iSSgY9UMhvrrimk0zWM71YDw@mail.gmail.com>
References: <kke7o1$oo$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 14 14:47:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URMLd-0003jf-9Z
	for gcvg-git-2@plane.gmane.org; Sun, 14 Apr 2013 14:47:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751791Ab3DNMrx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Apr 2013 08:47:53 -0400
Received: from mail-ve0-f174.google.com ([209.85.128.174]:61508 "EHLO
	mail-ve0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751397Ab3DNMrw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Apr 2013 08:47:52 -0400
Received: by mail-ve0-f174.google.com with SMTP id jz10so3537882veb.33
        for <git@vger.kernel.org>; Sun, 14 Apr 2013 05:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=t/GT2U2LLok0/9ZE4fSpKxgLSKe9MZPAky80QRByO+U=;
        b=ksD/D1ss06L2+ol+ycqhl9qMAz8Lc13QbefqXAfNUEm4onNhRCWBVEcdQ319bIWi76
         HmwqCzrOlHbMEy/vF5Odi8zy//d226ZgbgHnkKEJV9hEmy3jVPC/9r8r3iJLix/fblLl
         +/I9v5GeLm0IpKUk3bidiAtfwIziXFOegahY1UqxMwRnti/quBeY7eLXqbXKprEY8ihw
         TXGMluMBXXmGlPLcXr/Q0dA4U4xoyJb6lndv34PRpVG+1ITK2DMHPMjLq5gEdpGrzcVK
         ea3Q1Nbq0aNVdWKHEHaLlcU4cs1xezyCxBHm1OvhlHGTaH7qvrLg6tregqP5yxQxHEl5
         hOzQ==
X-Received: by 10.52.119.175 with SMTP id kv15mr11335697vdb.23.1365943671440;
 Sun, 14 Apr 2013 05:47:51 -0700 (PDT)
Received: by 10.220.107.82 with HTTP; Sun, 14 Apr 2013 05:47:31 -0700 (PDT)
In-Reply-To: <kke7o1$oo$1@ger.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221099>

On 14 April 2013 22:34, Sebastian Schuberth <sschuberth@gmail.com> wrote:
> Usually when I query a variable I'm not so much interested in whether it is at all (explicitly) set to some value or not, but what value is currently in use.

With your change in place, how do you know if the config item has been
explicitly set in your system?

The closest thing I can see for doing this is git config --list, but
perhaps there should be a flag to check if a config item is set?

More to the point, I can easily imagine many scripts relying on git
config returning a value to indicate that a config item has been set.
Your proposed change would break all those. For that reason, it might
be nicer to introduce a flag that returns the config if it is set or
the default otherwise. Something like git config --value perhaps.

Regards,

Andrew Ardill
