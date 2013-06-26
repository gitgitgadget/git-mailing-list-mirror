From: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: [RFC/PATCH 0/1] cygwin: Remove the Win32 l/stat() functions
Date: Wed, 26 Jun 2013 16:19:15 +0200
Message-ID: <51CAF863.4020803@web.de>
References: <51C5FD28.1070004@ramsay1.demon.co.uk> <51C7A875.6020205@gmail.com> <7va9mf6txq.fsf@alter.siamese.dyndns.org> <51C9EE26.9010006@kdbg.org> <7vppv928jx.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <j6t@kdbg.org>, dpotapov@gmail.com,
	Mark Levedahl <mlevedahl@gmail.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	mhagger@alum.mit.edu, Jeff King <peff@peff.net>,
	"Shawn O. Pearce" <spearce@spearce.org>, tboegi@web.de,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 26 16:19:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UrqZU-0007i0-CU
	for gcvg-git-2@plane.gmane.org; Wed, 26 Jun 2013 16:19:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751527Ab3FZOTj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Jun 2013 10:19:39 -0400
Received: from mout.web.de ([212.227.15.4]:50887 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751778Ab3FZOTj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Jun 2013 10:19:39 -0400
Received: from [192.168.209.26] ([195.67.191.23]) by smtp.web.de (mrweb103)
 with ESMTPA (Nemesis) id 0LyDlZ-1UFN7w2AWT-015dxT; Wed, 26 Jun 2013 16:19:21
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:17.0) Gecko/20130509 Thunderbird/17.0.6
In-Reply-To: <7vppv928jx.fsf@alter.siamese.dyndns.org>
X-Provags-ID: V03:K0:5QkjvkiC+FS3Pqe07zdcZ/C8g8vKtDEe4cLJeqHG+CkGccIRGn0
 M+FSEEKlUOfcTNK69Mv5enSwI/I/lACKZ1D/9R9zGjYOLEHi20BXb9rbKKW0AzxHdkOjZHq
 gNQdYUV8eM/jvfiIKP0zG4LwWBLyuJv5Z3dN60kTh/7YPY0H2c6+dDt8okv65wEKdE2GG54
 E6hH2i6wDJsM/nSM2Q5LA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229040>

On 2013-06-25 23.18, Junio C Hamano wrote:
> Johannes Sixt <j6t@kdbg.org> writes:
> 
>> Some context: This is about a patch by Ramsay that removes the
>> "schizophrenic lstat" hack for Cygwin. Junio, can you please queue that
>> patch in pu?
> 
> Sure.  Thanks.

First of all,
thanks for the work.

Here some "benchmark" results, 
(The test run of the test suite did the same amout of time).

But:
git status -uno in real life takes double the time,
git 1.8.3 compared against "pu with the vanilla l/stat"
   
    1 second ->  2 seconds on linux kernel
0.2 seconds -> 0.4 seconds on git.git 

Do we have any known problems with the current implementation ?
Does speed matter ?

One vote to keep the special cygwin functions.
(And have a look how to improve the core.filemode)

/Torsten
