From: Thiago Farina <tfransosi@gmail.com>
Subject: Re: About my git workflow; maybe it's useful for others
Date: Wed, 22 Apr 2015 16:57:06 -0300
Message-ID: <CACnwZYcD7ryJqM+85wxka+ViqOfy51bOgyetUEdgY1pcQPJv=A@mail.gmail.com>
References: <CAGZ79kaK-uRAE9-rH=-5t8djAw5e9rwkPjZuw=+XWEq+V6R5Yg@mail.gmail.com>
	<CACnwZYf6-Fh0JZeJZ4j3QOyqRF_2-NKJB06Wh20ipsRmrRN+qw@mail.gmail.com>
	<CAGZ79ka1U8SP-7b_Jbm--1j1sz0iHKd+v-WNCASAXH+kystefA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Apr 22 21:57:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yl0lk-00082l-Tk
	for gcvg-git-2@plane.gmane.org; Wed, 22 Apr 2015 21:57:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753871AbbDVT5I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Apr 2015 15:57:08 -0400
Received: from mail-oi0-f50.google.com ([209.85.218.50]:35922 "EHLO
	mail-oi0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753509AbbDVT5H (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Apr 2015 15:57:07 -0400
Received: by oift201 with SMTP id t201so190142801oif.3
        for <git@vger.kernel.org>; Wed, 22 Apr 2015 12:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=b/0sCFh2HqF039uHQANAIUjXYVEMt0jFh0Pp1XRJdcE=;
        b=paSEpPJk4ZhsiDFksDiF6cJhdQoSAoBlj9/n0J26BLFJOP4Yh+WkDbREg2RBBPiCnm
         1nvOIIk4p1i2avIMUD2kMCHXF4gh+YtFeAfMNTWvU5EBiuXWsLXJJqPyEMdjb8gXzmh/
         L025ieGALXOZK7VtwtN9ZwMZ0bUl2Kt5KRxxmGfXsvXc/cYcVpkVLFdakaKTV+FG/zqa
         MIfz1Vo9IxrQ+zy/s5UEmk92uwglLTfIWWOcYBTMO0Q2SkYYgA0aM64ouserMnRamkdd
         pCPZGx31XucxbsGu1sERS2lqCFpecGR6Sgn4GhOR96TNGKhFPKUFXq8gt/pZCjxanx7M
         tiWw==
X-Received: by 10.182.91.4 with SMTP id ca4mr25172792obb.39.1429732626597;
 Wed, 22 Apr 2015 12:57:06 -0700 (PDT)
Received: by 10.202.80.136 with HTTP; Wed, 22 Apr 2015 12:57:06 -0700 (PDT)
In-Reply-To: <CAGZ79ka1U8SP-7b_Jbm--1j1sz0iHKd+v-WNCASAXH+kystefA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267629>

On Wed, Apr 22, 2015 at 4:50 PM, Stefan Beller <sbeller@google.com> wrote:
> On Wed, Apr 22, 2015 at 12:38 PM, Thiago Farina <tfransosi@gmail.com> wrote:
>>>
>> IMO, sending email is the easiest part.
>>
>> The hard begins when you have to edit your patch and resend with the
>> reviewers' feedback incorporated. For me that is the most tricky and
>> hard part to get right, specially when using GMail as an email client.
>>
>> How do you handle that part of the process?
>
> I try to have as much in git as possible.
>
> So when the reviews trickle in, I change my commits (in git) accordingly
> via rebase and edit and lots of fixup commits. I use git notes
> to keep track of changes from one version to another.
>
> Having the "changes of the changes" in the git notes, I am (in theory)
> always able to kick out a new version of the patch series with
>
>    rm 00* # delete old patches
>    git format-patch --notes --coverletter somebranch...HEAD
>    edit 0000-cover-letter.patch
>    git send-email 00* --to=mailing list --to=John@doe.org --cc=Max@Mustermann.de
>
Is that capable of keeping the next patch set in the same thread that
started when you sent the initial patch? Otherwise things get
disconnected.

-- 
Thiago Farina
