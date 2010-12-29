From: Jonathan Nieder <jrnieder@gmail.com>
Subject: shared hooks (Re: help for a git newbie please)
Date: Wed, 29 Dec 2010 13:17:17 -0600
Message-ID: <20101229191717.GA19195@burratino>
References: <20053D7ED46E664F8B9A4D5E5B31937407197534@MBX021-W4-CA-1.exch021.domain.local>
 <m3k4iscsq2.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Marlene Cote <Marlene_Cote@affirmednetworks.com>,
	git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 29 20:18:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PY1XH-00012U-1O
	for gcvg-git-2@lo.gmane.org; Wed, 29 Dec 2010 20:18:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753862Ab0L2TRs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Dec 2010 14:17:48 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:48883 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753792Ab0L2TRr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Dec 2010 14:17:47 -0500
Received: by wwa36 with SMTP id 36so10990317wwa.1
        for <git@vger.kernel.org>; Wed, 29 Dec 2010 11:17:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=mQGNZLaRbcnqZQ21q3kg59/AvnjFUGKHzjOpZaxwfvE=;
        b=VZRZkLYWxtfrh+EiNXt5OS5Aww2+G2thAvGap1FhjCieBtAANHdfDxrIkXlriiypef
         tDe82B+Wh+Yx3Z5rSppbPW9enjfxLKwZzDzqjdsTp7HcTNetnLroxx6JIKzb5nPpsXlp
         yOLzwYsuBCbpA1rO6SJm9tpt3q2vj2QWXyrHg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=iGGpY9oVv4WiQbHLkihMkSs7xFu6nIMgWpTLAtpFHMXziGjInIbmS+HOIqpCqe+UsV
         PUxCy6GGD/XaRGauKaSMKT2DT/+bVXHIPXWOLcx+rCWUmtIuBYhlGtoqzgyH5Kb83RCC
         9jlLqz4Su58rEJrc0X4aVC4aDhCTBLMBOK0S4=
Received: by 10.216.48.70 with SMTP id u48mr16352314web.25.1293650266117;
        Wed, 29 Dec 2010 11:17:46 -0800 (PST)
Received: from burratino (c-76-126-174-171.hsd1.ca.comcast.net [76.126.174.171])
        by mx.google.com with ESMTPS id o51sm7290133wes.39.2010.12.29.11.17.43
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 29 Dec 2010 11:17:45 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <m3k4iscsq2.fsf@localhost.localdomain>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164323>

Jakub Narebski wrote:

> Now, if you either use some kind of networked filesystem, or you can
> configure it so each developers machine has the same install, you can
> make use of git templates mechanism.

To expand on this: if you are in the "controlled environment"
situation, you may find the discussion pointed to by [1] interesting.

If you do not control developer machines, life is even simpler.
One approach[2] is to track a git-templates/ directory in the working
tree and add a setup-hooks.sh script that installs those hooks in
.git/hooks.

[1] http://thread.gmane.org/gmane.linux.debian.devel.bugs.general/776932
Summary: it is easier to change hooks later if you keep hooks in some
directory outside the template dir (e.g., in /etc/hooks) and put a
symlink to that directory in the template.
[2] e.g., used by the libreoffice repository iirc
