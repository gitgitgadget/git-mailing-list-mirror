From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] prompt: fix show upstream with svn and zsh
Date: Tue, 21 May 2013 19:29:38 -0500
Message-ID: <CAMP44s3XjJ8AxTAF3OEPDd-3egb9koogxheZj+KdUrvJDOjxmQ@mail.gmail.com>
References: <1369169667-25166-1-git-send-email-t.gummerer@gmail.com>
	<20130521224119.GF30969@goldbirke>
	<CAMP44s1cbO-xzUAHR4THz4MPdqxY6SHG7uf_da_OM8YCDbTi+A@mail.gmail.com>
	<20130521233617.GG30969@goldbirke>
	<CAMP44s3nMSj5=pr-WmWTd_iUjK4iU_8KnOKHYgRHLAQyyMH9bA@mail.gmail.com>
	<20130522002028.GH30969@goldbirke>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Gummerer <t.gummerer@gmail.com>, git@vger.kernel.org,
	gitster@pobox.com
To: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Wed May 22 02:29:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ueww5-0000he-9Y
	for gcvg-git-2@plane.gmane.org; Wed, 22 May 2013 02:29:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753576Ab3EVA3k convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 21 May 2013 20:29:40 -0400
Received: from mail-la0-f41.google.com ([209.85.215.41]:63414 "EHLO
	mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752683Ab3EVA3j convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 May 2013 20:29:39 -0400
Received: by mail-la0-f41.google.com with SMTP id ee20so1386443lab.0
        for <git@vger.kernel.org>; Tue, 21 May 2013 17:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=40KqB60dRUFqkCCmLaKLLp2Z/WDTduEVX3CZplvuris=;
        b=prCYzw/6APRl6vVFSvw+VTm+w9g6aUbCrhzTHF6mlynbG24qHmgyUX1/IphhQEnc7a
         x56uXwUcmIIgzkZC0ffhtqEzgf/4c0DUhaJzxEvtUzIFAza9hFADKKRqdosgnoMIbceA
         RCZh95jdC/JVKQty0yGZRKi01gCEIj9Y9YNAW5hh7Zdh7bNTYR3y+Tp+HkAgUVzQWtuU
         UdVVCgRoFeUXLDmwjkCr7D81DvG2O/HxcNiny22VT8xfYRuKWGe5fOC1IV205aPJ/Sm8
         HiWgag5UeBS/BJbJ3KcRFzfULEPw4Xxoi9fGyqr+c2OJ+0WNTOOxxB9exavLbcu3kR+D
         FPKQ==
X-Received: by 10.112.63.169 with SMTP id h9mr2776552lbs.135.1369182578177;
 Tue, 21 May 2013 17:29:38 -0700 (PDT)
Received: by 10.114.184.3 with HTTP; Tue, 21 May 2013 17:29:38 -0700 (PDT)
In-Reply-To: <20130522002028.GH30969@goldbirke>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225100>

On Tue, May 21, 2013 at 7:20 PM, SZEDER G=C3=A1bor <szeder@ira.uka.de> =
wrote:
> On Tue, May 21, 2013 at 07:03:09PM -0500, Felipe Contreras wrote:
>> On Tue, May 21, 2013 at 6:36 PM, SZEDER G=C3=A1bor <szeder@ira.uka.d=
e> wrote:
>> > On Tue, May 21, 2013 at 06:04:35PM -0500, Felipe Contreras wrote:
>> >> On Tue, May 21, 2013 at 5:41 PM, SZEDER G=C3=A1bor <szeder@ira.uk=
a.de> wrote:
>> >>
>> >> > On Tue, May 21, 2013 at 10:54:27PM +0200, Thomas Gummerer wrote=
:
>> >> >> Currently the __git_ps1 git prompt gives the following error w=
ith a
>> >> >> repository converted by git-svn, when used with zsh:
>> >> >>
>> >> >>          __git_ps1_show_upstream:19: bad pattern: svn_remote[
>> >> >>
>> >> >> This was introduced by 6d158cba (bash completion: Support "div=
ergence
>> >> >> from upstream" messages in __git_ps1), when the script was for=
 bash
>> >> >> only.  Make it compatible with zsh.
>> >> >
>> >> > What is the actual cause of this problem/incompatibility and ho=
w/why do
>> >> > these changes fix it?
>> >>
>> >> I think the commit message makes that very clear.
>> >
>> > If that were the case I wouldn't have asked in the first place.
>>
>> You are not the authority on what *I think*, or if you meant s/If th=
at
>> were the case/If the message was clear/, still; you are not the
>> authority on what is or is not true. Only on what is your opinion.
>
> I would have preferred a more constructive reply, perhaps with answer=
s
> to the questions I asked earlier...

That's the job of the patch submitter, all I did was express my option
about the commit message. You have no say as to what is my option.

You are the one not being constructive by claiming that all opinions
contrary to yours are wrong.

--=20
=46elipe Contreras
