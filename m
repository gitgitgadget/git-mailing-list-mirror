From: Chris Rorvick <chris@rorvick.com>
Subject: Re: What's cooking in git.git (Jan 2013, #08; Tue, 22)
Date: Wed, 23 Jan 2013 07:26:24 -0600
Message-ID: <CAEUsAPaUy5ug0_HPjWDTSnAG0kURhP-1-9nOu9_Tpn5nEv6N_Q@mail.gmail.com>
References: <7va9s0n8gv.fsf@alter.siamese.dyndns.org>
	<20130122234554.GI7498@serenity.lan>
	<7vobgglpv4.fsf@alter.siamese.dyndns.org>
	<20130123092858.GJ7498@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	"Eric S. Raymond" <esr@thyrsus.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Wed Jan 23 14:26:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ty0Lo-0000FX-Dl
	for gcvg-git-2@plane.gmane.org; Wed, 23 Jan 2013 14:26:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753118Ab3AWN01 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jan 2013 08:26:27 -0500
Received: from mail-lb0-f181.google.com ([209.85.217.181]:46826 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752463Ab3AWN00 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jan 2013 08:26:26 -0500
Received: by mail-lb0-f181.google.com with SMTP id gm6so2148143lbb.26
        for <git@vger.kernel.org>; Wed, 23 Jan 2013 05:26:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=tk9q11l53tSOcPw029IYLryJGxdjUA25d8mhCIZ6F3E=;
        b=JNETxCd77SRx+Tqudnei73X6bEsnnXHeoGkwG/Fkt6qCdQJYBka0ZAFRfShQE351Sn
         KWNcyaP9In8sqwRKJIO0J1fXShoyp1r7lhvp4ENdGQB0qpel9KqskTfqSViuH9mCZtlj
         P3akODaedpOfSxd20+FzglIQ2oWpE7C7ebnfmY9BcUlqqxp5S/Md0cf6p77Tq3EexIkd
         fsdkpo+/laDqkc0cyko43UjH5ZM6p3fU5ejCI3JJmPiKqlQbXq+BonUPdf2afmumRe9I
         jsvwxD3MgipVIjyDdAcPF5bYUwcVd9Hv1e3E0g66uDW9RfnMSOZDcazMCcZG9qeALvYx
         3jNA==
X-Received: by 10.152.144.103 with SMTP id sl7mr1352157lab.23.1358947584861;
 Wed, 23 Jan 2013 05:26:24 -0800 (PST)
Received: by 10.114.2.97 with HTTP; Wed, 23 Jan 2013 05:26:24 -0800 (PST)
In-Reply-To: <20130123092858.GJ7498@serenity.lan>
X-Google-Sender-Auth: 4NRLfdvP9zx1LQiQIJsKtMxZvH8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214316>

On Wed, Jan 23, 2013 at 3:28 AM, John Keeping <john@keeping.me.uk> wrote:
> In my opinion the incremental import support really is substantially
> worse in cvsimport-3 than cvsimport-2.  cvsimport-2 looks at the output
> of git-for-each-ref to calculate the dates from which to continue each
> branch.  cvsps cannot be told this information and so the cvsimport-3
> script just takes the date of the last commit on the current branch.

Do you really need a timestamp per branch, though?  If you have
branches A and B, and B has a commit timestamp 5 minutes after A, you
can infer that nothing happened on A for those five minutes, right?
So maybe a single timestamp is sufficient, it just may not be picking
the right one.  Instead cvsimport-3 should compute the latest
timestamp across all import branches.

Chris
