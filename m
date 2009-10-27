From: Eugene Sajine <euguess@gmail.com>
Subject: Re: gti push interface inconsistency
Date: Tue, 27 Oct 2009 00:47:59 -0400
Message-ID: <76c5b8580910262147w4e3ef7a9k8b65f586e893f4fd@mail.gmail.com>
References: <76c5b8580910261523s51ac22b5y624ec3502e8fed67@mail.gmail.com>
	 <7veiopd7gs.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 27 05:48:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N2dyY-0006tR-7P
	for gcvg-git-2@lo.gmane.org; Tue, 27 Oct 2009 05:48:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754078AbZJ0Erz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Oct 2009 00:47:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754027AbZJ0Erz
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Oct 2009 00:47:55 -0400
Received: from mail-yw0-f202.google.com ([209.85.211.202]:48493 "EHLO
	mail-yw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753718AbZJ0Erz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Oct 2009 00:47:55 -0400
Received: by ywh40 with SMTP id 40so8951733ywh.33
        for <git@vger.kernel.org>; Mon, 26 Oct 2009 21:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=xCKSLc6vnFJT93DRLgGiHf9kuiyIexzadrW68AzcwqM=;
        b=tchWoiBzBkYMzLq422dddvJb4adZ0TgC+ZO+WRK++TtP1hE+OaJeJEAYiaU3z4B5aq
         mGjL6ztnhLh8feOSaRyspnFggLp56HmygK8F1Gxd3grGXOHCtVdb28OR8tvyqtvbbBXr
         2QM6hbHW99St3+F6GfAFwaTDqp0MTwUx+LGAU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=iZWBSImxxs5s6Qq+smVMHFYfsjvzfyf9ozStdwQ/9+gadQHDrudfDiOyIfGHAYX7aJ
         5epa/OTDTjYS/jSVTX6HQtzCLeAoODqs1TMpCWmF1h+99ElsZrD1iMIbMYgW4oEs2ZN3
         d//Thcnj0ufpEJFV0G+PXGQ7JD+NqrjUvBTr4=
Received: by 10.91.161.28 with SMTP id n28mr6179314ago.36.1256618879748; Mon, 
	26 Oct 2009 21:47:59 -0700 (PDT)
In-Reply-To: <7veiopd7gs.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131310>

>
> Probably because git is not smart enough to understand the human language
> to notice 't' 'a' 'g' is a tag and cannot be a remote name spelled
> incorrectly, or git cannot read your mind and find out that you spelled
> a name of the remote correctly but forgot to add the remote first.
>

;)
did you mean It is not smart enough yet?

My question was caused only by the fact that in both situations same
object type is transmitted to the origin repo. As understand that it
was done this way  in order to avoid specifying keys for remote...
I.e. "git push origin master" is kinda easier then something like "git
push -r origin master" (-r for remote).
But if for "git push --tags" the remote is not important (uses origin
by default) why it is important for "git push my_tag" or for "git push
origin master"?

Do you think

$ git push master

Which would default to origin have a chance to exist? (I would vote for this)
Or the correct aproach is to have

$ git push origin --tags

IMHO, In any case the push operation interface should be consistent.
Else it is a bit confusing (untill you didn't step on it and didn't
learn the difference).

Best regards,
Eugene
