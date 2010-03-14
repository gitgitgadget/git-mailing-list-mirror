From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH] git status: ignoring untracked files must apply to submodules
 too
Date: Sun, 14 Mar 2010 01:55:35 +0100
Message-ID: <4B9C3407.9090502@web.de>
References: <4B9C0AFB.1050306@web.de> <7vhboj6et9.fsf@alter.siamese.dyndns.org> <4B9C1AEC.2070605@web.de> <7vaaubzrxq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Sergio Callegari <sergio.callegari@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 14 01:55:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nqc7Y-0003Zh-92
	for gcvg-git-2@lo.gmane.org; Sun, 14 Mar 2010 01:55:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755286Ab0CNAzm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Mar 2010 19:55:42 -0500
Received: from fmmailgate03.web.de ([217.72.192.234]:53591 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753945Ab0CNAzl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Mar 2010 19:55:41 -0500
Received: from smtp05.web.de (fmsmtp05.dlan.cinetic.de [172.20.4.166])
	by fmmailgate03.web.de (Postfix) with ESMTP id 6E0F014439372;
	Sun, 14 Mar 2010 01:55:40 +0100 (CET)
Received: from [80.128.109.251] (helo=[192.168.178.26])
	by smtp05.web.de with asmtp (WEB.DE 4.110 #314)
	id 1Nqc7I-0000Ze-00; Sun, 14 Mar 2010 01:55:40 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.1.8) Gecko/20100227 Thunderbird/3.0.3
In-Reply-To: <7vaaubzrxq.fsf@alter.siamese.dyndns.org>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX19thbhwqSoPvDHdvyWDuPh3B7ofWO4eqVJ0aMkD
	ZI0LFKs2ZH0J4Vy0ENuBhzJCsaGfbr6G34hATF6JcLm6isklOj
	BJI0EAVmBUq5z4Oli7IA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142125>

Am 14.03.2010 01:07, schrieb Junio C Hamano:
> Jens Lehmann <Jens.Lehmann@web.de> writes:
> 
>> First: When called from "git status" run_diff_files() calls
>> wt_status_collect_changed_cb() for every file it considers changed, so
> 
> This reminds me of another thing, perhaps independent, perhaps related.
> Why aren't we collecting the submodule status in wt_status_collect() to
> begin with?  It examines the submodule status in wt_status_print(), but
> that feels quite against the way how the whole "struct wt_status" was
> designed to be used in the first place, I think.  Would restuctuing the
> code that way make this easier to handle?

I'm not sure I understand that, but AFAICS in wt_status_print_changed()
only the fact that at least one submodule is dirty is examined to be
able to print the extra hint line. The status of each submodule is
collected in wt_status_collect_changed_cb(), no?

And while not having being active when "struct wt_status" has been
designed, i think adding submodules to the "change" list when they
are dirty makes kind a sense ... but i might be wrong ;-)
