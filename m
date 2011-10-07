From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] fmt-merge-msg: use branch.$name.description
Date: Fri, 7 Oct 2011 15:12:44 -0500
Message-ID: <20111007201244.GB29712@elie.hsd1.il.comcast.net>
References: <7vobxtwaog.fsf@alter.siamese.dyndns.org>
 <4E8EBDA7.2040007@drmicha.warpmail.net>
 <20111007091636.GA22822@elie.hsd1.il.comcast.net>
 <4E8ECA25.205@drmicha.warpmail.net>
 <20111007100646.GA23193@elie.hsd1.il.comcast.net>
 <4E8EED39.1060607@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Oct 07 22:13:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RCGmx-0007el-Rj
	for gcvg-git-2@lo.gmane.org; Fri, 07 Oct 2011 22:13:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754351Ab1JGUMz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Oct 2011 16:12:55 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:59469 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754218Ab1JGUMy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Oct 2011 16:12:54 -0400
Received: by ywb5 with SMTP id 5so3973556ywb.19
        for <git@vger.kernel.org>; Fri, 07 Oct 2011 13:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=BH1pokfzYvLiHzq3ehR2p5XrQubqYEfrlJKaok31+2U=;
        b=MW28n7wgX6XUWlhbVYxuDdrd5mmUfuQKVV6UQOkc63gn4G1KoXKOF7RTKeqWK0nmlc
         A29jUd/vzfbsSPfga8X/aBu6kF26TksQ8Zomc6tGgwv9+2xBpgR4xhP2fVwPJLZ/jqSy
         NVnwfqOexYR4s9wQuvJ08Cia+RyjQKMrrSc1o=
Received: by 10.236.185.37 with SMTP id t25mr12543060yhm.131.1318018373608;
        Fri, 07 Oct 2011 13:12:53 -0700 (PDT)
Received: from elie.hsd1.il.comcast.net (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id o48sm14518289yhl.4.2011.10.07.13.12.51
        (version=SSLv3 cipher=OTHER);
        Fri, 07 Oct 2011 13:12:52 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4E8EED39.1060607@drmicha.warpmail.net>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183104>

Hi again,

Michael J Gruber wrote:

> I really haven't seen any convincing argument against yet. The details
> (note attached to refname object, or literal refanmes in the notes tree
> as per Jeff) should be discussed further, of course, but if branch
> descriptions aren't "notesy" then I don't know what is.

As mentioned before, I don't want to debate how Junio should spend his
time (better for each person to provide relevant information and
improvements to help out or to spend time on the alternatives one is
interested in), but as a general question, this statement looked
interesting to me.

"git notes" has a funny name, but deep down, as you know, it's about
attaching additional versioned text to commit objects without changing
their names.  Branch descriptions are not per commit object (and as a
mapping, the _keys_ are not shared), and personally I don't think they
should be versioned any more than the branch names are.

I wanted to emphasize this because

	"git notes" is not the best tool for all annotations!

This ends this public service announcement.

> Alternatively, one could store the description in a blob and refer to
> that directly, of course. I.e., have
>
> refs/description/foo
>
> point to a blob whose content is the description of the ref
>
> ref/foo

Sure, that would be a sane alternative design.  It has the advantage
of having the pumbing for fetching and pulling already set up, as you
mention.  The only disadvantages I know of are

 - "git branch -m" and "git remote rename" don't know about it yet
 - there's not one flat file you can edit to run a search/replace on
   all branch descriptions

and those aren't very serious problems.

>> I personally would prefer my branch descriptions to be non-versioned,
>> though I realize that is a matter of taste.
>
> Do you prefer you commit notes to be non-versioned?

No, I like them versioned.  If I didn't, why wouldn't I have sent a
patch to change that?  Maybe some day there will be a "git notes log"
tool to track the history of a note, taking changes in fanout into
account.

Hope that clarifies a little.
