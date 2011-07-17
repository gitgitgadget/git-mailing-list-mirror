From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 10/17] sequencer: Announce sequencer state location
Date: Sun, 17 Jul 2011 14:19:31 -0500
Message-ID: <20110717191931.GH27787@elie>
References: <1310396048-24925-1-git-send-email-artagnon@gmail.com>
 <1310396048-24925-11-git-send-email-artagnon@gmail.com>
 <20110712185638.GA14909@elie>
 <CAGdFq_ijTh-m7+zRFAyqvhN5k_BrC1TPdc3y47h=tBUiz6QF2A@mail.gmail.com>
 <CALkWK0k1pX6rjGh8U6ZdDFk3qFcbj-UjU-Q-Z76hn6HV46pncg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 17 21:19:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QiWsR-0000Ab-HF
	for gcvg-git-2@lo.gmane.org; Sun, 17 Jul 2011 21:19:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756193Ab1GQTTj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Jul 2011 15:19:39 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:53001 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756172Ab1GQTTi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jul 2011 15:19:38 -0400
Received: by iwn6 with SMTP id 6so2536097iwn.19
        for <git@vger.kernel.org>; Sun, 17 Jul 2011 12:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=hH5HpAAcFYUjfH3fioZanslt8mUHdwbgz4KsIJdj1zQ=;
        b=fYQFU2e2ae+1UUVjY/hhuh3RpoLGn0KD19INFZ4rXbXJlVn0PNXJngnHc1B2rPVbgQ
         PFtS7ig4HSDCqJ8Qe7WTL3FtU6TeygP5JCfcb+8NSKLl2hhdlfqGJZcTkPYntiX1K6gl
         Ej37wea4Fk5QeM9Ug4LpsgpUDthmVigqiSLM0=
Received: by 10.231.83.20 with SMTP id d20mr5075587ibl.152.1310930377716;
        Sun, 17 Jul 2011 12:19:37 -0700 (PDT)
Received: from elie (adsl-69-209-70-6.dsl.chcgil.sbcglobal.net [69.209.70.6])
        by mx.google.com with ESMTPS id fw9sm2381141ibb.47.2011.07.17.12.19.35
        (version=SSLv3 cipher=OTHER);
        Sun, 17 Jul 2011 12:19:36 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CALkWK0k1pX6rjGh8U6ZdDFk3qFcbj-UjU-Q-Z76hn6HV46pncg@mail.gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177313>

Ramkumar Ramachandra wrote:

> I don't think we should advertise it on stdout or stderr.  I think of
> a safeguard that only very few people will use.  Ofcourse, documenting
> it somewhere like Documentation/technical will make sense once we have
> something usable.

Yuck.  Documentation/technical is for API, protocol, and design
documentation.  One should not need to read Documentation/technical in
order to be able to use git!

If the worry is that such a hint would be too noisy, it can be
protected by a configuration variable using the usual advice
mechanism.

>> If I were doing it, I'd squash this with the patch that introduces
>> "git cherry-pick --quit", to give an example of how the new function is
>> meant to be used (and tests!).
>
> I would have done that too, except that the "reset: Make hard reset
> remove the sequencer state" patch depends on this.  So, I don't think
> it's fair to squash it into either patch.
> I can definitely write a better commit message though (wait for the
> next iteration to see it).

Would it be possible to introduce "cherry-pick --quit" here, and make
the later patch only do one thing, namely adding the check to prevent
a cherry-pick in the middle of a pending cherry-pick?

In other words, I don't understand why the "reset --hard" workaround
would need to come before "cherry-pick --quit".

Thanks for explaining.
Jonathan
