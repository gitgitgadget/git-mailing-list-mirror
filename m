From: roel kluin <roel.kluin@gmail.com>
Subject: Re: [PATCH] git-cget: prints elements of C code in the git repository
Date: Fri, 27 Mar 2009 10:22:42 +0100
Message-ID: <25e057c00903270222v7acad9ebxf2ed4242570f3de5@mail.gmail.com>
References: <49C8B159.2040600@gmail.com>
	 <alpine.DEB.1.00.0903241257430.7493@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Mar 27 10:24:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ln8IS-0007aT-5W
	for gcvg-git-2@gmane.org; Fri, 27 Mar 2009 10:24:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751909AbZC0JWq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Mar 2009 05:22:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752509AbZC0JWp
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Mar 2009 05:22:45 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:62637 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752064AbZC0JWp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Mar 2009 05:22:45 -0400
Received: by fxm2 with SMTP id 2so924629fxm.37
        for <git@vger.kernel.org>; Fri, 27 Mar 2009 02:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ivLp7LJXL+f/hPeFp8hZ9sCRObtRZqepZB2Y+ZuA/Wc=;
        b=EKadU883egbO5qHNLkTp1wdnp4mjkSu9zB8+AOJPXt9sXnjn05aUL8KcMYVozdA6/Q
         cB8/fNMrFZJ+9aHXGsdZKk6E6GgmTWm5VW5LhBmQC3UXlHzSCtZBO/UbMmW5y1b3PwRf
         qzxJC5Et0FFoJrrpp+xmpqcFtri0ztAwtsKIE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=eZVkfJ532VBKU8kRKqn89dvRnKGL0yUfU/enowNC8WmiV0KUfk11jXhU2B8Vat09ky
         NqdUIDsuVUtzydTuHEvh6CnGRctpGspcNB5Zti8DGpHORDJQJc3/eYfScn2Htixw7X69
         wbXqbmHbrjE4avodFDoSOZGJKfH7xQzQXFixk=
Received: by 10.223.109.148 with SMTP id j20mr1432441fap.43.1238145762305; 
	Fri, 27 Mar 2009 02:22:42 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0903241257430.7493@intel-tinevez-2-302>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114874>

Hi Johannes,

> - it misdetects functions: trying
>
>        $ ./git-cget -f get_sha1.*

The .* is not strict enough. What you want to do instead is:

$ ./git-cget -f "get_sha1[A-Za-z0-9_]*"

and that will give correct matches.

Roel
