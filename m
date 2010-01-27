From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Testing if a certain commit is in the current branch
Date: Wed, 27 Jan 2010 04:19:43 -0600
Message-ID: <20100127101943.GA4470@progeny.tock>
References: <201001270819.39819.elendil@planet.nl>
 <7viqaorowo.fsf@alter.siamese.dyndns.org>
 <201001270936.14935.elendil@planet.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Frans Pop <elendil@planet.nl>
X-From: git-owner@vger.kernel.org Wed Jan 27 11:19:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Na4zy-0006b2-GY
	for gcvg-git-2@lo.gmane.org; Wed, 27 Jan 2010 11:19:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753852Ab0A0KTm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jan 2010 05:19:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753847Ab0A0KTm
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Jan 2010 05:19:42 -0500
Received: from mail-iw0-f186.google.com ([209.85.223.186]:37186 "EHLO
	mail-iw0-f186.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753653Ab0A0KTl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jan 2010 05:19:41 -0500
Received: by iwn16 with SMTP id 16so951291iwn.5
        for <git@vger.kernel.org>; Wed, 27 Jan 2010 02:19:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=jPB7G9xBWKPz3kQ9x/mspbVpcI+ulvyBfqOa4NxRVpU=;
        b=rNX4ADYeatSiOMaRsY0aQm6cpwDnZUhaIzNFwlUjh4ZQ2tSUGu6N7IbypCGWg1ra1D
         p2bjlZ078vtxXH7tkj4hhO/tdFZxbg9oVDch8fHv63Dn1Uzn4OOHHLqOxlyT4iQBO+6L
         3xL8pLhEchQUhwKOb/7s/0ImaAynImXkX4C/o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=ln2/RgVsM5YUy7kC0jNl+I1+09K8KG/DCv8PGIOYzK4o4J++qAC7LtnBQ6Am81WKsp
         4wHjDjeM3FBqlbL6pjAummTBK7k81xV5/ZJOfPhXqysJPiOTN7NGmeHkvbJwhpk6WVnP
         5tDRTTzdec++/BOJakUnvEx7yHqzlW+nQLvTw=
Received: by 10.231.158.21 with SMTP id d21mr384067ibx.61.1264587579128;
        Wed, 27 Jan 2010 02:19:39 -0800 (PST)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 23sm6924555iwn.3.2010.01.27.02.19.36
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 27 Jan 2010 02:19:38 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <201001270936.14935.elendil@planet.nl>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138124>

Frans Pop wrote:

> The use case is a wrapper script for kernel builds in which some variation 
> are needed (due to changes in the build system) when building older 
> kernels, e.g. during bisections or when building older stable updates.
> So I test for the presence of commits that introduced relevant changes.

Neat idea.  How about this (untested)?

 git rev-list ^HEAD --no-walk commit1 commit2 ...
