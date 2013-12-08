From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Documentation: document pitfalls with 3-way merge
Date: Sun, 8 Dec 2013 14:40:13 -0800
Message-ID: <20131208224013.GC9108@google.com>
References: <1386535227-209788-1-git-send-email-sandals@crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Sun Dec 08 23:40:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vpn1k-00025b-Ex
	for gcvg-git-2@plane.gmane.org; Sun, 08 Dec 2013 23:40:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759991Ab3LHWkS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Dec 2013 17:40:18 -0500
Received: from mail-yh0-f49.google.com ([209.85.213.49]:56438 "EHLO
	mail-yh0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759941Ab3LHWkR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Dec 2013 17:40:17 -0500
Received: by mail-yh0-f49.google.com with SMTP id z20so2078912yhz.8
        for <git@vger.kernel.org>; Sun, 08 Dec 2013 14:40:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=4fZq6CT2gTZdPRNc3ojK3XB94igoEV11iYfhp3nMzT0=;
        b=rvW4jLZIXBMhLADbtCuHg7q4stZcf2N4sbhkA3P9JK21OyPKo4Xvof2q7TK3YDtutJ
         lx6KEENzN1oMTsME0gJhzLTOGId1wbQpYx22tzaTQBLgQyPpLLz3YaHS9R0iHkNmsfBu
         YQuaENshcMd3kSSRbM0pzVzhUMHhXTaMD2BnBwdIqx+Y+BKkgL0JrzDqIMvBYFaHTEWa
         GunRe74BMVHI3QR/ux8wkzJJyODYlmy/p5KH9bnGQYmQYDg5xiinaL6cCAFuX0ZQTsQn
         t8OeLlopkyTgrAIoyeVqWUDLLcU8pVjOkeTO5HlYIXqMo7vDUzWWWBCqmBEeBBL1L4TF
         rRKg==
X-Received: by 10.236.111.38 with SMTP id v26mr13323233yhg.40.1386542417036;
        Sun, 08 Dec 2013 14:40:17 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id d26sm12172830yhj.25.2013.12.08.14.40.15
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 08 Dec 2013 14:40:16 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1386535227-209788-1-git-send-email-sandals@crustytoothpaste.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239054>

Hi,

brian m. carlson wrote:

> Oftentimes people will make the same change in two branches, revert the change
> in one branch, and then be surprised when a merge reinstitutes that change when
> the branches are merged.

Life is even more complicated: if the merge-base chosen happens to be
a descendent of the change on both branches, the merge won't reinstate
the change.

The problem scenario hasn't happened to me recently.  Can you give an
example of how it happens?  Why is the same change being made
independently on two different branches?  I'm wondering because such a
story could make the example in the documentation a little clearer and
avoid having to make the explanation overly technical.

In any event, that the 3-way merge is really just a stupid 3-way merge
(modulo multiple merge base madness) does seem worth emphasizing, so
thanks for working on this.

Hope that helps,
Jonathan
