From: "Anatoly Yakovenko" <aeyakovenko@gmail.com>
Subject: Re: GIT_SSL_NO_VERIFY=1 over http doesn't ignore a different ip address for the signed certificate
Date: Thu, 21 Feb 2008 10:57:58 -0800
Message-ID: <e26d18e40802211057o255246f3p31800c73eb8391ec@mail.gmail.com>
References: <e26d18e40802201535s7a5c12fbtd61d2445426f4018@mail.gmail.com>
	 <20080221064252.GA16036@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Mike Hommey" <mh@glandium.org>
X-From: git-owner@vger.kernel.org Thu Feb 21 19:58:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JSGct-0006Jx-F6
	for gcvg-git-2@gmane.org; Thu, 21 Feb 2008 19:58:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752240AbYBUS6A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Feb 2008 13:58:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752064AbYBUS57
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Feb 2008 13:57:59 -0500
Received: from wa-out-1112.google.com ([209.85.146.183]:61267 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751311AbYBUS57 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Feb 2008 13:57:59 -0500
Received: by wa-out-1112.google.com with SMTP id v27so148302wah.23
        for <git@vger.kernel.org>; Thu, 21 Feb 2008 10:57:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=zR3+gLqSpa0Duah4zwfi/yr6YyOINpfVUXotlDGMsKE=;
        b=NdebEQBTklmmVO3k3PjamB8k6am6DzV0P9R3BgDnEwFa/qTpWBYJRejq6W12AA8gC2xXsMvyIHmmm5Tx1bADJ47Jt8yUhL6oMOgYpO1a3GwMdSndIM/hh2jd0Q6Ty2Ms4clFmmiUS5s4sgx+LqOb8kS5E72Fh8w4IvOIqa3shig=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=HCjaZEk8WgLAtPJRBpA3SEfAZBJxJ9iU9M9haP8E39KG4v4aLsLFbedTKSRzdut15x8c/6j636yK4bNDvObMYp8uYwaSGpaKuDY03XiTvRN83papPvZcQhCd1bICZkSDSmMu2ljPxdLT1YnYbOYRHdQ1E98sifekwA5WEDsXUvs=
Received: by 10.115.106.7 with SMTP id i7mr7370976wam.18.1203620278371;
        Thu, 21 Feb 2008 10:57:58 -0800 (PST)
Received: by 10.114.167.5 with HTTP; Thu, 21 Feb 2008 10:57:58 -0800 (PST)
In-Reply-To: <20080221064252.GA16036@glandium.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74641>

yep, it tells me that the certificate is rejected because it was
signed for a different ip then the one i am connected too.  while this
is a security threat, browsers will let you ignore it, so i expect
that libcurl or git should be able to ignore that error as well.

On Wed, Feb 20, 2008 at 10:42 PM, Mike Hommey <mh@glandium.org> wrote:
>
> On Wed, Feb 20, 2008 at 03:35:54PM -0800, Anatoly Yakovenko wrote:
>  > I am not sure if its a bug in curl or git, but despite setting
>  > GIT_SSL_NO_VERIFY=1, if i use a different ip address or hostname then
>  > the certificate was signed for, git fails to push changes.
>
>  Can you try with GIT_CURL_VERBOSE=1 ? The trace message will probably
>  help understanding what happens.
>
>  Mike
>
