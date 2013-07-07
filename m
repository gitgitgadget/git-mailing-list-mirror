From: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH] test-lib.sh - cygwin does not have usable FIFOs
Date: Sun, 07 Jul 2013 11:14:12 +0200
Message-ID: <51D93164.8030202@web.de>
References: <1372975470-13573-1-git-send-email-mlevedahl@gmail.com> <20130707005558.GI30132@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Mark Levedahl <mlevedahl@gmail.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 07 11:14:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uvl33-0004HW-CY
	for gcvg-git-2@plane.gmane.org; Sun, 07 Jul 2013 11:14:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751788Ab3GGJOR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Jul 2013 05:14:17 -0400
Received: from mout.web.de ([212.227.17.11]:62733 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751683Ab3GGJOQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jul 2013 05:14:16 -0400
Received: from [192.168.209.26] ([195.67.191.23]) by smtp.web.de (mrweb101)
 with ESMTPA (Nemesis) id 0MJkt6-1UwrVQ420S-001BD4; Sun, 07 Jul 2013 11:14:13
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:17.0) Gecko/20130620 Thunderbird/17.0.7
In-Reply-To: <20130707005558.GI30132@google.com>
X-Provags-ID: V03:K0:5ysPgk6pXmznKVn1K9rKNOEc5ky1Ajtz4scdIP2T84SDylfEgaX
 T8cqGtAnowcUiqpwFrcaVIdDOD5Lo8fWx/WE2025bHPf09dpyrxq40u0A+lbOc5/OQbPbEE
 +KT6GiLzKW/SMLEwIk2DF8h6Hftb2GwDsCUfJU05Nm9EoLHlX87iv/a9J6Op9P9qV/Lorfg
 hkHZzB5Sd9A3HdmP+NHfw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229757>

On 2013-07-07 02.55, Jonathan Nieder wrote:
> Mark Levedahl wrote:
> 
>> Do not use FIFOs on cygwin, they do not work. Cygwin includes
>> coreutils, so has mkfifo, and that command does something. However,
>> the resultant named pipe is known (on the Cygwin mailing list at
>> least) to not work correctly.
> 
> Hm.  How would you recommend going about writing a script that takes
> output from a command, transforms it, and then feeds it back into
> that command's input?  Are sockets a more reliable way to do this kind
> of IPC on Cygwin?
> 
> See reinit_git and try_dump from t9010-svn-fe.sh for context.
> 
> Thanks,
> Jonathan

t9010 needs PIPE in most test cases as a prerequisite.
And if PIPE isn't available, the tests can not be run.

Are you suggesting to replace the named pipes with a TCP socket?

Disabling PIPE under cygwin seems to be the right thing to do,
or do I miss something ?

/Torsten
