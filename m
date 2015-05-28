From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC 2/2] git rebase -i: Warn removed or dupplicated commits
Date: Thu, 28 May 2015 09:53:13 -0700
Message-ID: <xmqqfv6giqyu.fsf@gitster.dls.corp.google.com>
References: <1432676318-22852-1-git-send-email-remi.galan-alfonso@ensimag.grenoble-inp.fr>
	<1432676318-22852-2-git-send-email-remi.galan-alfonso@ensimag.grenoble-inp.fr>
	<CAPig+cQJMSjS=fiwMHE93efSsa2QYQ8TphyyfcLg7kAXRi_+cw@mail.gmail.com>
	<579982712.39028.1432732759119.JavaMail.zimbra@ensimag.grenoble-inp.fr>
	<xmqq1ti1n825.fsf@gitster.dls.corp.google.com>
	<1388345544.70438.1432799047393.JavaMail.zimbra@ensimag.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>,
	Git List <git@vger.kernel.org>
To: Remi Galan Alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu May 28 18:53:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yy13i-0001vN-Tq
	for gcvg-git-2@plane.gmane.org; Thu, 28 May 2015 18:53:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754419AbbE1QxY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 May 2015 12:53:24 -0400
Received: from mail-ie0-f171.google.com ([209.85.223.171]:35931 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754169AbbE1QxQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 May 2015 12:53:16 -0400
Received: by iepj10 with SMTP id j10so42912711iep.3
        for <git@vger.kernel.org>; Thu, 28 May 2015 09:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=bH37EyRB3sPHrustFgmHtOMMKhPFtHSeGW5azCZaksA=;
        b=hG6VpN5iHleZgdtKc6o6ZpgcPbeloI31KF08UqH3TaVYdidhC8CivKg41g0x4SdJGo
         jlkB6eyXc6LPToQnMxIOZFZ0u7SShvKPPvXCL/bIXHR38wwW2zPi1xhdp3OiT3MXnFve
         F0MR/WBbK1KlN3x4w+apu+d5n3+oYmtxZb2RvaEM90ypvLEzYY6WYF8zrpjNw/g9giY6
         YqwhX+G6q7grggddygJgg2folqpPxU2nLLzxyrnW0kZelmyYigLYo07IgfwZoDt0egJO
         Y8WHJ6JGP5rsfSySUc7CjGdUe6SpbO0MLt57H7qjwY+Y4/Zucn/h2BzLnNPr8KtXcIGf
         t/7g==
X-Received: by 10.42.240.82 with SMTP id kz18mr5842188icb.92.1432831995147;
        Thu, 28 May 2015 09:53:15 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:91c7:752b:4513:7344])
        by mx.google.com with ESMTPSA id d185sm2131444ioe.42.2015.05.28.09.53.14
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 28 May 2015 09:53:14 -0700 (PDT)
In-Reply-To: <1388345544.70438.1432799047393.JavaMail.zimbra@ensimag.grenoble-inp.fr>
	(Remi Galan Alfonso's message of "Thu, 28 May 2015 09:44:07 +0200
	(CEST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270159>

Remi Galan Alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>
writes:

> Junio C Hamano <gitster@pobox.com> writes:
>> I think there is a difference between (silently) accepting just to
>> be lenient and documenting and advocating mixed case uses.
>> 
>> Personally, I'd rather not to see gratuitous flexibility to allow
>> the same thing spelled in 47 different ways for no good reason.
>
> It was more of a mistake on our part rather than actually wanting to
> document mixed case uses.
>
> In the v2 of the patch (not sent to the mailing list yet since we want
> to take into consideration the conclusion of this discussion before)
> it is entirely in lower case in both the documentation and the code
> while we silently allow upper and mixed case.

Understood; I am not sold on the whole "warning" business, though.

I think I saw you did 'tr [:upper:]' or something like that in the
patch; we tend to avoid [:class:] and [=equiv=] when not needed,
unless we know that the matching engine used supports them (i.e. it
is OK to use them in Perl scripts and it is OK to feed them to the
wildmatch-based matcher in Git itself, but not in general shell
scripts).  As the values can all be represented in US-ASCII, it
should be sufficient to do "tr 'A-Z' 'a-z'", I would think.
