From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: Do moves add to repository size?
Date: Wed, 31 Dec 2008 16:17:26 +0100
Message-ID: <81b0412b0812310717w341f05b5qeb058ff1c2db19d2@mail.gmail.com>
References: <85fafb0c0812310111s552247em5f0ca57b737aedc3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Simon Chiang" <simon.a.chiang@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 31 16:18:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LI2qR-0000bQ-40
	for gcvg-git-2@gmane.org; Wed, 31 Dec 2008 16:18:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753118AbYLaPR2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Dec 2008 10:17:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755384AbYLaPR2
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Dec 2008 10:17:28 -0500
Received: from rv-out-0506.google.com ([209.85.198.226]:8945 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752777AbYLaPR1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Dec 2008 10:17:27 -0500
Received: by rv-out-0506.google.com with SMTP id k40so5311804rvb.1
        for <git@vger.kernel.org>; Wed, 31 Dec 2008 07:17:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=HvP1XX6ozpH5kiJaAecldM/HCG1yx9sdDqIIo4mp3Xg=;
        b=cOSXgAeBeQOQHy7TLt9EwOEri8omN2U6+UeAgk2j+Fo780TqbEaW85X72OsZLWE1a2
         5VA8wXXlNE6Jp4bUj9ed5MxLb81bxZU5aUQCCLwVQXih0zb/2GfpYIROVUAHiCRJjLe2
         3F+MS0oFtX8E9zjpd2saf0IkBw2BBUnDpcGl0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=Lc3p43cZzKN2fEDjxfkXArIVeKAAL0K24F2x3yAkzREcZhcmF+pCrkXiV7R88Cfjeb
         AWQLy3qgeS6cxBxgqtdKrTuTu+sryZsoxcrqh5LLEgaGOXSzi3jaalpnIw2WnOcAer62
         +IRjYPrUXUtBx54f6pd3pMIT2z9SOsI2/W7lE=
Received: by 10.114.80.1 with SMTP id d1mr10543402wab.168.1230736646616;
        Wed, 31 Dec 2008 07:17:26 -0800 (PST)
Received: by 10.114.179.4 with HTTP; Wed, 31 Dec 2008 07:17:26 -0800 (PST)
In-Reply-To: <85fafb0c0812310111s552247em5f0ca57b737aedc3@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104274>

2008/12/31 Simon Chiang <simon.a.chiang@gmail.com>:
> Hey, I'm quite curious to know if moves/renames duplicate the file
> content in the repository (and hence grow the repository size) or if
> they just change the location of the content.  I want to drastically
> reorganize a repository and I'm wondering if will double it in size.

It wont double its size, but it will grow a little: the tree objects
which contain names of the data (the file names) will be all changed.
