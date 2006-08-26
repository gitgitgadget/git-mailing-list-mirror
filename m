From: Mitchell Blank Jr <mitch@sfgoth.com>
Subject: Re: [PATCH] dir: do all size checks before seeking back and fix file closing
Date: Sat, 26 Aug 2006 11:43:30 -0700
Message-ID: <20060826184330.GA34439@gaz.sfgoth.com>
References: <20060826141709.GC11601@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 26 20:34:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GH2zX-000739-UV
	for gcvg-git@gmane.org; Sat, 26 Aug 2006 20:34:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751056AbWHZSeQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 26 Aug 2006 14:34:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932117AbWHZSeQ
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Aug 2006 14:34:16 -0400
Received: from gaz.sfgoth.com ([69.36.241.230]:19669 "EHLO gaz.sfgoth.com")
	by vger.kernel.org with ESMTP id S1751056AbWHZSeP (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 26 Aug 2006 14:34:15 -0400
Received: from gaz.sfgoth.com (localhost.sfgoth.com [127.0.0.1])
	by gaz.sfgoth.com (8.12.10/8.12.10) with ESMTP id k7QIhVtV046430;
	Sat, 26 Aug 2006 11:43:31 -0700 (PDT)
	(envelope-from mitch@gaz.sfgoth.com)
Received: (from mitch@localhost)
	by gaz.sfgoth.com (8.12.10/8.12.6/Submit) id k7QIhV1w046429;
	Sat, 26 Aug 2006 11:43:31 -0700 (PDT)
	(envelope-from mitch)
To: Jonas Fonseca <fonseca@diku.dk>
Content-Disposition: inline
In-Reply-To: <20060826141709.GC11601@diku.dk>
User-Agent: Mutt/1.4.2.1i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.2.2 (gaz.sfgoth.com [127.0.0.1]); Sat, 26 Aug 2006 11:43:31 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26061>

Jonas Fonseca wrote:
>   err:
> -	if (0 <= fd)
> +	if (0 >= fd)
>  		close(fd);

Could you explain that piece?  You now only close "fd" if it's zero (stdin)
or negative (invalid).  The old code (close if its >=0) make more sense.

-Mitch
