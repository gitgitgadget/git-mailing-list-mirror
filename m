From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] HOME must be set before calling git-init when creating
 test repositories
Date: Fri, 25 Mar 2011 22:01:55 +0100
Message-ID: <AANLkTimQzPVOWCUx1hr+DEmRfdFB8=UeY_xCaxzVSwFy@mail.gmail.com>
References: <20110325200528.GA7302@blimp.localdomain> <7vsjub53j2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 25 22:02:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q3E9S-0005Qk-51
	for gcvg-git-2@lo.gmane.org; Fri, 25 Mar 2011 22:02:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755197Ab1CYVCT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Mar 2011 17:02:19 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:38712 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755192Ab1CYVCQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Mar 2011 17:02:16 -0400
Received: by bwz15 with SMTP id 15so1197989bwz.19
        for <git@vger.kernel.org>; Fri, 25 Mar 2011 14:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=OB1nmqDtTUJI86XLsBrQhn+2tPd8dpsXTtRIi5Ntwvo=;
        b=RJ07ldtb06Ljo0yv99m4ywFsaSbHL0Jl+X8AjoEBoY/BzcS3b6TRoPDQdxK6CjEjyw
         x/AWOPixPznqCRcFs0lNsHoq7InjD6KPCI1UY3K+Ra8RRIRXQ4CLa2hyzDiYxkWFSeHX
         SxkjxWJCpOrnEuJcvV2y/66YtHk4BCQ9lSqKY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=FmX9zyHX4aJQ3tX6gC5nSU5QbL4Yy8wUFjfGcVu9WtT30xKAz7SnXn4zmDCpMOpQK/
         7T8N70N1hvo5djN1xVhITkjana3u24sjujt9aaOpvc5zkgQF9Z05nfKdPGZWQioBWI8l
         wKgEgMIOt6eAktk8TM6feqCa66cZYr+AQYkag=
Received: by 10.204.83.228 with SMTP id g36mr1222175bkl.30.1301086935108; Fri,
 25 Mar 2011 14:02:15 -0700 (PDT)
Received: by 10.204.29.2 with HTTP; Fri, 25 Mar 2011 14:01:55 -0700 (PDT)
In-Reply-To: <7vsjub53j2.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170018>

On Fri, Mar 25, 2011 at 21:49, Junio C Hamano <gitster@pobox.com> wrote:
> Alex Riesen <raa.lkml@gmail.com> writes:
>
>> Otherwise the created test repositories will be affected by users ~/.gitconfig.
>> For example, setting core.logAllrefupdates in users config will make all
>> calls to "git config --unset core.logAllrefupdates" fail which will break
>> the first test which uses the statement and expects it to succeed.
>
> Doesn't this change the location of HOME used during the test as well?
>

As long as the test only includes test-lib.sh only once - it doesn't.
Why? Or rather, how?
