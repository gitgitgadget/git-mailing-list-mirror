From: Phil Hord <phil.hord@gmail.com>
Subject: Re: Is this a bug?
Date: Fri, 22 Feb 2013 14:29:47 -0500
Message-ID: <CABURp0rO5zJywFN16=Sn20b2DAVA7XBs4EC4GxGbxftXqUS6gA@mail.gmail.com>
References: <937BB05095F39E46B969256AA776205322B2CF15C7@ST-EXCL29.statoil.net>
 <CABPQNSY4ordHh2ee8mk-2kCD40+sMf_SxrjfzGbkyGGTNW1TzA@mail.gmail.com> <CACsJy8DjatRbL=J-MZmQFnd+_7i-WwYHSnkY_ga++fx1R5Whmw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Erik Faye-Lund <kusmabite@gmail.com>,
	David Wade <DAWAD@statoil.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 22 20:30:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U8yKI-0007uH-KE
	for gcvg-git-2@plane.gmane.org; Fri, 22 Feb 2013 20:30:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756539Ab3BVTaJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Feb 2013 14:30:09 -0500
Received: from mail-vc0-f179.google.com ([209.85.220.179]:33717 "EHLO
	mail-vc0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753628Ab3BVTaJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Feb 2013 14:30:09 -0500
Received: by mail-vc0-f179.google.com with SMTP id gb23so621258vcb.24
        for <git@vger.kernel.org>; Fri, 22 Feb 2013 11:30:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=n5wcgxy+k3XF0iVSF8aZHCVgxbjveFoiG+24LQ2S6VM=;
        b=hMr87+3+m3EsM082/Pib1KLxUgAVkM9nzpePbR6iqY9gWewh7iBsDihtCcdJ/twK0G
         IqPkcmkE5ZfwxS9mpcZ1IBOk/tbHfJRtTLc674i0cC6Jcf+svynUTny9ETiLUxXEm81/
         f3T3rW7X1SpZzE4PwCwlO1deRue3alcMPQFFpg1DdqUjaupppjRbQKMyQqzPdNp6xEU7
         MHPZs8wpdcccbwcnJaxbSUF26HvCFzOkzMHii1Hxt2fo2tKvuOGlTOg/UTsFzCH82boi
         Cjq7fSNA67y0QQHnPCGT01+47dllXpXByAcJFeBoEBaOyaiFtCpUgpJcjhUSZdFuqWnM
         letA==
X-Received: by 10.52.94.71 with SMTP id da7mr3752434vdb.13.1361561408108; Fri,
 22 Feb 2013 11:30:08 -0800 (PST)
Received: by 10.58.201.103 with HTTP; Fri, 22 Feb 2013 11:29:47 -0800 (PST)
In-Reply-To: <CACsJy8DjatRbL=J-MZmQFnd+_7i-WwYHSnkY_ga++fx1R5Whmw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216857>

On Tue, Feb 19, 2013 at 6:02 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Tue, Feb 19, 2013 at 4:47 PM, Erik Faye-Lund <kusmabite@gmail.com> wrote:
>> On Tue, Feb 19, 2013 at 10:32 AM, David Wade <DAWAD@statoil.com> wrote:
>>> Hi,
>>>
>>> I wrote a commit message beginning with a hash (#) character, like this: 'git commit -m "#ifdef ...." '
>>>
>>> Everything went okay when committing, but then I tried 'git commit -amend' and without editing the commit message I was told I had an empty commit message.
>>>
>>> Is this a problem with my text editor (vim 7.2) or git itself? (git version 1.7.2.2 under RedHat 5.8) Or something I'm not supposed to do ;-) ?
>>
>> The problem is that when doing interactive editing of messages (like
>> 'git commit --amend' does), git considers '#' as a comment-character.
>> You can disable this by using the --cleanup=verbatim switch (or some
>> other suiting cleanup-setting, see 'git help commit').
>
> Nobody is always conscious about the leading # in commit message to do
> that. I once edited a commit message and the auto-wrap feature put '#'
> at the beginning of the line. I saved and went on without noticing one
> line was lost until much later :( Perhaps we should change the comment
> signature a bit to reduce accidents, like only recognize '#' lines as
> comments after a special line like
>
> # this is not a comment
> ### START OF COMMENT ###
> # this is a comment

Or maybe --amend should imply --cleanup=whitespace.
--
Phil
