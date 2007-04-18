From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: Things that surprise naive users
Date: Thu, 19 Apr 2007 11:57:46 +1200
Message-ID: <46a038f90704181657i540e8468xf2809e81e5cf7ac5@mail.gmail.com>
References: <Pine.LNX.4.64.0704181503080.27922@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Daniel Barkalow" <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Thu Apr 19 01:57:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HeK24-000713-GF
	for gcvg-git@gmane.org; Thu, 19 Apr 2007 01:57:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030332AbXDRX5t (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Apr 2007 19:57:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030357AbXDRX5t
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Apr 2007 19:57:49 -0400
Received: from wr-out-0506.google.com ([64.233.184.229]:48963 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030332AbXDRX5s (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Apr 2007 19:57:48 -0400
Received: by wr-out-0506.google.com with SMTP id 76so329943wra
        for <git@vger.kernel.org>; Wed, 18 Apr 2007 16:57:47 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=deKjfkKDQnNsMHW0vWHZzl/g+8JM789w3rkPWMmk0Fucrr6ApZmnGAiL9xVrDbsszZ5BvcWMBLZDyeK9zdy9ammbjBcdBrjnxf4w3/BL1SDHTMD/OKsfORmRqVRD5umixv9MECANvtFJ7zHV0CswXnMP/+k93niRsDTALKjBn5I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=PUSCwmt5Ib6jn81R7EQ1KAHKPHDONgwJP4liEjIse33LSqx1u8gKfcmYefdH00oK/lLot2X9akNdDFxxeljHgAvJgZN/H9v26DMnhqfiM2zivjtsRNrT77vv8U8eVOURc3mGMShlsxfcJO1EaDo6cEY9xXHIWoLtb/QiyBHRooY=
Received: by 10.90.79.6 with SMTP id c6mr1273214agb.1176940666952;
        Wed, 18 Apr 2007 16:57:46 -0700 (PDT)
Received: by 10.90.52.17 with HTTP; Wed, 18 Apr 2007 16:57:46 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0704181503080.27922@iabervon.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44966>

On 4/19/07, Daniel Barkalow <barkalow@iabervon.org> wrote:
> 2. There's no easy way to tell that you've made commits that you haven't
>    pushed upstream. In fact, it's impossible to tell when disconnected
>    whether you've pushed everything. This needs some command to report it,
>    and also for push to update the fetch sides of remote heads it updates.

Cogito does this (push updating the refs), and I like it. I think it's
worth doing. Then git-branch -v could flag pending-to-push local
branches.

> 3. You can't create a new repository by pushing, even if you could
>    actually create the repository. Obviously, this will be blocked by
>    policy more often than pushing in general would be, but it's not
>    always blocked. It's also harder than it should be to turn a repository
>    created locally into a repository identical in configuration to a clone
>    of a newly-created remote repository.

It's not too hard to do a

      git-publish git+ssh://host/path/to/repo.git

that just does a git init or maybe rsyncs out.

> 4. Creating new branches off of existing branches/remotes doesn't
>    configure the new branches in the obvious way (i.e., such that the
>    default update action matches the create action).

Junio was pointing out recently that there's an option for that -
pull.automerge I think - that you can set in your /etc/gitconfig. Or
you can say --track

cheers,



martin
