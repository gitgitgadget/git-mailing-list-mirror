From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: git: please refuse push containing commits marked for
 autosquash by default
Date: Fri, 16 Jul 2010 14:04:32 -0500
Message-ID: <20100716190432.GA16371@burratino>
References: <20100716123715.16356.65888.reportbug@richter>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Scott Chacon <schacon@gmail.com>,
	Jeff King <peff@peff.net>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Simon Richter <sjr@debian.org>
X-From: git-owner@vger.kernel.org Fri Jul 16 21:05:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OZqE4-0000a6-7y
	for gcvg-git-2@lo.gmane.org; Fri, 16 Jul 2010 21:05:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758936Ab0GPTFa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Jul 2010 15:05:30 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:63123 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754635Ab0GPTF3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Jul 2010 15:05:29 -0400
Received: by qwh6 with SMTP id 6so730215qwh.19
        for <git@vger.kernel.org>; Fri, 16 Jul 2010 12:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=6CRRrKxW79kpOnpDzC0C5vuWRpcds6wH7IAfrxZgqkw=;
        b=wDRvaJCCdINB3YeqU/VR1IOQRHHt/89yNkVan5y2G6Uy44jCYZSEni2qgXI9E8/Jn/
         /Gc51/nRT7qGaBX8kegcYGum1FoQd4LhatueimC3KYZBTpf+KBg8bbmqCUY6XP2Z0MNP
         LJp2E+sGpMRQy5gVDAa3Tbi1swQ1vxBt+6ZFQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=ixVHUXJ6O9i7zHTNNB8vjTy/JuWB2C6gi/tdB95eBZ1NebzPPjC0EfZMvtbKqvCmXN
         FKe03eHu9g6jXaSrhiimri+8n17Mcj9ymHPo0mZDQEikd8LIpX0/P7p/+wa3EUVi90ac
         bV4BZVL3/0V1G+qHnlj1jMGNcGCMj9L1M/6NA=
Received: by 10.224.43.163 with SMTP id w35mr1218268qae.92.1279307127566;
        Fri, 16 Jul 2010 12:05:27 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id h34sm11225629qcm.2.2010.07.16.12.05.25
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 16 Jul 2010 12:05:26 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100716123715.16356.65888.reportbug@richter>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151161>

Hi Simon,

Simon Richter wrote:

> When using the --autosquash feature, quite a number of temporary commits
> are created that should never be pushed anywhere. It might be a good
> idea to have an option to refuse to transfer commits whose messages
> start with "fixup!" or "squash!", both on the server and client side.

At first glance this looks very useful, as an optional hook rather
than on by default[1].

It sounds like a good use for hooks.

Receiving side: an update hook should do the trick.  See the githooks
manual page, or /usr/share/doc/git/contrib/hooks/update-paranoid for
an example.

Sending side: there is no pre-push hook yet, but there was some work
towards that about a year and a half ago[2].  Maybe someone interested
could revive the topic or figure out what remains to be done.

Jonathan

[1] Sometimes I send works in progress from one machine to another; it
would be quite unnerving if this resulted in some puzzling message
about how I forgot to rebase first.

[2] http://thread.gmane.org/gmane.comp.version-control.git/92900
http://thread.gmane.org/gmane.comp.version-control.git/128426/focus=128433
