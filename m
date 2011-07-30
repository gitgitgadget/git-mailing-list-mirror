From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 16/18] revert: Remove sequencer state when no commits are
 pending
Date: Sat, 30 Jul 2011 15:10:50 +0200
Message-ID: <20110730131050.GA4848@elie>
References: <1311736755-24205-1-git-send-email-artagnon@gmail.com>
 <1311736755-24205-17-git-send-email-artagnon@gmail.com>
 <20110727051755.GK18470@elie>
 <CALkWK0noPtLgr_t=DC_XFdLrWUNCLhUd00Mw1HbmWRJjeT4jew@mail.gmail.com>
 <20110727141006.GA24785@elie>
 <CALkWK0k8Lra7LkGJXoXScnGUjrag-xgNptaB_JCiAsgemTq0eQ@mail.gmail.com>
 <20110727154830.GA29924@elie>
 <CALkWK0mUGiCRQoW6UM+mF5tsn4DxRuaiXn0TS2CcEsR0OeusKg@mail.gmail.com>
 <20110729191654.GA2368@elie.dc0b.debconf.org>
 <CALkWK0=qXBteRjj5vXDEWGVausQ3ssOvy4hyHHz84ORFzDaHaQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 30 15:11:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qn9Jv-0001dG-TM
	for gcvg-git-2@lo.gmane.org; Sat, 30 Jul 2011 15:11:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751941Ab1G3NLH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Jul 2011 09:11:07 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:59380 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751836Ab1G3NLE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jul 2011 09:11:04 -0400
Received: by fxh19 with SMTP id 19so3085917fxh.19
        for <git@vger.kernel.org>; Sat, 30 Jul 2011 06:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=xxCcfU1h1fEsQfAAhbgz6zOGb/qH94KsUjRlt5L9pZo=;
        b=YmNzAXXLTjALEPbSufiSPE0Zj1535PrCRj3YCl9Ov+BrqnrxYYSDkraxKMsaxXqrvD
         IKdZZYaQJ2KFFO+pIkZOQZuV9MxQ8TsBUn1IBrIsy8iVQQa52jtQ0slb5AZ+Au2mYZ8n
         yh/UYUARkK5pHqVVNJbgb0p5g8/3JYUhKQ6yk=
Received: by 10.223.54.90 with SMTP id p26mr3469060fag.44.1312031463232;
        Sat, 30 Jul 2011 06:11:03 -0700 (PDT)
Received: from elie (adsl-165-161-90.teol.net [109.165.161.90])
        by mx.google.com with ESMTPS id q1sm384475faa.1.2011.07.30.06.11.00
        (version=SSLv3 cipher=OTHER);
        Sat, 30 Jul 2011 06:11:01 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CALkWK0=qXBteRjj5vXDEWGVausQ3ssOvy4hyHHz84ORFzDaHaQ@mail.gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178191>

Ramkumar Ramachandra wrote:

> Okay, I don't follow.  Wouldn't this function need to parse the todo
> sheet and figure out how many instructions are left?  For that, the
> todo parsing functions can't be buried in builtin/revert.c, no?  Hence
> I said "expose" them -- or move them to sequencer.c.

Oh, that makes sense.  Sorry for the nonsense.  If I were in your
shoes, I'd move everything below pick_commits to sequencer.c.
