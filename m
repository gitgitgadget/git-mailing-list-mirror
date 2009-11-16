From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: git am and CRLF files
Date: Mon, 16 Nov 2009 19:50:36 +0900
Message-ID: <20091116195036.6117@nanako3.lavabit.com>
References: <4AFD2A8F.7000806@atlas-elektronik.com> <4B01004A.8060600@atlas-elektronik.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Naewe <stefan.naewe@atlas-elektronik.com>
X-From: git-owner@vger.kernel.org Mon Nov 16 11:51:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N9zAx-0002aX-Rj
	for gcvg-git-2@lo.gmane.org; Mon, 16 Nov 2009 11:51:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752577AbZKPKuv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Nov 2009 05:50:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752579AbZKPKuu
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Nov 2009 05:50:50 -0500
Received: from karen.lavabit.com ([72.249.41.33]:48140 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752342AbZKPKut (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Nov 2009 05:50:49 -0500
Received: from c.earth.lavabit.com (c.earth.lavabit.com [192.168.111.12])
	by karen.lavabit.com (Postfix) with ESMTP id 67F0711B94A;
	Mon, 16 Nov 2009 04:50:51 -0600 (CST)
Received: from 6910.lavabit.com (customer-148-233-239-23.uninet.net.mx [148.233.239.23])
	by lavabit.com with ESMTP id ET3B4V1UF8AQ; Mon, 16 Nov 2009 04:50:51 -0600
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=Zsi8JSGMiSMvelIGxZY30FAqhfmkoOeRgmYqNdH51eCDVWALrscg9JLSvk1gyyspsgSTJSx0vvpfU3iFyZsnpPRKzmBpYVkjM/ksLAjX6m2rjO52/njsVQXBzD49hBOxVUnyS04n1Mk4B1SY7jY55/M0weCnv12Cy1Zkqo62xaE=;
  h=From:To:Cc:Subject:References:In-Reply-To:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-Reply-To: <4B01004A.8060600@atlas-elektronik.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132996>

Quoting Stefan Naewe <stefan.naewe@atlas-elektronik.com>

>> A repository with some UNIX (LF) and some Windows (CRLF) files.
>> (and no: I will not change the files. My editors handle CRLF and LF correctly)
>> 
>> My problem:
>> 
>> 'git am' can't handle changes in CRLF files because the patch
>> gets converted (by git mailsplit) to contain only LF.
>
>> Stefan
>
> Does anyone have any comment on this ?

This was done very much on purpose.

The "am" command is meant to handle e-mailed patches, and traditionally
mails are known to clobber carriage returns.

See commit c2ca1d79dbd54b06a05e5d14a897699e59dc9f9f

    Allow mailsplit (and hence git-am) to handle mails with CRLF line-endings
    
    It is not that uncommon to have mails with DOS line-ending, notably
    Thunderbird and web mailers like Gmail (when saving what they call
    "original" message).  So modify mailsplit to convert CRLF line-endings to
    just LF.

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
