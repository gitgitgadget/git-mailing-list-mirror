From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: regression: "96b9e0e3 config: treat user and xdg config
 permission problems as errors" busted git-daemon
Date: Thu, 11 Apr 2013 11:11:03 -0700
Message-ID: <20130411181103.GJ27070@google.com>
References: <1365572015.4658.51.camel@marge.simpson.net>
 <20130410135605.GB4694@odin.tremily.us>
 <1365651583.19620.8.camel@marge.simpson.net>
 <20130411054207.GE27795@sigill.intra.peff.net>
 <7vwqs9jd0t.fsf@alter.siamese.dyndns.org>
 <20130411172424.GC1255@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Mike Galbraith <bitbucket@online.de>,
	"W. Trevor King" <wking@tremily.us>, git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 11 20:11:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQLxr-0004aK-Op
	for gcvg-git-2@plane.gmane.org; Thu, 11 Apr 2013 20:11:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965053Ab3DKSLK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Apr 2013 14:11:10 -0400
Received: from mail-pd0-f174.google.com ([209.85.192.174]:56570 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964882Ab3DKSLI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Apr 2013 14:11:08 -0400
Received: by mail-pd0-f174.google.com with SMTP id p12so979756pdj.5
        for <git@vger.kernel.org>; Thu, 11 Apr 2013 11:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=jN7yIy1U+kMviAdoLKXJ0FguebYoHtvyzd9sm0NJ9D0=;
        b=PHbpjj15j2WYba9Xh+Ryd8vm/a6v1ODFqYU4Lpk8wjvqIJkrrpZhTqQFixX/WwP+jz
         4Tfppw8grNAgFPF4wEVH4KLDosxBiB1wW2o27C5VHhCTAM7x49X/Uip9mZJfZGiKRbAe
         SSAuxtaWoHI3mvWaFsupuWgQEM0psUItSz5Nu5aGk0BrKkoEE3B2kpw9iTApCZP8f1S/
         BUwHUdKzLV1M4sM7Qeyn4bAyfH+lRHj0DNHRo6BEG59k6CT+HBojw83n7luGzpl4Ws69
         mKBcIHTFqMvte9sGd9JPaSgJY3R9pRxd1nwfhykmdlNRXkuadvaCOsVRwxjKwTFVyRH2
         MCyQ==
X-Received: by 10.66.145.166 with SMTP id sv6mr11303348pab.1.1365703868323;
        Thu, 11 Apr 2013 11:11:08 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPS id ky10sm5843978pab.23.2013.04.11.11.11.05
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 11 Apr 2013 11:11:06 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20130411172424.GC1255@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220903>

Jeff King wrote:

> Here it is with a commit message.
>
> -- >8 --
> Subject: [PATCH] daemon: set HOME when we switch to --user

Thanks for taking care of it.  For what it's worth,

Acked-by: Jonathan Nieder <jrnieder@gmail.com>

I'm not sure whether to keep 96b9e0e (config: treat user and xdg
config permission problem as errors) in the long run, BTW.  There have
been multiple reports about dropping privileges and not being able to
access the old HOME, and I'm not convinced any more that the
predictability is worth the breakage for such people.  Though checking
if $HOME is inaccessible and treating that case specially would be
even worse...

Insights welcome.

Jonathan
