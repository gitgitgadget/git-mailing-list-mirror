From: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
Subject: Re: git-svn and core.autocrlf on windows
Date: Tue, 29 Jun 2010 10:32:48 +0200
Message-ID: <67C8E0A3-1A07-4F9E-965E-8E97C846D3D2@gmail.com>
References: <AANLkTin2CIla9AOt8bRVbQPgyNKhvY6LauOVRc1LqGuQ@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: "git@vger.kernel.org List" <git@vger.kernel.org>,
	kusmabite@gmail.com
To: MrUnleaded <mrunleaded@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 29 10:33:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OTWFd-00008f-Dt
	for gcvg-git-2@lo.gmane.org; Tue, 29 Jun 2010 10:33:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752300Ab0F2Icz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jun 2010 04:32:55 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:58132 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751501Ab0F2Icx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Jun 2010 04:32:53 -0400
Received: by wyb38 with SMTP id 38so2477846wyb.19
        for <git@vger.kernel.org>; Tue, 29 Jun 2010 01:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:references:in-reply-to
         :mime-version:content-type:message-id:content-transfer-encoding:cc
         :from:subject:date:to:x-mailer;
        bh=1O9Dvt+T78BaCXTpjj0RwAReTmS1LA64qDQGFrk4KwE=;
        b=nyHj3/jjwO/27HOg6qCkhjMb++VOARdBLyyzSW067CgKwxQ0bnqVGoxKpWHru30mY3
         2PqcBa83v/Pziu/Ve/upAuAxVEugW/gtNB+ZGXbaHTucW2EbXNdEjYvsi9zX3uVSetP7
         7TC6rm0Ky+9NkWKmHL8jPGh89gTZNlHifr+o8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=references:in-reply-to:mime-version:content-type:message-id
         :content-transfer-encoding:cc:from:subject:date:to:x-mailer;
        b=tF4itmbqvXvUbbXCqgA5DeTB6y4eVUryTAR8oQqIqweYOTzT3eqC6UfkFqMxvlBiTW
         fGRLH7Co46cNnrP+H5gXCxVoTwvKIQ5Y8dAbqdfIMbNp+lvq0h0E4LWxXBXQSIHB8nZ1
         LHLt1sexAhcHPTv7xB9OeK/MtCO+/mCEfNXkQ=
Received: by 10.227.69.201 with SMTP id a9mr4907746wbj.5.1277800372371;
        Tue, 29 Jun 2010 01:32:52 -0700 (PDT)
Received: from [10.36.80.159] ([62.113.137.5])
        by mx.google.com with ESMTPS id 6sm27932738wbz.22.2010.06.29.01.32.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 29 Jun 2010 01:32:51 -0700 (PDT)
In-Reply-To: <AANLkTin2CIla9AOt8bRVbQPgyNKhvY6LauOVRc1LqGuQ@mail.gmail.com>
X-Mailer: Apple Mail (2.1081)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149892>

On 28. juni 2010, at 19.01, MrUnleaded wrote:

> Hello, I was wondering what the best or correct setting for
> core.autocrlf would be when using git-svn to commit to a subversion
> repository that is a windows project(ie CRLF line endings).
> 
> The documentation says that text documents are converted to LF line
> endings in the repo. If you commit to subversion will if convert that
> commit to have the line endings you have on your system? Or will it
> use LF line endings regardless?

"core.autocrlf=false" is the safest setting, but according to this thread:

	http://kerneltrap.com/mailarchive/git/2010/3/4/24918/thread

git-svn works with core.autocrlf now.  The fix was included in git 1.7.1.

To answer your question, you will end up with the correct line endings in your Subversion repository if the svn:eol-style property is set to "native" for all text files, regardless of how git is configured.  If the property is not set, you should turn off autocrlf.
-- 
Eyvind
