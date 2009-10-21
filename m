From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [msysGit] [PATCH v4 7/8] mingw: enable OpenSSL
Date: Wed, 21 Oct 2009 14:55:23 +0200
Message-ID: <4ADF04BB.10302@viscovery.net>
References: <1255966929-1280-1-git-send-email-kusmabite@gmail.com>	 <1255966929-1280-7-git-send-email-kusmabite@gmail.com>	 <1255966929-1280-8-git-send-email-kusmabite@gmail.com>	 <200910192020.44890.j6t@kdbg.org> <4ADEFB6D.9050501@viscovery.net> <40aa078e0910210543t2dcc2af6ie16eb0e49895788f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: msysgit@googlegroups.com, git@vger.kernel.org,
	Marius Storm-Olsen <mstormo@gmail.com>
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Wed Oct 21 14:55:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0aiy-0007CW-54
	for gcvg-git-2@lo.gmane.org; Wed, 21 Oct 2009 14:55:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752520AbZJUMzV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Oct 2009 08:55:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751897AbZJUMzV
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Oct 2009 08:55:21 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:58506 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751746AbZJUMzU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Oct 2009 08:55:20 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1N0aiq-0006SP-CM; Wed, 21 Oct 2009 14:55:24 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 29BC16D9; Wed, 21 Oct 2009 14:55:24 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <40aa078e0910210543t2dcc2af6ie16eb0e49895788f@mail.gmail.com>
X-Enigmail-Version: 0.95.5
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130912>

Erik Faye-Lund schrieb:
> On Wed, Oct 21, 2009 at 2:15 PM, Johannes Sixt <j.sixt@viscovery.net> wrote:
>> I seem to have ack'ed this one too early. After testing in my environment,
>> I get:
>>
>> imap-send.o: In function `ssl_socket_perror':
>> D:\Src\mingw-git/imap-send.c:241: undefined reference to `ERR_get_error'
>> D:\Src\mingw-git/imap-send.c:241: undefined reference to `ERR_error_string'
>>
>> I need this patch in addition, and perhaps something similar is also
>> needed with MSVC:
> 
> Ah, yes - thanks for that one. I traced it a bit, and I found that it
> works for me without your patch because I'm using OpenSSL's sha1, so
> $(LIB_4_CRYPTO) is already included. Your fix is of course correct.
> I'll squash it in and resend.

Indeed, I observed the failure after I set BLK_SHA1=YesPlease. I did this
exactly because it removes the dependency on libcrypto.dll from git.exe.

-- Hannes
