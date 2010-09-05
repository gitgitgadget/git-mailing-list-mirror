From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Add ERR support to smart HTTP
Date: Sun, 5 Sep 2010 12:41:06 -0500
Message-ID: <20100905174105.GB14020@burratino>
References: <1283707815-32038-1-git-send-email-ilari.liusvaara@elisanet.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Tarmigan Casebolt <tarmigan+git@gmail.com>
To: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
X-From: git-owner@vger.kernel.org Sun Sep 05 19:43:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OsJFD-0002xV-2e
	for gcvg-git-2@lo.gmane.org; Sun, 05 Sep 2010 19:43:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754041Ab0IERnC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Sep 2010 13:43:02 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:50486 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753836Ab0IERnA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Sep 2010 13:43:00 -0400
Received: by ywh1 with SMTP id 1so1384094ywh.19
        for <git@vger.kernel.org>; Sun, 05 Sep 2010 10:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=zDFSwbzUaBDV+Vkb88ALBTEado4pbQFXZ6gAjvlB1uU=;
        b=Yhn5oyylvd4J+SedeQm992ahzKXZYnnHc0gJJMcMuU0JL8cWR1P0QWBChMFfRq/dBs
         1byaEV3L0DthKSGdIoabIVE2ClJbhmjZ/88aNxNY6amPuVYT36bfCS+JUcDu68DSfCTx
         jql95iR+aigxmy5oa4oSgpsdnjYWXVEHCWRoI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=bZdLnCXj7JAFoQnj1DMeGhEBlQqAjPOMDnOwf/4kLZTahiGynlHyICh9YkE4pxKXHg
         FtFaoF6SMNQNbD23RDDrPlUUEp304l96C0JaGpXMP6cNPklFgzsMTyBCmlAaIFekmp7o
         t3ctWPB7xnbiJODSVnJQwhhxJiqaZErMSL+do=
Received: by 10.100.46.17 with SMTP id t17mr422245ant.237.1283708580062;
        Sun, 05 Sep 2010 10:43:00 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id i30sm7390902anh.29.2010.09.05.10.42.58
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 05 Sep 2010 10:42:59 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1283707815-32038-1-git-send-email-ilari.liusvaara@elisanet.fi>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155466>

Ilari Liusvaara wrote:

> Thus for example server response:
> 
> "0031# ERR W access for foo/alice/a1 DENIED to bob"
> 
> Will cause the following to be printed:
> 
> "fatal: remote error: W access for foo/alice/a1 DENIED to bob"
> 
> If the git version is old and doesn't support this feature, then the
> message will be:
> 
> "fatal: invalid server response; got '# ERR W access for foo/alice/a1
> DENIED to bob'"

Yippee!  Thanks, Ilari.

For this specific error, why can't gitolite use an HTTP response code?
Should http-backend be using ERR is some places, too, a la [1]?

Jonathan
who would like to find time to write a test case for "git daemon" any
day now

[1] http://thread.gmane.org/gmane.comp.version-control.git/145456/focus=145573
