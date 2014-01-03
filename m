From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 3/4] completion: fix branch.autosetup(merge|rebase)
Date: Sat, 4 Jan 2014 00:28:31 +0530
Message-ID: <CALkWK0mGJ2V9V=KzuaAraNX-edEVBEpp-9DcAaBF-dZCqp6bsw@mail.gmail.com>
References: <1388415138-11011-1-git-send-email-artagnon@gmail.com>
 <1388415138-11011-4-git-send-email-artagnon@gmail.com> <xmqqa9fendj3.fsf@gitster.dls.corp.google.com>
 <CALkWK0=tL4K7UHDBp_jGz5zUaHE9m=OESo2=2a0fUZwXB4auGg@mail.gmail.com> <xmqq1u0pnf7b.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 03 19:59:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vz9xn-00020V-81
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jan 2014 19:59:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752888AbaACS7P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jan 2014 13:59:15 -0500
Received: from mail-ie0-f173.google.com ([209.85.223.173]:41693 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751139AbaACS7O (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jan 2014 13:59:14 -0500
Received: by mail-ie0-f173.google.com with SMTP id to1so16287281ieb.4
        for <git@vger.kernel.org>; Fri, 03 Jan 2014 10:59:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=JT+jEZbUFs/ruSphQum0ml9j2Fj9kTdr5AFGZPm9xiI=;
        b=nMG9H8oAMDv0+Rmi/FwWgBTG80NNOP/+uOT4obqE1KxitIliPyTEvh3+NsASt2O4jx
         G1QkejZmIDCI/tPqx/JMRviD0womvynF/lYhy7+kktAg2+nU+VRsR9IeP20ferR9S2IX
         jRtizXOwlxoWWhRqWsdk8mB/nDsiFLhkTVIWjkeR6tP27TQq8lw4qsdW7TUn6xvn05E9
         R1yIV0GJLCynfmf7OYBP81XZJ3KOVYDZqgZJZofK9lPuL/LIpCTxilCoysBxKeQQJIiW
         T+Xy4RP+BThddx/b9tyowMO07RlQKbLLzFtKzNGzZ8Shb35lStreqM2UH2+8W5saj2lB
         DoFw==
X-Received: by 10.42.24.210 with SMTP id x18mr45936814icb.38.1388775551981;
 Fri, 03 Jan 2014 10:59:11 -0800 (PST)
Received: by 10.64.195.9 with HTTP; Fri, 3 Jan 2014 10:58:31 -0800 (PST)
In-Reply-To: <xmqq1u0pnf7b.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239925>

Junio C Hamano wrote:
> You seem to be calling it "incorrect" to give the same degree of
> completion for a branch the user named "autosetupmerge" as another
> branch "topic", but I think it is incorrect not to, so I cannot tell
> if we are agreeing or disagreeing.

No, what's incorrect is providing completions for

  $ git config branch.autosetupmerge.<TAB>

when no branch called "autosetupmerge" exists. The purpose of the hunk
(which I now removed) was to prevent such completions, but it has the
side-effect of also preventing a legitimate completion in the case
when the user really has a branch named "autosetupmerge".

What is your take on the issue?
