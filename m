From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 3/3] The Makefile.PL will now find .pm files itself.
Date: Wed, 25 Jul 2012 16:31:12 -0500
Message-ID: <20120725213112.GG4732@burratino>
References: <1343186471-1024-1-git-send-email-schwern@pobox.com>
 <1343186471-1024-4-git-send-email-schwern@pobox.com>
 <20120725211143.GA5455@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com, robbat2@gentoo.org,
	bwalton@artsci.utoronto.ca, normalperson@yhbt.net
To: "Michael G. Schwern" <schwern@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 25 23:32:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Su9BY-0002jM-Vj
	for gcvg-git-2@plane.gmane.org; Wed, 25 Jul 2012 23:32:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750946Ab2GYVbT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jul 2012 17:31:19 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:41434 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750803Ab2GYVbS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jul 2012 17:31:18 -0400
Received: by yenl2 with SMTP id l2so1256508yen.19
        for <git@vger.kernel.org>; Wed, 25 Jul 2012 14:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=oCWppZCTQThZmmevHGF2JuCc/StIIh5+t9rlPeazx54=;
        b=hYmXuWtZWMsyBkghAHWb4S7exl/NqEm+fLl13yaTteHyiHDmLb+T0AW2GAAC/mCbXD
         uWY9HrKuUCCNwJy7McT6Cy/MOJcl5tnEJlCnQgnHiT/KlwwiZnE3At6DTcCI3rwb+9zz
         4hAcP+7+ApYCl1nYgpuBKb6XLGxtJOQYWQbrEIvgtFAimpwNpNv3TY82ZmUyMd97T6Ku
         x24Y+645VkelaQSMYFFGAsDWANlNCUIU0AOnvjPnoSSmobKdfHbDFkGBc1BDXbx7KvXU
         fuceQNALczX7apTTXoX8aI5HgA3/DvoOEZl0u9r1uddDvkvx0FUV3nfogMa+3l1Ry1vY
         Aswg==
Received: by 10.236.197.42 with SMTP id s30mr24965493yhn.64.1343251877786;
        Wed, 25 Jul 2012 14:31:17 -0700 (PDT)
Received: from burratino (cl-1372.chi-02.us.sixxs.net. [2001:4978:f:55b::2])
        by mx.google.com with ESMTPS id l49sm38521520yhj.8.2012.07.25.14.31.16
        (version=SSLv3 cipher=OTHER);
        Wed, 25 Jul 2012 14:31:17 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120725211143.GA5455@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202201>

Jonathan Nieder wrote:
> Michael G. Schwern wrote:

>> --- a/perl/Makefile.PL
>> +++ b/perl/Makefile.PL
>> @@ -2,6 +2,10 @@ use strict;
>>  use warnings;
>>  use ExtUtils::MakeMaker;
>>  use Getopt::Long;
>> +use File::Find;
>> +
>> +# Don't forget to update the perl/Makefile, too.
>> +# Don't forget to test with NO_PERL_MAKEMAKER=YesPlease
[...]
> Who are these comments in perl/Makefile.PL addressed to?  Why would
> such a person be looking at perl/Makefile.PL?  Sorry to sound like a
> broken record, but I don't think these questions were answered yet.

To maybe answer my own question: are these comments addressed to
people making other changes to perl/Makefile.PL, rather than people
adding new modules?

That could make sense --- it would just be a change in purpose from
the original comments.  It also means there's no reminder when adding
new modules to list them in perl/Makefile any more, but that's
probably inevitable as long as we don't have a perl coding style
document.

Hoping that clarifies,
Jonathan
