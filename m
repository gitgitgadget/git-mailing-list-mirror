From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] add new options to git format-patch: --cover-subject
 and --cover-blurb
Date: Sat, 6 Feb 2010 13:13:15 -0600
Message-ID: <20100206191315.GA3732@progeny.tock>
References: <1265405973-5670-1-git-send-email-larry@elder-gods.org>
 <201002051526.18205.wjl@icecavern.net>
 <7vfx5fwbws.fsf@alter.siamese.dyndns.org>
 <20100205225901.GA29821@cthulhu>
 <7vtytvjhit.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Larry D'Anna <larry@elder-gods.org>,
	"Wesley J. Landaker" <wjl@icecavern.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 06 20:22:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NdqEo-0000Cf-Qq
	for gcvg-git-2@lo.gmane.org; Sat, 06 Feb 2010 20:22:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932848Ab0BFTNV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Feb 2010 14:13:21 -0500
Received: from mail-iw0-f185.google.com ([209.85.223.185]:62807 "EHLO
	mail-iw0-f185.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932817Ab0BFTNU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Feb 2010 14:13:20 -0500
Received: by iwn15 with SMTP id 15so2166105iwn.19
        for <git@vger.kernel.org>; Sat, 06 Feb 2010 11:13:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=sCDwuWUzoHUuwxqAVYtVilDJy7yMVZDkFTRHmhCGz+8=;
        b=vjfbc6EmpRt8EhHQQ/AF+2XQ0I9m5LYy9Ah99VjkTuEI61dlm3D9I9PH0qCWU7N3QN
         ZDP3ZbWfv7vlp0xni4DChX+gY6d3is7VFsNXValEV7MeCeCUSdg8FB88BaPIYEzkLpPB
         CEetsqR6vtP70nWrLGWf6bh3qE4hglBbyubws=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=O2oH4wSzaj7VBUFl1KTnmItIop4txmd3W1mCvtaMVG7tzwxySpQBSuBVDWuUOmlpyg
         NHl9Udn5WvonUoqzkkGbYtBLdQolUoZxkZoGRL035pqM9GVAJcTkXjED18nRJua0XkGe
         KS2OmSRUpenGh8VjW49E7sy8sSxJaqDZx7Fqo=
Received: by 10.231.149.9 with SMTP id r9mr2573547ibv.82.1265483599203;
        Sat, 06 Feb 2010 11:13:19 -0800 (PST)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 21sm2384511iwn.6.2010.02.06.11.13.18
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 06 Feb 2010 11:13:18 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7vtytvjhit.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139185>

Junio C Hamano wrote:
> Larry D'Anna <larry@elder-gods.org> writes:
 
>> 1) make your branch
>>
>> 2) git format-patch --cover-letter
>>
>> 3) edit the cover letter
>>
>> 3) review the series, and realize you need to fix something, fix it.
>
> Hmph, this begs a natural question: why didn't you review and realize that
> in step (1)?

One answer: writing a cover letter forces one to reflect a little.
Perhaps that is why the cover letter and review share step 3. ;-)

> It might be sufficient for format-patch to notice a 0000-cover file that
> is already there, read the subject and blurb part and carry that forward,
> instead of unconditionally writing "*** SUBJECT HERE ***" and stuff.  That
> way, the user does not have to prepare a separate file before running
> format-patch.

FWIW I think this sounds sane and would be happy to see this feature.

Jonathan

> By scanning from the bottom of the existing 0000-cover file, skipping
> diffstat part (easy to spot with regexp) and then skip backwards a block
> of text whose lines are one of:
> 
>  (1) two space indented---that's one-line-per-commit;
> 
>  (2) empty line---separator; or
> 
>  (3) unindented line that ends with '(' number ')' ':'---the author.
> 
> The remainder would be the BLURB.  And you know it is much easier to find
> where the Subject: is ;-)
