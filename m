From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: Partial tree export and merging
Date: Thu, 25 Sep 2008 00:51:55 +0700
Message-ID: <fcaeb9bf0809241051se24bcf7tb836d1b820e288d6@mail.gmail.com>
References: <ACF330629DFB034AB290061C320F43460836E082@GOEMAILBE02.europe.mahr.lan>
	 <48D9FACB.20901@mahr.de> <48DA476F.1070700@mahr.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Jens Lehmann" <Jens.Lehmann@mahr.de>
To: "Heiko Voigt" <heiko.voigt@mahr.de>
X-From: git-owner@vger.kernel.org Wed Sep 24 19:53:12 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KiYY0-0003sl-IP
	for gcvg-git-2@gmane.org; Wed, 24 Sep 2008 19:53:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752095AbYIXRv4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Sep 2008 13:51:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751987AbYIXRv4
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Sep 2008 13:51:56 -0400
Received: from rv-out-0506.google.com ([209.85.198.232]:16816 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751954AbYIXRvz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Sep 2008 13:51:55 -0400
Received: by rv-out-0506.google.com with SMTP id k40so24253rvb.1
        for <git@vger.kernel.org>; Wed, 24 Sep 2008 10:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=PCRmMC4wailjVKk/7FRSVhthXr2n7CzcTELHNDPvAFk=;
        b=rswQgCQLiyc3GdDT7fVlmOrEdvDLbguhaXKtCMxhmE5YFyT4Xl8nJkxzUsdIVdKr2b
         a+sAJr1AOp875OxL2IK/PVvD6/JPV1jRvxBnr2bJ+llfoPLe8/XnUk58uEHhbvWdVA6N
         osSfDy9jJ5njlgBYWmWlGIAGbC8e09YBCu6fM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=Zsa2sXnmwgZ0d2L8bbazv0vEU9jioCdOy6TOeu9Fpn3CtrYtT4f0a1n5Pn3G7TmbL/
         MDK392fGcPk7NMOuAFv0N8ArysHauR7+VGVz3OUpGAVcOsjxssB/7IVe8fDnT1Jycm78
         ZA9spxHomN857pRbf7EkPgjzhtsr4zfiQD1bA=
Received: by 10.140.132.8 with SMTP id f8mr3620167rvd.198.1222278715062;
        Wed, 24 Sep 2008 10:51:55 -0700 (PDT)
Received: by 10.141.98.6 with HTTP; Wed, 24 Sep 2008 10:51:55 -0700 (PDT)
In-Reply-To: <48DA476F.1070700@mahr.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96669>

On 9/24/08, Heiko Voigt <heiko.voigt@mahr.de> wrote:
> Hallo,
>
>  I am currently facing a challenge for adding limited access to a git
> repository for the i18n and documentation (language) team. Our repository
> contains *.html and *.loc files which are located along with the code. The
> language team should not see the code. At the same time a developer using
> the full tree needs to be able to contribute to the i8n files.

That could be done with (under-developing) sparse checkout. Basically
language team's people do "git clone --sparse-checkout='*.loc:*.html'
your-repo.git". Then they only have *.loc and *.html files in working
directory. When they commit, all other files are unchanged. Developers
merge to have updated *.log/html as usual.

I have a question though: is language team allowed to checkout/modify
files other than *.loc and *.html?
-- 
Duy
