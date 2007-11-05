From: Francesco Pretto <ceztkoml@gmail.com>
Subject: Re: [PATCH] Implement selectable group ownership in git-init
Date: Mon, 05 Nov 2007 16:09:06 +0100
Message-ID: <472F3212.4090800@gmail.com>
References: <472CC676.3000603@gmail.com> <7vabpvx8uu.fsf@gitster.siamese.dyndns.org> <8EF5148D-C1F0-4329-A221-82D0B7E9932C@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Mon Nov 05 16:09:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ip3aH-0003El-TF
	for gcvg-git-2@gmane.org; Mon, 05 Nov 2007 16:09:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756937AbXKEPJO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Nov 2007 10:09:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756936AbXKEPJO
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Nov 2007 10:09:14 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:50451 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756050AbXKEPJL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Nov 2007 10:09:11 -0500
Received: by ug-out-1314.google.com with SMTP id z38so915331ugc
        for <git@vger.kernel.org>; Mon, 05 Nov 2007 07:09:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        bh=oHtWBTSst0c72S62Iyxghpm9ixNYHpWhzwAlNDVTb2I=;
        b=NG6Z961fkY+Co31JZYcHkC9CvF6eeHEfOpHqiroAuSVd3Miw2FU/AF8phoVnVbTuonsBKDi+RVy6nh0PMR0QTPmx077kcuDSXiZFnjuH8X2GuO2NTQT3opxjfnvCyR428Hj55gNxYbhq374O7wrQkdY6Xxn6yrej89hy3Xc8/Ks=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=TGipjeuM7mxj2Jdp3bae+CnerxVthKf38bw1uQ/AkvrbbynNNiVYOjTZnTz5SaFxP9ZpU5NJtUHQVZUS5B1f9KMDygjN6FjN5USfgRtzWLO9SmEC1rgUDWTEA0I+Ho7Zdf8CNRGKOLIHNzR9/3Us13BDASS3S3ubvTtFKM+72Wk=
Received: by 10.66.219.11 with SMTP id r11mr471497ugg.1194275350177;
        Mon, 05 Nov 2007 07:09:10 -0800 (PST)
Received: from ?192.168.1.14? ( [87.0.185.143])
        by mx.google.com with ESMTPS id s8sm5425618uge.2007.11.05.07.09.07
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 05 Nov 2007 07:09:09 -0800 (PST)
User-Agent: Thunderbird 2.0.0.6 (X11/20071022)
In-Reply-To: <8EF5148D-C1F0-4329-A221-82D0B7E9932C@wincent.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63521>

Wincent Colaiuta ha scritto:
> 
> using the administration tools designed for managing access, just like
> every other SCM (and every server, and every piece of software which can
> be accessed by many on a multi-user system).
> 

I don't agree in general: in SCMs and other multi-user softwares, the access
control configuration can be safely postponed just because it's in their
standard usage pattern that the access should be conditioned by a daemon
to be configured later. It's not the case of git, just because git is very
tied to *nix permissions.
But as it is now, it could seems that it's good to put committers in the (for
example) git group, just because you have a git administrative account
git:git . This is caused, imo, by the fact that the flow of creating a shared
repository for a specific work/project group with git-init run by an
administrative user (as it should be) is something like this:

	- Do it wrong;
	- Fix it immediately.

I don't like the "Do it wrong" part. I'm trying to produce a sane and
transparent patch to implement the selectable group just in case of repository
first initialization. Why do I care so much of first time users? Dunno, but
I think it's important.
