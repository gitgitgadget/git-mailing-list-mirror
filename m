From: Nico Williams <nico@cryptonector.com>
Subject: Re: Amending merge commits?
Date: Wed, 30 Jul 2014 12:43:14 -0500
Message-ID: <CAK3OfOgcO9dmePtXCu9gUSf2bdQytJf9-RCZDXhv9Gy8UVyDOQ@mail.gmail.com>
References: <CAK3OfOjr6ej5VdGU=bLmtag9cca1=ogLxVakCFTMG7b-A2uBiA@mail.gmail.com>
	<87r4147agk.fsf@osv.gnss.ru>
	<CAK3OfOhFzbUA7gZbox84W=VC+0aSuiNc-XRP_MTyYy1UeFFzZQ@mail.gmail.com>
	<87siljxmnh.fsf@osv.gnss.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	"Besen, David" <david.besen@hp.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Sergei Organov <osv@javad.com>
X-From: git-owner@vger.kernel.org Wed Jul 30 19:43:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XCXuP-0002aN-CE
	for gcvg-git-2@plane.gmane.org; Wed, 30 Jul 2014 19:43:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755856AbaG3RnS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jul 2014 13:43:18 -0400
Received: from sub4.mail.dreamhost.com ([69.163.253.135]:42428 "EHLO
	homiemail-a31.g.dreamhost.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755810AbaG3RnQ (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 30 Jul 2014 13:43:16 -0400
Received: from homiemail-a31.g.dreamhost.com (localhost [127.0.0.1])
	by homiemail-a31.g.dreamhost.com (Postfix) with ESMTP id E1C9D20202C
	for <git@vger.kernel.org>; Wed, 30 Jul 2014 10:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=cryptonector.com; h=
	mime-version:in-reply-to:references:date:message-id:subject:from
	:to:cc:content-type; s=cryptonector.com; bh=iXLoHxMFLxz0csviZ6uq
	y9YZynU=; b=V5ymGM/3AmEOfikllg8nh1dy7DcBxj8dUWs/d6bJDLP0jPkkgHuK
	RXcsHymy2JTvMS3sXhcqH60ej7tbRNXeVwBEA/BQ9l5Ci17HqPtIvuKjNns9LZ24
	qczFV2k1DBlR22HK1OS8QgL+Elk8FKmfgMb0bI4DlUVmiC+wO/FJaAw=
Received: from mail-we0-f176.google.com (mail-we0-f176.google.com [74.125.82.176])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: nico@cryptonector.com)
	by homiemail-a31.g.dreamhost.com (Postfix) with ESMTPSA id 89DAC202022
	for <git@vger.kernel.org>; Wed, 30 Jul 2014 10:43:15 -0700 (PDT)
Received: by mail-we0-f176.google.com with SMTP id q58so1565571wes.7
        for <git@vger.kernel.org>; Wed, 30 Jul 2014 10:43:14 -0700 (PDT)
X-Received: by 10.180.39.73 with SMTP id n9mr8156486wik.70.1406742194281; Wed,
 30 Jul 2014 10:43:14 -0700 (PDT)
Received: by 10.217.98.6 with HTTP; Wed, 30 Jul 2014 10:43:14 -0700 (PDT)
In-Reply-To: <87siljxmnh.fsf@osv.gnss.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254503>

On Wed, Jul 30, 2014 at 3:42 AM, Sergei Organov <osv@javad.com> wrote:
> Nico Williams <nico@cryptonector.com> writes:
>> Local merge commits mean that you either didn't rebase to keep all
>> your local commits on top of the upstream, or that you have multiple
>> upstreams (the example exception I gave).
>
> I rather have multiple (release) branches on single upstream, say, v2.3
> and v2.4. When something needs to be fixed in 2.3, it's fixed there and
> pushed upstream, then, on 2.4, the 2.3 is merged to it, and result is
> pushed upstream. When I do this merge, I need to push the merge

Hmm, why not cherry-pick the fix?  That's how every project I know
that ports fixes across release branches does it.

> upstream, and this won't work reliably when --rebase=true is acitve
> (through pull.merge=rebase). If nothing changes upstream, I can simply
> push this, and the merge is correctly preserved. However, if somebody
> makes any changes upstream while I perform the merge, I'll need to pull
> before pushing, and this immediately flattens-out my merge, that is
> absolutely not what is needed here. Or I can simply pull before push,
> just in case, and this flattens history even when there are no any
> changes upstream!

Does this change if you give your merge commits an different commit message?

>> Conversely, if you always rebase your local commits on top of the
>> upstream then you won't have merge commits to worry about.
>
> Wrong. I do alwys rebase my local commits on top of upstream, but I
> still do have my own merge commits to worry about, as explained above.

If you cherry-pick the cross-release-branch commits you'll not have a
merge commit to worry about.

Nico
--
