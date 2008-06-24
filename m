From: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <sbejar@gmail.com>
Subject: Re: git-fetch remote tag to local branch fails
Date: Tue, 24 Jun 2008 16:27:49 +0200
Message-ID: <8aa486160806240727r6fc6de6doec8300700293a3a7@mail.gmail.com>
References: <33f4f4d70806240517h5e3ae420h263dd0c2d6bae459@mail.gmail.com>
	 <8aa486160806240638o221b01d2i2f46cc8f0f3760a3@mail.gmail.com>
	 <33f4f4d70806240701o1c00cef2g688a188970964b0f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Klas Lindberg" <klas.lindberg@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 24 16:30:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KB9WU-0003KU-Oh
	for gcvg-git-2@gmane.org; Tue, 24 Jun 2008 16:29:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755633AbYFXO1x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2008 10:27:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755599AbYFXO1x
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 10:27:53 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:45863 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755578AbYFXO1w (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2008 10:27:52 -0400
Received: by ug-out-1314.google.com with SMTP id h2so725762ugf.16
        for <git@vger.kernel.org>; Tue, 24 Jun 2008 07:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=2yF6XaoQinoz3dp0P4/dyDddDgH6RGjhKutJxLdbHTg=;
        b=Ux23s2WzXqasdyJN/3ZATIBZq9EDA0zhAJ+QDUAHEzv5bm6qLo1Rn2P7hFdj4di5SA
         E1KP0Lw+KwNR8EHeSUcmwER/9dRahTnNLhbzNzTRs1EttJYtGXZzvV0VqMBw4E9N/JdM
         9G07GhbOKOJaq1mV74NACgDmvrvaZqmbGNHlA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=Npo8eFPhNbfp8sqvj2ghbYYMN0xx6VPhICvwCqj/aqto4AV622E4z+wmh+aIcHWpBs
         UXQx6uEkOd451qF7LBQ7OXv0Av0/Sz+DUD1xk9nWKmCfK6GJFgO/ttqO8+pW27UAhNIs
         lO9ciqSsPzwQTaRe1g8C5erji1aHqttztq7v8=
Received: by 10.67.97.15 with SMTP id z15mr3374828ugl.27.1214317669844;
        Tue, 24 Jun 2008 07:27:49 -0700 (PDT)
Received: by 10.150.152.19 with HTTP; Tue, 24 Jun 2008 07:27:49 -0700 (PDT)
In-Reply-To: <33f4f4d70806240701o1c00cef2g688a188970964b0f@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86064>

On Tue, Jun 24, 2008 at 16:01, Klas Lindberg <klas.lindberg@gmail.com> wrote:
> Hello
>
>> git tag -l
> foo_tag
> test_tag
>>
>
>> git branch -a
>>

empty?

>
> At this point, I can create the branch "b" from "foo_tag", so the
> fetch did get me a remote tag. It just didn't update a local branch
> with the contents (or create a new one).
>
> Something that also confuses me is that if branch "b" already exists, then
>
>> git-pull bogustree refs/tags/foo_tag:refs/heads/b
>
> actually does update branch "b". I find the behaviour quite inconsistent.

You asked explicitly to update branch b with :refs/heads/b.

>
> Unfortunately it isn't a solution for me to fetch tags and then create
> branches from the tags. I need to be able to update existing branches,
> and I have to do that without first making such a branch the current
> branch.
>

If you have to update existing branches from remote branches you can:

git fetch <remote> refs/heads/<remotebranch>:refs/heads/<localbranch>

But normally you have some remote tracking branches, such as how the
"origin" remote repository is configured.

Updating from remote tags is not normal, since tags are not supposed to change.

Can you explain why you have to do it this way? Or the whole workflow?

Santi

P.D.: Please, do not toppost.
