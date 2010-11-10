From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2] Documentation/git-pull: clarify configuration
Date: Wed, 10 Nov 2010 11:24:31 -0600
Message-ID: <20101110172431.GB11513@burratino>
References: <1289373188-32543-1-git-send-email-martin.von.zweigbergk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 10 18:25:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PGEPt-0006pr-0B
	for gcvg-git-2@lo.gmane.org; Wed, 10 Nov 2010 18:25:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757239Ab0KJRYz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Nov 2010 12:24:55 -0500
Received: from mail-pz0-f46.google.com ([209.85.210.46]:43473 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757117Ab0KJRYy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Nov 2010 12:24:54 -0500
Received: by pzk28 with SMTP id 28so185072pzk.19
        for <git@vger.kernel.org>; Wed, 10 Nov 2010 09:24:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=s2usCegFCvruucdfcC1QdjWQAXL43c6pq1FXIQ6NHj4=;
        b=ljVwvaR1ntUAbIH4AXi3orMOEvPAmFjGGGh52RdrWXa8zRO9xPupWntka/FvTdMhPm
         d6+XIqOhSMisIJdOsuwGUtzbTwHlDzJEOuksfwLKJfVHpjkSbYh3asEqMfya85LaqcZr
         3utSwhHLTRIywjzDUAmspVmvjO9tMrae5YMeQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=dgbsnKGfB49egIvnxGdA+6hhAP+6GZUV5gSuzw9DZBk4V6VGzkeluBj+Ximg269aUG
         QlyuFLT8fUKKPzAYT3XCU+7AAo6AmhpqPySp+nC1PNmZG/ba/IPv33duMPO7LiQ8BY+u
         tYvF1Uj+NTMkWHdMmqtj43oqKC7O2QieYa4Vw=
Received: by 10.142.164.11 with SMTP id m11mr6760222wfe.109.1289409894408;
        Wed, 10 Nov 2010 09:24:54 -0800 (PST)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id w5sm252987vcr.6.2010.11.10.09.24.51
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 10 Nov 2010 09:24:52 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1289373188-32543-1-git-send-email-martin.von.zweigbergk@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161161>

Hi again,

Martin von Zweigbergk wrote:

> The sentence about 'branch.<name>.rebase' refers to the first sentence
> in the paragraph. Clarify by putting it in a separate paragraph.

I think the patch clarifies by rewording a little, too. :)

> --- a/Documentation/git-pull.txt
> +++ b/Documentation/git-pull.txt
> @@ -92,12 +92,15 @@ include::merge-options.txt[]
>  :git-pull: 1
>  
>  --rebase::
> -	Instead of a merge, perform a rebase after fetching.  If
> -	there is a remote ref for the upstream branch, and this branch
> -	was rebased since last fetched, the rebase uses that information
> -	to avoid rebasing non-local changes. To make this the default
> -	for branch `<name>`, set configuration `branch.<name>.rebase`
> -	to `true`.
> +	Instead of merging, rebase the current branch on top of the
> +	upstream branch after fetching.  If there is a remote-tracking
> +	branch corresponding to the upstream branch and the upstream
> +	branch was rebased since last fetched, the rebase uses that
> +	information to avoid rebasing non-local changes.
> +
> +	The default behavior is to merge rather than rebasing, but it
> +	can be overridden per branch with the `branch.<name>.rebase`
> +	configuration item (see git-config(1)).
>  +

Do these changes result in good output with "make -C Documentation
git-pull.1" or "make -C Documentation git-pull.html"?  I think it
might need to be

	first paragraph
 +
 second paragraph
 +
 third paragraph

or similar.

Regards,
Jonathan
