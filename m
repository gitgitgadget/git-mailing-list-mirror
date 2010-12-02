From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] documentation: escape '~' in git revert
Date: Thu, 2 Dec 2010 12:32:57 -0600
Message-ID: <20101202183257.GH3962@burratino>
References: <1291311393-31843-1-git-send-email-sylvain.rabot@f-secure.com>
 <20101202175013.GF3962@burratino>
 <7vzksoqbjd.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sylvain Rabot <sylvain.rabot@f-secure.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 02 19:33:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PODy0-0003QC-BT
	for gcvg-git-2@lo.gmane.org; Thu, 02 Dec 2010 19:33:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757253Ab0LBSdL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Dec 2010 13:33:11 -0500
Received: from mail-ww0-f66.google.com ([74.125.82.66]:33802 "EHLO
	mail-ww0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752816Ab0LBSdK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Dec 2010 13:33:10 -0500
Received: by wwe15 with SMTP id 15so592181wwe.1
        for <git@vger.kernel.org>; Thu, 02 Dec 2010 10:33:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=dGvN6/JfFvegvunHMet3mhpmXaE5ilmLEzgzeoR3FQQ=;
        b=mVj1yh4juRd9E0om3QTpmDIgAaPbG7HOztAhX5AJSBWYYeZIlaO1Lh/I5RZ9PR8THc
         sLurWl42mi6rKzpKPfO6uUopIZjX2O4lrNC0YW92/gEADCs9tNGgYqWsEFmWV3+U0eIS
         53pQcFn2A/sroaf7GXElVDWflcgkhMcV/lpmk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=I07mJaiyFH56DZRfJ2qKQPVtjRaWVp9s8IE50Kx4O0Gsk1ZJgzdzhP4jooMzdlurkU
         JoYxYPN6cP8LJKFsfcRVIEI+Pxsqzk4pZldig0/2UwNzy0PaCCOFAB5y425ioR20hUNw
         4tc6gZrK4BHVv+URrM1srDIAwa4MXd3bt9gG0=
Received: by 10.216.162.70 with SMTP id x48mr3887713wek.4.1291314789048;
        Thu, 02 Dec 2010 10:33:09 -0800 (PST)
Received: from burratino (adsl-68-255-109-73.dsl.chcgil.ameritech.net [68.255.109.73])
        by mx.google.com with ESMTPS id x15sm429880weq.7.2010.12.02.10.33.06
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 02 Dec 2010 10:33:07 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7vzksoqbjd.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162728>

Junio C Hamano wrote:

> There is one funny I do not understand (oh, well, I admit that I do not
> understand many funnies around AsciiDoc).  The two extra lines you would
> find if you drop "::$" from the above, namely,
> 
>     git-rebase.txt:    git rebase --onto topicA~5 topicA~3 topicA
>     user-manual.txt:$ git merge-file hello.c~2 hello.c~1 hello.c~3
> 
> do not seem to suffer from this issue.  IOW, it seems to affect only the
> enumeration head items.

FWIW I suspect those are both "literal" environments, thus governed
by the rule described in v1.6.0-rc0~152 (git-format-patch(1): fix
stray \ in output, 2008-07-02).

Based on "git grep -e '~[^~].*~' -- Documentation/", I think you found
them all, unless there are some examples span multiple lines.
