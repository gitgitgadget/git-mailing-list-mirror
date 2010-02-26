From: Mark Levedahl <mlevedahl@gmail.com>
Subject: Re: [PATCH] submodule: Improve handling of relative submodule URLs.
Date: Thu, 25 Feb 2010 21:03:50 -0500
Message-ID: <4B872C06.50502@gmail.com>
References: <1267126109-14638-1-git-send-email-jacob.helwig@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jacob Helwig <jacob.helwig@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 26 03:04:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NkpYf-0005yT-09
	for gcvg-git-2@lo.gmane.org; Fri, 26 Feb 2010 03:04:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934989Ab0BZCDz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2010 21:03:55 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:36248 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934980Ab0BZCDy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2010 21:03:54 -0500
Received: by vws16 with SMTP id 16so860997vws.19
        for <git@vger.kernel.org>; Thu, 25 Feb 2010 18:03:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=pYqltTU0PuTVZK2N0m5TWfu8PAwvTsOKucsTDQt7k/k=;
        b=oBhGKb2VCK62WD0P0T8mEVPP+HwI8oYk/ouh/k9iyWPSoevf6nCBmf6DnuYRPTozYt
         EagxiV8DUZ8xQbo7uAHiSYuLcs3VymC4VVPQXABREtKIRqF51QqFZ9P3Ae/uu5Rak9I2
         cccGNiNMO2Z9xfthWR603EmK+jR+imij0iPzQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=qsOjnM27j/v+g67wF+BIBH8bmbc22HrrbCnsyF0YMkTGb9VF2v4n51wzdLLdvzjGk4
         cNfZvmdjiUFVQWtFtl40iRRx+H3bQGqzL78FrPa099vNuFTOtKHes18e652zpoFWMItu
         x8UTuVXFKa//t0f6UCJjIHA0Bp1nHiS4j5OKc=
Received: by 10.220.126.197 with SMTP id d5mr339027vcs.118.1267149833504;
        Thu, 25 Feb 2010 18:03:53 -0800 (PST)
Received: from mark-laptop.lan (pool-173-79-105-120.washdc.fios.verizon.net [173.79.105.120])
        by mx.google.com with ESMTPS id 30sm65985132vws.1.2010.02.25.18.03.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 25 Feb 2010 18:03:52 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.7) Gecko/20100120 Fedora/3.0.1-1.fc12 Thunderbird/3.0.1
In-Reply-To: <1267126109-14638-1-git-send-email-jacob.helwig@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141088>

On 02/25/2010 02:28 PM, Jacob Helwig wrote:
> Relative URLs only worked with<proto>://<host>/<location>  style URLs, and
> would break when cloning a repository using<user>@<host>:<location>  (scp)
> style "URL"s.
>
> When a submodule's URL was set to "../submodule.git", and the repository
> using it was cloned from "git@example.com:repo.git", git would try to
> clone the submodule from "git@example.com:repo.git/submodule.git", which
> would not likely work.
>    
My solution for this has been to always give the full path, possibly using ~

e.g.,     git@example.com:~/repo.git

and as that works fine, I'm indifferent to this proposed change.

Mark
