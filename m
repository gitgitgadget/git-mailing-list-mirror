From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCHv4 15/15] Replace "unset VAR" with "unset VAR;" in
 testsuite as per t/README
Date: Fri, 1 Oct 2010 06:45:14 -0500
Message-ID: <20101001114514.GA18405@burratino>
References: <1285542879-16381-1-git-send-email-newren@gmail.com>
 <1285542879-16381-16-git-send-email-newren@gmail.com>
 <7viq1omiv8.fsf@alter.siamese.dyndns.org>
 <AANLkTimgTAerCNcSHBR9t-s-ThWHLMXdsb2T=E2w8gpB@mail.gmail.com>
 <7v39srkyax.fsf@alter.siamese.dyndns.org>
 <AANLkTimmSLwZaGvM1j7CQtTzd7mJXSiBDHztj4S97rOr@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 01 13:52:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with smtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P1eAP-00038a-Ku
	for gcvg-git-2@lo.gmane.org; Fri, 01 Oct 2010 13:52:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756686Ab0JALsY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Oct 2010 07:48:24 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:54906 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756642Ab0JALsX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Oct 2010 07:48:23 -0400
Received: by iwn5 with SMTP id 5so3730471iwn.19
        for <git@vger.kernel.org>; Fri, 01 Oct 2010 04:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=4Dn9CkLQUXnFVqDEuywv2fuehqjaItZhjE1j/A/REHo=;
        b=OGMvsZx7OE5Vzq37Whvdud8qRqr5Eiwbk7+aUHarbOmc5yC+KbvkQzXWot6Ak7sCSP
         ZS+PXGT562PmUpDtx95EEYZ0BXoiHQDSORFsHUq2MLu5/WHhX7jv3pMotslf5O7QgaYL
         WIe3mbu0PQlQ5AqVyge6iu+8JxAdbSeBL1Hh8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=AazvyL89GVfrOcOQZZBqUxuggNrJWxUFxFjNr7jrLmdYuIxEFaRl/+P7tF6G53uoOK
         nnQmMHY73SfPXK/4WHNz+NVzFIc54gupzCtLIYhEgj/YRpqmKZWL3wNiABRSalVfmWn4
         KKo+6rFflOGfo646Bxa0LT7KIobM/m39RkSys=
Received: by 10.231.16.204 with SMTP id p12mr5238561iba.194.1285933702455;
        Fri, 01 Oct 2010 04:48:22 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id u3sm1117953ibu.18.2010.10.01.04.48.21
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 01 Oct 2010 04:48:21 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTimmSLwZaGvM1j7CQtTzd7mJXSiBDHztj4S97rOr@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157748>

Elijah Newren wrote:

> What do you think of the previous suggestions in this thread for a
> portable_unset() function

That sounds fine.  Or if they are rare enough, one can use

 { unset FOO BAR BAZ || :; }

> , or for using test_might_fail in front of
> all these unset commands

I fear this would make it harder for new readers to understand what
test_might_fail does.  But if a new function to run "foo || true" is
needed, I wouldn't be opposed to adding one with a different name.
