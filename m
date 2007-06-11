From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: Asking again... [Re: how to properly import perforce history?]
Date: Mon, 11 Jun 2007 17:44:04 +0200
Message-ID: <81b0412b0706110844i12ebe52m21735815cc06effa@mail.gmail.com>
References: <20070608202236.GJ25093@menevado.ms.com>
	 <20070611142525.GN25093@menevado.ms.com>
	 <200706111656.33696.simon@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Simon Hausmann" <simon@lst.de>
X-From: git-owner@vger.kernel.org Mon Jun 11 17:44:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hxm42-0002Vk-1O
	for gcvg-git@gmane.org; Mon, 11 Jun 2007 17:44:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755284AbXFKPoI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Jun 2007 11:44:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755653AbXFKPoI
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jun 2007 11:44:08 -0400
Received: from wr-out-0506.google.com ([64.233.184.233]:42697 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755610AbXFKPoG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jun 2007 11:44:06 -0400
Received: by wr-out-0506.google.com with SMTP id 76so1032627wra
        for <git@vger.kernel.org>; Mon, 11 Jun 2007 08:44:05 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ZkXXw+13OA0M3robuQoim6E6pbgBfaPOsLxdrKHTPzsi6vnXGuokpLJqoOQRtvJKjvHKyV5afxSVdgvJnAAtDBQDXZbN0e96dcNDHHbGTgA3Cw4DEJKIsMRAcN9ql50wNqZYVp2oY0AcC2e3g31EkB08QtXGEfSlzs3eRlOacGA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=VKifC4oaIA/dUq/r2Pzi2LMho6tXSl7sVCDdnINgDl5/BIRgEMU0RZ7ht3q1/76/X3uZrS7PicuxGwHvPpU8MwOVqv4cnONxMYoQm/fiy0iEqepEBkRQE5x7X5jeAsWNHhQh6kLZ6iqs9/PgS2Df4T2TC7uytni1medwChx44io=
Received: by 10.78.193.5 with SMTP id q5mr2267478huf.1181576644753;
        Mon, 11 Jun 2007 08:44:04 -0700 (PDT)
Received: by 10.78.118.19 with HTTP; Mon, 11 Jun 2007 08:44:04 -0700 (PDT)
In-Reply-To: <200706111656.33696.simon@lst.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49858>

On 6/11/07, Simon Hausmann <simon@lst.de> wrote:
>
> *plug* You could try with git-p4 from http://repo.or.cz/w/fast-export.git . It
> should be just a matter of calling
>
>         git-p4 clone //depot/path
>

Can I suggest you add a target directory mapping to your tool?
Something like:

  git-p4 clone //depot/project/path [libs/project/path] [rev-range]

The way Perforce handles branches and directories leads to
the problem that it actually cannot cleanly support neither of
them, and it is very hard to untangle a big repo which
historically has had many projects living in it.
Especially if some idiot actually tried to "do branching".

And, BTW, don't you have a small problem with filenames with
spaces and quoting?
