From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v3 2/3] Add the 'fetch.recurseSubmodules' config setting
Date: Thu, 11 Nov 2010 02:27:48 -0600
Message-ID: <20101111082748.GA15525@burratino>
References: <4CDB3063.5010801@web.de>
 <4CDB30D6.5040302@web.de>
 <20101111000216.GA14189@burratino>
 <4CDBA5FD.20802@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Kevin Ballard <kevin@sb.org>,
	Jon Seymour <jon.seymour@gmail.com>,
	Chris Packham <judge.packham@gmail.com>,
	Marc Branchaud <marcnarc@xiplink.com>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Thu Nov 11 09:28:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PGSW2-0000PZ-MH
	for gcvg-git-2@lo.gmane.org; Thu, 11 Nov 2010 09:28:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757813Ab0KKI2O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Nov 2010 03:28:14 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:41536 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757769Ab0KKI2N (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Nov 2010 03:28:13 -0500
Received: by gxk23 with SMTP id 23so1004972gxk.19
        for <git@vger.kernel.org>; Thu, 11 Nov 2010 00:28:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=2kIs6EgEa6DWZ/LgGl2ElkYiAbLpFZQjq7yJ3apYHGk=;
        b=JVicns6DbVS5LZ11Yrm+yKhcLq3MNDb81a7XAKP/4SjwHScQ+peUYu+a6IEohXNlfG
         2Oni9NA8KtbpFCWPDUgsqSFyUd8ZTeT9qVFq140IoqsjwVXHxmYFueeqDanp9xRLyMdg
         mCJ2vGScQ9eK4l4ymbuASVtpI7eDqPPVn60SQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=Q9k9mVZZ9pEONyeIwVdC3jBdNXuQC7/iCch0ZWa/iJRVYJ2eEL+w0X4xGLcFj0JQCM
         aPQmJreOLNtyPdM7u2Ts/BFz/wo9WN3dwAF1imeC0nPd45hhm2m13v7z+LCIuU03QFIq
         XrXbadqN4yjgUHPAtYIQxwo+qIY8wyLG5/YoI=
Received: by 10.100.112.4 with SMTP id k4mr348886anc.66.1289464092614;
        Thu, 11 Nov 2010 00:28:12 -0800 (PST)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id t23sm2047626ano.27.2010.11.11.00.28.10
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 11 Nov 2010 00:28:11 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4CDBA5FD.20802@web.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161217>

Jens Lehmann wrote:
> Am 11.11.2010 01:02, schrieb Jonathan Nieder:

>> This configuration item is read from .gitmodules, too, right?  Would
>> it be easy (or desirable) to make it not read from there?  Either way,
>> it would be nice to have a test so the behavior doesn't change without
>> anyone noticing.
>
> "fetch.recurseSubmodules" is only read from .git/config. The one read
> first from .gitmodules and then from .git/config is the per-submodule
> setting "submodule.<name>.fetchRecurseSubmodules" added in 3/3.

Sorry for the nonsense.  Would it be easy (or desirable) to make
_that_ one not be read from .gitmodules?

>                                                                 But
> maybe I should add a test that "fetch.recurseSubmodules" also works
> when set in the global config ...

Yes, I agree that such a test would be good (though less important
than a test for the behavior with no configuration set at all, say).
A test to demonstrate that configuration aside from submodule.* is not
read from .gitmodules would also be good imho, but I don't think it's
a blocker for anything. :)
