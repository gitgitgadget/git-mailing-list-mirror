From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: Re: [PATCH] sequencer.c: abbreviate hashs placed in the middle of messages
Date: Fri, 8 May 2015 21:56:58 +0200
Message-ID: <CAN0XMO+ZY-oXb1aWK3TzUxDRuBEEoasxjdagYQQoB+JVheju9Q@mail.gmail.com>
References: <1431104035-2056-1-git-send-email-ralf.thielow@gmail.com>
	<CAPig+cSeNn0r7N6vp+qs4NTNwfYx5p-zUX3tkifuXLu+nB2yNQ@mail.gmail.com>
	<xmqqbnhvm1f5.fsf@gitster.dls.corp.google.com>
	<CAN0XMOKPbKUMwU5-T78m_knt=9O2GkKaqmXKViSi5k-Z7Damrg@mail.gmail.com>
	<xmqqtwvmlxlo.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 08 21:57:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YqoOQ-0003PE-Lx
	for gcvg-git-2@plane.gmane.org; Fri, 08 May 2015 21:57:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752813AbbEHT5B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 May 2015 15:57:01 -0400
Received: from mail-wi0-f170.google.com ([209.85.212.170]:38189 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751283AbbEHT5A (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 May 2015 15:57:00 -0400
Received: by wiun10 with SMTP id n10so38750458wiu.1
        for <git@vger.kernel.org>; Fri, 08 May 2015 12:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=A6IFNUhBZ58FFu8bdUsBCR4ykwaMyjxdqrs1aD4KKH4=;
        b=iDGT/ZnbYLcaD9ywOcJvll/845lpIml+8cOlVyNLv2Z5G2BdbXITC0fb77jdFIsVbh
         eYUS7U6KfUpSBjqTF4NkQwT1ipv9MDAyNDJMURr9guYnDehYarNtyY/q7AbUrcQBiIzF
         RdEO/gzR9rLb3UfsUt05bwtNSYSxoZ8mBJpumsQOZPkkZMCLzbkAxAiS4mbZ1MBU/vL4
         a3gftEq2wZKOy8cyXsPhE6qp9po4+v2pbZdqFixZw2OXtzlawj243jD+SvK/fFehmgAP
         npBfaTCM/jFqZ/7VVepVA6OkNx59oJMQsKeBELH8I7OeWyf4zVM7EDes4SGeqe+eWWZ7
         ss1Q==
X-Received: by 10.194.79.135 with SMTP id j7mr10620407wjx.0.1431115018896;
 Fri, 08 May 2015 12:56:58 -0700 (PDT)
Received: by 10.194.72.6 with HTTP; Fri, 8 May 2015 12:56:58 -0700 (PDT)
In-Reply-To: <xmqqtwvmlxlo.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268654>

Junio C Hamano <gitster@pobox.com> wrote:

> And shortening the output feels to me a more expedient thing to do
> because we do not have to analyse the ramification of possible
> information loss (your "It has value since...").  If we analyse the
> issue well, we might realize that there is little point in showing
> the commit object name in hexadecimal, be it in full or in shortened
> form.
>
> If the proposal were to parrot what the user typed on the command
> line, e.g. one of these (or their rephrased versions)
>
>         error: commit 'next' is a merge but no -m option was given.
>         error: no -m option was given to pick a merge 'next'.
>
> against the above example, then I would say that would be an
> improvement, but that is not what is being discussed, so...

Commits to be merged don't have to be branches.

OK. So let's stay with 40 character hash in the messages.
