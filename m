From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] shell: add missing initialization of argv0_path
Date: Thu, 05 May 2011 08:58:07 +0200
Message-ID: <4DC24A7F.20705@viscovery.net>
References: <62D8CA91-5C11-458E-AADB-D8EC8EB99F09@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Dima Sharov <git.avalakvista@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 05 08:58:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QHsVs-0008FH-30
	for gcvg-git-2@lo.gmane.org; Thu, 05 May 2011 08:58:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752029Ab1EEG6L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 May 2011 02:58:11 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:32274 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751384Ab1EEG6L (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2011 02:58:11 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1QHsVj-0003Md-Jv; Thu, 05 May 2011 08:58:07 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 591FA1660F;
	Thu,  5 May 2011 08:58:07 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.17) Gecko/20110414 Thunderbird/3.1.10
In-Reply-To: <62D8CA91-5C11-458E-AADB-D8EC8EB99F09@gmail.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172810>

Am 5/5/2011 8:40, schrieb Dima Sharov:
> According to c6dfb39 (remote-curl: add missing initialization of
> argv0_path, 2009-10-13), stand-alone programs (non-builtins)
> must call git_extract_argv0_path(argv[0]) in order to help builds
> that derive the installation prefix at runtime. Without this call,
> the program segfaults (or raises an assertion failure).

Good catch! I checked PROGRAM_OBJS in Makefile, and shell.c was the only
one remaining that did not call this function.

-- Hannes
