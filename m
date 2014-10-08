From: Sergey Organov <sorganov@gmail.com>
Subject: Re: [PATCH] git-merge: mutually match SYNOPSIS and "usage".
Date: Wed, 08 Oct 2014 14:12:00 +0400
Message-ID: <87h9zeg9an.fsf@osv.gnss.ru>
References: <87wq8cnla9.fsf@osv.gnss.ru>
	<xmqq4mvfg24e.fsf@gitster.dls.corp.google.com>
	<87bnpnsjrw.fsf@osv.gnss.ru>
	<xmqq1tqjefd8.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 08 12:12:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XboE7-0003rd-PE
	for gcvg-git-2@plane.gmane.org; Wed, 08 Oct 2014 12:12:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754992AbaJHKME (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Oct 2014 06:12:04 -0400
Received: from mail.javad.com ([54.86.164.124]:53040 "EHLO mail.javad.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754601AbaJHKMD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Oct 2014 06:12:03 -0400
Received: from osv.gnss.ru (unknown [89.175.180.246])
	by mail.javad.com (Postfix) with ESMTPSA id 4299B6187E;
	Wed,  8 Oct 2014 10:12:02 +0000 (UTC)
Received: from osv by osv.gnss.ru with local (Exim 4.72)
	(envelope-from <sorganov@gmail.com>)
	id 1XboDw-00065c-HW; Wed, 08 Oct 2014 14:12:00 +0400
In-Reply-To: <xmqq1tqjefd8.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Tue, 07 Oct 2014 14:31:31 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Sergey Organov <sorganov@gmail.com> writes:
>
>> Junio C Hamano <gitster@pobox.com> writes:
>> ...
>> I was looking at the merge.c code, and that's how it seems to work. You
>> can get new semantics without -m, and you can't get old semantics with
>> -m, isn't it? It looks like the set of descriptions I produced is
>> formally correct.
>
> The thing is, with "-m <msg>" we will never fall into the
> traditional syntax, hence "git merge -m <msg> <msg> HEAD <commit>"
> appear to be allowed with "git merge [options] <msg> HEAD
> <commit>...", but it is not.

No. When you see:

  git merge [options] [-m <msg>] <commit>...

Isn't it obvious that 'options' don't include "-m <msg>", so
  
  git merge [options] <msg> HEAD <commit>...

form will never apply when you have "-m <msg>" in the command, exaclty
because 'options' don't include "-m <msg"?

>
> And the inverse is not true (an obvious example is "git merge
> $branch", even though it does not have "-m <msg>" it uses the modern
> & common.

Sure, and this is covered as well.

> So the updated SYNOPSIS is not really helping.

I disagree, see above.

I still think that for somewhat messy historical situation, the
suggested syntax description is good enough.

-- 
Sergey.
