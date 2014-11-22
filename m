From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/6] prune_remote(): exit early if there are no stale
 references
Date: Sat, 22 Nov 2014 13:07:25 -0800
Message-ID: <20141122210725.GB15320@google.com>
References: <1416423000-4323-1-git-send-email-sbeller@google.com>
 <1416578950-23210-1-git-send-email-mhagger@alum.mit.edu>
 <1416578950-23210-2-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ronnie Sahlberg <sahlberg@google.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Sat Nov 22 22:07:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XsHtv-0003ex-J2
	for gcvg-git-2@plane.gmane.org; Sat, 22 Nov 2014 22:07:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752772AbaKVVHW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Nov 2014 16:07:22 -0500
Received: from mail-ig0-f181.google.com ([209.85.213.181]:49257 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752688AbaKVVHT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Nov 2014 16:07:19 -0500
Received: by mail-ig0-f181.google.com with SMTP id l13so1503013iga.2
        for <git@vger.kernel.org>; Sat, 22 Nov 2014 13:07:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=8eaz7KmuzzlnWJF6oD+SPIVg0qQSG9D0OM3kTr8ZQAw=;
        b=mH0f0awwFOxWENZZtppSN83ByUpd1znLpRyYdqtx3JEkIb4mCcfyThIcZFGEAfGSdz
         Bwa0SNXfK/ZykAzxsp8jdmth6g4iGtcQkTIpCrfArTI1ZpGSXzv8IjzSJgGM01Nc8daZ
         SnSVB8feKghDsIce+jwayMpY1SECwmPSY+wU2Bbmh93n2p5rePgSVwN7pGQy0azLRC8u
         iPz5BpehpOraUsFGMy0WzxBLjIvH1WaOALdFvosL4AzT98Lhp5m7oJbid8TQmIit9nO1
         4xhoJXfkDkM6hXrHAKKkrXmAyYzMA5M1HPLqQdcth7uQUU3T2EIaZoXRhvL5SnrtOtem
         ZwnQ==
X-Received: by 10.107.130.30 with SMTP id e30mr9555517iod.87.1416690438809;
        Sat, 22 Nov 2014 13:07:18 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:8d62:add2:ab4d:c706])
        by mx.google.com with ESMTPSA id f4sm5055576ioe.11.2014.11.22.13.07.17
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sat, 22 Nov 2014 13:07:18 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1416578950-23210-2-git-send-email-mhagger@alum.mit.edu>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260076>

Michael Haggerty wrote:

> Aside from making the logic clearer, this avoids a call to
> warn_dangling_symrefs(), which always does a for_each_rawref()
> iteration.
>
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---
>  builtin/remote.c | 39 +++++++++++++++++++++------------------
>  1 file changed, 21 insertions(+), 18 deletions(-)

I had been wondering about this but didn't chase it down far enough.
Thanks for noticing and cleaning it up.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
