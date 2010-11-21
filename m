From: Yang Zhang <yanghatespam@gmail.com>
Subject: =?windows-1252?Q?Re=3A_How_to_fix_=93Your_branch_and_=27origin=2Fmaster=27_ha?=
	=?windows-1252?Q?ve_diverged=94_after_editing_a_commit_that_came_before_a_pul?=
	=?windows-1252?Q?l=3F?=
Date: Sun, 21 Nov 2010 10:51:51 -0800
Message-ID: <AANLkTim6h17cd6LjCt8e8HBHGCdyCjw1yx7PVUsD7piJ@mail.gmail.com>
References: <AANLkTikr+uGrO2EB9WQk+CXeOm7jiYxdbhGzRRvgc9B9@mail.gmail.com>
 <20101120043628.GB20725@sigill.intra.peff.net> <AANLkTikCnX5aBrmh9+wnb9JyOiynv0zhrpdMJwbhL2ji@mail.gmail.com>
 <20101121163001.GA29216@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Gavin Guo <tuffkidtt@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Nov 21 19:58:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PKF7e-0005u7-6I
	for gcvg-git-2@lo.gmane.org; Sun, 21 Nov 2010 19:58:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755113Ab0KUSwM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 21 Nov 2010 13:52:12 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:41060 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751694Ab0KUSwM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 21 Nov 2010 13:52:12 -0500
Received: by yxf34 with SMTP id 34so3657639yxf.19
        for <git@vger.kernel.org>; Sun, 21 Nov 2010 10:52:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=0XJdbfQBWeM6uWQ4Gfh2teq2nMiyMIN3aIq61dIemqY=;
        b=KczRqP/IJiltZIzMuwRvn6aIk0Nx8B7QBHeAaXX0nYJwoaqfP7jHLfaJzS18gZwKFE
         paV1YenlU7dp8RdRJHs7+WP39iLtybs9ptO7M8GFKktm4Ye2j5RU8mK/jnlsUkZxDMjz
         QkVhzhVrA3Tnt7yTNvcBd5xce3F/vGLw6tT+E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=jaYIko6Rf87lnfqdKyodcSe4kI7n6lPUizPeRPRujx/xAHVvrEVcieQCdFZczqLU2E
         H63K1rPz9DjxYjkv+74W8q587gZ5BZ+4rNjOlfAdF5D/8rkzh1gfhTLGKNaA6KhlcTcM
         /7WqHImRMYcnQ5LjuPj4Y5A9rNF3Y1Cu/chdU=
Received: by 10.90.4.6 with SMTP id 6mr4505020agd.16.1290365531232; Sun, 21
 Nov 2010 10:52:11 -0800 (PST)
Received: by 10.90.222.2 with HTTP; Sun, 21 Nov 2010 10:51:51 -0800 (PST)
In-Reply-To: <20101121163001.GA29216@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161868>

On Sun, Nov 21, 2010 at 8:30 AM, Jeff King <peff@peff.net> wrote:
> On Sun, Nov 21, 2010 at 10:45:13PM +0800, Gavin Guo wrote:
>
>> > To fix it, what you want to do is recreate the history on top of B=
' as
>> > it happened on top of B. So first you go back to C', the last comm=
it
>> > just before the commits from upstream that were rewritten. (you wi=
ll
>> > have pick its sha1 out of the log):
>> >
>> > =A0git checkout -b temp B'
>>
>> I think you mean git checkout -b temp C'
>
> Yes, sorry. You should base your temp branch on C'.
>
>> > =A0git rebase --onto temp F'^ branch_name
>> [...]
>> > At that point your original branch should be in the state you want=
=2E You
>> > can delete the temp branch with "git branch -D temp".
>>
>> I'm sorry that I can't understand "your original branch should be in
>> the state you want" ?
>> You only create a temp branch, and rebase some commits on it, right =
??
>> What does that related to original branch ??
>
> The three-argument form of rebase above will switch to branch_name (y=
our
> original branch), consider F'^ as the upstream, and rebase
> F'^..branch_name on top of the commits in "temp".
>
> -Peff
>

Actually, I missed this detail earlier, and now like Gavin I'm
confused. *temp* is "in the state that you want," not original_branch,
right? temp shouldn't be deleted just yet; master should be updated to
point to this....
--=20
Yang Zhang
http://yz.mit.edu/
