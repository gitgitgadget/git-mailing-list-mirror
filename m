From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2] Introduce CHERRY_PICK_HEAD
Date: Thu, 17 Feb 2011 16:16:45 -0600
Message-ID: <20110217221645.GA10007@elie>
References: <1297850903-65038-2-git-send-email-jaysoffian@gmail.com>
 <1297876835-70613-1-git-send-email-jaysoffian@gmail.com>
 <20110216214236.GC2615@elie>
 <AANLkTimBExej1mF=4UuTszcSoKy_xnj7bB3BaT5ze2vH@mail.gmail.com>
 <20110216230250.GF2615@elie>
 <7vpqqqbfgr.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 17 23:17:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqC9s-0004kE-7j
	for gcvg-git-2@lo.gmane.org; Thu, 17 Feb 2011 23:17:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753612Ab1BQWQ7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Feb 2011 17:16:59 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:53711 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752053Ab1BQWQ5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Feb 2011 17:16:57 -0500
Received: by wyb28 with SMTP id 28so3041273wyb.19
        for <git@vger.kernel.org>; Thu, 17 Feb 2011 14:16:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=v2b8V5HsWB/7kKLf4AtOntyn0g/S1oyhOCl7XX4au0s=;
        b=UopdqNp4IYJNOhXYb6+Xf9UubCemTJqobth+5yy0OaIMei0ObP9faOWkAZP22VMDmj
         FsSTTtMOC6EyZ+qI5dKsLSm6zb6sz2c4rDVejAPWi67Nn7tulYyEpZy7d7qRcKQ7QWEz
         v1BpF7GrG1dQMqRUNO/SBtnkbW5KflGEhs/Bs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=w7MyT+mvF2zPo2NvFTKNaFq6SM7rvV11ANzCreYIEJ+DrGzxsF4hQIMA2iRRHjuUZ+
         6qWYnDpCI8jkmGtR/JtOxrxDa+Ieok4hbDtgezr/1/quYEYwDbcjEBDSnQm0E41qg6E6
         9GXretG4YZcwnc0snt5mkqTwPOz4atAFdCS90=
Received: by 10.227.10.81 with SMTP id o17mr2083952wbo.14.1297981016594;
        Thu, 17 Feb 2011 14:16:56 -0800 (PST)
Received: from elie (adsl-69-209-51-217.dsl.chcgil.ameritech.net [69.209.51.217])
        by mx.google.com with ESMTPS id y29sm1082915wbd.22.2011.02.17.14.16.54
        (version=SSLv3 cipher=OTHER);
        Thu, 17 Feb 2011 14:16:55 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7vpqqqbfgr.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167128>

Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:

>> Wait, does this mean that -c/-C/--amend/CHERRY_PICK_HEAD overrides
>> GIT_AUTHOR_NAME, GIT_AUTHOR_EMAIL, and GIT_AUTHOR_DATE?
[...]
> Hmph, -c/-C/--amend is like giving the identity with --author from the
> command line so overriding the values from the environment variables
> sounds like the right thing to do.

Good point.  There are two principles at work here:

 - options with more specific effect override more general ones
 - options on the command line override the environment

On second thought, the latter does seem more relevant (though it need
not apply to CHERRY_PICK_HEAD).

Thanks for a sanity check.
Jonathan
