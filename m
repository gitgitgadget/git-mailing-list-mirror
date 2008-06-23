From: "Kalle Vahlman" <kalle.vahlman@gmail.com>
Subject: Git clone behaviour change in 1.5.6 (vs 1.5.5.1)
Date: Mon, 23 Jun 2008 22:51:15 +0300
Message-ID: <177e83dd0806231251u223717e4s2149f69313787ead@mail.gmail.com>
Reply-To: zuh@iki.fi
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 23 21:52:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAs5g-0003N1-W0
	for gcvg-git-2@gmane.org; Mon, 23 Jun 2008 21:52:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761473AbYFWTv2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jun 2008 15:51:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756673AbYFWTv2
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jun 2008 15:51:28 -0400
Received: from yw-out-2324.google.com ([74.125.46.31]:18350 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753192AbYFWTv1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jun 2008 15:51:27 -0400
Received: by yw-out-2324.google.com with SMTP id 9so950604ywe.1
        for <git@vger.kernel.org>; Mon, 23 Jun 2008 12:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :to:subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=cZ/03uotuclwWlpeGbVLyh2HnpYzY3gb/10VwADbzWk=;
        b=rrh5fWtq0SdnHliqjRDCsloJdKPd2M1gLl+j9Z1AP3HVhWs0zyd4UBsND4EroiIgaH
         xoNGCx+h7O5k5Lbrol0zWQt+qp9+nE2/z1S8mDnTNXxS/mb1/iKaUvZweVX7pPuKwL5B
         V0Q6Ml/GcwWMH6jq5To6t285gx4cdGXNF+5qc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=vlPrrkCnj8Wu+wEAu0Z8A+9VtmDEmjkbrh8sQdmB3l0yyAWGFBpCoE5eo9UYIuefa+
         RpgE/DIDFivsfcFsi8IqwBIoxx0wR0RooC2F0iZwQpKMvqCNP1m6YjNiaoeRDjzjgT1v
         Hippw/g3i6HCCww9labkT3eROgApO9bxG38i4=
Received: by 10.125.111.15 with SMTP id o15mr1025492mkm.127.1214250675139;
        Mon, 23 Jun 2008 12:51:15 -0700 (PDT)
Received: by 10.125.85.17 with HTTP; Mon, 23 Jun 2008 12:51:15 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85908>

Hi!

Switching to the 1.5.6 release from 1.5.5.1, I found out that the
rewritten git-clone command changed its behaviour wrt cloning to a
non-existing destination directory structure. In the shell version the
destination (work tree) is created with 'mkdir -p' but in the C
version with just the mkdir() call which doesn't create the parent
directories.

I can't find any indication that this would be intended in the repo
history nor in the mailing list, so I'm left thinking that this is an
unwanted regression. Could someone confirm this?

-- 
Kalle Vahlman, zuh@iki.fi
Powered by http://movial.fi
Interesting stuff at http://syslog.movial.fi
