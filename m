From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: New special handing of '@' character broke my use case
Date: Wed, 14 Aug 2013 22:11:20 +0200
Message-ID: <520BE468.1030808@kdbg.org>
References: <520BC017.7050907@gmail.com> <7vd2pgtagc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Stefano Lattarini <stefano.lattarini@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 14 22:11:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V9hPq-0005lO-Af
	for gcvg-git-2@plane.gmane.org; Wed, 14 Aug 2013 22:11:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933095Ab3HNULa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Aug 2013 16:11:30 -0400
Received: from bsmtp2.bon.at ([213.33.87.16]:13655 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S933081Ab3HNUL3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Aug 2013 16:11:29 -0400
Received: from [10.69.30.72] (178.115.250.72.wireless.dyn.drei.com [178.115.250.72])
	by bsmtp.bon.at (Postfix) with ESMTP id B3BF1CDF84;
	Wed, 14 Aug 2013 22:11:25 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130307 Thunderbird/17.0.4
In-Reply-To: <7vd2pgtagc.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232313>

Am 14.08.2013 20:05, schrieb Junio C Hamano:
> Stefano Lattarini <stefano.lattarini@gmail.com> writes:
>
>> My problems is that some new automagical interpretation of the bare
>> @' character (introduced after 1.8.3) has destroyed my use case:
>> ...
>> I don't want to ask you to revert this new behaviour, but I'd like to
>> at least have an option to disable it.
>
> I do not think it is simply not worth the complexity to selectively
> disable it.  If it is a regression, it is much better to simply
> revert, if we can (it appears that cdfd9483 (Add new @ shortcut for
> HEAD, 2013-05-07) can be reverted without any textual context, but
> there may already be new stuff that depends on the "@").
>
> For the upcoming release, I am very much tempted to revert it and
> let the topic retried, by people who really want the "let's save
> four keystrokes and replace it with @ aka Shift-<something>",
> without hurting your use case (and others), after the upcoming
> release.
>
> What do others think?

Stefano's use-case, where @/foo is turned into HEAD/foo, indicates a bug.

In my opinion, the topic, which touches a central part of ref handling, 
was a bit hurried (and this report is a symptom of it), and I wouldn't 
mind seeing it reverted.

-- Hannes
