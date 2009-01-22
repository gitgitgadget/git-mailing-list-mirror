From: Tomas Carnecky <tom@dbservice.com>
Subject: Re: git-describe hash length
Date: Thu, 22 Jan 2009 13:34:06 +0100
Message-ID: <497867BE.8070509@dbservice.com>
References: <497857CE.3060101@iaik.tugraz.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Martin Pirker <Martin.Pirker@iaik.tugraz.at>
X-From: git-owner@vger.kernel.org Thu Jan 22 13:37:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPyon-00076l-Uh
	for gcvg-git-2@gmane.org; Thu, 22 Jan 2009 13:37:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754636AbZAVMgc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jan 2009 07:36:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754635AbZAVMgb
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Jan 2009 07:36:31 -0500
Received: from office.neopsis.com ([78.46.209.98]:37560 "EHLO
	office.neopsis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754325AbZAVMgb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jan 2009 07:36:31 -0500
Received: from [192.168.0.130] ([62.65.141.13])
	(authenticated user tom@dbservice.com)
	by office.neopsis.com;
	Thu, 22 Jan 2009 13:35:50 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1b3pre) Gecko/20090117 Shredder/3.0b2pre
In-Reply-To: <497857CE.3060101@iaik.tugraz.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106747>

On 01/22/2009 12:26 PM, Martin Pirker wrote:
> Hi!
>
>
> john@doe:/workspace$ git version
> git version 1.6.1
> john@doe:/workspace$ git describe
> fatal: cannot describe '7aee61cc635a923e70b74091486742481ee0928b'
> john@doe:/workspace$ git describe --always
> 7aee61c
> john@doe:/workspace$ git describe --always --abbrev=8
> 7aee61cc
>
>
> man git-describe:
>
>    --abbrev=<n>
>        Instead of using the default 8 hexadecimal digits as the
>        abbreviated object name, use<n>  digits.
>
>
>
> There is one character missing from default or what am I missing?

The man page is wrong:

cache.h:#define DEFAULT_ABBREV 7
builtin-describe.c:static int abbrev = DEFAULT_ABBREV;

tom
