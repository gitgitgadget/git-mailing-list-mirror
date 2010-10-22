From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] Print diffs of UTF-16 to console / patches to email as UTF-8...?
Date: Fri, 22 Oct 2010 10:58:35 -0700 (PDT)
Message-ID: <m3wrpajek6.fsf@localhost.localdomain>
References: <1287763608.31218.63.camel@drew-northup.unet.maine.edu>
	<20101022161851.GH9224@burratino>
	<1287766916.31218.71.camel@drew-northup.unet.maine.edu>
	<20101022171248.GA11794@burratino>
	<1287768426.31218.75.camel@drew-northup.unet.maine.edu>
	<20101022173055.GA11923@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Drew Northup <drew.northup@maine.edu>,
	Git mailing list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 22 19:58:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9LtF-0002ee-Gk
	for gcvg-git-2@lo.gmane.org; Fri, 22 Oct 2010 19:58:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932342Ab0JVR6o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Oct 2010 13:58:44 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:41965 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932333Ab0JVR6i (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Oct 2010 13:58:38 -0400
Received: by wyf28 with SMTP id 28so1120470wyf.19
        for <git@vger.kernel.org>; Fri, 22 Oct 2010 10:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=fi4WtbyaraqzbztrJTWPcZTWfefpsuj++SK5z4obeak=;
        b=sDrKBpk9OYA4e2XQ/P+7KJlTiBR1NGqPi1ApNkFhwONo+Mtc+a7XiWPEsvYZjnrqsT
         9qpk89ISP4Vq1qmevQUz5iIqBmeYAqk+yR31G5W1sVKg2kBULSz/qLw5evzSeJ+RRlLV
         /eVk69magTHG4ac/UsXk3n4wfda9v19vK0b3o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=owKLvt4BM5g1BVhtfqgv+0TmU4Dr2N3nNx6wIiUww05upg3fJStZOvRFgOlOsddjD1
         B7Ep4Zsry8pneMn2+k5OmkVBbXJhORfmPcEMlQWZ52i2o83903ZXZh6eXVigEXGN6oFW
         tlxTTes0mZdE3+cg1uAf6vyHFUhb5toxhW/Yw=
Received: by 10.216.231.215 with SMTP id l65mr11581906weq.75.1287770316740;
        Fri, 22 Oct 2010 10:58:36 -0700 (PDT)
Received: from localhost.localdomain (abwn200.neoplus.adsl.tpnet.pl [83.8.237.200])
        by mx.google.com with ESMTPS id k4sm2118311weq.33.2010.10.22.10.58.32
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 22 Oct 2010 10:58:35 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o9MHvj9T004669;
	Fri, 22 Oct 2010 19:57:56 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o9MHvTFp004665;
	Fri, 22 Oct 2010 19:57:29 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20101022173055.GA11923@burratino>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159719>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Drew Northup wrote:
> 
> > Please forgive me for being offended that UTF-16 text is not "generic"
> > enough.
> 
> First some words of explanation.
> 
> By "generic" I did not mean ubiquitous, unbranded, popular, or some
> other almost-synonym.  What I actually meant is that it is not obvious
> what to do with UTF-16.  Should it be converted to UTF-8 for output?
> Should it always be normalized when added to the index, so that
> switching between canonically equivalent sequences does not result
> in spurious diffs?  Should the byte-for-byte representation be
> faithfully preserved, even when it is not valid UTF-16?
> 
> When in such a situation, often a good approach is the following:
> take care of mechanism first, then policy.  So the first thing to do
> is to make sure that the code is _capable_ of what people are trying
> to do; then one can try various configurations and see what is most
> convenient; and finally, one can make sure the program behaves in an
> intuitive way by setting a reasonable default.
> 
> So by "generic" I meant those mechanisms that can be used in the
> context of multiple policies.

It would be nice if there was a way (perhaps stearable via
gitattributes) to change whether Git is to treat file as sequence of
bytes (as it is now), or as sequence of characters (probably like 
Perl 6, i.e. as sequence of graphemes), though this would require
to specify encoding (and normalization) used.

Wishful thinking
-- 
Jakub Narebski
Poland
ShadeHawk on #git
