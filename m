From: Andrew Wong <andrew.kw.w@gmail.com>
Subject: Re: blame -C: adding a line in moved content sometimes affect blame
 result
Date: Wed, 08 Jun 2011 21:31:44 -0400
Message-ID: <4DF02280.8080004@gmail.com>
References: <4DEF041A.9070003@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Andrew Wong <andrew.kw.w@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 09 03:31:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUU6E-0001bZ-7O
	for gcvg-git-2@lo.gmane.org; Thu, 09 Jun 2011 03:31:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752216Ab1FIBbs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2011 21:31:48 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:51444 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751988Ab1FIBbr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2011 21:31:47 -0400
Received: by iyb14 with SMTP id 14so921111iyb.19
        for <git@vger.kernel.org>; Wed, 08 Jun 2011 18:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=8r/NHs/5UiLAK56gKs4xxDJhfdypbSCri2x2S+cZb6k=;
        b=bxK2Nd6hgPG+qbVITIN/UgH1QZFURMaY6uqgIt9ltwU+MxOCT5qlo5dUZ8KyO5DFcU
         YFyO/KU9NI/cRFLWy5VxvR/ITX8Fzc3J9bgsZHRdDAc2iCy9ra3GWvw0/m/OPJZltYeY
         guI+lUFYv8CRQ8W2R3qrhbt/fI9L8SS1VfAvA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=T8sxL4Q9+pYVRAAq6+L2b6htZZfAuhFkD9P0H0fgxciUE3PemUCdM4UPDnBbnqNUy3
         a65nxFU+28AZk7ohYUp9fYnD1PBJtMKfHkQ9H4tcyTuPwSh4i0jRWff9T6IpEe/oyhGN
         SBkNQJ0PWWElopPY2HD9X0jjOtJ0kpJZHs3+Y=
Received: by 10.42.180.10 with SMTP id bs10mr194668icb.321.1307583107299;
        Wed, 08 Jun 2011 18:31:47 -0700 (PDT)
Received: from ZanarkandMac.local (24-246-58-202.cable.teksavvy.com [24.246.58.202])
        by mx.google.com with ESMTPS id d10sm538895ibb.66.2011.06.08.18.31.45
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 08 Jun 2011 18:31:45 -0700 (PDT)
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-US; rv:1.9.2.17) Gecko/20110414 Thunderbird/3.1.10
In-Reply-To: <4DEF041A.9070003@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175483>

On 11-06-08 1:09 AM, Andrew Wong wrote:
> I've attached a script for illustration.
>
> After moving content from file1 to file2, "git blame -C file2" 
> correctly shows that the content came from file1. However, if I add a 
> line in near the top or bottom of the moved content in file2, "git 
> blame -C file2" fails to detect that the top or bottom of the moved 
> contents came from file1. I looked around in blame.c, and this feels 
> like a boundary case somewhere inside find_copy_in_blob? Any clues?
Anyone has any ideas regarding this issue?
