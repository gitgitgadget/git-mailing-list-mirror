From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 03/17] revert: Don't check lone argument in get_encoding
Date: Tue, 12 Jul 2011 11:59:49 -0500
Message-ID: <20110712165949.GB13578@elie>
References: <1310396048-24925-1-git-send-email-artagnon@gmail.com>
 <1310396048-24925-4-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 12 19:00:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QggJZ-0002OX-3q
	for gcvg-git-2@lo.gmane.org; Tue, 12 Jul 2011 19:00:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751520Ab1GLQ77 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jul 2011 12:59:59 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:37368 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750848Ab1GLQ76 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jul 2011 12:59:58 -0400
Received: by gxk21 with SMTP id 21so2011456gxk.19
        for <git@vger.kernel.org>; Tue, 12 Jul 2011 09:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=bwHKYmWol9pKbDGYmsEFyATq67G3nHmT5znSiXFncWs=;
        b=I9H84mV+a1ilzmZb3AjCz6rWQAI7lwNhBp7r3PE5hd7pq5vZZZeo0LWpWerfEaYzhY
         7Ce7kLE7qBUJb61eCWxuDZGcHN46KoyQrD/VkGV4yodJ4PlXANJnw0/YtcGBVZmBu+sA
         FN/WVNaACCS/HlrIWbumwTddm9MbIHKEmY4A4=
Received: by 10.151.63.33 with SMTP id q33mr320029ybk.226.1310489997587;
        Tue, 12 Jul 2011 09:59:57 -0700 (PDT)
Received: from elie (adsl-69-209-70-6.dsl.chcgil.ameritech.net [69.209.70.6])
        by mx.google.com with ESMTPS id s17sm861231ybm.7.2011.07.12.09.59.55
        (version=SSLv3 cipher=OTHER);
        Tue, 12 Jul 2011 09:59:56 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1310396048-24925-4-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176950>

Hi,

Ramkumar Ramachandra wrote:

> The get_encoding function has only one callsite, and its caller makes
> sure that a NULL argument isn't passed.  Don't unnecessarily double
> check the same argument in get_encoding.

Such a double-check is not a huge maintenance burden, is it?  As I
mentioned at [1], I am guessing the actual motivation is (1) to avoid
having to pass "commit" around and (2) to avoid burdening translators
with a message that will never be shown.

Would it be possible to clarify the commit message so it is no longer
necessary to guess?

[1] http://thread.gmane.org/gmane.comp.version-control.git/176139/focus=176166
