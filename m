From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: Check out doesn't set x-flag on CIFS
Date: Wed, 20 Nov 2013 13:41:40 +0100
Message-ID: <CABPQNSaEs10U+3F8v3tBwMQ6cWa=YO=G2=p6t3VPcCz45OX02Q@mail.gmail.com>
References: <loom.20130529T161408-317@post.gmane.org> <CABPQNSZDSRf9LSeBHBJ46pbBGsDwybTPkyJ2esqvoc0UHPifKA@mail.gmail.com>
 <528CA18D.40004@geneity.co.uk> <CABPQNSYgkkiCxx60gwBtXoQTSj4RZMUiQHuzz7Gq7ELE5ke32Q@mail.gmail.com>
 <528CA43E.7020804@geneity.co.uk> <CABPQNSbkV6bxkoeDdn9n=WUSF9fjVxrA_5bEH=KurcHE3xtJbQ@mail.gmail.com>
 <528CAD36.3030407@geneity.co.uk>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Andre Esser <andre.esser@geneity.co.uk>,
	GIT Mailing-list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Nov 20 13:42:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vj76v-00060z-67
	for gcvg-git-2@plane.gmane.org; Wed, 20 Nov 2013 13:42:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751796Ab3KTMmW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Nov 2013 07:42:22 -0500
Received: from mail-ie0-f180.google.com ([209.85.223.180]:57079 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751133Ab3KTMmV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Nov 2013 07:42:21 -0500
Received: by mail-ie0-f180.google.com with SMTP id tp5so6258384ieb.11
        for <git@vger.kernel.org>; Wed, 20 Nov 2013 04:42:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:content-type;
        bh=iW8K1hxOwww9WmhZ/arz0ygaNBG4yiiSQkJiMCjjP9U=;
        b=088U4gB4DiWKBuXls3ka3X8ZNeFXtzsoO6FLwQqOAhMb7mjxkTVGnPrQuXIQa9y6dH
         Wuw3nx9XROBw/G+zi29cwXF6s6dX4ddll2Y0EfIen5habGcxC+KJiDeh0mS0I1lebLYf
         9VPdn+Fv3sWEQNpAMgsZ2I8kMwmIRDZf+c1ZpSIuyn3dUTkK7qiCXWX/QexxuUNPSGx6
         vZFTgKhyDShOQbbxEPG3pN1F6hGT9AVT4IGByIRuUW87BqNdnwJDSHKjkAQMRSxz8dDo
         XZo3EtbDhxXzaLltkFL0tMuVvdOIebfSthiMXnTnCeqx30IQfYKshoCi5Ki2iv42s74q
         wXkg==
X-Received: by 10.43.52.129 with SMTP id vm1mr306507icb.10.1384951340928; Wed,
 20 Nov 2013 04:42:20 -0800 (PST)
Received: by 10.64.249.33 with HTTP; Wed, 20 Nov 2013 04:41:40 -0800 (PST)
In-Reply-To: <528CAD36.3030407@geneity.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238078>

Sigh, it seems replying from Gmail on my phone culled the CC-list.
Sorry about that, and here's the rest of the discussion in case
someone else is interested:

On Wed, Nov 20, 2013 at 1:38 PM, Andre Esser <andre.esser@geneity.co.uk> wrote:
> On 2013-11-20 12:23, Erik Faye-Lund wrote:
>> On Wed, Nov 20, 2013 at 12:59 PM, Andre Esser <andre.esser@geneity.co.uk> wrote:
>>>
>>> There is with POSIX extensions, and git recognises it correctly when an
>>> executable file is being committed, ie the file's exec flag is set in
>>> the repository.
>>>
>>> If that file is then however checked out to the same CIFS file system,
>>> the exec flag is not set, which seems a least inconsistent.
>>
>> OK, in that case, core.filemode probably leads down the wrong path. In
>> fact, shouldn't everything just work? I mean, normal POSIX calls
>> should behave as ususal, no? Perhaps this is a Samba issue?
>
> We've had a look at the GIT source code (after my original post) and it
> seems that after GIT identifies the file system as CIFS, it doesn't even
> try to set the x-flag. Given POSIX extensions have been around for years
> it would probably be a good idea to change GIT's behaviour. But I'm no
> developer and we don't have the spare manpower in the company to look
> into this any deeper.
>
> Thanks for your replies though!
>
> Andre
