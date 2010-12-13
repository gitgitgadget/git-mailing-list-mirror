From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC PATCH 0/2] gitweb: die_error (error handling) improvements
Date: Mon, 13 Dec 2010 10:46:38 +0100
Message-ID: <201012131046.38725.jnareb@gmail.com>
References: <20101213004259.9475.87376.stgit@localhost.localdomain> <4D058228.7040905@eaglescrag.net> <201012130855.23013.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "J.H." <warthog9@eaglescrag.net>
X-From: git-owner@vger.kernel.org Mon Dec 13 10:46:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PS4ze-00040L-1O
	for gcvg-git-2@lo.gmane.org; Mon, 13 Dec 2010 10:46:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751560Ab0LMJqu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Dec 2010 04:46:50 -0500
Received: from mail-bw0-f45.google.com ([209.85.214.45]:43072 "EHLO
	mail-bw0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751357Ab0LMJqt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Dec 2010 04:46:49 -0500
Received: by mail-bw0-f45.google.com with SMTP id 16so6384586bwz.4
        for <git@vger.kernel.org>; Mon, 13 Dec 2010 01:46:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=JQ/I+qUiBnHvzdjSlhsR+Jnr66EMWnc2pSbdTL9aBys=;
        b=fZZmx8wxZLO9gOb/9PCVo1Uamc9vyuFiciU3chcxKOiJ7R2fZsdDLMnByIqHkOWjbz
         rPW6NXw0wSOJZoA7Tcn+edNPa2Fw7SsRaviGOk2HsaNGenRP48HXoY8H2yTMWWetqT0H
         Zjd3qPXxnhU7XQLhJ5OgSjY9MDpkgGe50kU98=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=PV51xfp0a92CsYmhNow4f+RvhUE2gv6WTBy/ygPpP+xPJpbROreWLc1gc7ZGq+TxDL
         ierOEhAUKG1jiZqrTM+H4KmqCKbS402Eus0FmIjnH5mQuQS2Fp+wGQH94qRUuk7YeL6R
         W8oa8GTJ4spPDS5t8n5VuAusgitkT2YMnmSLc=
Received: by 10.204.103.132 with SMTP id k4mr3491932bko.28.1292233608474;
        Mon, 13 Dec 2010 01:46:48 -0800 (PST)
Received: from [192.168.1.13] (abwq106.neoplus.adsl.tpnet.pl [83.8.240.106])
        by mx.google.com with ESMTPS id a17sm2942591bku.11.2010.12.13.01.46.45
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 13 Dec 2010 01:46:47 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <201012130855.23013.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163529>

On Mon, 13 Dec 2010, Jakub Narebski wrote:

> Nevertheless I'll take a look how it is solved in other web applications
> written in Perl, like SVN::Web or CPAN Hubble.

SVN::Web uses eval / die... well, it uses SVN::Web::X->throw() instead
of "die" for error handling (SVN::Web::X is based on Exception::Class;
other class to use for exceprion handling is Throwable but it requires
Moose).  For errors early in the process it just uses "die".

-- 
Jakub Narebski
Poland
