From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 6/7] vcs-svn: implement prop-delta handling.
Date: Tue, 12 Oct 2010 17:59:32 -0500
Message-ID: <20101012225932.GG15587@burratino>
References: <1286891424-2067-1-git-send-email-david.barr@cordelta.com>
 <1286891424-2067-7-git-send-email-david.barr@cordelta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: David Barr <david.barr@cordelta.com>
X-From: git-owner@vger.kernel.org Wed Oct 13 01:02:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P5ns2-0008LG-Ks
	for gcvg-git-2@lo.gmane.org; Wed, 13 Oct 2010 01:02:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751220Ab0JLXCx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Oct 2010 19:02:53 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:55218 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751172Ab0JLXCw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Oct 2010 19:02:52 -0400
Received: by qyk5 with SMTP id 5so1074447qyk.19
        for <git@vger.kernel.org>; Tue, 12 Oct 2010 16:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=FYE3ZJw+GLy4El1EisImTJCDyT95eQinOZbkFBJb+/g=;
        b=NcRx2+v4Z1oYQLB83UfDO3ZalstXhxAu7e99nz5FjJksedLT9k0hhMTc/sIALEAAgF
         RcrCSKDPVS/scM3Ppm05O6Ip+NG+FwBPtbTdr4FCITWBBXg++obQFDTAenoAVDkc5gTf
         aWxVlga5BcdlXC+wEH+JzHdei1aoRKpd3VWGg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=yIA+5IA5vph4ipsDg8JQum9Ct2gOADhs84pE6Zd21Z+nNQg1da4eWOBQC/6J0PWL3b
         yAwYJPpbbR+qU3BzU10iN8BDerii7Yy+52RIKlUW11myqrAlmkJqc4/GF/taqLle6+2T
         WSaVG3mCeNpDh264Sga41okr0UaljbGR2jPQU=
Received: by 10.224.73.14 with SMTP id o14mr6179421qaj.397.1286924572083;
        Tue, 12 Oct 2010 16:02:52 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id e16sm1749618vcm.32.2010.10.12.16.02.50
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 12 Oct 2010 16:02:51 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1286891424-2067-7-git-send-email-david.barr@cordelta.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158892>

David Barr wrote:

> [Subject:  vcs-svn: implement prop-delta handling.]
>
> By testing against the Apache Software Foundation
> repository, some simple rules for decoding prop
> deltas were derived.
> 
> 'Node-action: replace' implies the empty prop set
> as the base for the delta.
> Otherwise, if a copyfrom source is given that node
> forms the basis for the delta.
> Lastly, if the destination path exists in the active
> revision it forms the basis.

These rules are used for text deltas, too, right?  Probably
worth mentioning the new (placeholder) fast_export_blob()
parameter in the commit message.
