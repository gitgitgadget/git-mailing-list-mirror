From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: Draft of Git Rev News edition 5
Date: Mon, 6 Jul 2015 13:24:40 -0400
Message-ID: <CAPig+cTfkDqSDRqDjA=CNkT1c7Fo0zaLiwi2bAbCLZxPHi5=Bg@mail.gmail.com>
References: <CAP8UFD2fpRiOmgL9GW-1N9ZLAY+p-nOSH-b57vJFO4e_tELrWw@mail.gmail.com>
	<20150705191101.GB9815@flurp.local>
	<xmqqa8v92qdf.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Christian Couder <christian.couder@gmail.com>,
	git <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Thomas Ferris Nicolaisen <tfnico@gmail.com>,
	Nicola Paolucci <npaolucci@atlassian.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 06 19:24:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCA8N-0003GW-66
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jul 2015 19:24:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753904AbbGFRYm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jul 2015 13:24:42 -0400
Received: from mail-yk0-f180.google.com ([209.85.160.180]:36388 "EHLO
	mail-yk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753881AbbGFRYl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jul 2015 13:24:41 -0400
Received: by ykdr198 with SMTP id r198so154445689ykd.3
        for <git@vger.kernel.org>; Mon, 06 Jul 2015 10:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=dii9zp9mR01CanqPKB43S4VJWxFxrDYg/JIWxH7QzpM=;
        b=pOgC1fBvsqtkfDiIy+kH2hvjKn5wFjHc9sj3qnYL0kZtXmKZPldvCoZDc8DesiP4rl
         2chOcmFVxJl285FDO1v2R1QHCu52P3uDZh33bbSRvwh8RSBZojLABQO5p0bjpDjkQfeI
         shC2apBb8+ZkI7dQea3TcFscrS2NSOQUMsbPQ1b7PBkgbjSMs/tAPCtkDeSpWP4Rw5+1
         6wmJC8dmb12yjay39XiM25yXKT3g8Fu+L0zsTJWYfEKy8fsNUu1s6C6EheDmizaoHcao
         C/5xyYhaDt+T0xO/CSy1rUerswpVSOqicDtzrfwE6guv17CSYP0islsr1w/oGFxBn6+g
         /U7Q==
X-Received: by 10.170.138.134 with SMTP id f128mr60889387ykc.90.1436203480516;
 Mon, 06 Jul 2015 10:24:40 -0700 (PDT)
Received: by 10.37.12.129 with HTTP; Mon, 6 Jul 2015 10:24:40 -0700 (PDT)
In-Reply-To: <xmqqa8v92qdf.fsf@gitster.dls.corp.google.com>
X-Google-Sender-Auth: aLl3iOkghXqVO0naX2OYHkcrINw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273411>

On Mon, Jul 6, 2015 at 12:38 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
>> I'm not familiar with the criteria for deciding what merits mention
>> in the newsletter. Is the recent introduction of git-worktree and the
>> attendant relocation of "add" and "prune" functionality worthy? If
>> so, perhaps the following write-up would be suitable?
>
> One issue I had with this text was that it was not immediately clear
> what the end-game UI of the feature was.  Is "checkout --to" they
> way the user is expected to trigger this?  It appears in the very
> early part of the multi-paragraph description and I suspect that the
> majority of the users would think that way, not with "worktree add"
> that appears a lot later.

I had the same concern when proof-reading, but wasn't sure if the
concern was warranted. Since you reacted to the text in the same way,
I'd say the concern was justified.

How about this instead: prefixing with "As originally implemented",
with a couple s/is/was/ thrown in...

    As originally implemented, creation of linked-worktrees was
    accomplished via `git checkout --to <path> <branch>`, and cleanup
    of leftover administrative files, after `<path>` is deleted, was
    done with `git prune --worktrees`. However, a recent unrelated
    change to `git prune` led to a discussion that concluded that
    worktree-related maintenance functionality didn't belong in `git
    prune`.

Is that sufficient to clue in the reader that "checkout --to" is not
final form, or should we mention "worktree add" and "worktree prune"
upfront?
