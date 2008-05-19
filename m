From: "Alexander Gladysh" <agladysh@gmail.com>
Subject: Re: Git GUI vs interactive post-commit hooks
Date: Mon, 19 May 2008 17:42:05 +0400
Message-ID: <c6c947f60805190642x7d44ef04h4090cbb687de69e@mail.gmail.com>
References: <c6c947f60805190348g3395f8degae81963b402856b6@mail.gmail.com>
	 <20080519131942.GA5526@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: "=?ISO-8859-1?Q?Bj=F6rn_Steinbrink?=" <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Mon May 19 15:43:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jy5dw-0003og-76
	for gcvg-git-2@gmane.org; Mon, 19 May 2008 15:43:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932565AbYESNmK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 19 May 2008 09:42:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932563AbYESNmJ
	(ORCPT <rfc822;git-outgoing>); Mon, 19 May 2008 09:42:09 -0400
Received: from wr-out-0506.google.com ([64.233.184.227]:29250 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764062AbYESNmH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 May 2008 09:42:07 -0400
Received: by wr-out-0506.google.com with SMTP id c48so714168wra.1
        for <git@vger.kernel.org>; Mon, 19 May 2008 06:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=yHK2D7jiNxlEOQZXQCo4cnm7PWKnGd5gI1tvf9NMFxE=;
        b=IBKvON7+osQ8lDkDhmL0mWscXTq17QZl8ZcrdGrn4dZIJoT00U8iW3Lgb7S/lOU9GQPz1FWCLk1pZAhU2/2PkDQQnA+3FwtgKsK8WCEI3FRwwd6PqjWLZ9d/MN1QqwhENqjWmEliGBusa6m8WIY4UhwwPMLdrVYdzPbNog3pvD0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=WRNQAFOtp3R4W4UX6fk6l7LdQ5yO4DKAoYPJhQ3OC4uPrw23gze+BjSYOszTzwXZwHwZypEkNk4FCmIHCILMc6GF53OdxOrNJCN7oiTCGbzkpnnrb3f9lk1jSmMck12DXqn8Jmn1sbrsysW/XJnn70UPcPl+a1pZ68bUC+k9CZw=
Received: by 10.115.14.1 with SMTP id r1mr7471570wai.139.1211204525499;
        Mon, 19 May 2008 06:42:05 -0700 (PDT)
Received: by 10.115.111.4 with HTTP; Mon, 19 May 2008 06:42:05 -0700 (PDT)
In-Reply-To: <20080519131942.GA5526@atjola.homenet>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82428>

On Mon, May 19, 2008 at 5:19 PM, Bj=F6rn Steinbrink <B.Steinbrink@gmx.d=
e> wrote:
> On 2008.05.19 14:48:14 +0400, Alexander Gladysh wrote:
>> Hi, list!
>>
>> $ git --version
>> git version 1.5.5.1
>>
>> I have a post-commit hook which does backups for me:
>>
>>   username=3Dagladysh
>>   for name in `git branch | cut -b3-`
>>   do
>>     remote=3D$username-$name
>>     echo pushing $name as $remote
>>     git push backup +$name:refs/heads/$remote
>>   done
>
> Isn't that what "git push --all" does? And that will only ask for a
> password once, not for every branch.

git push --all would not rename my branches... But, I guess, this can
be done as preparation step somehow.

>> The backup repo is behind ssh. Recently I have put password on my ss=
h
>> key and post-commit hook ask me for password once for each branch.
>> This makes unhappy commit process from Git GUI -- after I shut it
>> down, there are multiple ssh key password prompts in the shell from
>> where I launched it, and it does not display any input I enter.
>>
>> Any advice? I do want to input password for my key each time I use i=
t.
>
> For a graphical tool, you might want to use something like
> gtk-led-askpass, which shows a window with a password prompt. SSH wil=
l
> make use of it if SSH_ASKPASS contains its path _and_ ssh is not star=
ted
> from a terminal. Unfortunately, the latter is probably not true for g=
it
> gui most of the time.

<Useful advice regarding how to solve SSH_ASKPASS issue skipped.>

Thanks, I would try that. I'm mostly working from X, so lack of X
should be not an issue... However I'd like to avoid patching my local
copy of git as much as possible. :-)

> Maybe someone else can come up with a sane solution that makes git gu=
i
> more SSH_ASKPASS-friendly.

That would be great.

Thank you,
Alexander.
