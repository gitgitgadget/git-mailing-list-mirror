From: Dave Borowitz <dborowitz@google.com>
Subject: Re: Working towards a common review format for git
Date: Fri, 8 Jan 2016 09:24:43 -0500
Message-ID: <CAD0k6qRFPMZxLh4MtwkXwrk4GCjf64vWEd=9NPn-t_-uVHWz9g@mail.gmail.com>
References: <20160108140831.GA10200@salo>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>, Stefan Beller <sbeller@google.com>,
	Edwin Kempin <ekempin@google.com>
To: Richard Ipsum <richard.ipsum@codethink.co.uk>
X-From: git-owner@vger.kernel.org Fri Jan 08 15:25:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aHXyi-0003nN-Om
	for gcvg-git-2@plane.gmane.org; Fri, 08 Jan 2016 15:25:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755168AbcAHOZI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Jan 2016 09:25:08 -0500
Received: from mail-ig0-f182.google.com ([209.85.213.182]:35058 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755149AbcAHOZD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jan 2016 09:25:03 -0500
Received: by mail-ig0-f182.google.com with SMTP id t15so52651052igr.0
        for <git@vger.kernel.org>; Fri, 08 Jan 2016 06:25:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=WYtGfvRN30PqaFbRRM5fiJjirJoXQr2sUThZwmh0LIQ=;
        b=Jfis7sk3KHdLw0qKN+GvXiORNz5WI4iicqwuHJVHY+LK1lQtKGyQc0vJrkMWZsy8Az
         Ks9fesVQD3Xa0i1coDVBDRkZ6sqme0Syq52vowsA2iQ3K3aTDwx3n4zBHwiwVfyzK2qt
         aV25MPxXMNjGtJ/UoVVTielIgkjS0eJ7+0iVGeZqRN65W3WYozba5FcQVmVX92bF45HN
         M693jog5WqcRx/7FAsg27Iu+1MHWu5JgIc5tmf1lwKm90yLviqAUnmHDcFZdA/zb62Ck
         1UtssBitehSl+hTZG0sVUg9BPlQ9oTUlA12ZSt6SSn3cOhtwQgZecRx49h17PuB3Az4f
         JaXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=WYtGfvRN30PqaFbRRM5fiJjirJoXQr2sUThZwmh0LIQ=;
        b=Q2eyWBo/XH5AeS58F5XRuNpCc/9Fq2UbYv1/zbccvN+Gh3Rje/YS/kaaI4ga5nFuva
         0Uo3fpRaxNzalb2nC756Jerrdo/tnRVxjsdtSQTZpDXUkQiekazP9cS/p74EYwD4XflH
         8i9tMq83bIP4iVqBTy92UVpvc+yiMdORvWy5G+B+qgFzA9WZqqPSaADQ1xbYHxMQt/hf
         WduaVgZ1NBaxi0WPmduwuv3WlZ7eqdnQw/WRZis//MMkBrikzHDLmRPqlVzQ7V+t5gzO
         5com/K94ZU3TCP2hZxhIYtlMW96UWTfHsmTle84CK7AAaK0hAKR/U549UtXUZtZxaykP
         l4Pw==
X-Gm-Message-State: ALoCoQlQsBFBP9NDCsRMrW/mKgyg0jS6ZK39wOrIg5KWOMJCQ0KioSKJVhWqE6btNpnGgcPkq5LGrhpe2uACP2FsZghcyPmxVEdnFt7i8KVmpzbtGV1YzFw=
X-Received: by 10.50.155.39 with SMTP id vt7mr20773440igb.19.1452263102600;
 Fri, 08 Jan 2016 06:25:02 -0800 (PST)
Received: by 10.36.122.193 with HTTP; Fri, 8 Jan 2016 06:24:43 -0800 (PST)
In-Reply-To: <20160108140831.GA10200@salo>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283554>

On Fri, Jan 8, 2016 at 9:08 AM, Richard Ipsum
<richard.ipsum@codethink.co.uk> wrote:
> Hi,
>
> In a prior email I mentioned in passing a library I've been working
> on to try to reach a common format for storing review content in git:
> perl-notedb.[1]
>
> I'm making reasonable progress with this but my work has uncovered
> necessary (and trivial) modifications to Notedb, the first[2] is a
> trivial modification to ensure the 'Status' trailer gets written
> to the commit when a change's status changes.

I would consider this a bugfix, and will respond on that review.

> The second[3] is an RFC
> where I suggest adding a 'Commit' trailer so that it is always
> possible to reference the commit under review by its sha.

I think this is probably fine but I'll have to think about it some more.

> With these patches applied to gerrit it's possible for perl-notedb to parse
> all meta content from notedb and map it to the actual git content
> under review. However, my concern at present is that I'm already
> operating under a fork of notedb which defeats the objective of
> collaborating to produce a standard format, let's try to avoid[4]

I hope I can assuage some of your concerns by saying that since Gerrit
notedb is such a work in progress, literally nobody is running it in
the wild, so even if the formats diverge temporarily I don't see it as
being a long-term issue. But thank you for caring about it, I do
appreciate your proactive considerations.

> If the gerrit folks could let me know what I need to do to get
> these modifications merged, or else what we need to do to achieve
> equivalent functionality I'd really appreciate it.
>
> Thanks again,
> Richard Ipsum
>
> [1]: https://bitbucket.org/richardipsum/perl-notedb
> [2]: https://gerrit-review.googlesource.com/#/c/73436/
> [3]: https://gerrit-review.googlesource.com/#/c/73602/
> [4]: https://xkcd.com/927/
