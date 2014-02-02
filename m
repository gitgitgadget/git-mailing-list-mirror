From: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH] fast-import.c: always honor the filename case
Date: Sun, 02 Feb 2014 21:08:51 +0100
Message-ID: <52EEA5D3.9000502@web.de>
References: <1391346784-11891-1-git-send-email-reubenhwk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: dpotapov@gmail.com, tboegi@web.de
To: Reuben Hawkins <reubenhwk@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 02 21:09:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WA3Lf-0002pU-Bj
	for gcvg-git-2@plane.gmane.org; Sun, 02 Feb 2014 21:08:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752459AbaBBUIz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Feb 2014 15:08:55 -0500
Received: from mout.web.de ([212.227.15.3]:55994 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752450AbaBBUIy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Feb 2014 15:08:54 -0500
Received: from [192.168.209.26] ([78.72.74.102]) by smtp.web.de (mrweb102)
 with ESMTPSA (Nemesis) id 0M2MYq-1VI5BI1YDU-00s2mJ for <git@vger.kernel.org>;
 Sun, 02 Feb 2014 21:08:52 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
In-Reply-To: <1391346784-11891-1-git-send-email-reubenhwk@gmail.com>
X-Provags-ID: V03:K0:Dcy0YOxS+BaYUwbwIgJPjB1tEdL5UQd0cl9Ca3AT6ZXu8cYMxbR
 s+89HcsAazVWDi0kdLoxCUJe4t8r8KLybDH1qqKkBOUaX2VNcYwVueSLPaGIwmGINmYS8h0
 A50ChFrGBRYsYymN/UAQl3L9HGJlsqrZSaC58LRaRgJDzKJCTgS7kGv3FG3u/Boy45vbaX8
 3VL7yW096XQOXJqlukZ2g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241382>

On 2014-02-02 14.13, Reuben Hawkins wrote:
> fast-import should not use strncmp_icase.  When it does, files with
> similar names, but different case can be lost in the import.  For
> example...
> 
> M 100644 :1 FileName.txt
> D Filename.txt
That seems to be wrong, shouldn't it be
D Filename.txt
M 100644 :1 FileName.txt

How do you generate the export/import stream ?

Please see here:
>https://www.kernel.org/pub/software/scm/git/docs/git-fast-import.html
>Handling Renames

>When importing a renamed file or directory, simply delete the old name(s) and modify the new name(s) during the corresponding commit. 
>Git performs rename detection after-the-fact, rather than explicitly during a commit.
