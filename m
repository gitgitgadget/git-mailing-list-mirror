From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] help git-upload-pack find git
Date: Tue, 16 Sep 2008 15:43:54 +0200
Message-ID: <48CFB81A.5060108@viscovery.net>
References: <d3a045300809150130w6f78edd8xf599d1c7f639b77d@mail.gmail.com> <d3a045300809150130w6f78edd8xf599d1c7f639b77d@mail.gmail.com> <1221495891-12600-1-git-send-email-git@drmicha.warpmail.net> <7vzlm9b3v4.fsf@gitster.siamese.dyndns.org> <48CEC3FB.5070101@drmicha.warpmail.net> <48CF4F6A.6080604@viscovery.net> <48CFB183.1090205@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Sep 16 15:45:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kfarc-00019M-44
	for gcvg-git-2@gmane.org; Tue, 16 Sep 2008 15:45:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753026AbYIPNn7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Sep 2008 09:43:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752615AbYIPNn7
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Sep 2008 09:43:59 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:12978 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753026AbYIPNn6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Sep 2008 09:43:58 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1KfaqQ-0000uZ-QJ; Tue, 16 Sep 2008 15:43:55 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 8AECD6EF; Tue, 16 Sep 2008 15:43:54 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <48CFB183.1090205@drmicha.warpmail.net>
X-Enigmail-Version: 0.95.5
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96004>

Michael J Gruber schrieb:
> Why is it that setup_path() cannot be done before commit_pager_choice()?
> We need the pager in case list_common_cmds_help() is triggered, but why
> can't setup_path() be before that? Not because of "--", really.

I think that setup_path() must be called *after* handle_options() because
of this use-case:

  $ git --exec-path=/some/where foo

and git_set_argv0_path() must be called *before* handle_options() because
of this use-case:

  $ git --exec-path

-- Hannes
