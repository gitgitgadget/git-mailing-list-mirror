From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: Proposal: branch.<name>.remotepush
Date: Sat, 9 Feb 2013 00:12:16 +0530
Message-ID: <CALkWK0kR-KWJbG_kWSf7+JMJEQc7vO0Emx=_yogCB0jMBfccAg@mail.gmail.com>
References: <CALkWK0nA4hQ0VWivk3AVVVq8Rbb-9CpQ9xFsSOsTQtvo4w08rw@mail.gmail.com>
 <5113E849.8000602@elegosoft.com> <CALkWK0=53riU3xKbKkyAVS8--9VoAU5P6h88MQ9-geW=H5+a-w@mail.gmail.com>
 <20130207233017.GD19397@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Michael Schubert <mschub@elegosoft.com>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 08 19:43:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3sua-0003ad-Bh
	for gcvg-git-2@plane.gmane.org; Fri, 08 Feb 2013 19:43:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760192Ab3BHSmh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2013 13:42:37 -0500
Received: from mail-oa0-f45.google.com ([209.85.219.45]:45252 "EHLO
	mail-oa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758314Ab3BHSmh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2013 13:42:37 -0500
Received: by mail-oa0-f45.google.com with SMTP id o6so4416198oag.32
        for <git@vger.kernel.org>; Fri, 08 Feb 2013 10:42:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=STXswUfU+/tyJ+sig3SGOxLkxjJMVsbqk0LFMyr/HU4=;
        b=rBAM+MejRHZWGTyPAhDQ6l1HR6z0PihrI/S/d/EZskh/aJMR9Isc40d0MVm7R1s1qo
         P/HByiRTiXnyP+82xTzX2/owiPwLTNfir8YtzM2Ra5+t1QMqcGUnw3SX31u4Zo6gCU/V
         uKVsUoXG1XUaGL9pamf897nUe+PKWj7KXhQmAOys5KMF+CS206fb6I8EyGponboBBpPL
         cpPrrb0ANjvFxYXtz8do5xn4cNTGzXpJgyFP+Bs4re5QqvXj9cN7w8Lf4J8j4Q6P9G5z
         nxSKI3opz38ymuDF2RIGChiMH96zFP9JStWYszLjTwYZIuRxsyTuljyC3eF1Jdochnv3
         J1zw==
X-Received: by 10.182.157.44 with SMTP id wj12mr4921260obb.41.1360348956735;
 Fri, 08 Feb 2013 10:42:36 -0800 (PST)
Received: by 10.76.128.79 with HTTP; Fri, 8 Feb 2013 10:42:16 -0800 (PST)
In-Reply-To: <20130207233017.GD19397@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215800>

Jonathan Nieder wrote:
> Ramkumar Ramachandra wrote:
>
>> And yes, a regular `git push origin refs/for/master` is just retarded.
>
> The usual incantation is "git push gerrit HEAD:refs/for/master".  Is
> the code review creation push that uses a different branchname from
> the branch the integrator pulls what seems backward, or is it the need
> to specify a refname at all on the command line?

How else would you design a system to differentiate between a
push-for-review, and push-to-update-ref?

On a slightly unrelated note, it would be nice if we could streamline
the git-format-patch, git-send-email process.  Let's say we make it a
push', which has a pre-hook that fires up the $EDITOR for a cover
letter.  Wouldn't you love it if this push' would update refs on your
private fork and fire off emails to the Git List?  Bonus for contrib/:
fetch the Google address book, and allow me to auto-complete names
when sending emails.

> I agree that a "[branch "master"] pushremote" configuration would be
> handy.  pushremote instead of remotepush to be less surprising to
> people who have already seen pushurl.

Thanks for that, by the way (used in RFC patch).  My taste in variable
names is a little sour.
