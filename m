From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: bug: git merge --no-commit loses track of file modes in the index
Date: Fri, 13 Jun 2014 08:26:19 +0200
Message-ID: <539A998B.7030200@kdbg.org>
References: <20140613013858.GA28485@kitenet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Joey Hess <joey@kitenet.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 13 08:26:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WvKwZ-0000AC-Vx
	for gcvg-git-2@plane.gmane.org; Fri, 13 Jun 2014 08:26:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752590AbaFMG0Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jun 2014 02:26:24 -0400
Received: from bsmtp3.bon.at ([213.33.87.17]:49342 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751960AbaFMG0X (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2014 02:26:23 -0400
Received: from [192.168.0.200] (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 6B4A510025;
	Fri, 13 Jun 2014 08:26:20 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:24.0) Gecko/20100101 Thunderbird/24.0.1
In-Reply-To: <20140613013858.GA28485@kitenet.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251517>

Am 13.06.2014 03:38, schrieb Joey Hess:
> If git merge --no-commit is used to merge a commit adding a
> file with an unusual mode -- specifically a symlink which has "mode" 120000,
> it fails to stage the right mode into the index.
>
> This only happens when core.symlinks=false. I noticed it on FAT, but
> have managed to reproduce it on ext4.

There's a similar breakage with core.filemode=false, which loses the x bit 
of files that need a content merge.

-- Hannes
