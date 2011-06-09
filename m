From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Command-line interface thoughts
Date: Thu, 9 Jun 2011 15:06:30 +0200
Message-ID: <201106091506.31511.jnareb@gmail.com>
References: <BANLkTikTWx7A64vN+hVZgL7cuiZ16Eobgg@mail.gmail.com> <BANLkTimir5nQYJk+GuNQOzmTWMEXb2kWqQ@mail.gmail.com> <201106091445.55601.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Junio C Hamano <gitster@pobox.com>,
	Scott Chacon <schacon@gmail.com>, git@vger.kernel.org
To: mike@nahas.com
X-From: git-owner@vger.kernel.org Thu Jun 09 15:06:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUewg-0003Bs-EY
	for gcvg-git-2@lo.gmane.org; Thu, 09 Jun 2011 15:06:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757604Ab1FINGl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jun 2011 09:06:41 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:63334 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757235Ab1FINGl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jun 2011 09:06:41 -0400
Received: by fxm17 with SMTP id 17so960613fxm.19
        for <git@vger.kernel.org>; Thu, 09 Jun 2011 06:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=R7ldoqafDxl/fwNYVgXVLzSGyG5x0vaTDji7RIR0i6E=;
        b=lctL+AXfrXQ97N22wKTHjAhotaVVNYzQ2T6ccAvypHs+JtL5XWrMkxVqrrc5wTmnoc
         rVdSSfJV/TRREfNgC1m+zW+7Q8ixImF/z7B17hJFhtzTlkWX/F7HwNr27n/0sozVFYNl
         ssbxLoOpiApC/zxNqDGodsftzwlR2GECLmbdI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=SThtprSDZOYAICYViBPf9Z523R+zlBWJq6e4WKzcUs44nHQPQC02Ju/8t4Cdp8jKs3
         2LsWoKkVrWxRsXBA0vmNgeLCLDXa7NicfbMYf3+dvSUelwEFt2hYK7JGHYfvS6nTGcYB
         dZvf1BI/LIUgsXxP1x+uKZvkJ+9b0HWU5dukQ=
Received: by 10.223.41.89 with SMTP id n25mr100558fae.7.1307624799753;
        Thu, 09 Jun 2011 06:06:39 -0700 (PDT)
Received: from [192.168.1.15] (abvo166.neoplus.adsl.tpnet.pl. [83.8.212.166])
        by mx.google.com with ESMTPS id 5sm1376410faz.0.2011.06.09.06.06.37
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 09 Jun 2011 06:06:38 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <201106091445.55601.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175521>

Jakub Narebski wrote:
> On Thu, Jun 9, 2011, Michael Nahas wrote:
>> On Thu, Jun 9, 2011 at 5:48 AM, Jakub Narebski <jnareb@gmail.com> wrote:
>>> On Wed, 8 June 2011, Michael Nahas wrote:

[...]
>>>> "git diff HEAD NEXT" would print the resolved changes.
>>>> "git diff NEXT WTREE" would print the unresolved changes
>>>> "git diff HEAD WTREE" would print all changes.
>>>>
>>>> I believe that is the same behaviour as "git diff", "git diff
>>>> --cached" and "git diff HEAD" during a conflicted merge.
>>>
>>> "git diff NEXT WTREE" would not behave (with your proposal) like
>>> "git diff", but like "git diff --ours".
>> 
>> OURS and HEAD are the same thing, so I doubt a command that does not
>> involve "HEAD" would behave like "--ours"
> 
> OURS and HEAD are not the same thing.  In OURS you have _conflicted_
> chunks replaced with HEAD ('ours') version, but chunks that can be
> resolved sutomatically are resolved; sometimes to 'theirs' version.

I'm very sorry, my mistake.  I have actually checked and OURS is the
same as HEAD version.

You wrote that NEXT contains either stage 0 for resolved files, or
OURS (HEAD) version for files with conflicts.  But that is exactly
what "git diff --ours" show.

> "git diff" in case of conflict prints 3-way combined diff between
> 'ours', 'theirs' and working area version.  As "git diff NEXT WTREE"
> doesn't print 3-way combined diff, it would be different for conflicts
> from "git diff".
> 
> "git diff --ours" for nonconflicted entry (stage 0 in index) would
> print ordinary diff between index and working area, just like
> "git diff NEXT WTREE". [...]

-- 
Jakub Narebski
Poland
