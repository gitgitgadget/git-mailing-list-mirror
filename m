From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: diff for deleted file only, when changed to directory
Date: Wed, 8 Dec 2010 02:21:03 -0600
Message-ID: <20101208082103.GA4927@burratino>
References: <AANLkTimXOKC_9TJU1foNkTqPHouFPouzZw3XU_9Za=na@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Wed Dec 08 09:21:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQFH8-0002Ur-AO
	for gcvg-git-2@lo.gmane.org; Wed, 08 Dec 2010 09:21:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754274Ab0LHIVR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Dec 2010 03:21:17 -0500
Received: from mail-gx0-f180.google.com ([209.85.161.180]:54618 "EHLO
	mail-gx0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754045Ab0LHIVQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Dec 2010 03:21:16 -0500
Received: by gxk19 with SMTP id 19so645350gxk.11
        for <git@vger.kernel.org>; Wed, 08 Dec 2010 00:21:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=6Lv69BwrhiS2xdE5HCRTpssv1ZswVHw8sHGCNeS9GCo=;
        b=Bc0Fq0IAJAXNlFvP2PdFf2FfjMC4kpdaGp29EIYoLD0LwLrdLrWu6LSP5ka6lMovrH
         mJBvG2Z9h+RzIkHcZUywtDqsxI8wRucaN555HynjjweoQ/hhBH9C9DDtaOwjriArzm76
         VC7iAXjIINtOGUdTH6wbxFyLHWMtdX8ZxUW14=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=ePAWnWWwiIsOZdr/xo9vq5YDnsSOB6hTRjJn9sej7OdAw4Y3sZ1rNH4taNWhUsL/LS
         w6k9sNQgKoiCOIs/WezriNHgZMMS9NtUExSa/x+vqfhooBOwz4vEYKuCSYKPetiyO8dF
         MEF2lZC7/wHFVZpmSJMUemO/4pTvbvE7QiHhI=
Received: by 10.151.147.17 with SMTP id z17mr3632977ybn.116.1291796475996;
        Wed, 08 Dec 2010 00:21:15 -0800 (PST)
Received: from burratino (adsl-68-255-109-73.dsl.chcgil.sbcglobal.net [68.255.109.73])
        by mx.google.com with ESMTPS id u3sm761499yba.16.2010.12.08.00.21.14
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 08 Dec 2010 00:21:14 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AANLkTimXOKC_9TJU1foNkTqPHouFPouzZw3XU_9Za=na@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163176>

Bert Wesarg wrote:

>                                                                git
> diff --cached -- foo shows me the diff for both the file foo and file
> foo/bar.
[...]
>                                              But for the case
> file->directory, I would like to see only the deleted diff, not
> recursing into the directory.

If I understand correctly, this is a documentation bug and feature
request.

The documentation bug: the "git diff" documentation says something
like

	git diff [--options] [<tree>[..<tree>]] [--] [<path>...]

but the <path>s after "--" are actually patterns (path specifiers).
See [1] ([RFD] git glossary: define pathspec, 2010-11-29).

The feature request: there is no way to specify an "exact match"
or "negative match" when specifying paths.  At least "negative
match" has been suggested before.

[1] http://thread.gmane.org/gmane.comp.version-control.git/162379
