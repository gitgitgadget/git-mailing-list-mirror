From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [GSoC 2011] Git Sequencer
Date: Tue, 5 Apr 2011 12:16:22 +0530
Message-ID: <BANLkTimfSvGeZcwExB_RW5X_coN908s8Rw@mail.gmail.com>
References: <20110403172054.GA10220@kytes> <201104040643.35583.chriscool@tuxfamily.org>
 <7vy63qa8z1.fsf@alter.siamese.dyndns.org> <201104050823.29762.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Stephen Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Tue Apr 05 08:46:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q702L-0003sI-Ak
	for gcvg-git-2@lo.gmane.org; Tue, 05 Apr 2011 08:46:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752596Ab1DEGqo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Apr 2011 02:46:44 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:37393 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752129Ab1DEGqo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Apr 2011 02:46:44 -0400
Received: by wwa36 with SMTP id 36so82066wwa.1
        for <git@vger.kernel.org>; Mon, 04 Apr 2011 23:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=3LsB+0FiYELcK+pqnVoKO80gbnGgDOMMNu/fbPX+VnI=;
        b=uvtaMZUs7rc5Z0BOILhSzQLxgUXMJNbmKdg2wlFS0JxKzf6SiN6b0XAnBVFOfCxxr4
         2DtDcNrXfXTBwO4NMKr7eB/JJkO+Wia36ptb1mP1GuNH4aAcgqouxIbH/f5etgQ8jbBd
         VG/1smGGYglo3urjzrnikt8KVA+twrk00N7Bs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=SA4g7RVeMfK0JqTzownV727ZQHH834Bqx3G6L2C9lzPEffQC1Eo+3ho/nSn8rl3Nho
         BML5i/bzorrxHRI4Xqe4N/hTx2J9bOcajrwFg6X90OC7UjW2DqdgHG6edOz+jh4VTyhA
         7OBF0ZagLr+YO/N/ZesJFX1pVWipYxbjT9FfU=
Received: by 10.216.72.201 with SMTP id t51mr4784735wed.6.1301986002118; Mon,
 04 Apr 2011 23:46:42 -0700 (PDT)
Received: by 10.216.158.80 with HTTP; Mon, 4 Apr 2011 23:46:22 -0700 (PDT)
In-Reply-To: <201104050823.29762.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170871>

Hi Christian and Junio,

On Tue, Apr 5, 2011 at 11:53 AM, Christian Couder
<chriscool@tuxfamily.org> wrote:
> On Monday 04 April 2011 07:20:18 Junio C Hamano wrote:
>> Christian Couder <chriscool@tuxfamily.org> writes:
>> > Yeah, the first step should be 'cherry-pick' with '--continue',
>> > '--abort', and '--skip' merged.
>>
>> I haven't looked at rebase-i machinery recently, but I wonder if it would
>> just be a matter of making a multi-commit cherry-pick just prepare a bunch
>> of "pick XXX" lines into .git/rebase-merge/rebase-todo file, make other
>> trivial setups (like detaching HEAD, writing head-name and head files) and
>> then execing "git rebase --continue"?
>
> It is probably quite easy to do that, but it would result in cherry-pick in C
> calling rebase-i in shell that itself calls cherry-pick in C (to pick
> individual commit). Instead with this GSoC I think we have the opportunity to
> have everything we needed in C.

I thought I should clarify- in the original proposal, I didn't mean
for cherry-pick to call "rebase -i" at all. When I said "use rebase to
resume", I meant "try resuming by hand using rebase --continue to
verify that cherry-pick has written the state information correctly"
as an intermediate step in the cherry-pick development.

-- Ram
