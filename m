From: Timo Hirvonen <tihirvon@gmail.com>
Subject: Re: [PATCH] Fix filename verification when in a subdirectory
Date: Wed, 26 Apr 2006 21:05:41 +0300
Message-ID: <20060426210541.5e145e88.tihirvon@gmail.com>
References: <17483.27938.890830.375324@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.64.0604230906370.3701@g5.osdl.org>
	<E1FYlwn-0005mf-CL@moooo.ath.cx>
	<Pine.LNX.4.64.0604260832240.3701@g5.osdl.org>
	<Pine.LNX.4.64.0604261010390.3701@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: junkio@cox.net, matled@gmx.net, git@vger.kernel.org,
	paulus@samba.org
X-From: git-owner@vger.kernel.org Wed Apr 26 20:05:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FYoNc-0005Mz-3N
	for gcvg-git@gmane.org; Wed, 26 Apr 2006 20:04:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932361AbWDZSEp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 26 Apr 2006 14:04:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932360AbWDZSEp
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Apr 2006 14:04:45 -0400
Received: from nproxy.gmail.com ([64.233.182.191]:11114 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932361AbWDZSEo (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 26 Apr 2006 14:04:44 -0400
Received: by nproxy.gmail.com with SMTP id n29so1209025nfc
        for <git@vger.kernel.org>; Wed, 26 Apr 2006 11:04:42 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=MbhtHTCklrQMIhuYhEoGsuyJeyNFAs4i50bcOAY0OFuMS1vY10y6y5n7E7LcaHZ6STq6GZgU6i4grKnR+WHO5sNe8tCmU/nx4njbgX9ZQgMo8n+OUWUBmNNFWsovi+x3HIweQOAoBKEgk96zTnwLQ9LAsWTtJ8AJFhdJ+ZuavJ0=
Received: by 10.49.38.10 with SMTP id q10mr4793598nfj;
        Wed, 26 Apr 2006 11:04:42 -0700 (PDT)
Received: from garlic.home.net ( [82.128.200.31])
        by mx.gmail.com with ESMTP id l21sm1060221nfc.2006.04.26.11.04.41;
        Wed, 26 Apr 2006 11:04:42 -0700 (PDT)
To: torvalds@osdl.org
In-Reply-To: <Pine.LNX.4.64.0604261010390.3701@g5.osdl.org>
X-Mailer: Sylpheed version 2.2.3 (GTK+ 2.8.17; i686-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19215>

Linus Torvalds <torvalds@osdl.org> wrote:

> +void verify_filename(const char *prefix, const char *arg)
> +{
> +	const char *name;
> +	struct stat st;
> +
> +	if (*arg == '-')
> +		die("bad flag '%s' used after filename", arg);
> +	name = prefix ? prefix_filename(prefix, strlen(prefix), arg) : arg;
> +	if (!lstat(name, &st))
> +		return;
> +	if (errno == ENOENT);

Extra semicolon.

-- 
http://onion.dynserv.net/~timo/
