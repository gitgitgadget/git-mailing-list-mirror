From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Breaking t1510-repo-setup.sh tests in pu
Date: Fri, 26 Nov 2010 08:51:04 +0100
Message-ID: <4CEF66E8.1050806@viscovery.net>
References: <AANLkTim=_0WiphBv-RBhJ2i9rGzXvz8yKcZcm_7pYXFc@mail.gmail.com> <AANLkTikvXhKoRg4a0FuyW8cG45b6AM9+NbbHuJQWtb4L@mail.gmail.com> <AANLkTinhgMhrcMtPKL0aOrkeVgo8NE8Sq0fuPuCcbdbq@mail.gmail.com> <AANLkTim1G__J6KAnd+pNmKWwEDTHexUSJU2E7=7WFZmp@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 26 08:51:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PLt5P-0005rC-5E
	for gcvg-git-2@lo.gmane.org; Fri, 26 Nov 2010 08:51:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753291Ab0KZHvJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Nov 2010 02:51:09 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:47907 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753186Ab0KZHvI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Nov 2010 02:51:08 -0500
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1PLt5F-00042c-Ay; Fri, 26 Nov 2010 08:51:05 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 01CE81660F;
	Fri, 26 Nov 2010 08:51:04 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.12) Gecko/20101027 Thunderbird/3.1.6
In-Reply-To: <AANLkTim1G__J6KAnd+pNmKWwEDTHexUSJU2E7=7WFZmp@mail.gmail.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162207>

Am 11/26/2010 3:45, schrieb Nguyen Thai Ngoc Duy:
> OK it's probably bashisms. I think it will pass if you run it with
> bash :-P I'll resend the series later without bash specific
> constructs.

Sure, it is. This:

   GIT_DIR="$TRASH_DIRECTORY/2/.git" test_repo 2/sub

does not work the same way in all shells when test_repo is a shell
function. You have to export GIT_DIR explicitly before the function call.
(But since in this case, test_repo invokes its own subshell anyway, you
better do it in the function.)

-- Hannes
