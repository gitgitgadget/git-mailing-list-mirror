From: Nico Williams <nico@cryptonector.com>
Subject: Re: cherry picking and merge
Date: Fri, 1 Aug 2014 17:00:49 -0500
Message-ID: <CAK3OfOiLRpz7n7rCQZ7ixahoQyt=xywnDewtc+KCT_5LhYEC7A@mail.gmail.com>
References: <51C01AAA-3CFB-4110-BAE9-7D04CA8EE53A@comcast.net>
	<20140801200201.GS12427@google.com>
	<20140801205040.GT12427@google.com>
	<CAK3OfOhbJJqLB4yPbuJyufytxNUSBLzKF6axc4jeU7eAjvXtgA@mail.gmail.com>
	<xmqq4mxvvqan.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Mike Stump <mikestump@comcast.net>,
	git discussion list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 02 00:00:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XDKsi-0004lc-Ca
	for gcvg-git-2@plane.gmane.org; Sat, 02 Aug 2014 00:00:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756458AbaHAWAv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Aug 2014 18:00:51 -0400
Received: from sub4.mail.dreamhost.com ([69.163.253.135]:38883 "EHLO
	homiemail-a110.g.dreamhost.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756443AbaHAWAv (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 Aug 2014 18:00:51 -0400
Received: from homiemail-a110.g.dreamhost.com (localhost [127.0.0.1])
	by homiemail-a110.g.dreamhost.com (Postfix) with ESMTP id C52C72007F128
	for <git@vger.kernel.org>; Fri,  1 Aug 2014 15:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=cryptonector.com; h=
	mime-version:in-reply-to:references:date:message-id:subject:from
	:to:cc:content-type; s=cryptonector.com; bh=dyQbXiggklWoO0BT2gt0
	nxH9XN4=; b=kJHvLdnPZCLkHkRNKGME8BgxGbVgkshHKsxZBgiTujEIrhxu/ETN
	jggkKB/vPZ4WqsDL6ALHgCguY2q9egJpP3qLUTaIWU9JK57+A+f3xrcNshBV+vvG
	5O4dXuUZmh66T0GNogbP2c+mye5UFg79B+qkPKmwEN4KicojLDL3uJU=
Received: from mail-wi0-f173.google.com (mail-wi0-f173.google.com [209.85.212.173])
	(using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: nico@cryptonector.com)
	by homiemail-a110.g.dreamhost.com (Postfix) with ESMTPSA id 78F032007F125
	for <git@vger.kernel.org>; Fri,  1 Aug 2014 15:00:50 -0700 (PDT)
Received: by mail-wi0-f173.google.com with SMTP id f8so2100266wiw.6
        for <git@vger.kernel.org>; Fri, 01 Aug 2014 15:00:49 -0700 (PDT)
X-Received: by 10.194.103.38 with SMTP id ft6mr11892841wjb.18.1406930449459;
 Fri, 01 Aug 2014 15:00:49 -0700 (PDT)
Received: by 10.217.98.6 with HTTP; Fri, 1 Aug 2014 15:00:49 -0700 (PDT)
In-Reply-To: <xmqq4mxvvqan.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254668>

On Fri, Aug 1, 2014 at 4:44 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Nico Williams <nico@cryptonector.com> writes:
>
>> Cherry-picks should record two parents, like merges.
>
> No.
>
> It is OK to record where it came from, and we let you do so with the
> "-x" option.
>
> But the "where it came from" commit is very different from being
> parent, which implies "all the history behind it".  The whole point
> of a cherry-pick is that you do not want to grab the changes behind
> the commit you are cherry-picking and you want the _change_ the
> cherry-picked commit (and that commit alone) brings in.  It should
> never record "two parents, like merges."

I didn't mean to imply all that.  s/parent/where it came from/, but -x
edits the commit message, not the metadata...

The point remains: to do what the OP wants git merge would have to be
able to notice that a given commit was cherry-picked from the other
branch, and what commit it was on that other branch, and right now the
only place where that information is available is in the reflog.
Recording that metadata somewhere in the commit resulting from the
cherry-pick would be better.

Nico
--
