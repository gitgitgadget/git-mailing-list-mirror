From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH] contrib: remote-helpers: add move warnings (v2.0)
Date: Tue, 13 May 2014 16:11:24 -0700
Message-ID: <CAL=YDW=jCEtfEmvO-173jpJB0f3mJ2+efihprVw+MpVjxyyExQ@mail.gmail.com>
References: <1400016596-13178-1-git-send-email-felipe.contreras@gmail.com>
	<xmqq7g5pmj5r.fsf@gitster.dls.corp.google.com>
	<53729b2150a84_34aa9e5304e0@nysa.notmuch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 14 01:11:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkLr8-0007lO-73
	for gcvg-git-2@plane.gmane.org; Wed, 14 May 2014 01:11:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753794AbaEMXL1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 May 2014 19:11:27 -0400
Received: from mail-ve0-f171.google.com ([209.85.128.171]:47853 "EHLO
	mail-ve0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752687AbaEMXLZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 May 2014 19:11:25 -0400
Received: by mail-ve0-f171.google.com with SMTP id oz11so1384268veb.30
        for <git@vger.kernel.org>; Tue, 13 May 2014 16:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=wcBWuoKTjN0dm65sdrkh4qftF91HqV2vtTzWjMX8c+A=;
        b=m6amxqkSRDbWdjHKzELg39tQCNeespsnYad1ZcNspukqOpiRDWQWOjfs4lHUgfguyN
         4043xRNTyYgSPYoYlYZWyFBXRXDwYGjT9bW0QTjItokr9GzYa28RWuFszE3pCjnQDMtp
         oKL9M92HlQlTGZZqbGWhTbsKE4V60xVcBJ4xGGmf+QZtVhsZFV3aQhfSjYdx3susq72u
         cGOdzu7CO13zUbvT9nIjwKT6Cyr8lUHkvGN8pSn5L5N1ibadzs29BwWTteNa4QBZ0XAf
         9ZQQqA89aDJauijMzS/AT1VhQudxHDhzDzSSBHOd/MSPJWduXk5hu/CxRseon+zfv3vP
         tWRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=wcBWuoKTjN0dm65sdrkh4qftF91HqV2vtTzWjMX8c+A=;
        b=OAtA/FYknkL5ba3kY63/u7hFtmLnSZdnwsxHrdCm3fAcDMfR+0sFaHZAeelVRQ0WDj
         2VirUeogUw0dGVYt2NNJcrHRlFNnuW4NktrFdzohyvib8SiP4BhZGd/s6BbLneSBfa9O
         7xlc7zJiHJbN2n/+bylDXVkkGVrDbtdLhwuhHS59BaodNcrSSKVtkn3Ayo2+quIbMH6b
         CDe33n2PzNmHbIzvXiY3rC/0HWprozqWx5u6SIPbnThtpPTPwGhXF3BUI+f1tKzehtkA
         nyokwWEP8cARUA0vfYE4R/Sj7EymmOofGKB8TxrFvQbpb7gtW1/s9t3+Nb4UDG/7R9YX
         FvcQ==
X-Gm-Message-State: ALoCoQn1n98doi6cDZ7VyniO8TTSbyoMQQPFaj5a40NpgfnflJZ1kewK9Zw45aHJBxmqbw6uW4nk
X-Received: by 10.58.66.195 with SMTP id h3mr32258vet.57.1400022684918; Tue,
 13 May 2014 16:11:24 -0700 (PDT)
Received: by 10.52.6.163 with HTTP; Tue, 13 May 2014 16:11:24 -0700 (PDT)
In-Reply-To: <53729b2150a84_34aa9e5304e0@nysa.notmuch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248886>

On Tue, May 13, 2014 at 3:22 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> Junio C Hamano wrote:
>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>
>> > The tools are now maintained out-of-tree, and they have a regression in
>> > v2.0.
>>
>> You seem not to understand at all what a regression is.
>>
>> My understanding is that versions of remote-hg shipped with all
>> versions of Git did not work with Hg 3.0, so not working with Hg 3.0
>> is a regression in v2.0 at all.
>
> I explained to you multiple times already that is a different issue, but
> it somehow doesn't get through your skull.


Could you please calm down and adjust your behavior.
This constant hostility and rudeness makes the mailing list very unpleasant.


>
> Let me try a different approach.
>
> git-remote-bzr has a regression in Git v2.0.
>
> Did you get the BAZAAR part? That's right, this is unrelated to
> Mercurial v3.0 because it doesn't have anything to do with Mercurial.
>
> *BOTH* git-remote-hg and git-remote-bzr have a regression in Git v2.0.
>
>> A recent report was about Hg 3.0 not working with 1.9.3, but I think
>> you earlier said all versions of Git does not work with Hg 3.0, and I
>> can believe it.  That is hardly a regression.
>>
>> You could argue that Hg has a new regression to its external users
>> of its API when it went to 3.0.  We actually had a similar breakage
>> in 1.5.4, where it was reported late in the cycle after -rc0 [*1*]
>> that cgit that linked with our internal API libgit.a was broken by a
>> change on our side, which resulted in us fixing the breakage (even
>> though technically you may be able to say that it was cgit's fault
>> to link with libgit.a in the first place) with 18125644 (Move
>> sha1_file_to_archive into libgit, 2008-01-14) very late in the
>> cycle.  Calling that a regression in cgit would have been insane,
>> even if we did not patch our side up to accomodate it.
>>
>> Stop this idiocy.
>
> Sigh, you just don't seem to understand that you are thinking about a
> different issue. I don't think there's any other way I can explain it to
> you.
>
> --
> Felipe Contreras
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
