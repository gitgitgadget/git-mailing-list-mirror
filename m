From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: [FIXED PATCH] Make rebase save ORIG_HEAD if changing current branch
Date: Mon, 7 Jul 2008 10:36:29 -0400
Message-ID: <B8E7062C-8CE6-492B-BDB4-91993140739B@silverinsanity.com>
References: <1215379370-34265-1-git-send-email-benji@silverinsanity.com> <7v7iby9ucx.fsf@gitster.siamese.dyndns.org> <803A3528-2451-4C5D-A48D-5E0C37B8E90E@silverinsanity.com> <7vbq1a8ay3.fsf@gitster.siamese.dyndns.org> <20080707111803.GF31490@mit.edu>
Mime-Version: 1.0 (Apple Message framework v926)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Mon Jul 07 16:38:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KFrqN-0002iI-Dm
	for gcvg-git-2@gmane.org; Mon, 07 Jul 2008 16:37:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753606AbYGGOgd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jul 2008 10:36:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753556AbYGGOgd
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Jul 2008 10:36:33 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:50845 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753408AbYGGOga (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jul 2008 10:36:30 -0400
Received: from [192.168.1.2] (cpe-69-205-115-17.rochester.res.rr.com [69.205.115.17])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTP id 2A9BD1FFC02C;
	Mon,  7 Jul 2008 14:36:26 +0000 (UTC)
In-Reply-To: <20080707111803.GF31490@mit.edu>
X-Mailer: Apple Mail (2.926)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87614>


On Jul 7, 2008, at 7:18 AM, Theodore Tso wrote:

> On Sun, Jul 06, 2008 at 11:28:36PM -0700, Junio C Hamano wrote:
>> (1) ORIG_HEAD is not strictly necessary these days, because we have
>>     reflogs;
>
> True, but (and please correct me if I'm wrong) ORIG_HEAD will always
> be pointing out HEAD before the user typed pretty much any git
> porcelein command (which saves HEAD into ORIG_HEAD), but with reflogs,
> it you have to paw through multiple HEAD@{n} to find the 'n' which
> corresponds to state before executing the git plumbing command, since
> multiple git plumbing commands could have updated the HEAD's reflog,
> right?

This is _exactly_ why I wanted `pull --rebase` to set ORIG_HEAD.   
Reflogs are great in their own way, but having ORIG_HEAD regularly  
being available for a quick way to set it back or refer to the  
original state is just too useful.

~~ Brian
