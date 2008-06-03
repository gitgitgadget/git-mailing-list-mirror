From: "Rafael Garcia-Suarez" <rgarciasuarez@gmail.com>
Subject: Re: [PATCH] Avoid errors from git-rev-parse in gitweb blame
Date: Tue, 3 Jun 2008 15:36:26 +0200
Message-ID: <b77c1dce0806030636i434e4716r8a52d6aeb93e9719@mail.gmail.com>
References: <1212489977-26822-1-git-send-email-rgarciasuarez@gmail.com>
	 <200806031445.23002.jnareb@gmail.com>
	 <b77c1dce0806030600x520d35edxbe6e732ce6cc4ad6@mail.gmail.com>
	 <200806031512.20729.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Luben Tuikov" <ltuikov@yahoo.com>
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 03 15:37:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3WhV-0006Za-BF
	for gcvg-git-2@gmane.org; Tue, 03 Jun 2008 15:37:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752646AbYFCNg2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jun 2008 09:36:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752574AbYFCNg2
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jun 2008 09:36:28 -0400
Received: from rv-out-0506.google.com ([209.85.198.227]:20033 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751413AbYFCNg1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jun 2008 09:36:27 -0400
Received: by rv-out-0506.google.com with SMTP id l9so1581514rvb.1
        for <git@vger.kernel.org>; Tue, 03 Jun 2008 06:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=L1XD7IuJxPekvmFOViCVpBQdqFGwqQzfN2BLZFdp4u4=;
        b=E6xPTqV1QXxvwV39+z6n0s6Mfpr5xZTgVgOKXXR/A3a5Lsh64lehSb1Dk17UB34kiSfbFOAvP2DTw1u2v1rWRPwiKrKu1j2kzQ/w9XwGi2XOIYAg39oNHFCexfWbwrPlZwWVpbGd08zZlWk7s7aZ43K0o10TkHncUwBntgDVyVc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=AkwiyaijPqO/bIrXB0gYudNgAUDu8PNJShXsUxPH0rhuaI7zbtLBJN9uMPMNkbBvMsk7hfE3k3jF3p2koLcgRDMV4cbPpq8jOpPFVqsr3BU38KGS8UyoJNorBzrU/UgGcxxP+46EYsthLcHX0R8nNbKylkZYT1AMrPf7fsHQe6A=
Received: by 10.141.18.14 with SMTP id v14mr5727959rvi.125.1212500186816;
        Tue, 03 Jun 2008 06:36:26 -0700 (PDT)
Received: by 10.141.178.21 with HTTP; Tue, 3 Jun 2008 06:36:26 -0700 (PDT)
In-Reply-To: <200806031512.20729.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83656>

2008/6/3 Jakub Narebski <jnareb@gmail.com>:
>>
>> OK, I see. That would be nice. Also: currently taking "$full_rev^"
>> directs the user to the parent commit, but it would be more
>> user-friendly to point at the previous commit where the selected file
>> was modified instead.
>
> That's what I meant by distinguishing between 'parents' and
> 'original-parents' (or 'rewritten-parents' and 'parents'): first are
> rewritten parents in history limited to specified file (with the
> addition of code movements and copying across files/filenames),
> second are original parents of a commit.
>
> For gitweb we would use the first set (I wonder what to do in the case
> of merge commit, i.e. more than one parent).

Currently that takes the left parent. Or something.

Shameless plug : the sources for perl 5 are currently being kept in a
perforce repository. There is a rough web interface to it at
http://public.activestate.com/cgi-bin/perlbrowse with excellent blame
log navigation features (including navigation against p4
integrations).

Since we're going to move the official perl 5 vcs to git (many many
thanks to Sam Vilain for that, BTW), I'm more or less trying to
duplicate this blame log navigation in gitweb. So it might result in a
few patches here :)
