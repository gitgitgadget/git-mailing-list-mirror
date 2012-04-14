From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH v2 0/3] Re: i18n: use test_i18ncmp in t2020 (checkout
 --detach)
Date: Fri, 13 Apr 2012 23:44:13 -0500
Message-ID: <20120414044413.GA1791@burratino>
References: <20110320090111.GA15641@sigill.intra.peff.net>
 <20110320090918.GB15948@sigill.intra.peff.net>
 <20120413225901.GA13220@burratino>
 <20120413233010.GA16663@sigill.intra.peff.net>
 <20120413234607.GE13995@burratino>
 <20120414022452.GA17535@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Piotr Krukowiecki <piotr.krukowiecki@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Jiang Xin <worldhello.net@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Apr 14 06:44:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SIuqd-0002hQ-54
	for gcvg-git-2@plane.gmane.org; Sat, 14 Apr 2012 06:44:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751006Ab2DNEo0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Apr 2012 00:44:26 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:44358 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750905Ab2DNEoZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Apr 2012 00:44:25 -0400
Received: by iagz16 with SMTP id z16so5106048iag.19
        for <git@vger.kernel.org>; Fri, 13 Apr 2012 21:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=xhQJmXz5ijHjUat0sBCntuUSepQ2Q8QBDcExIfFBen0=;
        b=kO38VH4ma5sL4p1hmGm1A4Hu6irLZo5NvQhKoa7mY0dl+gpe0a/c/Y2b3ri8NVsvNU
         Yhwz7OXCunVOV4XUQ6/uRiAAkrvHmMRjLsVZzV4eCUWTG52d5fwae4GCsl2fi3ACNEH2
         ziwlaaMs3PHsZRLNlEnWtsct90V2E90emyCAfQQRf+Fa5iK3REV70dSLHTDxD5XCkxBO
         V8N4I6jm946D4X3FvpPhmX/ye3su+2/UBt0dW6j0y4tzzVqvop3NUN+URZJD/ClzOOfd
         Nduicjlls44Wjcuf8zz4pMk3jIOmOViEh7aWG26kHUjdvebWrMDA72SdaPGbrenPbyJd
         xMdQ==
Received: by 10.50.207.5 with SMTP id ls5mr402714igc.51.1334378664858;
        Fri, 13 Apr 2012 21:44:24 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id md6sm2456289igc.0.2012.04.13.21.44.21
        (version=SSLv3 cipher=OTHER);
        Fri, 13 Apr 2012 21:44:23 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120414022452.GA17535@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195465>

Jeff King wrote:

> Yeah, that makes sense to me. It seems like t6040 is broken under
> GETTEXT_POISON by that commit, too (and is still broken). Probably your
> patch should deal with both breakages, as their root cause is the same.

Yep.

Here's a series doing that.  Patch 3 is a bonus patch unrelated to the
cause: it fixes a test buglet noticed while working on the other two.

Jonathan Nieder (3):
  test: do not rely on US English tracking-info messages
  test: use test_i18ncmp for "Patch format detection failed" message
  test: am of empty patch should not succeed

 t/t2020-checkout-detach.sh |    2 +-
 t/t4150-am.sh              |    4 ++--
 t/t6040-tracking-info.sh   |   10 +++++-----
 3 files changed, 8 insertions(+), 8 deletions(-)
