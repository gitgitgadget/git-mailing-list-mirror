From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [bug] 2.5.0 build with NO_PERL is broken
Date: Fri, 14 Aug 2015 17:15:29 -0400
Message-ID: <CAPig+cR6iT=AC8zq-vHHTkXMzRmDA-o9JLi0h8gbR1tzbqNyKA@mail.gmail.com>
References: <loom.20150814T171757-901@post.gmane.org>
	<loom.20150814T184447-932@post.gmane.org>
	<xmqq7foxiqu6.fsf@gitster.dls.corp.google.com>
	<CAPig+cR77oFo6D3f8BjAB_yM-xPt+3EUGK4vZr3eYWJGTtksAQ@mail.gmail.com>
	<xmqqoai9h9co.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Renato Botelho <garga@freebsd.org>, Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 14 23:15:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZQMK6-00078T-K1
	for gcvg-git-2@plane.gmane.org; Fri, 14 Aug 2015 23:15:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752459AbbHNVPa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Aug 2015 17:15:30 -0400
Received: from mail-yk0-f178.google.com ([209.85.160.178]:36055 "EHLO
	mail-yk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750940AbbHNVPa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Aug 2015 17:15:30 -0400
Received: by ykfw73 with SMTP id w73so26356143ykf.3
        for <git@vger.kernel.org>; Fri, 14 Aug 2015 14:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=riHS1edBYahXpmmcwfvrnGTiGLJ00DMYXhQVSQsmJZ0=;
        b=iDoMO3Mk1GvzWnlw/RWWE89/ygxnuMgZkPhkD6m9V04bDajZqA1TZoiv5Lav29MEte
         vPJBzSRn9CZBReUfvkWILnjKD8U+Bvm4dzRnitY2AFM46eoVdCDhgl149UFYskNElPHY
         M4gKHxRbim/nYvGPzJOEeZo/4lSQpNDsyNFKNB5/lGK7bMI+VlLWklIZae0X/gkKr6Jh
         aJ26i0Lsa+oBe+K+PfZd/qM4s9pe1l4VMa0XFV8Ydj2Ye5Lkxv+zCQOolDqQwdBb+V+K
         UCOgJB9poTAUZSa4nDDf3vjSLlsbi/3iJ3GYaXKKDQubzfXkjSQefOe6Nb+Wodn1+xDv
         Mvtg==
X-Received: by 10.129.70.5 with SMTP id t5mr884203ywa.4.1439586929620; Fri, 14
 Aug 2015 14:15:29 -0700 (PDT)
Received: by 10.37.208.78 with HTTP; Fri, 14 Aug 2015 14:15:29 -0700 (PDT)
In-Reply-To: <xmqqoai9h9co.fsf@gitster.dls.corp.google.com>
X-Google-Sender-Auth: -CiUjDmu3pBE2onz5h3dt1ue1Lk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275961>

On Fri, Aug 14, 2015 at 5:02 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
>> Nevertheless, there's still the problem, due to 527ec39
>> (generate-cmdlist: parse common group commands, 2015-05-21), that git
>> doesn't build at all anymore when Perl is unavailable.
>
> I do not think that is anything new.  We always have assumed "some"
> version of Perl available in order to run t/ scripts.

True, but prior to 527ec39, without Perl available, git itself could
at least be built and used (with some commands unavailable), even if
it couldn't be fully tested. As of 527ec39, however, git won't even
build because common-cmds.h can't be generated.
