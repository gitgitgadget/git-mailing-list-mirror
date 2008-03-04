From: "Mike Ralphson" <mike.ralphson@gmail.com>
Subject: Re: t3900-i18n-commit.sh problem on Solaris
Date: Tue, 4 Mar 2008 16:11:51 +0000
Message-ID: <e2b179460803040811y38e639b6wa83857c49b55aa05@mail.gmail.com>
References: <8ec76080803040751y4bf808f9ma83a9faa4f857039@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Whit Armstrong" <armstrong.whit@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 04 17:12:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWZkl-0008Ss-79
	for gcvg-git-2@gmane.org; Tue, 04 Mar 2008 17:12:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763461AbYCDQLy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Mar 2008 11:11:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763401AbYCDQLy
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Mar 2008 11:11:54 -0500
Received: from rv-out-0910.google.com ([209.85.198.189]:32583 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763339AbYCDQLx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Mar 2008 11:11:53 -0500
Received: by rv-out-0910.google.com with SMTP id k20so544979rvb.1
        for <git@vger.kernel.org>; Tue, 04 Mar 2008 08:11:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=I6zmTJ7NVtKrOXninUMc3qGMQ3dja+Rz+RmDDT+4Hsw=;
        b=YJFZ43KGQHQUVKIM8hyK6Lsodqs1fgaVIb7WLqzdMLcapsIMswp2sXhO9F0xECoFT1etKdYUbmFtEBQhreznv38PWeV+uxQpmUDmAcd+yOrAbaEncwygkDWVhXo0nisnckUVgTEE2VjAn5FENqN1W3LdrXmn3Uxcet6pW6xPN3c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=XlLVaCnbokDY8+hcccRBqPWjqkk58MgT+oOUfhbpPXCp3RCEo+p+ikrLOfvUhUgzcS1Cr7pJr4daZV+0+CXFyKwbxJcEt7QhK9x7fhGiytdMd/p6W7rVuplP20iqvSx32K18d+noK+i7R7Svwolc9/W7ChlV9FaI+WeWlI2gAxE=
Received: by 10.141.43.5 with SMTP id v5mr689892rvj.216.1204647111279;
        Tue, 04 Mar 2008 08:11:51 -0800 (PST)
Received: by 10.141.19.11 with HTTP; Tue, 4 Mar 2008 08:11:51 -0800 (PST)
In-Reply-To: <8ec76080803040751y4bf808f9ma83a9faa4f857039@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76112>

On 04/03/2008, Whit Armstrong <armstrong.whit@gmail.com> wrote:
> this is with git latest: c95b3ad9ea310ec89e31a21edecaaf2c374e2c46
>  (GIT_VERSION = 1.5.4.3.447.gc95b3)
>
>
>  xs5-trd-p1.grn:warmstro> sh t3900-i18n-commit.sh -i -v
>  ...
>  ...
>  ...
>  * FAIL 22: ISO-2022-JP should be shown in EUCJP now
>
>  Is this a Solaris problem?

Could be. Some builtin iconv() functions / libiconv implementations
don't seem to have support for all of the character encodings git
expects.

Are you able to link against a current GNU libiconv instead?

Mike
