From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH] commit: Add -f, --fixes <commit> option to add Fixes: line
Date: Sat, 2 Nov 2013 13:54:52 +0100
Message-ID: <CAP8UFD0RvFo9cHm56+_HFOt2NOvqF0i=65irYd_0-TUbKm4WBA@mail.gmail.com>
References: <20131024122255.GI9378@mwanda>
	<20131024122512.GB9534@mwanda>
	<20131026181709.GB10488@kroah.com>
	<20131027013402.GA7146@leaf>
	<526CA7D4.1070904@alum.mit.edu>
	<20131027071407.GA11683@leaf>
	<874n83m8xv.fsf@linux-k42r.v.cablecom.net>
	<20131027092019.GB13149@leaf>
	<CALKQrgc7a+p5eebJErcGdA3QDyvdHEaef36RhZocQp9LjDUeeg@mail.gmail.com>
	<CAP8UFD3MZJKWUbdZqrSwoatpnx73MTpiwSkxPHYDagGjMSqJNw@mail.gmail.com>
	<CALKQrgcgfimZRJL7WyS-brqEZnHJkJjK_0cqe6-7HWkuCW6Dzw@mail.gmail.com>
	<CAP8UFD1eTmUGt7dWAP-Ws17op=z98hOvBa_g8_y=xS8WQ1dRMg@mail.gmail.com>
	<CALKQrgdo=RP6vgCUML_L_NPsvSbg8Lyjy4HqmWYXk+NmWOjCvw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Josh Triplett <josh@joshtriplett.org>,
	Thomas Rast <tr@thomasrast.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Git mailing list <git@vger.kernel.org>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Greg KH <greg@kroah.com>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Sat Nov 02 13:55:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vcajb-0008MI-SH
	for gcvg-git-2@plane.gmane.org; Sat, 02 Nov 2013 13:55:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752473Ab3KBMy4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Nov 2013 08:54:56 -0400
Received: from mail-ve0-f171.google.com ([209.85.128.171]:48621 "EHLO
	mail-ve0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752428Ab3KBMyz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Nov 2013 08:54:55 -0400
Received: by mail-ve0-f171.google.com with SMTP id pa12so379914veb.16
        for <git@vger.kernel.org>; Sat, 02 Nov 2013 05:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=dnghBjlckOhEZPRXBfC3xo1YVbwL4xl/4AegQ4tiTz0=;
        b=IHE6YWAxnEyB+VsH3iqee+IWC6lLi8QQH1g9BavcoGzJDt84SY/sD9SNvGpVQVhdWO
         HzshzEdm7UJkloZ76Z6Ph3ZOBCUt7YNZxzv9o32MBcFDeNj2ifCXf03EWcjsNlACZ92D
         5kQDbqAsdE/7dU4d7NzmBYZdJ+ykqzb9W7HmKd//UgnLzHJUu7qns6icTSfQJw3XfOkT
         Z9J2yA/7yunBdLfwthjd0O+FPsBI3Q+nSSS53NMj0EXRItjidVjd89RBRtW03MorP858
         4uxn4ZgaidAJk8Tz8wOU23E22deUZVbnCv1t1gh9c+8x42zzJFgRVjaal8TRKHmQ/WDq
         AOOQ==
X-Received: by 10.52.98.194 with SMTP id ek2mr4080495vdb.11.1383396892450;
 Sat, 02 Nov 2013 05:54:52 -0700 (PDT)
Received: by 10.58.253.136 with HTTP; Sat, 2 Nov 2013 05:54:52 -0700 (PDT)
In-Reply-To: <CALKQrgdo=RP6vgCUML_L_NPsvSbg8Lyjy4HqmWYXk+NmWOjCvw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237242>

On Wed, Oct 30, 2013 at 8:07 PM, Johan Herland <johan@herland.net> wrote:
> On Tue, Oct 29, 2013 at 7:23 AM, Christian Couder
> <christian.couder@gmail.com> wrote:
>>
>> I don't agree. Git doesn't need to dictate anything to be able to do
>> these expansions.
>> Git only needs some hints to do these expansions properly and it could
>> just look at the commit template, or the config, to get those hints.
>>
>> For example, if there is a "Acked-by:" line in the commit template,
>> then Git might decide that "ack" means "Acked-by", and then that "-by"
>> means that "Peff" should be related to an author, and then that it is
>> probably "Jeff King <peff@peff.net>".
>
> I don't like putting that much Magic into core Git... Especially not
> into builtin/commit.c. However, if we - as you suggest further below -
> put it into a separate helper, and we make that helper available (and
> usable) from elsewhere (most importantly from hooks where
> people/projects can add their own more specific functionality), then I
> don't have a problem with it.

Ok, great! I started working on "git interpret-trailers" and I will
post an RFC patch soon.
It will support both configuration as Junio suggested and reading a
commit template file as you suggested.

>> Ok, let's call the new plumbing command "git interpret-trailers".
>> And let's suppose that "git commit" is passed "-f ack:Peff -f
>> fix:security-bug" (or "--trailer ack=Peff --trailer
>> fix=security-bug").
>>
>> "git commit" would then call something like:
>>
>> git interpret-trailers --file commit_message_template.txt 'ack:Peff'
>> 'fix:security-bug'
>>
>> And this command would output:
>>
>> ------------------
>> <<<upper part of commit_message_template.txt>>>
>>
>> Fixes: 1234beef56 (Commit message summmary)
>> Reported-by:
>> Suggested-by:
>> Improved-by:
>> Acked-by: Jeff King <peff@peff.net>
>> Reviewed-by:
>> Tested-by:
>> Signed-off-by: Myself <myself@example.com>
>> ------------------
>>
>> Because it would have looked at the commit template it is passed and
>> filled in the blanks it could fill using the arguments it is also
>> passed.
>>
>> "git commit" would then put the above lines in the file that it passes
>> to the prepare-commit-msg hook.
>>
>> Then the prepare-commit-msg could just do nothing.
>>
>> After the user has edited the commit message, the commit-msg hook
>> could just call:
>>
>> git interpret-trailers --trim-empty --file commit_message.txt
>>
>> so that what the user changed is interpreted again.
>>
>> For example if the user changed the "Reviewed-by:" line to
>> "Reviewed-by: Johan", then the output would be:
>>
>> ------------------
>> <<<upper part of commit_message.txt>>>
>>
>> Fixes: 1234beef56 (Commit message summmary)
>> Acked-by: Jeff King <peff@peff.net>
>> Reviewed-by: Johan Herland <johan@herland.net>
>> Signed-off-by: Myself <myself@example.com>
>> ------------------
>>
>> And that would be the final commit message in most cases.
>
> This approach looks OK to me, as long as we make sure that this
> functionality is (a) optional, (b) flexible/reusable from hooks, and
> (c) not bound tightly to core Git (and AFAICS, your proposal is just
> that). As I said above, this stuff certainly does not belong in
> builtin/commit.c...

Ok, I think it will be very easy to do all with "git interpret-trailers".

Best regards,
Christian.
