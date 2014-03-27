From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 7/8] ls-files: support --max-depth
Date: Thu, 27 Mar 2014 21:36:08 +0700
Message-ID: <CACsJy8ANjMd+jMmrXfAdNEdggwhmpPt0QsnvUKdsbscorkqwkw@mail.gmail.com>
References: <1395310551-23201-1-git-send-email-pclouds@gmail.com>
 <1395310551-23201-8-git-send-email-pclouds@gmail.com> <1457323768.788823.1395737758945.JavaMail.zimbra@imag.fr>
 <CACsJy8Awu6oNOS-m5_DNh_HGeHKgcnowUY+iz4efo3s1HYycnQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Cc: Git Mailing List <git@vger.kernel.org>
To: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Mar 27 15:36:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WTBQB-0007ES-Uu
	for gcvg-git-2@plane.gmane.org; Thu, 27 Mar 2014 15:36:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755729AbaC0Ogk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Mar 2014 10:36:40 -0400
Received: from mail-qc0-f181.google.com ([209.85.216.181]:53158 "EHLO
	mail-qc0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755034AbaC0Ogj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Mar 2014 10:36:39 -0400
Received: by mail-qc0-f181.google.com with SMTP id e9so4375892qcy.12
        for <git@vger.kernel.org>; Thu, 27 Mar 2014 07:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=hxkEedYlgo7FJiAQWWpheOdAzQVFjGjSlYhXkfRD+4I=;
        b=HEJtIMD4J3E5eEic9HUAcfqVnkujsQXE/IVrJtIsCHYOCcfoupuEsGbRAVXXLc5lT4
         Gtiwo+LVoJPhh4Egbe4Riy7Z6PxiSO+piD8sgGUEs0roiYhCqc3vXOM08crxh9Bq2ruP
         7ptahIPLzur5qqQ59W+ae8dz7hw4odeQZ6RUEXDbNRtJOoVnR8gjTzBp9g299bOS7AGT
         nE/3OBepi37NePL8szpCuVAisSmNWJ00+AiHAoQT6kGs/p1HvG7/UUmfSROvLOcwlg9f
         XZf4u+/cAFVKs6jaLiR2ThjhXpDULiMuu/Wrpu3ffurCTrO+jJCqlsJ0DyAQjksq9yDT
         HnNA==
X-Received: by 10.224.161.140 with SMTP id r12mr2591827qax.24.1395930998424;
 Thu, 27 Mar 2014 07:36:38 -0700 (PDT)
Received: by 10.96.103.166 with HTTP; Thu, 27 Mar 2014 07:36:08 -0700 (PDT)
In-Reply-To: <CACsJy8Awu6oNOS-m5_DNh_HGeHKgcnowUY+iz4efo3s1HYycnQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245284>

On Tue, Mar 25, 2014 at 6:15 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Tue, Mar 25, 2014 at 3:55 PM, Matthieu Moy
> <matthieu.moy@grenoble-inp.fr> wrote:
>> ----- Original Message -----
>>> The use case in mind is --max-depth=0 to stop recursion. With this we can do
>>>
>>> git config --global alias.ls 'ls-files --column --color --max-depth=0'
>>>
>>> and have "git ls" with an output very similar to GNU ls.
>>
>> One big difference though: your "git ls" does not show directories. I understand that this is easier to implement, but from the user point of view it resulted in a "wtf" from me running "git ls" in a repository containing essentially directories, and seeing just a README file in the output.
>
> I was hoping you didn't notice :) It'll be more difficult but not impossible.
>
>> Ideally (for me), directories should be shown with a trailing / like "ls -F" does.
>
> I'd rather go with no trailing slash by default and add -F (which
> seems to be more than just '/')

And we need a new indicator for submodules when -F is used. I think it
should be different than '/'. I randomly picked '&' for now. Any
suggestions welcome.
-- 
Duy
