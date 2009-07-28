From: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
Subject: Re: git-send-email generates mail with invalid Message-Id
Date: Tue, 28 Jul 2009 13:38:14 +0200
Message-ID: <20090728113814.GB12947@vidovic>
References: <200907280446.22890.elendil@planet.nl> <200907281127.44558.trast@student.ethz.ch> <20090728104423.GA12947@vidovic> <200907281313.51304.elendil@planet.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>,
	Thomas Rast <trast@student.ethz.ch>,
	Erik Faye-Lund <kusmabite@googlemail.com>, git@vger.kernel.org
To: Frans Pop <elendil@planet.nl>
X-From: git-owner@vger.kernel.org Tue Jul 28 13:38:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MVl1B-0004ZZ-Ps
	for gcvg-git-2@gmane.org; Tue, 28 Jul 2009 13:38:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753113AbZG1LiS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2009 07:38:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753068AbZG1LiS
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Jul 2009 07:38:18 -0400
Received: from mail-ew0-f226.google.com ([209.85.219.226]:35680 "EHLO
	mail-ew0-f226.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752639AbZG1LiS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jul 2009 07:38:18 -0400
Received: by ewy26 with SMTP id 26so3894904ewy.37
        for <git@vger.kernel.org>; Tue, 28 Jul 2009 04:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=FvsK1FbZmb5NsBU9ZJFzEAgfHnI9ihwaCJHmClJ1WEA=;
        b=H289WBV/BG6kTwi7ncEm9GQfiJo4uhH5YLpK5BZiZu1rbUiB3giUPyE84MF8lTIoJm
         CTvGop0kJdFsFd8zGV/JPGVe5N/gW1swy8Dt5cu5o5w9Y5P9xOSMjwvfLbSQHXJXrBlU
         nICIhHwOywOyR648Ocz7OmF6FQRhdatcovgms=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=PLsfrcqIZ9bpnDpfEUzTgmdBnmCFsbdquo+PB+ezQ5OuddtN1iBBOtyDhOOG+G8UHq
         mWr2eNWjw9Ir6zz5VMflF9sPhSKH5IwfR/VgSJZ1qk6yplNkgpvkDiG6323OpfZ1MlnE
         rMF8nxhJT39j7cvuvhUM6anx+ePV/wyxSB/Ww=
Received: by 10.210.143.17 with SMTP id q17mr9834501ebd.97.1248781097651;
        Tue, 28 Jul 2009 04:38:17 -0700 (PDT)
Received: from @ (91-165-131-3.rev.libertysurf.net [91.165.131.3])
        by mx.google.com with ESMTPS id 24sm2460296eyx.3.2009.07.28.04.38.16
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 28 Jul 2009 04:38:17 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <200907281313.51304.elendil@planet.nl>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124239>

The 28/07/09, Frans Pop wrote:
> On Tuesday 28 July 2009, you wrote:
> > Erik Faye-Lund wrote:
> >
> > Stricly speacking, it is not an invalid Message-Id. RFC 2822 says that
> > the Message-Id has to be unique. The right hand side may not contain a
> > domain identifier. It is a RECOMMENDED practice (a good one, though).
> 
> It also says that (3.6.4):
>    The message identifier (msg-id) is similar in syntax to an angle-addr
>    construct without the internal CFWS.
> 
> And defines:
>    message-id      =       "Message-ID:" msg-id CRLF
>    msg-id          =       [CFWS] "<" id-left "@" id-right ">" [CFWS]
> 
> So, the domain part *is* required (or at least: there has to be a "@"; it 
> maybe does not require id-right to be an actual domain, but that's not 
> really relevant here).
> 
> So, IMO inn2's check is correct.

Hum, you're right. The '@' symbol is required, whatever "id-right" is.
My previous patch should fix it.

-- 
Nicolas Sebrecht
