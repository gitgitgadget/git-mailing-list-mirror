From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Documentation: Note about the meaning of "clone"
Date: Sun, 15 Jun 2008 15:39:17 +0200
Message-ID: <200806151539.17967.jnareb@gmail.com>
References: <20080614.150548.71104932.hanzl@noel.feld.cvut.cz> <m3od63ozuf.fsf@localhost.localdomain> <200806151505.27686.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Vaclav Hanzl <hanzl@noel.feld.cvut.cz>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Sun Jun 15 15:40:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7sT1-0001zK-Su
	for gcvg-git-2@gmane.org; Sun, 15 Jun 2008 15:40:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757442AbYFONj3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Jun 2008 09:39:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757457AbYFONj3
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jun 2008 09:39:29 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:38542 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752208AbYFONj3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jun 2008 09:39:29 -0400
Received: by ug-out-1314.google.com with SMTP id h2so269610ugf.16
        for <git@vger.kernel.org>; Sun, 15 Jun 2008 06:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=U2iXFXTL2SYyZo5xj7IW4x68fQYfDcxmjiTBbcgPDh0=;
        b=XjzOrLMScqmgzjA16DM/BmoTuwHq0MB3vQ0GZ5/SOsqnSASpYgYzori0MgLUB9blTL
         Fsm5mO75e8FeV5qc6nKDGiSTfGIkb6CXrPblamUtqEd2Fu5RhJQ8CwVzpK1cBB7GiBDO
         zuT45FykGjE1fhB8KXnnoZMo4lhIt3GL10HV8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=IP3K+rTC1qoldyXZtQsVGSdcIk3hEocw9efcjZTsvfeLgYWIxG4pEoXkEImcszwqVZ
         FZsajTL04OhzuF1lvkI27BstbzviBenzQ2czbEwzYDE3Sp/kDVEjUtmxsQ4ceZOKtrhc
         QYatfA9be1Vd+sfRfIDSNVCb+zI9I82frBEUA=
Received: by 10.67.21.11 with SMTP id y11mr4473056ugi.36.1213537167268;
        Sun, 15 Jun 2008 06:39:27 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.223.105])
        by mx.google.com with ESMTPS id e34sm6338413ugd.38.2008.06.15.06.39.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 15 Jun 2008 06:39:25 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <200806151505.27686.robin.rosenberg.lists@dewire.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85091>

Robin Rosenberg wrote:
>
> Clarify that a clone is not an exact copy.

> +*NOTE*: Although this command is called clone, the clone is not identical
> +in all respects. Local branches in the repository being cloned
> +becomes remote tracking branches in the clone and remote tracking
> +branches are not cloned at all. For security reasone the config sections
> +and triggers are not cloned either.

One nitpick, one comment, one historical comment.

Nitpick: Actually biological clone is usually not identical in
phenotype, and we know now that due to different gene expression
it can have different genotype as well. ;-)

COMMENT: when you do "git clone --bare" it mirrors local (regular)
branches in 1:1 correspondence; but it still doesn't clone anything
outside refs/heads/ and refs/remotes (and HEAD).

Historical comment: git-clone used to do 1:1 mapping even for non-bare
clone, with exception of <current branch> -> origin mapping, before
behavior provided by --use-separate-remotes was made default (thanks
Carl!).

-- 
Jakub Narebski
Poland
