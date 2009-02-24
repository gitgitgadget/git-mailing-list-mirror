From: =?utf-8?Q?David_K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: Re: [PATCH] git.el: Only show completions from refs/heads, refs/remotes and refs/tags
Date: Tue, 24 Feb 2009 16:57:57 +0100
Message-ID: <87y6vvu8sa.fsf@krank.kagedal.org>
References: <1235464350-23383-1-git-send-email-davidk@lysator.liu.se>
	<87fxi4ut2p.fsf@krank.kagedal.org> <87ocwrx527.fsf@wine.dyndns.org>
	<871vtnvo55.fsf@krank.kagedal.org> <87fxi3x2es.fsf@wine.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Alexandre Julliard <julliard@winehq.org>
X-From: git-owner@vger.kernel.org Tue Feb 24 17:01:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbziE-0005DU-4H
	for gcvg-git-2@gmane.org; Tue, 24 Feb 2009 17:00:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758643AbZBXP6J convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Feb 2009 10:58:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758650AbZBXP6H
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Feb 2009 10:58:07 -0500
Received: from mail.lysator.liu.se ([130.236.254.3]:45347 "EHLO
	mail.lysator.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758643AbZBXP6G (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Feb 2009 10:58:06 -0500
Received: from mail.lysator.liu.se (localhost [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id 6531740007;
	Tue, 24 Feb 2009 16:57:56 +0100 (CET)
Received: by mail.lysator.liu.se (Postfix, from userid 1674)
	id 58D194001C; Tue, 24 Feb 2009 16:57:56 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.1.7-deb3 (2006-10-05) on 
	bernadotte.lysator.liu.se
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=5.0 tests=AWL autolearn=disabled 
	version=3.1.7-deb3
Received: from krank (unknown [87.96.142.66])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTP id 2AB2F40007;
	Tue, 24 Feb 2009 16:57:56 +0100 (CET)
Received: by krank (Postfix, from userid 1000)
	id 06326DC49C; Tue, 24 Feb 2009 16:57:58 +0100 (CET)
In-Reply-To: <87fxi3x2es.fsf@wine.dyndns.org> (Alexandre Julliard's message of "Tue\, 24 Feb 2009 16\:47\:23 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111306>

Alexandre Julliard <julliard@winehq.org> writes:

> David K=C3=A5gedal <davidk@lysator.liu.se> writes:
>
>> Alexandre Julliard <julliard@winehq.org> writes:
>>
>>> David K=C3=A5gedal <davidk@lysator.liu.se> writes:
>>>
>>>> Sorry, I didn't check this properly. I thought I was fixing inside=
 the
>>>> git-checkout function, but this is git-read-commit-name which is u=
sed
>>>> in more than one place.
>>>>
>>>> But for git-checkout, I would like to see a much shorter list of n=
amed
>>>> commits, namely those that can be called "branches". I'll come up =
with
>>>> a better patch.
>>>
>>> I think it's reasonable to do this for the other uses of
>>> git-read-commit-name too, so your original patch looks OK.
>>
>> Actually, I'd like to go one step further. I'm only interested in
>> branches, and only in branches I can commit to. So only asking for
>> refs/heads seems the best solution.
>
> I think that's going too far. It's useful to be able to checkout a ta=
g,
> or to cherry-pick from a remote branch.

Cherry-pick, yes. And checkout, sometimes. My problem is that I have a
truckload of remote (svn) branches and that means I can't see the
obvious checkout candidates for all the noise.

But add "refs/remotes" and "refs/tags" to the last patch, and maybe we
have a good compromise.

--=20
David K=C3=A5gedal
