From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [PATCH 3/3 FIXED] help (Windows): Display HTML in default browser using Windows' shell API
Date: Sat, 12 Jul 2008 08:45:08 +0200
Message-ID: <8D150442-8B57-4025-9110-BC4C23C2310C@zib.de>
References: <228FC26D-D318-487A-9BF3-B473096CB0C9@zib.de> <1215761822-21356-1-git-send-email-prohaska@zib.de> <7vtzevhjf8.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v926)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <johannes.sixt@telecom.at>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 12 08:46:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHYsI-0006CR-DG
	for gcvg-git-2@gmane.org; Sat, 12 Jul 2008 08:46:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751889AbYGLGpH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jul 2008 02:45:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751854AbYGLGpH
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Jul 2008 02:45:07 -0400
Received: from mailer.zib.de ([130.73.108.11]:39828 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751822AbYGLGpG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jul 2008 02:45:06 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id m6C6ilRH010645;
	Sat, 12 Jul 2008 08:44:57 +0200 (CEST)
Received: from [192.168.178.21] (brln-4db95b87.pool.einsundeins.de [77.185.91.135])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id m6C6ig6O001280
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Sat, 12 Jul 2008 08:44:44 +0200 (MEST)
In-Reply-To: <7vtzevhjf8.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.926)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88222>


On Jul 12, 2008, at 5:26 AM, Junio C Hamano wrote:

> Steffen Prohaska <prohaska@zib.de> writes:
>
>> diff --git a/compat/mingw.c b/compat/mingw.c
>> index 3a05fe7..0ca73f7 100644
>> --- a/compat/mingw.c
>> +++ b/compat/mingw.c
>> @@ -1017,3 +1017,24 @@ sig_handler_t mingw_signal(int sig,  
>> sig_handler_t handler)
>> ...
>> +void mingw_open_html(const char *unixpath)
>> +{
>> +	const char *htmlpath = make_backslash_path(unixpath);
>> +	printf("Launching default browser to display HTML ...\n");
>> +	ShellExecute(NULL, "open", htmlpath, NULL, "\\", 0);
>> +}
>
> Do you mean to have that printf() or is it a leftover debugging  
> statement?

I mean to have it.  It takes some time until a fresh browser starts up
if no browser has been running before.  Impatient people (like me) could
start believing that nothing would happen.  But this certainly depends
on your machine.  I run Windows inside a virtual machine on a Laptop,
which is probably rather slow compared to a desktop machine running
Windows natively.

	Steffen
