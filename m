From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 07/10] bisect: automatically sort sha1_array if needed when looking it up
Date: Sat, 09 May 2009 09:28:47 -0700 (PDT)
Message-ID: <m3ljp6me9v.fsf@localhost.localdomain>
References: <20090509154419.5324.96204.chriscool@tuxfamily.org>
	<20090509155548.5387.70784.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Sat May 09 18:29:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M2pQ4-0007lu-5x
	for gcvg-git-2@gmane.org; Sat, 09 May 2009 18:29:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753336AbZEIQ2t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 May 2009 12:28:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752587AbZEIQ2t
	(ORCPT <rfc822;git-outgoing>); Sat, 9 May 2009 12:28:49 -0400
Received: from mail-bw0-f174.google.com ([209.85.218.174]:55376 "EHLO
	mail-bw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752083AbZEIQ2s (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 May 2009 12:28:48 -0400
Received: by bwz22 with SMTP id 22so1879659bwz.37
        for <git@vger.kernel.org>; Sat, 09 May 2009 09:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=yFaYKDRBg7yMb9E5BZ//bPdZ3cojy++TRgZ/6LtNxZg=;
        b=Acy0tmbzokJDsSLdRASTSi6Xy0CQqhIDmljnKYYfGh/B1HZpfF/VkIQ2e4w08gUPPo
         x9b1cvT+RnmtvKDVE/4euvSkV5sA+qXnRe0L6gJN0LrfQI3WJ26pYIadaMOJCYmqy9l6
         To185Fkl0ktu18tt7GtCjWOJ7Vm+G0WfhRKpM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=ntdOMLMb9/YyN8ZcWT/uvNuknnz4uKs5aXfPRBdP/t9qch7/u4Yi1qfg/ottT2rAdj
         0OXkx6Yey7o4yMNaxo6WtkkOusL3EY8rWJoOkThiecCO3JRZB3BZyzg/4I5etpCtWlZ8
         UUUqD/GreVvtCJtcWXzU/YLXqC4ODC0qU74wY=
Received: by 10.103.248.17 with SMTP id a17mr3097866mus.83.1241886528173;
        Sat, 09 May 2009 09:28:48 -0700 (PDT)
Received: from localhost.localdomain (abvf146.neoplus.adsl.tpnet.pl [83.8.203.146])
        by mx.google.com with ESMTPS id 25sm1377932mul.59.2009.05.09.09.28.47
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 09 May 2009 09:28:47 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n49GSlbw031147;
	Sat, 9 May 2009 18:28:47 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n49GSi7u031144;
	Sat, 9 May 2009 18:28:44 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20090509155548.5387.70784.chriscool@tuxfamily.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118672>

Christian Couder <chriscool@tuxfamily.org> writes:

> This makes sha1_array easier to use, so later patches will be simpler.

Hmmm... sort on lookup array. I wonder if it would be worth
librarizing, and if there is any smart optimization for that (like
e.g. heap for fast access to smallest value and fast insertion, using
insertion sort for almost sorted array, etc.).

BTW. does it become unsorted anywhere?

-- 
Jakub Narebski
Poland
ShadeHawk on #git
