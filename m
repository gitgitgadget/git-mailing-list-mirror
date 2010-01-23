From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH 2/4] msvc: Fix an "unrecognized option" linker warning
Date: Sat, 23 Jan 2010 01:06:36 +0100
Message-ID: <4B5A3D8C.3000701@gmail.com>
References: <4B5758BF.9090806@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 23 01:07:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NYTXL-0004AL-Jy
	for gcvg-git-2@lo.gmane.org; Sat, 23 Jan 2010 01:07:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754299Ab0AWAHb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jan 2010 19:07:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753087Ab0AWAHb
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Jan 2010 19:07:31 -0500
Received: from lo.gmane.org ([80.91.229.12]:57212 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751457Ab0AWAH3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jan 2010 19:07:29 -0500
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1NYTX5-00044N-DH
	for git@vger.kernel.org; Sat, 23 Jan 2010 01:07:19 +0100
Received: from 91-67-62-42-dynip.superkabel.de ([91.67.62.42])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 23 Jan 2010 01:07:19 +0100
Received: from sschuberth by 91-67-62-42-dynip.superkabel.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 23 Jan 2010 01:07:19 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 91-67-62-42-dynip.superkabel.de
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.12) Gecko/20080213 Thunderbird/2.0.0.12 Mnenhy/0.7.5.0
In-Reply-To: <4B5758BF.9090806@ramsay1.demon.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137790>

On 20.01.2010 20:25, Ramsay Jones wrote:

> Having recently added support for building git-imap-send on
> Windows, we now link against OpenSSL libraries, and the linker
> issues the following warning:
>
>      warning LNK4044: unrecognized option '/lssl'; ignored
>
> In order to suppress the warning, we change the msvc linker
> script to translate an '-lssl' parameter to the ssleay32.lib
> library.
>
> Note that the linker script was already including ssleay32.lib
> (along with libeay32.lib) as part of the translation of the
> '-lcrypto' library parameter.  However, libeay32.dll does not
> depend on ssleay32.dll and can be used stand-alone, so we remove
> ssleay32.lib from the '-lcrypto' translation.
>
> The dependence of ssleay32.dll on libeay32.dll is represented in
> the Makefile by the NEEDS_CRYPTO_WITH_SSL build variable.
>
> Also, add the corresponding change to the buildsystem generator.
>
> Signed-off-by: Ramsay Jones<ramsay@ramsay1.demon.co.uk>

Acked-by: Sebastian Schuberth <sschuberth@gmail.com>

-- 
Sebastian Schuberth
