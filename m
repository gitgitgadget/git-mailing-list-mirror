From: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
Subject: Re: [RFC] Zit: the git-based single file content tracker
Date: Thu, 23 Oct 2008 15:28:11 +0200
Message-ID: <cb7bb73a0810230628l22871f3bj26cd825e2de99ff9@mail.gmail.com>
References: <gdok16$vh2$1@ger.gmane.org> <49007623.1060606@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Johannes Sixt" <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Oct 23 15:29:56 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kt0G7-0004WP-4c
	for gcvg-git-2@gmane.org; Thu, 23 Oct 2008 15:29:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751144AbYJWN2O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Oct 2008 09:28:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750856AbYJWN2O
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Oct 2008 09:28:14 -0400
Received: from hs-out-0708.google.com ([64.233.178.244]:13557 "EHLO
	hs-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750808AbYJWN2N (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Oct 2008 09:28:13 -0400
Received: by hs-out-0708.google.com with SMTP id 4so82749hsl.5
        for <git@vger.kernel.org>; Thu, 23 Oct 2008 06:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=GDg6SQaB0xwpGcEClpG7dn1d91Np33m+YJC/FUcK/D8=;
        b=wP9+fWRN8HUeGn2DoKWDqlCgIQyZcV7gnbBmmLj0VPaZB/u/+sGDOTtyxctcoJVnjK
         uPiqy41B2K1kV4RaCXTZP+aD4UHJ8nGXIz2pZFwlARo/V4IP2sibYjbQ7GNseS1oMp3O
         lRfl8T/yBTPWD+aK7LNkM02wAZmY2JsV3tw/I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=aUyp9MCWjJICy7pIUP78bNrX7ZU8rSXMXz1B434O2Mj9MQP3TmxRLFZDIGo2lgYH/Q
         meDz35nSKB04e/RssUHLzswwqlPthEvC5Ac7jhYXzjzSIxXodJE/RhL6CFcRWNC3f41P
         kD7M6KCtu9R7y69HRY6GvKsEdHGDUBX4qNu/Q=
Received: by 10.151.44.18 with SMTP id w18mr3826521ybj.104.1224768491799;
        Thu, 23 Oct 2008 06:28:11 -0700 (PDT)
Received: by 10.150.145.2 with HTTP; Thu, 23 Oct 2008 06:28:11 -0700 (PDT)
In-Reply-To: <49007623.1060606@viscovery.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98963>

On Thu, Oct 23, 2008 at 3:03 PM, Johannes Sixt <j.sixt@viscovery.net> wrote:
> Giuseppe Bilotta schrieb:
>> Zit will create a directory .zit.file to hold a git repository
>> tracking the single file .zit.file/file, which is just a hard link to
>> file.
>
> git breaks hard links, mind you! (Just in case you check out older
> versions and you wonder why your "real" file is not updated).
>
> But there's a recent patch by Dscho floating around that takes care of the
> hard link case.

I feared that the hardlink choice was not the best one. I would
definitely prefer finding a solution that didn't depend on hardlinks:
not only there would be no worry about breaking them, it'd also be
more portable.

-- 
Giuseppe "Oblomov" Bilotta
