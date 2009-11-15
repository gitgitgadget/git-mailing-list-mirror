From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: pushing remote branches
Date: Sun, 15 Nov 2009 16:34:13 +0530
Message-ID: <2e24e5b90911150304i1472ed13k6c60611ef2e9ba19@mail.gmail.com>
References: <hdneuv$nc8$2@ger.gmane.org>
	 <2e24e5b90911141645n59680856ja21f2f3c7063f7c0@mail.gmail.com>
	 <hdoko1$s78$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Lorenzo Bettini <bettini@dsi.unifi.it>
X-From: git-owner@vger.kernel.org Sun Nov 15 12:04:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N9cu5-0007xD-4q
	for gcvg-git-2@lo.gmane.org; Sun, 15 Nov 2009 12:04:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751876AbZKOLEI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Nov 2009 06:04:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751825AbZKOLEI
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Nov 2009 06:04:08 -0500
Received: from mail-iw0-f178.google.com ([209.85.223.178]:65082 "EHLO
	mail-iw0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751784AbZKOLEH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Nov 2009 06:04:07 -0500
Received: by iwn8 with SMTP id 8so3624122iwn.33
        for <git@vger.kernel.org>; Sun, 15 Nov 2009 03:04:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=nGAXGUE9vbqsuNWEnD2D6gSPt4JJ3+QSa0wvXKEX/sc=;
        b=YAKrzo8PgaPE635yi9gEzkcwW5vqS1NKACu8k8nGuTgJqHvyZk+ZpgXN8uP2Ei3WlT
         AvoZyhJK2uefMyKp5X2zVck36k1vQXWOXRLGVRNgKoolM4fN5/2BUxFL8mTuC8m8dd3x
         NaTZ7dGwWRAQxlOPBj8O7oFqmkZKByoMz1bJ4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=UNtprhTI2WQq36hWu4kgG/Z4tgBow0yB2WCVf61xsKjNT+3JIrhNd1K3FeTY1WjuzJ
         iBahDB2J/OehSylGvBIpm7tEHjZTECHp4HljhCIGQLtn9FqWUp3jf4y31wVs7JpXQzfc
         lhtteY39PsMEWmZBc3yTD2NsBLiY5Zlyi0R0I=
Received: by 10.231.24.208 with SMTP id w16mr5073162ibb.38.1258283053057; Sun, 
	15 Nov 2009 03:04:13 -0800 (PST)
In-Reply-To: <hdoko1$s78$1@ger.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132931>

On Sun, Nov 15, 2009 at 3:51 PM, Lorenzo Bettini <bettini@dsi.unifi.it> wrote:
> Sitaram Chamarty wrote:
>>
>> Hi Lorenzo,
>>
>> On Sun, Nov 15, 2009 at 5:07 AM, Lorenzo Bettini <bettini@dsi.unifi.it>
>> wrote:
>>
>>>                url = git://...
>>
>>> isn't this enough to be able to push the experiments branch?
>>
>> not normally.
>>
>> The "git://" protocol is a read-only protocol by default.   Since it is
>> completely unauthenticated, enabling push via git:// is not a good idea in
>> general.
>
> so probably I managed to push origin master anyway because gitorious asked
> me for my ssh passphrase?

As far as I know you could not have pushed anything when the url is
git:// (at least by default.  Push over git:// can be enabled but is
highly inadvisable and I have not seen anyone enable it nor any good
reason to)

> Thus, if I had
>
> [remote "origin"]
>            fetch = +refs/heads/*:refs/remotes/origin/*
>            url = git@...
> [branch "master"]
>            remote = origin
>            merge = refs/heads/master
> [branch "experiments"]
>            remote = origin
>            merge = refs/heads/experiments
>
> instead of
>
> [remote "origin"]
>            fetch = +refs/heads/*:refs/remotes/origin/*
>            url = git://...
> [branch "master"]
>            remote = origin
>            merge = refs/heads/master
> [branch "experiments"]
>            remote = origin
>            merge = refs/heads/experiments
>
> I would have been able to push also to branch experiments?   Without having
> to add
>
> [remote "experiments"]
>            url = git@...
>            fetch = +refs/heads/experiments:refs/remotes/experiments/experiments
>
> ?

(by the way: do you mean refs/remotes/origin/experiments in that last
line above?)

Anyway to answer your question, I do not see the refspec line as the issue
here, but the URL for the repo, which determines how you access it.

regards,

sitaram
