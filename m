From: Jed Brown <jed@59A2.org>
Subject: Re: git branch: multiple --merged and --no-merged options?
Date: Fri, 22 Mar 2013 21:46:42 -0500
Message-ID: <8738vmu92l.fsf@59A2.org>
References: <87fvzwmp23.fsf@59A2.org> <20130322175034.GB29011@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Mar 23 03:47:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UJEUD-0002Sp-EL
	for gcvg-git-2@plane.gmane.org; Sat, 23 Mar 2013 03:47:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423159Ab3CWCqq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Mar 2013 22:46:46 -0400
Received: from mail-ia0-f170.google.com ([209.85.210.170]:40160 "EHLO
	mail-ia0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422859Ab3CWCqp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Mar 2013 22:46:45 -0400
Received: by mail-ia0-f170.google.com with SMTP id h8so4124691iaa.15
        for <git@vger.kernel.org>; Fri, 22 Mar 2013 19:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:sender:from:to:cc:subject:in-reply-to:references
         :user-agent:date:message-id:mime-version:content-type;
        bh=IQeJ21cc8iSIRAEY362E9G9QiypPg60YkG+mZMZGoe4=;
        b=GS4C5ji2Ouq8PeP4qvKbERKjnlwxdIAm2Wy2jzkaC3M+dvp/tvJBs8ABItNpQMwMGj
         lmKPri1eRi2tp+8/u88m29RfMm/K51BzWBHTddxkFzKobBJ4S50wjs0b/9zEha+PgxVK
         /qxaCSbruUh1BLQ3BDhUtQKfECQWdFIuRk9JHpsmMUzLiABXj2ixQrr/xVXq8D9+Hh+9
         DWVNI9kxwVSjEK58yv6W8Ak+CkY0wbdoG/W1uf6yOa5RfSSSlSFX7QAsIHKEoRm/Z9j0
         lmJLCFOrjtY/KkXXfJOQDUpOWY3RswsTj1I1VQ6lyVCKoKADhLZPdbUL9iMnlDpylsen
         7fHw==
X-Received: by 10.50.212.3 with SMTP id ng3mr2803589igc.43.1364006804724;
        Fri, 22 Mar 2013 19:46:44 -0700 (PDT)
Received: from batura ([38.69.41.96])
        by mx.google.com with ESMTPS id y5sm5407224igg.7.2013.03.22.19.46.42
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 22 Mar 2013 19:46:44 -0700 (PDT)
In-Reply-To: <20130322175034.GB29011@sigill.intra.peff.net>
User-Agent: Notmuch/0.15 (http://notmuchmail.org) Emacs/24.3.1 (x86_64-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218877>

Jeff King <peff@peff.net> writes:

> On Fri, Mar 15, 2013 at 02:38:12PM -0500, Jed Brown wrote:
>>   $ git branch --no-merged master --merged next
>
> Yeah, sadly that does not work, as we use the same slot for the flag and
> store only one of the two (and we also allow only one "--merged" head,
> even though you could in theory want to know "merged to X, or merged to
> Y").

Hmm, I would have said conjunction (AND) was more natural than
disjunction (OR). If we add support for multiple '--merged' and
'--no-merged', do we expect to eventually have a full query grammar?
