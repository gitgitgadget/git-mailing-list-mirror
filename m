From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Documentation: 'cherry' does not cope well with merges
 from upstream
Date: Thu, 1 Jul 2010 19:51:47 -0500
Message-ID: <20100702005147.GA5962@burratino>
References: <1278012954-sup-3724@pimlott.net>
 <20100701210919.GA4283@burratino>
 <7vbpaq3glt.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Andrew Pimlott <andrew@pimlott.net>, git <git@vger.kernel.org>,
	=?iso-8859-1?B?RnLpZOlyaWMgQnJp6HJl?= <fbriere@fbriere.net>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jeff King <peff@peff.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 02 02:52:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OUUUS-0001x4-1K
	for gcvg-git-2@lo.gmane.org; Fri, 02 Jul 2010 02:52:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753317Ab0GBAwS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 1 Jul 2010 20:52:18 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:57455 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752745Ab0GBAwR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Jul 2010 20:52:17 -0400
Received: by iwn7 with SMTP id 7so2633183iwn.19
        for <git@vger.kernel.org>; Thu, 01 Jul 2010 17:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=QdYItn3kmBCv29reJfyTivB5pN7RMKev+qefMSabd8o=;
        b=Cgh583fRVlYutzG5RzxbO5mBVbWHAB1C7cYcd1rAutkPi6UMufEJFQXdws4e+Au/fk
         +XSGsojEr6J5DuNzvHJRfDHWuwbJP7GlLtZ+j3gFee+dY2O0XD8uP+qwp0TiVdv+EEyF
         ztsYyxYlI10sf0AlRD2Hgmxyt3KaveEV1cqLs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=ivFs8WooqA8YXCgIww9yN4kusUnkmOHAQshnPVs6O2SBfvBXmRkmebeLg3XKKAK9EO
         yLaZe769U8OumKYSKocmWZEfi5kAb5Nhgy017NrC2ndXwf6C5e+wcx8Yc6aCEgZdUaI5
         AYJrSpXadCGVkhh+lssuOR66Q4iqprUrflFJw=
Received: by 10.231.146.129 with SMTP id h1mr273949ibv.180.1278031936074;
        Thu, 01 Jul 2010 17:52:16 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id h8sm246453ibk.3.2010.07.01.17.52.14
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 01 Jul 2010 17:52:15 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vbpaq3glt.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150093>

Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:

>> Example:
>>
>>  o---o---F---X'---G---U [upstream]
>>           \        \
>>            X----Y---M---T [topic]
[...]
>> Consider the author of a different branch, also called =E2=80=98topi=
c=E2=80=99, but
>> this one starts from commit G.  Some infrastructure from an existing=
=20
>> branch is needed, so first she merges that.  Then she adds her own
>> commit.
>
> Sorry, but it is unclear to me what kind of history you have in mind =
at
> this point.  What "existing branch" are you talking about?  Presumabl=
y it
> is not the [topic] in an earlier example, nor it is [upstream] right?
>=20
> o---o---o---o----G-------.---U [upstream]
>                   \       \=20
>                    X---Y---M---T
>=20
> Something like this?

Sorry for the lack of clarity.  The "existing branch" was the history
ending at commit Y in the original picture.  The resulting topic would
have the shape of the branch labelled [topic] in my diagram.

And except for the shapes being the same, this has nothing to do with
the earlier example.

What I was trying to get at with the two examples is that in histories
like the above, the concept of "fork point" is not well defined.
Where did topic fork from upstream?  It could have been at G, or F, or
any other merge-base of upstream and topic for that matter; the
recorded history does not give enough information to say.

The choice of fork point might look like it is only for optimization,
but it affects the semantics, too.

Example: reviving a reverted patch

 ... o---F---P---R---G---o [upstream]
                      \
                       P' [alice]

Upstream, a certain patch (P) was accepted, found to introduce horrible
problems, and then reverted (R).  Patch submitter Alice still believes
that is a good patch, though, so she creates a branch to start work on
it, cherry-picking the change (P').  =E2=80=98git cherry=E2=80=99 corre=
ctly reports
P' as not merged upstream; that it has the same patch-id as commit P
is simply irrelevant.

 $ git cherry
 + P'

Alice might merge a branch with a fork point that does not have P as
an ancestor:

 ... o---o---P---R---G---o [upstream]
                      \ /
                       x
                      / \
                     o   P'
                    /     \
   ... o---o---o---F---o---M [alice]

How can =E2=80=98git cherry=E2=80=99 tell that the fork point was G?  T=
hat
knowledge determines whether P' should be considered to be merged
upstream or not:

 * If the fork point was F, then the patch for P' has been applied
   upstream since then (indirectly through the merge of G).

 * If the fork point is G, then the patch for P' was upstream all
   along, and P' has no upstream analog since then.

In reality, =E2=80=98git cherry=E2=80=99 does not choose; instead of do=
ing arithmetic
based on fork points, it just says _no_ commit reachable from the tip
of alice can be used as evidence that a patch from alice has been
merged.

Plenty of other heuristics are possible, but it is hard to find a
more intuitive efficient one.  I suspect I would find it useful to be
able to explicitly set a commit =E2=80=98prefork=E2=80=99 and examine a=
ll commits
prefork..upstream in the search for evidence that a patch has been
merged.
