From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH v2 6/7] rebase: write better reflog messages
Date: Wed, 19 Jun 2013 08:24:19 +0200
Message-ID: <51C14E93.5000707@viscovery.net>
References: <1371581737-10013-1-git-send-email-artagnon@gmail.com> <1371581737-10013-7-git-send-email-artagnon@gmail.com> <51C1442A.2010904@viscovery.net> <CALkWK0mMLPHp=OcWAPW5g3Eb7CBt42dtqkDwpQp69tKwLNYe0Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 19 08:24:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UpBog-0004IQ-U9
	for gcvg-git-2@plane.gmane.org; Wed, 19 Jun 2013 08:24:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756459Ab3FSGYX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Jun 2013 02:24:23 -0400
Received: from so.liwest.at ([212.33.55.13]:50005 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752338Ab3FSGYW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Jun 2013 02:24:22 -0400
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.77)
	(envelope-from <j.sixt@viscovery.net>)
	id 1UpBoZ-0000eb-D9; Wed, 19 Jun 2013 08:24:19 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 2BB571660F;
	Wed, 19 Jun 2013 08:24:19 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130509 Thunderbird/17.0.6
In-Reply-To: <CALkWK0mMLPHp=OcWAPW5g3Eb7CBt42dtqkDwpQp69tKwLNYe0Q@mail.gmail.com>
X-Enigmail-Version: 1.5.1
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228350>

Am 6/19/2013 8:09, schrieb Ramkumar Ramachandra:
> Johannes Sixt wrote:
>> I haven't followed the topic closely, but I wonder why there are so many
>> explicit assignments to GIT_REFLOG_ACTION. Is calling set_reflog_action
>> (defined in git-sh-setup) the wrong thing to do?
> 
> Does this answer your question?
> 
> set_reflog_action() {
> 	if [ -z "${GIT_REFLOG_ACTION:+set}" ]
> 	then
> 		GIT_REFLOG_ACTION="$*"
> 		export GIT_REFLOG_ACTION
> 	fi
> }

Please don't state the obvious, that does not help. Of course, this does
not answer my question. I was rather hinting that it may be wrong to set
GIT_REFLOG_ACTION explicitly.

I thought that the convention is not to modify GIT_REFLOG_ACTION if it is
already set. set_reflog_action does just that.

-- Hannes
