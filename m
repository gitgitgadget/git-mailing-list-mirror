From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] string_list: Add STRING_LIST_INIT macro and make use
 of it.
Date: Wed, 7 Jul 2010 10:19:56 -0500
Message-ID: <20100707151956.GA1529@burratino>
References: <20100702202257.GA7539@burratino>
 <546093148a7ccecace6552c75a70a1cd66b3f420.1278272508.git.tfransosi@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, srabbelier@gmail.com, gitster@pobox.com,
	raa.lkml@gmail.com, peter.kjellerstedt@axis.com
To: Thiago Farina <tfransosi@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 07 17:20:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWWQa-00053g-G2
	for gcvg-git-2@lo.gmane.org; Wed, 07 Jul 2010 17:20:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756467Ab0GGPUl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jul 2010 11:20:41 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:39085 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752438Ab0GGPUk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jul 2010 11:20:40 -0400
Received: by iwn7 with SMTP id 7so7951008iwn.19
        for <git@vger.kernel.org>; Wed, 07 Jul 2010 08:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=MGEfvf663ngP3NbFWFgqpMQ5ka9/zlBws4oi8pBcTt4=;
        b=LjzPHutF87rGgv49o4CO6kIKPTzLGKzlqA0eNQyTc5EG0AYtok95Py1KG8grxhuP8n
         bauFS4Rv7lWXDCEWQiDdQm+zEjl8D7a9oRayDs/BrdJD9EK/ro6IdCEVJRg3wG+H3oe9
         hdxzuCrptLzxvslyA/x70yw21FK7Kv91km488=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=Wto+4AiwQ/7up3nhn/im1zpekhlnUlR4kiBlUysm5mtRw/z9WKd5UR32IKzuf1Nhq5
         SYhJicc5nYO46pgBgV1HUUjYWDDM/uoQAmhQzczjbDHV6py2y526SGXsHi6BzhPC8tnd
         qNqnSxAw/WUu0tTqvj0lFojVr26KNAHTPkgHM=
Received: by 10.231.59.13 with SMTP id j13mr6608886ibh.77.1278516037655;
        Wed, 07 Jul 2010 08:20:37 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id r3sm29204843ibk.13.2010.07.07.08.20.36
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 07 Jul 2010 08:20:36 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <546093148a7ccecace6552c75a70a1cd66b3f420.1278272508.git.tfransosi@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150477>

Hi Thiago,

Thiago Farina wrote:

> I see that no one commentted in the patch, but I can't see it on
> http://git.kernel.org/?p=git/git.git;a=summary, so I'm not sure if it
> was accepted.
> 
> What is the easiest way to verify if the patch was committed?

Good question.  When no one comments on a patch, that is usually
a bad sign.  In this case, I think the patch is good and I was too
lazy to comment on it (sorry).

| $ git log --oneline --author=Thiago origin/pu
| 183113a string_list: Add STRING_LIST_INIT macro and make use of it.
| [...]
| $ git branch tf/string-list-init 183113a
| $ git branch -r --contains tf/string-list-init
| origin/pu
| $

So it has been queued in "pu" but not graduated to "next" yet.

Side note.  From the description of the "pu" branch in
origin/todo:MaintNotes

	The "pu" branch, and topic branches that are only in
	"pu", are subject to rebasing in general.  By the above
	definition of how "next" works, you can tell that this
	branch will contain quite experimental and obviously
	broken stuff.

it might sound like Junio thinks your patch is obviously broken!
I suspect that description of "pu" is intended for testers
(meaning: try this branch only if you found "next" too boring and
like writing bug reports) rather than patch authors[1].

Especially during a release candidate period (which this is),
promising new features are often queued to "pu" and only merged to
"next" when Junio has had time to look them over again.

HTH,
Jonathan

[1] Maybe it could be clarified: how about inserting "sometimes"
before "contain"?

	                           ... you can tell that this
	branch will sometimes contain quite experimental and
	obviously broken stuff.
