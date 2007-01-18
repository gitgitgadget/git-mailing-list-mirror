From: "Morten Welinder" <mwelinder@gmail.com>
Subject: Re: [PATCH 2/2] Use fixed-size integers for .idx file I/O
Date: Thu, 18 Jan 2007 09:51:37 -0500
Message-ID: <118833cc0701180651w3b5ac164m4e396399f1d58cb7@mail.gmail.com>
References: <7vd55col04.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Simon Schubert" <corecode@fs.ei.tum.de>
X-From: git-owner@vger.kernel.org Thu Jan 18 15:51:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H7Yc8-0001B7-P6
	for gcvg-git@gmane.org; Thu, 18 Jan 2007 15:51:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752053AbXAROvj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 18 Jan 2007 09:51:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752056AbXAROvj
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Jan 2007 09:51:39 -0500
Received: from an-out-0708.google.com ([209.85.132.242]:59172 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752055AbXAROvi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jan 2007 09:51:38 -0500
Received: by an-out-0708.google.com with SMTP id b33so82531ana
        for <git@vger.kernel.org>; Thu, 18 Jan 2007 06:51:38 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=iIXzHISK7I996Vzyh6cEZePD/5hZw/hY3vA0MXMHZjVgzNtwblpaWx0TL2BvZ5d4wpg4vuYNveq4wM0S53m3WZz4Hxd4ppNfA9OJtxtkGy+v5TOki8XxhiyXYmJGAuMVzAtzct+LBbCTohfazrXfhkb6xjqvkZ5jR3jPfuXw7po=
Received: by 10.100.48.7 with SMTP id v7mr200355anv.1169131898025;
        Thu, 18 Jan 2007 06:51:38 -0800 (PST)
Received: by 10.70.95.5 with HTTP; Thu, 18 Jan 2007 06:51:37 -0800 (PST)
To: "Junio C Hamano" <junkio@cox.net>
In-Reply-To: <7vd55col04.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37098>

> -                       return ntohl(*((unsigned int *) ((char *) index + (24 * mi))));
> +                       return ntohl(*((uint32_t *)((char *)index + (24 * mi))));

Is that pointer gymnastics guaranteed to work?  I.e., how do we know
that we can access an uint32_t (or unsigned) at such an address?

M.
