From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] logging branch deletion to help recovering from mistakes
Date: Tue, 7 Dec 2010 11:45:20 -0600
Message-ID: <20101207174520.GB21483@burratino>
References: <7vlj42siu5.fsf@alter.siamese.dyndns.org>
 <20101207162358.GT355@fearengine.rdu.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Casey Dahlin <cdahlin@redhat.com>
X-From: git-owner@vger.kernel.org Tue Dec 07 18:45:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQ1bc-0001Hn-37
	for gcvg-git-2@lo.gmane.org; Tue, 07 Dec 2010 18:45:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752574Ab0LGRpb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Dec 2010 12:45:31 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:33240 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751948Ab0LGRpa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Dec 2010 12:45:30 -0500
Received: by vws16 with SMTP id 16so174090vws.19
        for <git@vger.kernel.org>; Tue, 07 Dec 2010 09:45:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=vhpZ/7rJlY1lXIuG6FOQBG81/q9WBC/WUbrxp38QNJU=;
        b=tXGES+OKrdWDPbPSuisFTUhsjUApJwkIuSeJnWzK/Rvsw+9OihQWimTNnDxZP94RCk
         TizIEj6siqfMyZ+ESIBpd7DGVgrcTGr2IxoKLqhE0dELxCaPOII8OpfQC0NtX0+9VEYB
         iPjbVz1ztxRBS+335cMGR5eIYWg1Rv6RfPPzY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=kFkYU5n6+VXQOkio8Lao3jheh22qnZRK3NIKa+43YRD3Z75qWmL2MaOpQXNrcI57Sj
         7/9QPVSSOgfPM8wzw4Yj+xOGiYX5o6tb/97Mq3dcKrMe5SZclyJFKipaKbD3eI6M48vh
         GvIei5sfBWHWmnahbhJlTf+H5o/kD3p10zNvU=
Received: by 10.220.190.201 with SMTP id dj9mr900443vcb.251.1291743929772;
        Tue, 07 Dec 2010 09:45:29 -0800 (PST)
Received: from burratino (adsl-68-255-109-73.dsl.chcgil.ameritech.net [68.255.109.73])
        by mx.google.com with ESMTPS id e18sm2322696vbm.15.2010.12.07.09.45.27
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 07 Dec 2010 09:45:28 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20101207162358.GT355@fearengine.rdu.redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163096>

Casey Dahlin wrote:

> Could commits made onto a detached head also show up here? Or is that
> better thwarted with another mechanism?

I think that's better thwarted with the HEAD reflog:

	$ git log -g HEAD
