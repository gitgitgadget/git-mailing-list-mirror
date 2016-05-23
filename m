From: Eric Wong <e@80x24.org>
Subject: Re: [PATCH v1 2/2] travis-ci: enable sequential test execution for
 t9113 and 9126
Date: Mon, 23 May 2016 21:32:54 +0000
Message-ID: <20160523213254.GA11731@dcvr.yhbt.net>
References: <1463649009-56941-1-git-send-email-larsxschneider@gmail.com>
 <1463649009-56941-3-git-send-email-larsxschneider@gmail.com>
 <20160519100658.GA20225@dcvr.yhbt.net>
 <xmqqwpmqj7m1.fsf@gitster.mtv.corp.google.com>
 <7A9DE9C1-4AC7-4FF3-B8B1-26DE84BA625B@gmail.com>
 <xmqq60u48o6v.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Lars Schneider <larsxschneider@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 23 23:32:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b4xSn-0006Fc-2F
	for gcvg-git-2@plane.gmane.org; Mon, 23 May 2016 23:32:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752509AbcEWVcd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 May 2016 17:32:33 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:37490 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751903AbcEWVcc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 May 2016 17:32:32 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3604A1FCC7;
	Mon, 23 May 2016 21:32:32 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <xmqq60u48o6v.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295398>

Junio C Hamano <gitster@pobox.com> wrote:
> Lars Schneider <larsxschneider@gmail.com> writes:
> >> On 19 May 2016, at 19:11, Junio C Hamano <gitster@pobox.com> wrote:
> >> Eric Wong <e@80x24.org> writes:
> >> 
> >>> Anyways, how about making the tests run on separate ports and
> >>> not worry about serializing them at all?
> >> 
> >> Yeah, that does sound like a more sensible approach.
> >
> > Makes sense. However, it's not something I will tackle soon.
> > Would you be willing to pick up $gmane/295048 (the first patch) as is 
> > and drop $gmane/295050 (the patch discussed here)? Then the majority
> > of Git SVN tests would run on Travis CI.
> 
> I am not sure if adding git-svn alone would be a good change.
> Wouldn't it invite false failures from running these conflicting
> tests at the same time?

The problematic tests won't run unless *_PORT variables are set;
which AFAIK they aren't, yet.
