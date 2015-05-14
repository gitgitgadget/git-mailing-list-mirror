From: Robert Dailey <rcdailey.lists@gmail.com>
Subject: Re: Show all branches and ahead/behind states
Date: Thu, 14 May 2015 13:13:15 -0500
Message-ID: <CAHd499BoApGJSM_qEKG8cHNOV_pOCyPRqEAXHo8iqYVg1LpGdw@mail.gmail.com>
References: <CAHd499AyEDNM7mDstFugD0Ah46=gAS=BRocDmpmOK-1k+qMCmw@mail.gmail.com>
	<1431618938.31573.3.camel@kaarsemaker.net>
	<CAHd499CQTW0J6ms+XYUBbyfT6gGKuiFFCiP57i8-eTwng+UzNQ@mail.gmail.com>
	<1431624587.31573.5.camel@kaarsemaker.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>
To: Dennis Kaarsemaker <dennis@kaarsemaker.net>
X-From: git-owner@vger.kernel.org Thu May 14 20:13:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YsxdM-0004eW-2Z
	for gcvg-git-2@plane.gmane.org; Thu, 14 May 2015 20:13:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933175AbbENSNS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 May 2015 14:13:18 -0400
Received: from mail-ie0-f171.google.com ([209.85.223.171]:32861 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752786AbbENSNQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 May 2015 14:13:16 -0400
Received: by iebgx4 with SMTP id gx4so67492855ieb.0
        for <git@vger.kernel.org>; Thu, 14 May 2015 11:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=LrqbM8cXnpmlivl1bxDSLdJjqNwPka4rHxifEjXuavM=;
        b=LHrupLph0DbXRBL9or1Yoz8HgYz+MCNr4tkPNaqupiPXwAveRg8kSFVFbbT31bhUiV
         m1SUIeKNr+Lj19FQuV9ec8A1OyX0HGaXZTh4xoDEZaQJPwGXTOHxfmnZ9NeBJSxk3xAZ
         YR9JDZCT8rwikOke9dMkOujPkQQBOPK+Z64ZBKKGpnmLWVTYGaNUJ0sM6BEnTZ/AIdSB
         hB/OU6yU2aNCmLiCdAsndyrNjLKEghc5eGyFMSTNd+r/C5aRk1COiOHACRcPUarHoecR
         +/MGwdyqhdasGKygNb1XvLW5tBdVwoZs8/S+0d3gXuIkOfEyEIV1DPOHIYedd/P+ZMZC
         tjhA==
X-Received: by 10.107.150.14 with SMTP id y14mr4422472iod.55.1431627195658;
 Thu, 14 May 2015 11:13:15 -0700 (PDT)
X-Google-Sender-Delegation: rcdailey@gmail.com
Received: by 10.36.86.148 with HTTP; Thu, 14 May 2015 11:13:15 -0700 (PDT)
In-Reply-To: <1431624587.31573.5.camel@kaarsemaker.net>
X-Google-Sender-Auth: FBNygOX-5B18YkT0_KN9OU1mEeY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269061>

On Thu, May 14, 2015 at 12:29 PM, Dennis Kaarsemaker
<dennis@kaarsemaker.net> wrote:
> On do, 2015-05-14 at 12:18 -0500, Robert Dailey wrote:
>> On Thu, May 14, 2015 at 10:55 AM, Dennis Kaarsemaker
>> <dennis@kaarsemaker.net> wrote:
>> > On do, 2015-05-14 at 09:57 -0500, Robert Dailey wrote:
>> >> Is there a script or built-in functionality in git 2.4.1 that will
>> >> allow me to list all local branches with the ahead and behind status
>> >> of each? Basically the first line of:
>> >>
>> >> $ git status -sb
>> >>
>> >> But for every branch would be roughly what I'm looking for. Any ideas? Thanks.
>> >
>> > git branch -v (or -vv) is what you're after.
>> > --
>> > Dennis Kaarsemaker
>> > www.kaarsemaker.net
>> >
>>
>> Nice, I never noticed that -v showed ahead/behind status. Would be
>> nice if branch had a --format option to customize the coloring of the
>> "ahead" / "behind" text so that there was more contrast. It's a lot of
>> information to consume especially with a lot of local branches;
>> coloring would bring some sanity.
>
> Fortunately for you, git for-each-ref lets you do just this. For
> example, this gives you what branch -vv does, minus coloration and
> padding:
>
> git for-each-ref --format '%(HEAD) %(refname:short) %(upstream:short) %(upstream:track) %(subject)' refs/heads

Great idea. For some reason I can't apply coloring though:

for-each-ref --format '%(HEAD) %(refname:short) %C(bold
blue)%(upstream:track)%C(reset)' refs/heads

Output:

hotfix/4.2.3.1 %C(bold blue)[ahead 1, behind 1]%C(reset)
