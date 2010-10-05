From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 3/6] Allow the transport fetch command to add additional
 refs
Date: Mon, 4 Oct 2010 21:18:33 -0500
Message-ID: <20101005021833.GC10818@burratino>
References: <4CA86A12.6080905@dbservice.com>
 <1286108511-55876-3-git-send-email-tom@dbservice.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Tomas Carnecky <tom@dbservice.com>
X-From: git-owner@vger.kernel.org Tue Oct 05 04:22:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2xAf-0000Jq-W8
	for gcvg-git-2@lo.gmane.org; Tue, 05 Oct 2010 04:22:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756930Ab0JECVw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Oct 2010 22:21:52 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:43136 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753244Ab0JECVv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Oct 2010 22:21:51 -0400
Received: by gxk9 with SMTP id 9so1857329gxk.19
        for <git@vger.kernel.org>; Mon, 04 Oct 2010 19:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=bZuWXfwMn6v8FqTv5ZCxQwDowiU/vhJFpywTtE05Y+Q=;
        b=Lk8GoHjDi1/iAh0JBytFpSUz4+5JONib/9K370js4VTsipIz/+LKTq/cirNlWLcm2z
         7eZaPLsmGkZsR5Scs8H3K7YxXQ8CgJhsaY+tLZueJz2P4yX7fa9NOu9ZIYbjKpJaLFwc
         GWb8UFUFUoTQazCa1nRCQ21O6xWwS2nmdqbVY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=eHHnslgpRDG2JMZznqzYUNKlh0X6+Th3yhcFTJPbhEFDTUP4JcpsmdVyH83gXyUOMN
         8Ji9xTugOYXpvLhwRQeuQWXm0f3U37+J/U11pQxFImSPCZeXDY1PFl2Yq4WXn6/5bdWL
         62QHnRfCWAytHy61FCPPaKOjd1kZN7NJQUNYE=
Received: by 10.220.190.139 with SMTP id di11mr18422vcb.210.1286245310459;
        Mon, 04 Oct 2010 19:21:50 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id f18sm2447605vcm.11.2010.10.04.19.21.48
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 04 Oct 2010 19:21:49 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1286108511-55876-3-git-send-email-tom@dbservice.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158159>

Tomas Carnecky wrote:

> Remote helpers such as those for svn may chose to save the Git SHA1 -> Subversion
> revision mapping as notes attached to the commits (as opposed to strings in the
> commit message itself). The helper would need to update the notes on each fetch,
> but the user should not be bothered by the presence of that ref. The remote
> helper can update the notes tree through fast-import and then inform Git core
> that it should silently update the notes ref.

What is the advantage of this approach over having fast-import update
the notes ref (but not the others) on its own?

Curious,
Jonathan
