From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Migrate from svn to git
Date: Wed, 26 May 2010 16:23:35 +0000
Message-ID: <AANLkTikD6Op5TO0EtQWLQ0N6zD0Kr-pltW76rY1Dvx5D@mail.gmail.com>
References: <4BFD3AAF.4080403@fechner.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Matthias Fechner <idefix@fechner.net>
X-From: git-owner@vger.kernel.org Wed May 26 18:23:52 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OHJOV-0007UE-Lq
	for gcvg-git-2@lo.gmane.org; Wed, 26 May 2010 18:23:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755391Ab0EZQXn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 May 2010 12:23:43 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:52626 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755054Ab0EZQXm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 May 2010 12:23:42 -0400
Received: by gyg13 with SMTP id 13so3044422gyg.19
        for <git@vger.kernel.org>; Wed, 26 May 2010 09:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=p5nn/DK1KPB3V5rSAtWCNNRzdHbeEaPwnlwSTSd9kqw=;
        b=MhPmAPk2/m545ulBzw8+2b61wF3HjHKt5vLMzn822wDyupON2MgWj4hrsgTEs0QoM/
         YA2v2UdVKTE8agdqBh/1X6pSUamb6nZqH/PkKYo+ejWyAEHRC6IF/becMLKjEo7gNNe8
         i7WP2cHdwKF22WqkdRLs3PhouoTjy44ksr1r8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=DyWXd4xJ95bEh26ggmXFICbLnfasf4BevR1zbueOMB9/KUaaaU0lgNbvnPqONPY5oL
         FLnhEKwZQVW4TH/gGy/7nsNvv0JQ5JjggJ5ukDyBIzMwtESdv+Ta4AGAH3u1TRAyalOK
         cmvMKZYLdo5pT/Zdd5cFRRSCT3fi3hCZzfMT0=
Received: by 10.231.178.132 with SMTP id bm4mr7503890ibb.62.1274891015589; 
	Wed, 26 May 2010 09:23:35 -0700 (PDT)
Received: by 10.231.171.145 with HTTP; Wed, 26 May 2010 09:23:35 -0700 (PDT)
In-Reply-To: <4BFD3AAF.4080403@fechner.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147810>

On Wed, May 26, 2010 at 15:13, Matthias Fechner <idefix@fechner.net> wrote:
> I hope that is the correct list to ask some questions.
> I understood that the idea behind git is completely different and I like the
> idea behind git.
>
> But for the svn repository I want to convert I need some features and I'm
> not sure how / if to implement them in git.
>
> Corrently the svn repo is divided into trunk branches and tags.
> In each of this directory like trunk i have directories like hardware,
> software, docu and more.
>
> For each of this subdirectories I have usergroups defined which has no
> access, read access or rw access.
>
> If I understood the manual correctly I can stick on that structure and
> easily work here with the unix-permission to grant access to the folders?
> I think I have to test then acl with freebsd to have more then one group for
> each directory.

No. Git isn't centralized. Anyone can clone the repo and change
anything the want. You implement control by setting a policy on what
you merge back into your tree, which is considered canonical.

There are several on-commit filtering programs available that can do
that automatically based on paths within the repository.

> The second question is, I someone commits some files with svn an email is
> sent to a svn-commit mailinglist so changes can easily be discussed.
> The current mail is sent in html format with a colored diff, so it is easier
> to read.
>
> Is something similar possible with git or do you suggest a complete
> approach?

There are a lot of these scripts available in contrib and elsewhere.
