From: =?windows-1252?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH/RFC] blame: CRLF in the working tree and LF in the repo
Date: Mon, 27 Apr 2015 21:45:17 +0200
Message-ID: <553E91CD.9060205@web.de>
References: <553CD3DA.9090700@web.de> <xmqqzj5uxhls.fsf@gitster.dls.corp.google.com> <20150427061115.GB2766@camelia.ucw.cz> <553E86BD.7030401@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: =?windows-1252?Q?Torsten_B=F6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	sandals@crustytoothpaste.net
To: Johannes Sixt <j6t@kdbg.org>, Stepan Kasal <kasal@ucw.cz>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 27 21:45:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YmoyS-0007nn-OR
	for gcvg-git-2@plane.gmane.org; Mon, 27 Apr 2015 21:45:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964985AbbD0Tpb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Apr 2015 15:45:31 -0400
Received: from mout.web.de ([212.227.15.4]:56874 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932902AbbD0Tpb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Apr 2015 15:45:31 -0400
Received: from [192.168.209.17] ([217.211.68.12]) by smtp.web.de (mrweb001)
 with ESMTPSA (Nemesis) id 0M4qsv-1ZW7ON4A3R-00z2eE; Mon, 27 Apr 2015 21:45:19
 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.6.0
In-Reply-To: <553E86BD.7030401@kdbg.org>
X-Provags-ID: V03:K0:F0IbG1aH8cEC7TmYXHxGzQLbViWzel5lAyHguXuzFdIP11Yd+jN
 O+HVOqZ/H4GQB9AgQVI58Rx8toRbpZNSJw0eQ38AH2l/2ML+0PaHuuQ88VJp2dhWqDwcSfc
 cEcLjCI8yoO1cwrurborww3haijIqMioSGsx0ESerzyhKK6pX5rAVy1G51l0VE/pUwH/WU1
 K6EkukrXxzxTaMyBm9R9w==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267877>

On 04/27/2015 08:58 PM, Johannes Sixt wrote:
> Am 27.04.2015 um 08:11 schrieb Stepan Kasal:
>> Git does not support CRLF as the internal line separator.
>> If you commit file in binary mode with CRLF, you are on your own.
> 
> When I commit my C source code files with CRLF into the repository (because I do not set any line ending options or configurations or any 'text' attributes or similar), do I then commit binary files or text files? Should I expect not to see any diffs?
> 
> -- Hannes
> 
You commit files with CRLF in the repo.
If you have CRLF in the working tree, things are as follows:

core.autocrlf=false   : "Same as binary, no changes"
core.autocrlf=true    : "Normalization is suppressed, (CRLF in repo), and therefore no changes.
core.autocrlf=input   : "Normalization wanted, (CRLF in repo), normalization will be done
                                               (and should be committed as soon as possible)
 
