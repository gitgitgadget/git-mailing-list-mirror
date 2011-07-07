From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: generation numbers
Date: Thu, 7 Jul 2011 22:31:12 +0200
Message-ID: <201107072231.13181.jnareb@gmail.com>
References: <1307819051-25748-1-git-send-email-avarab@gmail.com> <20110707185908.GB12044@sigill.intra.peff.net> <7vliw9hoky.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Ted Ts'o <tytso@mit.edu>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?iso-8859-1?q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
	Clemens Buchacher <drizzd@aon.at>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 07 22:31:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QevEO-0003Op-CA
	for gcvg-git-2@lo.gmane.org; Thu, 07 Jul 2011 22:31:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751282Ab1GGUbY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Jul 2011 16:31:24 -0400
Received: from mail-fx0-f52.google.com ([209.85.161.52]:56385 "EHLO
	mail-fx0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750756Ab1GGUbX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jul 2011 16:31:23 -0400
Received: by fxd18 with SMTP id 18so1397922fxd.11
        for <git@vger.kernel.org>; Thu, 07 Jul 2011 13:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=iL8Lcon0nBEQ4PwSkETp67i0BTWjzbIZPkVXv1ia5dU=;
        b=pzs+8I8RjxtgIMgJqAluvg/h95B9+1WLo6zusqlXbePLiJMlj3JqrZaHeInmHmCDXW
         EYJsDrCda9PhrrmmpqH2/U+6UOCchOEwf+NXG6v0zdiISMqQ1K1bOimU+lzm+0qCxOTN
         rou3rMDcQkT6NRl2EU6mMmeLNi4Oq1UGCYwDA=
Received: by 10.223.71.194 with SMTP id i2mr1871137faj.42.1310070682090;
        Thu, 07 Jul 2011 13:31:22 -0700 (PDT)
Received: from [192.168.1.15] (abwq132.neoplus.adsl.tpnet.pl [83.8.240.132])
        by mx.google.com with ESMTPS id n27sm6924900faa.4.2011.07.07.13.31.20
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 07 Jul 2011 13:31:21 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <7vliw9hoky.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176778>

On Thu, 7 Jul 2011, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
> 
> > You could "cheat" and instead of storing the sha1 of a blob object in
> > the notes tree, use the lower 32 bits to store an actual value. I don't
> > think that currently breaks any assumptions in the notes code, but it
> > definitely is against the intent of it.
> 
> I highly suspect that it would break fsck rather badly.  You may not even
> be able to repack a repository with such a notes tree.

Well, we could (ab)use file mode to mark that what would be sha1 actually
stores fixed-width content of a file, like we do with submodules.

This technique is I think quite similar in idea to filesystems storing
contents of small files in file inode, isn't it?

-- 
Jakub Narebski
Poland
