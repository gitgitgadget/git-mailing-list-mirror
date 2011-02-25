From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Revert a single commit in a single file
Date: Fri, 25 Feb 2011 20:43:42 +0100
Message-ID: <AANLkTinzhd_nL265e7DZA4xEnXqDn-5m=9GPS7JsFY-S@mail.gmail.com>
References: <AANLkTikpdGfAAUMu_7DfA-GRUv7gKn5Yc9RnJwo2iKoM@mail.gmail.com>
	<7v8vx4aqun.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Ferris Nicolaisen <tfnico@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 25 20:45:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pt3be-00036J-Si
	for gcvg-git-2@lo.gmane.org; Fri, 25 Feb 2011 20:45:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932785Ab1BYTpe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 25 Feb 2011 14:45:34 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:58188 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932710Ab1BYTpd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 Feb 2011 14:45:33 -0500
Received: by fxm17 with SMTP id 17so2006764fxm.19
        for <git@vger.kernel.org>; Fri, 25 Feb 2011 11:45:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Z46FJbqs8KrKNE3sRLS8acBfpZFjNaw4JKfrjwNkV9E=;
        b=BhgABoj9YRZxvQfCbJ9r14qnZi1DLrlScixvFybe2/CbTVkljehdkSR1BM+0Rvl0cM
         +0rTA14G0/Hzj1ErYG8HGwYrVG/c45oNEKahiAfcxVkgBX478PlGxDmEG0PF5YrhWS/D
         UatG4UIg+53m+fKkOOoaqiHGZhHXbkn5sSNTs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=c+EskOashVAJROZ1cPt1BqCo4VeXmeRJmzCgtmkAl6tB3lgnGKluZx5HEDn1ih+Jlo
         pLvQKHveBgI/mMmQ9ktQu6Qp4oEOKnZW4/OKhV0yoLqBVvbBS4a5iwCUfsiEWV4apEj0
         pco/X8A2eXGa4UzEKZIj5fPgwT0FYEO9L5DGE=
Received: by 10.223.100.15 with SMTP id w15mr3119920fan.121.1298663022988;
 Fri, 25 Feb 2011 11:43:42 -0800 (PST)
Received: by 10.223.2.201 with HTTP; Fri, 25 Feb 2011 11:43:42 -0800 (PST)
In-Reply-To: <7v8vx4aqun.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167925>

On Fri, Feb 25, 2011 at 19:53, Junio C Hamano <gitster@pobox.com> wrote=
:
> Thomas Ferris Nicolaisen <tfnico@gmail.com> writes:
>
>> I tried asking the same question on the "newbie" list some time ago:
>>
>> http://groups.google.com/group/git-users/browse_thread/thread/d562b4=
eeac016711
>>
>> Basically, when I go
>>> git revert <commit> <path>
>>
>> .. my expectation was that a new commit would be made reverting the
>> changes from the old commit, but only for specified path/file.
>>
>> Maybe it's a bit of a corner-case, but still would be nice to have
>> once in a while. What do you think?
>
> I am afraid that it would lead to encouraging people to record a horr=
ibly
> broken history, unless you think carefully about what the resulting c=
ommit
> log message should describe. =C2=A0It would look _as if_ you negated =
the effect
> of the original commit as a whole, but in reality you are only revert=
ing
> just a part of what you chose to revert with <path>.
>
> We do encourage people to record the _reason_ why the particular comm=
it
> was removed by not supporting "-m <message>" option to "git revert"
> command, but the commit template in the editor given to the user shou=
ld
> make it absolutely clear that the particular partial revert is revert=
ing
> only a part of the original commit, and need additional words to stro=
ngly
> encourage to record why only that part and not other parts are revert=
ed.

Agreed, but FWIW where I work I've seen people record "horribly broken
history" already because git-revert doesn't support this, and they
don't know the trick I described.

I also don't agree that the history would be horribly broken. The
message is just an advisory template, it's always the content that
changed that we care about, and we can analyze the history and see
that this chunk is the reverse of a chunk in a previous commit.

But just like we now have:

    Revert "some commit"

    This partially reverts commit <sha1>.

We could have with <path>:

    Revert "some commit"

    This partially reverts commit <sha1>. Only the path <path> has
    been reverted, which is X out of Y files changed in the original
    commit.

Or something like that.
