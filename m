From: "Anatoly Yakovenko" <aeyakovenko@gmail.com>
Subject: Re: GIT_SSL_NO_VERIFY=1 over http doesn't ignore a different ip address for the signed certificate
Date: Thu, 21 Feb 2008 17:27:20 -0800
Message-ID: <e26d18e40802211727w4f7f5b37vc73a756f6b384289@mail.gmail.com>
References: <e26d18e40802201535s7a5c12fbtd61d2445426f4018@mail.gmail.com>
	 <20080221064252.GA16036@glandium.org>
	 <e26d18e40802211057o255246f3p31800c73eb8391ec@mail.gmail.com>
	 <20080221190954.GA24759@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Mike Hommey" <mh@glandium.org>
X-From: git-owner@vger.kernel.org Fri Feb 22 02:28:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JSMhj-0005X2-7a
	for gcvg-git-2@gmane.org; Fri, 22 Feb 2008 02:27:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935830AbYBVB1X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Feb 2008 20:27:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935735AbYBVB1W
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Feb 2008 20:27:22 -0500
Received: from wa-out-1112.google.com ([209.85.146.179]:55287 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934325AbYBVB1V (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Feb 2008 20:27:21 -0500
Received: by wa-out-1112.google.com with SMTP id v27so260044wah.23
        for <git@vger.kernel.org>; Thu, 21 Feb 2008 17:27:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=kepfDq37faRxcAu/wKRAzc3M7ZEqGQUxShp36dd4nLI=;
        b=L9EhZVSJU/mKfh1b6RD5/hj6jpgbJe5mZiFIP+Sf524Gzah/hszERMuS+CN2/ylVofdms4+U4Z7jZgeKyZS/2ofUkknpgamkyHRlktYIsH6uH3BYSEwrxdd2mTo2F/SZ8Q86tLss/gLb/fCDyU+bEJxjEDvtXsVS7NXSqYJ05Xs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=OV4nm6hfPcjecFMgfBQVnAdyID9wkkp9PMMpSD0vRvhxnA8GghuYgDx+v2YWA9gHOJAmkMFKH7bdCvA9rzLQvB0STHue8WnE3DNrnfox3sORTOfyMLHJ7LxlIqvEtn2fm3sKL3znq5xyhmJyI0WHrXktDV7aPhJuiMyx8MSG/MA=
Received: by 10.115.78.1 with SMTP id f1mr5249833wal.100.1203643640603;
        Thu, 21 Feb 2008 17:27:20 -0800 (PST)
Received: by 10.114.167.5 with HTTP; Thu, 21 Feb 2008 17:27:20 -0800 (PST)
In-Reply-To: <20080221190954.GA24759@glandium.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74688>

On Thu, Feb 21, 2008 at 11:09 AM, Mike Hommey <mh@glandium.org> wrote:
> On Thu, Feb 21, 2008 at 10:57:58AM -0800, Anatoly Yakovenko wrote:
>  > yep, it tells me that the certificate is rejected because it was
>  > signed for a different ip then the one i am connected too.  while this
>  > is a security threat, browsers will let you ignore it, so i expect
>  > that libcurl or git should be able to ignore that error as well.
>
>  What is the exact message ?

$ GIT_SSL_NO_VERIFY=1 GIT_CURL_VERBOSE=1 git clone
https://aeyakovenko@127.0.0.1/git

i get this as an error:

error: SSL: certificate subject name 'localhost' does not match target
host name '127.0.0.1' (curl_result = 51, http_code = 0, sha1 =
4590de71622f1a90f906413fd7f63d5553cd5f93)

cloning https://aeyakovenko@localhost/git works fine
