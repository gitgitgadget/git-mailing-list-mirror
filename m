From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [DONOTAPPLY PATCH 2/3] setup: warn about implicit worktree with
 $GIT_DIR
Date: Tue, 26 Mar 2013 13:35:23 -0700
Message-ID: <20130326203523.GM1414@google.com>
References: <20130326200851.GA22080@sigill.intra.peff.net>
 <20130326201208.GB22522@sigill.intra.peff.net>
 <20130326202142.GL1414@google.com>
 <20130326202722.GA22769@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Richard Weinberger <richard@nod.at>,
	Philip Oakley <philipoakley@iee.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 26 21:36:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKab6-0000PY-R1
	for gcvg-git-2@plane.gmane.org; Tue, 26 Mar 2013 21:35:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753444Ab3CZUf2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Mar 2013 16:35:28 -0400
Received: from mail-pb0-f44.google.com ([209.85.160.44]:37794 "EHLO
	mail-pb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752600Ab3CZUf2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Mar 2013 16:35:28 -0400
Received: by mail-pb0-f44.google.com with SMTP id wz17so1464707pbc.3
        for <git@vger.kernel.org>; Tue, 26 Mar 2013 13:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=Ty++NhhshU+YLQK7Do5PPnCto6E5xhrmSMRMRyfI9QY=;
        b=s8bS8z/B/V8sL9u5nfaWi7CqsLEbYw+jQgIcZYmvRa2qe7nRZrEhuxgRNcs0zEPsDm
         R1X/7WOwQxjy2nKgBHSvtxSfCG6u0btfcABe9+n2+eYVAmlqbYlcExExZA24V31BUF2Q
         aC/BUpI8ED7yPfv2G98adnbtga3Ll0wg/D4hRnSO4IgViDWdTHRq6xItSngCX5Rgfk+i
         gjd7Qb19C64AJXmB4Tqd/ayQA6ni1zbF0LAd51efotQQ3wQ7sOtW2WGtfMde2SOofN16
         o6YpmpVHK50LGyfHqfZtW3oHkXT0GfHst++tlBZmr0piUwhdJRTHYKBq2UT5xZI7Harv
         bHmA==
X-Received: by 10.68.106.4 with SMTP id gq4mr25644030pbb.50.1364330127782;
        Tue, 26 Mar 2013 13:35:27 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPS id in5sm18653110pbc.20.2013.03.26.13.35.25
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 26 Mar 2013 13:35:26 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20130326202722.GA22769@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219202>

Jeff King wrote:
> On Tue, Mar 26, 2013 at 01:21:42PM -0700, Jonathan Nieder wrote:

>> If we want this warning, would something like the following do?
>> 
>> 	warning: You have set GIT_DIR without setting GIT_WORK_TREE
>> 	hint: In this case, GIT_WORK_TREE defaults to '.'
>> 	hint: To suppress this message, set GIT_WORK_TREE='.'
>
> That can help by teaching people how GIT_DIR behaves in general.

Yes, I think it would have helped in this case.  If I understand
correctly then for a while Richard was habitually setting GIT_DIR to
mean "act on this repository" and thought the worktree was
automatically being set to the containing directory.

I think patch 3 is a bad direction to go because there will always be
old scripts that follow what used to be the recommended way to use
GIT_DIR.  In the long term a warning like this that doesn't break them
(or a fatal error that at least doesn't confuse them) might be a good
way to go.

Thanks for your thoughtful work, as always.

Jonathan
