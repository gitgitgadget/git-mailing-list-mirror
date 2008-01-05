From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Test "git log --diff-filter"
Date: Sun, 6 Jan 2008 00:33:02 +0100
Message-ID: <200801060033.03672.jnareb@gmail.com>
References: <1198580807-18802-1-git-send-email-arjen@yaph.org> <1199571622-12953-1-git-send-email-jnareb@gmail.com> <7vsl1b7vhb.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Arjen Laarhoven <arjen@yaph.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 06 00:33:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JBIWI-00073F-Py
	for gcvg-git-2@gmane.org; Sun, 06 Jan 2008 00:33:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753093AbYAEXdK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jan 2008 18:33:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753035AbYAEXdJ
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Jan 2008 18:33:09 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:53324 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752303AbYAEXdH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jan 2008 18:33:07 -0500
Received: by ug-out-1314.google.com with SMTP id z38so2961883ugc.16
        for <git@vger.kernel.org>; Sat, 05 Jan 2008 15:33:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=RfwUE/z0CDWWyo88i+1J9AKpoNeQZW/Fo+V/d7GgysM=;
        b=AGK+Do7nlzXqRt3dHAYkDaykwnXTkADMPvFLztIdf5ZJowLcoNmUG8ikH5j0esHiovtRYMSo/ihNa2hG385Ec2V5xgYPwK2PC0ilnKPrSTW1K7mIPyj8+6xbEnyvhBOTmrD7TtI/azKitrjQbi3YyXUTe5Vfk7ThvAbYroS1NuM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=XYdrhnDWzwf66cE2yUsFs2IgYPSk02IwH5xk4O5iqhZquUgQ3vYYjln3gqup/qZ+9PPRYq4T3l2K+72Vs/46Djwdt3ahop0az8Cl95dqqKugRcVNlseDYKzr7PaRjh2WWG3MIVQIqZ4Od/bbB5DTMKY9HygGHoZivicjZjmv7q8=
Received: by 10.67.22.2 with SMTP id z2mr2386532ugi.1.1199575979027;
        Sat, 05 Jan 2008 15:32:59 -0800 (PST)
Received: from ?192.168.1.11? ( [83.8.190.130])
        by mx.google.com with ESMTPS id z40sm27929203ikz.4.2008.01.05.15.32.55
        (version=SSLv3 cipher=OTHER);
        Sat, 05 Jan 2008 15:32:56 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <7vsl1b7vhb.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69694>

Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
> > Add test to check "git log --diff-filter" works correctly with and
> > without diff generation by git-log; the main purpose of this test is
> > to check if "git log --diff-filter" filters revisions correctly.
> >
> > This is a companion test to commit 0faf2da7e5ee5c2f472d8a7afaf8616101f34e80
> > (Fix "git log --diff-filter" bug) by Arjen Laarhoven.
> 
> If you look at the commit, you'd notice that I've added
> necessary test when I accepted the patch from Arjen already ;-).

Sorry for the noise, then.

> Does this new set of tests check something new?

My test checks all --diff-filter filters relevant to git-diff-tree,
i.e. ADMRCBT, and not only AMD.

Also it checks if the diff is shown correctly for --diff-filter=M and
for --diff-filter=M*, but I think this should be a separate test, and
use only git-diff-something, and not git-log.


P.S. By the way, it is IMHO a bit strange that --pretty=oneline uses
newline as a terminator (it means that there is a newline at the end of
"git log --pretty=oneline), while --pretty="format:%s" uses newline as
a separator (meaning that there is no newline at the end) when redirected
to file.

 # git log --pretty="format:%s" -B -C -C >current

The 'current' file doesn't end with newline (with --pretty=oneline it
does), when log ends at root commit. Strange.

-- 
Jakub Narebski
Poland
