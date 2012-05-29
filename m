From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 03/65] i18n: archive: mark parseopt strings for
 translation
Date: Tue, 29 May 2012 07:14:28 -0500
Message-ID: <20120529121428.GD14697@burratino>
References: <1336314232-21002-3-git-send-email-pclouds@gmail.com>
 <1338203657-26486-1-git-send-email-pclouds@gmail.com>
 <20120528224729.GK14606@burratino>
 <CACsJy8ANyMxLNCP1P28AKywssGdSQP3QnE_HZHHGzkX-4oqFtw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Jiang Xin <worldhello.net@gmail.com>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 29 14:14:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SZLK1-0004sL-FY
	for gcvg-git-2@plane.gmane.org; Tue, 29 May 2012 14:14:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753790Ab2E2MOk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 May 2012 08:14:40 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:53117 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753482Ab2E2MOj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 May 2012 08:14:39 -0400
Received: by yenm10 with SMTP id m10so1934482yen.19
        for <git@vger.kernel.org>; Tue, 29 May 2012 05:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=RckLrPGmmOYsyUibupDS5XLgQKy3LB56TPH/ZDC3laE=;
        b=jSEDpwpnwMLoR76uUhgF+TDaR1pjG3ZIHxHw8QEvlesrbwQ7zDzCIvjMeqgdYWO31+
         1E6HDmcg4f2nTPWbuBKZtXkxunvfsAEQ83xAKMEPkr+uWF88bsRRpQzRNm4IuEt70xXu
         E7hjhCG2l9nQXB2lIhZBH3Vec4ZwGLpYR8yYi4HXh3dc73lDQGBpst7frX10g3BJ8n/g
         Y59Rf8XGRJMVlRmoOwrRcOenLAdRPxEi1HGHopkdQVkjSZxdQzcCzRQ3zliR/84yzgqA
         7r+3IIDCz/HKTJOo+OjsMw9rPdN6BzwCP/Tb4qGbxlFIUa3Q3IoLazZw3NsLpHQ4qT6J
         pFrA==
Received: by 10.50.236.74 with SMTP id us10mr6978387igc.29.1338293678406;
        Tue, 29 May 2012 05:14:38 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id ey7sm15005458igb.2.2012.05.29.05.14.36
        (version=SSLv3 cipher=OTHER);
        Tue, 29 May 2012 05:14:36 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CACsJy8ANyMxLNCP1P28AKywssGdSQP3QnE_HZHHGzkX-4oqFtw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198737>

Nguyen Thai Ngoc Duy wrote:

>                         The test suite is currently more focused on
> features than human readable output.

Thanks for clarifying this.  Yes, that's the point of the
GETTEXT_POISON check.  It is supposed to make sure that running git in
another locale does not break features by modifying text that
(internal and external) scripts parse.

For a sanity check on the messages marked for translation from a
translator's perspective, it is generally better to just look at the
pot file.  And from the end user's perspective, I don't know a better
way to test than to just use git a little.

As a side effect, GETTEXT_POISON keeps the test suite usable for
exercising a copy of git configured for an actual other locale, which
means that in the future the test suite could be used to check for
problems due to differences between locales other than the translated
messages (think: charset, collation order, etc).

Ciao,
Jonathan
