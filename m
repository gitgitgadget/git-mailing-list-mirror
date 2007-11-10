From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: gitweb, updating 'last changed' column on the project page
Date: Sat, 10 Nov 2007 14:27:15 +0100
Message-ID: <200711101427.18215.jnareb@gmail.com>
References: <9e4733910711091709k173bf23flf2824673f82de9bb@mail.gmail.com> <200711101034.47861.jnareb@gmail.com> <9e4733910711100505n78459612xdaa12eaa880773d8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Jon Smirl" <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 10 14:27:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqqNE-0006pc-Ps
	for gcvg-git-2@gmane.org; Sat, 10 Nov 2007 14:27:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750942AbXKJN1X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Nov 2007 08:27:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750842AbXKJN1X
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Nov 2007 08:27:23 -0500
Received: from nf-out-0910.google.com ([64.233.182.189]:55995 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750791AbXKJN1W (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Nov 2007 08:27:22 -0500
Received: by nf-out-0910.google.com with SMTP id g13so725047nfb
        for <git@vger.kernel.org>; Sat, 10 Nov 2007 05:27:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=+LcbN74caiH3YJKOzOqJ7YJfKgNyE+2qOr0FmLy8Q0Y=;
        b=opF1hqUzdKIegcHyOJjCabP+UMn9UVAfEVU2cpHZYtSES0250F90nu27x/D3xNK79gvXkzhJBI4LjgzjrTfLTBLtHr5n9rhImOI1x64d7ay1DdQgj7XPSZrff8o6Kmg7CW+3ri3Vi8iuKyG/OKyp3gg2lx2cDMSLmfOFROIHW7U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=kLOlkC/dUZpsF82ZoZGtsLAW8wxK2TYm271l5TW+vX8LvJ8YlLgMivNE3NC6DMvPhsWxVaDYe+W97lBjo/k18vXZRK8+q9Mr2dEfA3+SeuUtkbfeD2IZvBKc5WBuhzN6m+klJlK+45xad3qgd+I6BuzLgWe2QHx+QbtEvjPQFMA=
Received: by 10.86.60.7 with SMTP id i7mr2436290fga.1194701241218;
        Sat, 10 Nov 2007 05:27:21 -0800 (PST)
Received: from ?192.168.1.11? ( [83.8.206.124])
        by mx.google.com with ESMTPS id e20sm2526764fga.2007.11.10.05.27.19
        (version=SSLv3 cipher=OTHER);
        Sat, 10 Nov 2007 05:27:20 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <9e4733910711100505n78459612xdaa12eaa880773d8@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64346>

Jon Smirl wrote:
> On 11/10/07, Jakub Narebski <jnareb@gmail.com> wrote:
>> On Saturday, 10 November 2007, Jon Smirl wrote:
>>> On 11/10/07, Jon Smirl <jonsmirl@gmail.com> wrote:
>>>
>>>> [daedalus]$ git for-each-ref --format="%(refname):%09%(committer)" \
>>>> --sort=-committerdate refs/heads
>>>> refs/heads/m24: Jon Smirl <jonsmirl@gmail.com> 1191362799 -0400
>>>> refs/heads/m25: Jon Smirl <jonsmirl@gmail.com> 1191472422 -0400
>>>> refs/heads/m26: Jon Smirl <jonsmirl@gmail.com> 1194382038 -0500
>>>> refs/heads/m28: Jon Smirl <jonsmirl@gmail.com> 1194385071 -0500
>>>> refs/heads/m29: Jon Smirl <jonsmirl@gmail.com> 1194585780 -0500
>>>
>>> It appears to be using the first head instead of the most recent date.
>>
>> It appears to not _sort_ the output by committerdate, as it should with
>> '--sort=-committerdate'.
> 
> It is sorted by committerdate, the sort is ascending. Did you expect
> it to be descending, pick off the last entry instead of the first?

Excerpts from git-for-each-ref(1):

  git-for-each-ref [--count=<count>]* (...) [--sort=<key>]* (...)

  <count>
          By  default  the  command  shows all refs that match <pattern>. This
          option makes it stop after showing that many refs.

   <key>  A field name to sort on. Prefix - to sort in descending order of the
          value.  When  unspecified,  refname is used. More than one sort keys
          can be given.

So I expect --sort=-committerdate to sort by date of committing, 
descending, and --count=1 pick first one, which means most recent.

It looks like "your" gitweb sorts ascending instead... strange...


How does git_get_last_activity subroutine in your gitweb.cgi looks like?
Does it have '--sort=-commiterdate'? If it has, then I think it is some
strange bug in git, if it doesn't it is strange modification of gitweb.

HTH
-- 
Jakub Narebski
Poland
