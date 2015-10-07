From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH] pretend_sha1_file(): Change return type from int to void
Date: Wed, 7 Oct 2015 14:24:24 -0700
Message-ID: <CAGZ79kYfcA4Atsx9zy+DNA_uhW-f91c5dLMGqhwSpEV7tPE5dA@mail.gmail.com>
References: <1444133704-29571-1-git-send-email-tklauser@distanz.ch>
	<632cbcf1dc9fa45ce71693a2cfae73e4@dscho.org>
	<20151006135101.GA11304@distanz.ch>
	<ef5b20ed42ea20b2891fc3998a81f339@dscho.org>
	<xmqqfv1mvawu.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kZmon6xwDE2reSOjM87HfG_dqc6-Rk2KzxnePLAN=BiQw@mail.gmail.com>
	<xmqqh9m2tm8v.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Tobias Klauser <tklauser@distanz.ch>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 07 23:24:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZjwCL-0002UE-Q0
	for gcvg-git-2@plane.gmane.org; Wed, 07 Oct 2015 23:24:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754191AbbJGVY0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Oct 2015 17:24:26 -0400
Received: from mail-yk0-f173.google.com ([209.85.160.173]:36858 "EHLO
	mail-yk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753771AbbJGVYZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Oct 2015 17:24:25 -0400
Received: by ykba192 with SMTP id a192so27328109ykb.3
        for <git@vger.kernel.org>; Wed, 07 Oct 2015 14:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=5Qlt0AZe7aUHzgjCMGqlUa8DvyuH9G7Czdfo0irXRfA=;
        b=jADK39W1Tp0hPmo4pQRJVNk7+UwwDR9CtVyP1znoSwgbNz6ucH4pDEKd47yMBw4tkG
         nGVvpSadKNeunLGGzYjzAldQYlqw2KHbPDk/KL9vg84coA6QPNEb3cUwF6IoCDo1K7lw
         VKg/snnb3cZG26FBTtZ+h4rHyrgHEb2a1BZdt0zSeVuZGseSnsgaInCTfQNsEhSTEcrK
         +0qY+C+obohNPxmGYo6mhp5m07Zy9KTzNKFwiFQqKL6oNkmiTWptE1BccLACL/trFIJZ
         UWv/s9wN6w+Fb8PBVjk34OGAA+Kj+VuI+lDqgucmISZVohSJAg4zbqp+uUhmjtfQGrXX
         ut3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=5Qlt0AZe7aUHzgjCMGqlUa8DvyuH9G7Czdfo0irXRfA=;
        b=Pm6tifrBuOSdchz8iHP5QBRrvQ+HgFqwT9HjrxfMGC/2qmQdsuIRNSpUfh3FZ86/yH
         5+p0LhTaQ+IlNfHXAnl5lOkMLbPszZZlskkMikDF6j2dLKwfV5qqhLjukbLhKECWfTM5
         cKPrtrnN7uGGIoz5J/n4fnoRLPzVhfpLENJ99vTzhuPdf42b2aqj7FSwrDdjfUj8c7hf
         oFD1P3l6SL5uPMrB7z5nlxr5Wz62nu3AmUmZpHf7oly85pZBz1DqBTrQMFE6/qHNBOhz
         rx/JJSEZPS32z6ZGZdoD4ptlYsinTNblwXedt5lWGZLOLK0kluFkw7BtI8lNCcGlicrb
         rMWw==
X-Gm-Message-State: ALoCoQnBSscc3+S5zUrTuphQkVw0gnNit8RFLdR6dfsWlOaOi+JaFA+QWzO9fR10U1ncBR9SlCAC
X-Received: by 10.13.198.194 with SMTP id i185mr2860036ywd.68.1444253064332;
 Wed, 07 Oct 2015 14:24:24 -0700 (PDT)
Received: by 10.37.29.213 with HTTP; Wed, 7 Oct 2015 14:24:24 -0700 (PDT)
In-Reply-To: <xmqqh9m2tm8v.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279200>

On Wed, Oct 7, 2015 at 2:14 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> Compare to a patch[1] I sent a while back and the discussion on it.
>>
>> [1] https://www.mail-archive.com/git@vger.kernel.org/msg70474.html
>
> It is not clear what conclusion you want others to draw from the
> comparison, I am afraid.

I did not draw a conclusion. All I wanted is to point out, we've had similar
patches before. Maybe I wanted to point out, you had a different opinion
about the patch I linked to than you seem to have now about this patch.

>
> I am guessing that you are in favor of dropping this patch, because
> 'int' that signals success or error is the most natural return type
> and meanint for this function if its callers ever start using the
> value as the indication of an error, just like in the old thread,
> the return value from get_remote_heads() had the most useful type
> and the meaning for its callers if they wanted to use it.
>
> And if that is what you wanted to say, I fully agree with the
> conclusion.

I really did not want to say anything except for pointing out how similar
cases were dealt with in the past. So I guess for a good comparision
we'd need to asses how similar the patches are. If they are similar
it's easier to link to the old discussion instead of retyping the same
reasons.

>
> By the way, it is not a very good comparison, though.  The patch in
> the old thread deliberately attempted to discard a useful piece of
> information.  The information the patch in this thread attempts to
> discard is not so useful, as there currently is nobody that returns
> an error in the codepath.

Isn't that a bit picky? (old thread: the information is useful, but
nobody uses it,
this thread: information is useless, and nobody uses it)

So the similarity is nobody is using the result, the difference is the
usefulness of
the information provided.

>  So in that sense, the patch in this
> thread to change the return value to void is a bit more justifiable
> than the one in the old thread, I think.

That makes sense to me.

>
> Thanks.
