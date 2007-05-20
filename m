From: "Jonas Fonseca" <jonas.fonseca@gmail.com>
Subject: Re: [PATCH] branch: fix segfault when resolving an invalid HEAD
Date: Sun, 20 May 2007 14:44:47 +0200
Message-ID: <2c6b72b30705200544g2f9cb67eod5ea9342c3fda2a5@mail.gmail.com>
References: <20070520121917.GA18850@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 20 14:44:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HpkmL-0008Ka-8f
	for gcvg-git@gmane.org; Sun, 20 May 2007 14:44:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754913AbXETMot (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 May 2007 08:44:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755359AbXETMot
	(ORCPT <rfc822;git-outgoing>); Sun, 20 May 2007 08:44:49 -0400
Received: from nz-out-0506.google.com ([64.233.162.239]:46261 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754913AbXETMos (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 May 2007 08:44:48 -0400
Received: by nz-out-0506.google.com with SMTP id z3so45942nzf
        for <git@vger.kernel.org>; Sun, 20 May 2007 05:44:48 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=iydkWEw+f2zz0y890hiQWNz7jqkcl8p7S5nUtbNgHV//qS54IplALR6GtkI8lwDTilAYohJ/Lx2ENsYh4oUkzL0NhpTWUVso1RXTm1+FSr9cGGE+XMV8hehq6lNOhBnhiX/wGRb7OWMOXarR0JDAql1q5NAs1YCsGTMSAulgd1w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qKoXOB/DZPw9BFEMcjvzWQPOsHo+hcU6He8h147sgFNMhMUXYMgoysg8yDxiJ2zlbbNjqNaaVQVtIOJilvy2TKAIcRSnaNx3jK2uB7QUxsAbCD+qpAFHwf85T9+PBX9mknX2FQymn8HQGgwG7dAXPcFDarKnoM4jvA0Nr0nau/A=
Received: by 10.114.174.2 with SMTP id w2mr1986543wae.1179665087600;
        Sun, 20 May 2007 05:44:47 -0700 (PDT)
Received: by 10.114.26.20 with HTTP; Sun, 20 May 2007 05:44:47 -0700 (PDT)
In-Reply-To: <20070520121917.GA18850@diku.dk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47832>

On 5/20/07, Jonas Fonseca <fonseca@diku.dk> wrote:
> Caused by return value of resolve_ref being passed directly
> to xstrdup whereby the sanity checking was never reached.

While checking other usage of resolve_ref, this problem also occurs in
builtin-show-branch.c around line 695, however, the logic later in the
file seems to be more forgiving so I have no idea of how to patch it.

-- 
Jonas Fonseca
