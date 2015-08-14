From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [bug] 2.5.0 build with NO_PERL is broken
Date: Fri, 14 Aug 2015 18:25:48 -0400
Message-ID: <CAPig+cQkApWfZ6N159F-XFZk+nnzY-gAgLRfZXNitdd0CHpm2g@mail.gmail.com>
References: <loom.20150814T171757-901@post.gmane.org>
	<loom.20150814T184447-932@post.gmane.org>
	<xmqq7foxiqu6.fsf@gitster.dls.corp.google.com>
	<CAPig+cR77oFo6D3f8BjAB_yM-xPt+3EUGK4vZr3eYWJGTtksAQ@mail.gmail.com>
	<xmqqoai9h9co.fsf@gitster.dls.corp.google.com>
	<CAPig+cR6iT=AC8zq-vHHTkXMzRmDA-o9JLi0h8gbR1tzbqNyKA@mail.gmail.com>
	<xmqqzj1tfr2g.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Renato Botelho <garga@freebsd.org>, Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 15 00:25:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZQNQ9-0007Q2-GA
	for gcvg-git-2@plane.gmane.org; Sat, 15 Aug 2015 00:25:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751349AbbHNWZt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Aug 2015 18:25:49 -0400
Received: from mail-yk0-f171.google.com ([209.85.160.171]:35522 "EHLO
	mail-yk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750735AbbHNWZs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Aug 2015 18:25:48 -0400
Received: by ykbi184 with SMTP id i184so16888627ykb.2
        for <git@vger.kernel.org>; Fri, 14 Aug 2015 15:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=E5uPhyFYquh4CfjU8PCVdXHcOiH1cy32N77yxN+iuRw=;
        b=PTpH6OM7akj8MXY2N3OGl8ZWRATqL+0IDoDqn/mA1Z00WL3SeryaljZI0USMk8w2hk
         XUtW83nq6Ps1v5fG3KvrteytbBQ4ZbHS/i0JGygX6X5Ia0qDPAW1Ly/okCVLTRZKekHH
         89K/5ba2Uy8Tq5AheaXmNYJfJQ1JcR6fkqz5Wv/A9FtcUVGZb6zrmDuy/vv8bZJxCmWZ
         91U+sG/yvbScLoSVCdskjF6K6SxnnRuVO7GAyKaxS9A3r2yAZO/dILhlov92CbyFJD4S
         uuXbMR9H+LJ3XN+aQu1+tqr8HI09vKBCzYIc6R0pnLFoc1q5vOOgoLAcRpw9q2w4MIs4
         Y9Kg==
X-Received: by 10.129.88.9 with SMTP id m9mr11104776ywb.147.1439591148108;
 Fri, 14 Aug 2015 15:25:48 -0700 (PDT)
Received: by 10.37.203.6 with HTTP; Fri, 14 Aug 2015 15:25:48 -0700 (PDT)
In-Reply-To: <xmqqzj1tfr2g.fsf@gitster.dls.corp.google.com>
X-Google-Sender-Auth: lcbuiw2nxBc5GFLYeWtaLNL3RWw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275969>

On Fri, Aug 14, 2015 at 6:22 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
>
>> On Fri, Aug 14, 2015 at 5:02 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>> Eric Sunshine <sunshine@sunshineco.com> writes:
>>>> Nevertheless, there's still the problem, due to 527ec39
>>>> (generate-cmdlist: parse common group commands, 2015-05-21), that git
>>>> doesn't build at all anymore when Perl is unavailable.
>>>
>>> I do not think that is anything new.  We always have assumed "some"
>>> version of Perl available in order to run t/ scripts.
>>
>> True, but prior to 527ec39, without Perl available, git itself could
>> at least be built and used (with some commands unavailable), even if
>> it couldn't be fully tested. As of 527ec39, however, git won't even
>> build because common-cmds.h can't be generated.
>
> I wouldn't bother digging in the history myself, but I am reasonably
> sure that the current genereate-common-cmds is not the sole instance
> that we relied on Perl to build (not test) in the past, and that is
> another reason why I do not think this is anything new.

Hmm. In my tests by setting PERL_PATH to a bogus (non-existent)
command, prior to 527ec39, git builds successfully, whereas, following
527ec39, it does not build. But, perhaps I overlooked something...(?)
