From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH] t0060: loosen overly strict expectations
Date: Fri, 15 Jan 2016 00:46:22 +0000
Message-ID: <5698415E.7070907@ramsayjones.plus.com>
References: <eccf149d9557fd9afb591d9411ecb0b3460c9eb0.1452754049.git.johannes.schindelin@gmx.de>
 <xmqqziw8jcbr.fsf@gitster.mtv.corp.google.com>
 <5697E550.9020102@ramsayjones.plus.com> <56981DC2.6070706@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	git@vger.kernel.org, Michael Blume <blume.mike@gmail.com>,
	=?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Fri Jan 15 01:46:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJsXE-0006Hb-NK
	for gcvg-git-2@plane.gmane.org; Fri, 15 Jan 2016 01:46:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756979AbcAOAqd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jan 2016 19:46:33 -0500
Received: from avasout04.plus.net ([212.159.14.19]:33842 "EHLO
	avasout04.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756947AbcAOAqc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jan 2016 19:46:32 -0500
Received: from [10.0.2.15] ([46.208.159.221])
	by avasout04 with smtp
	id 60mQ1s0014mu3xa010mRHr; Fri, 15 Jan 2016 00:46:30 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=CvRCCSMD c=1 sm=1 tr=0
 a=Sp5fw55EgyGSOjouSGNDoQ==:117 a=Sp5fw55EgyGSOjouSGNDoQ==:17 a=0Bzu9jTXAAAA:8
 a=L9H7d07YOLsA:10 a=9cW_t1CCXrUA:10 a=s5jvgZ67dGcA:10 a=EBOSESyhAAAA:8
 a=N659UExz7-8A:10 a=VZdTsbspDSk4Eld1VOEA:9 a=gsK-mB7ujOfF2UxA:21
 a=XaQdSaMXUD6gfYJ7:21 a=Rzok8Zz9PyN6jWCt:21 a=pILNOxqGKmIA:10
X-AUTH: ramsayjones@:2500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
In-Reply-To: <56981DC2.6070706@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284126>



On 14/01/16 22:14, Johannes Sixt wrote:
> Am 14.01.2016 um 19:13 schrieb Ramsay Jones:
>> Correct me if I'm wrong (quite possible), but
>> _each_ drive has a current working directory associated with
>> it in win32, so it's a bit difficult to use drive designators
>> with a relative path (eg. C:usr/lib).
> 
> As far as it matters for Git, such a path is still an absolute path, 
> because it is not anchored at $(pwd).

I have been using cygwin on windows since beta-18 (about 1995), in order
to avoid most of the horrors of the windows command line, so I'm a little
rusty. ;-)

You know windows _much_ better than me, so could you please educate me
on this point. I tried this (on windows 8.1):

    ramsay@satellite $ cmd
    Microsoft Windows [Version 6.3.9600]
    (c) 2013 Microsoft Corporation. All rights reserved.
    
    C:\cygwin64\home\ramsay>cd junk
    cd junk
    
    C:\cygwin64\home\ramsay\junk>dir
    dir
     Volume in drive C is TI31255200A
     Volume Serial Number is 0024-4AC0
    
     Directory of C:\cygwin64\home\ramsay\junk
    
    15/01/2016  00:23    <DIR>          .
    15/01/2016  00:23    <DIR>          ..
    15/01/2016  00:23                 1 regular
    15/01/2016  00:23    <DIR>          sub-1
    15/01/2016  00:24    <DIR>          sub-2
                   1 File(s)              1 bytes
                   4 Dir(s)  800,988,291,072 bytes free
    
    C:\cygwin64\home\ramsay\junk>dir C:
    dir C:
     Volume in drive C is TI31255200A
     Volume Serial Number is 0024-4AC0
    
     Directory of C:\cygwin64\home\ramsay\junk
    
    15/01/2016  00:23    <DIR>          .
    15/01/2016  00:23    <DIR>          ..
    15/01/2016  00:23                 1 regular
    15/01/2016  00:23    <DIR>          sub-1
    15/01/2016  00:24    <DIR>          sub-2
                   1 File(s)              1 bytes
                   4 Dir(s)  800,988,291,072 bytes free
    
    C:\cygwin64\home\ramsay\junk>dir C:.
    dir C:.
     Volume in drive C is TI31255200A
     Volume Serial Number is 0024-4AC0
    
     Directory of C:\cygwin64\home\ramsay\junk
    
    15/01/2016  00:23    <DIR>          .
    15/01/2016  00:23    <DIR>          ..
    15/01/2016  00:23                 1 regular
    15/01/2016  00:23    <DIR>          sub-1
    15/01/2016  00:24    <DIR>          sub-2
                   1 File(s)              1 bytes
                   4 Dir(s)  800,988,291,072 bytes free
    
    C:\cygwin64\home\ramsay\junk>dir C:\
    dir C:\
     Volume in drive C is TI31255200A
     Volume Serial Number is 0024-4AC0
    
     Directory of C:\
    
    17/09/2015  15:52    <DIR>          cygwin64
    05/08/2015  10:10               383 ftconfig.ini
    09/04/2014  05:41    <DIR>          Intel
    22/08/2013  15:22    <DIR>          PerfLogs
    06/10/2015  19:28    <DIR>          Program Files
    26/12/2015  14:09    <DIR>          Program Files (x86)
    18/05/2014  11:18                 0 Recovery.txt
    03/12/2013  17:02    <DIR>          Toshiba
    25/06/2014  18:15    <DIR>          UBIOS
    26/12/2015  14:09    <DIR>          Users
    27/08/2015  10:08    <DIR>          Windows
                   2 File(s)            383 bytes
                   9 Dir(s)  800,988,299,264 bytes free
    
    C:\cygwin64\home\ramsay\junk>dir C:sub-1
    dir C:sub-1
     Volume in drive C is TI31255200A
     Volume Serial Number is 0024-4AC0
    
     Directory of C:\cygwin64\home\ramsay\junk\sub-1
    
    15/01/2016  00:23    <DIR>          .
    15/01/2016  00:23    <DIR>          ..
    15/01/2016  00:23                 1 bill
    15/01/2016  00:23                 1 fred
                   2 File(s)              2 bytes
                   2 Dir(s)  800,988,299,264 bytes free
    
    C:\cygwin64\home\ramsay\junk>exit
    exit
    ramsay@satellite $ 

... which seems to contradict what you say above.

What am I missing?

ATB,
Ramsay Jones


    
