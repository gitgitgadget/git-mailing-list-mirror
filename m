From: dloewenherz@gmail.com
Subject: Pretty date option for git tag?
Date: Mon, 18 May 2009 11:14:40 -0400
Message-ID: <20090518151440.GA10536@andros.its.yale.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
To: gitster@pobox.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 18 17:16:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M64ZP-0007gM-2d
	for gcvg-git-2@gmane.org; Mon, 18 May 2009 17:16:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756212AbZERPOo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 May 2009 11:14:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755957AbZERPOo
	(ORCPT <rfc822;git-outgoing>); Mon, 18 May 2009 11:14:44 -0400
Received: from mail-qy0-f112.google.com ([209.85.221.112]:46293 "EHLO
	mail-qy0-f112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755276AbZERPOn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 May 2009 11:14:43 -0400
Received: by qyk10 with SMTP id 10so1316762qyk.33
        for <git@vger.kernel.org>; Mon, 18 May 2009 08:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:subject
         :message-id:mail-followup-to:mime-version:content-type
         :content-disposition:x-os:user-agent;
        bh=+PnlblwKk6chNJcZFu5XyMQ0RdjKYa+eFqURXmeFJTY=;
        b=cA9xJst0IY7w31tFCTtKWfyJAQoQCIMTr7UiZA86vYJaFWp0BhpGrxowaDXzL5snBy
         kW9y063TAK3sBPAUTRVygqi2EKFMh7pp4N901LfCv6QLoDzMe5PXxD6eCKVcyDL/Sf7r
         oM7q7sk29eTEV6H5Fecf1Pg1n9OUUhnqUlrRA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:mail-followup-to:mime-version
         :content-type:content-disposition:x-os:user-agent;
        b=qeSbQaoVSOTHc370tDVPFa1cWCNbynOlsmm7o96bjCd6FciX1fV54RLVIpbkjk8AD9
         YHQXQSoZrwQx0qyWH2hvBJMp+eebIB9s14mZGYNv4i60dvxMHL028fCVw9fKAfHGy9vV
         vK1emx8Sl6I6/CFwyFSPoHgkNyWt+qkytKMSQ=
Received: by 10.224.32.73 with SMTP id b9mr6451207qad.11.1242659683639;
        Mon, 18 May 2009 08:14:43 -0700 (PDT)
Received: from andros.its.yale.edu (dhcp128036172176.med.yale.edu [128.36.172.176])
        by mx.google.com with ESMTPS id 26sm1011819qwa.8.2009.05.18.08.14.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 18 May 2009 08:14:43 -0700 (PDT)
Mail-Followup-To: gitster@pobox.com, git@vger.kernel.org
Content-Disposition: inline
X-OS: Darwin andros 9.7.0 i386
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119449>

It is relatively hard to verify the date a tag was created unless it was been
gpg/pgp-signed at the time of creation, no? I suppose that the Unix timestamp
included in each tag file is useful for sorting, but it's not very easy for
people to digest.  Additionally, we have our `log.date` config, why not use it
here for some sort of option, like `--pretty=date` to make it easy to see when
a tag was created?

I.e.

$ git tag -l --pretty=date
...
Mon, 13 Apr 2009 00:06:25: v1.6.3-rc0
Sat, 18 Apr 2009 22:11:00: v1.6.3-rc1 
Sat, 25 Apr 2009 06:01:13: v1.6.3-rc2 
Sun, 26 Apr 2009 23:43:48: v1.6.3-rc3 
Sat, 02 May 2009 06:32:21: v1.6.3-rc4 
Wed, 13 May 2009 05:30:37: v1.6.3.1

I don't know if this is feasible. Perhaps there already exists a feature for
this that I'm unaware of. Or maybe this would be a waste of time.

Dan
