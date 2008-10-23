From: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
Subject: Re: [RFC] Zit: the git-based single file content tracker
Date: Thu, 23 Oct 2008 15:33:29 +0200
Message-ID: <cb7bb73a0810230633r9970a50mbb4ecf3a855c3a21@mail.gmail.com>
References: <gdok16$vh2$1@ger.gmane.org>
	 <fcaeb9bf0810230550t54813c09m3b1984f065732c0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 23 15:35:35 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kt0L2-0006ml-Cz
	for gcvg-git-2@gmane.org; Thu, 23 Oct 2008 15:34:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752073AbYJWNdd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Oct 2008 09:33:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750881AbYJWNdc
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Oct 2008 09:33:32 -0400
Received: from mail-gx0-f16.google.com ([209.85.217.16]:64920 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750808AbYJWNdb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Oct 2008 09:33:31 -0400
Received: by gxk9 with SMTP id 9so1351384gxk.13
        for <git@vger.kernel.org>; Thu, 23 Oct 2008 06:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=OGT8rwD1Y5rDmoFZgmfkLD21w51pmeCaT0ERzULkFg4=;
        b=G/tZTtcXvZtWsWLevYo76H6xlJty4uGByreW4vM0PBT/YYVqb3zq5C5qRC4VqMI9wB
         +pSmdLO5Zudv9HdDVlTsYiSHsouuJMBefQcSHDSV7ChpVlYoE9JWq7R5A1gKESDMeiMj
         1wECGt01Y119ptrEMJGm4zLw9IjPZmzfyWGMI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=tNvPmFHUmtUAiuj3TUMcGw+F26RXOUPdfNeaBCUfqGrd7hsEIv4VfM92Rjbxrkylaj
         AMIoXnCB91h8GFliozOyIXPz51W6ZPEEJdjZUah/Un4EQSaFxQa5ihuSqDrEQYoFr04R
         /LZeIlmxczXooow6C6TabHYnug0n+nU3luKaI=
Received: by 10.151.102.21 with SMTP id e21mr3859939ybm.41.1224768809070;
        Thu, 23 Oct 2008 06:33:29 -0700 (PDT)
Received: by 10.150.145.2 with HTTP; Thu, 23 Oct 2008 06:33:29 -0700 (PDT)
In-Reply-To: <fcaeb9bf0810230550t54813c09m3b1984f065732c0@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98964>

On Thu, Oct 23, 2008 at 2:50 PM, Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
> On 10/23/08, Giuseppe Bilotta <giuseppe.bilotta@gmail.com> wrote:
>>  The principle is extremely simple: when you choose to start tracking a
>>  file with Zit,
>>
>>  zit track file
>>
>>  Zit will create a directory .zit.file to hold a git repository
>>  tracking the single file .zit.file/file, which is just a hard link to
>>  file.
>
> Why not use one .zit repo and track each file on each own branch?.

So your proposal is to have a single .zit repo which is actually a git
repo and where each additional tracked file becomes its own branch,
and zit would take care of switching from branch to branch when zit
commands are called?

I think this solution would have a number of problems, apart from
being generally quite messy. First of all, moving a file and its
history somewhere else means toying around with the history of a much
wider repo, whereas the current approach would mean just moving the
.zit.file dir together with the file (modulo hardlinks). Non-linear
histories for a single file would be more complex to handle, too. And
publishing just the history of one file would be damn complex.


-- 
Giuseppe "Oblomov" Bilotta
