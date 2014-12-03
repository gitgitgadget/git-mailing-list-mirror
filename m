From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Disabling credential helper?
Date: Tue, 2 Dec 2014 17:29:50 -0800
Message-ID: <20141203012950.GC6527@google.com>
References: <20141203000310.GE90134@vauxhall.crustytoothpaste.net>
 <20141203005953.GB6527@google.com>
 <20141203012148.GB29427@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Dec 03 02:29:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XvylR-0004m7-UZ
	for gcvg-git-2@plane.gmane.org; Wed, 03 Dec 2014 02:29:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751215AbaLCB3y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Dec 2014 20:29:54 -0500
Received: from mail-ig0-f179.google.com ([209.85.213.179]:51918 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751141AbaLCB3x (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Dec 2014 20:29:53 -0500
Received: by mail-ig0-f179.google.com with SMTP id r2so11945272igi.6
        for <git@vger.kernel.org>; Tue, 02 Dec 2014 17:29:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=4HYmKzwCqUhRGzrO8LGbL+4M77d56UOQJ30e5sqwQy4=;
        b=wVMTrx8JKl8iZcrgHQPzYfSW2ZR7I3IICryRwcefxbuMzlLYWNdaL11tGRou8HXUoB
         Fna9fiOJeI73AhAMlhpEsLUs+JSKprGdZPlaxnGOkOo/TlHHg8599xJKCZ064cxT1yDx
         lVHJyTlf/zatu9Py+kZ7VJcQzK1jtsbcom4Mgjanepglr4HXa542vfJHt+nt+br2RsxS
         7zugJHa5ZNza4fycANpWi9QhMLmWBULP+5H95NOh5wY9rRQuv/KlrvJY911Z/Fi06VBS
         jc8SPDf7vdqL4jiDOobDki9x76S/rHhVFKX49AP1AAeKMBVXPbZTP7Wq5LbLmj7BOFVE
         mDFg==
X-Received: by 10.43.130.71 with SMTP id hl7mr4950528icc.57.1417570193096;
        Tue, 02 Dec 2014 17:29:53 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:fd7b:507b:3c7b:554e])
        by mx.google.com with ESMTPSA id i69sm5349696ioe.20.2014.12.02.17.29.52
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 02 Dec 2014 17:29:52 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20141203012148.GB29427@peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260612>

Jeff King wrote:
> On Tue, Dec 02, 2014 at 04:59:53PM -0800, Jonathan Nieder wrote:

>> As long as you have no credential helpers configured, your GIT_ASKPASS
>> based approach should work fine.
>
> Yeah, it's fine (as is GIT_ASKPASS=true). You could also provide a
> credential helper that gives you an empty username and password. But in
> both cases, I think that git will then feed the empty password to the
> server again, resulting in an extra useless round-trip. You probably
> instead want to say "stop now, git, there is nothing else to be done".
>
> We could teach the credential-helper code to do that (e.g., a helper
> returns "stop=true" and we respect that). But I think you can do it
> reasonably well today by making the input process fail.

How can my scripts defend against a credential helper that I didn't
set up that e.g. pops up a GUI window to ask for a password?

Thanks,
Jonathan
