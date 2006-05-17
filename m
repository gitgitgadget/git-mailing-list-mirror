From: "Bertrand Jacquin" <beber.mailing@gmail.com>
Subject: Re: [PATCH] builtin-grep: workaround for non GNU grep.
Date: Wed, 17 May 2006 17:39:26 +0200
Message-ID: <4fb292fa0605170839r259732dcw1c1bae3f1808db32@mail.gmail.com>
References: <f3d7535d0605161652n3b2ec033r874336082755e728@mail.gmail.com>
	 <Pine.LNX.4.64.0605161904260.16475@g5.osdl.org>
	 <7vejythvkr.fsf@assigned-by-dhcp.cox.net>
	 <7vves5geng.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Cc: "Linus Torvalds" <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 17 17:40:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FgO7a-0006Ol-LP
	for gcvg-git@gmane.org; Wed, 17 May 2006 17:39:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750701AbWEQPja (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 17 May 2006 11:39:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750704AbWEQPja
	(ORCPT <rfc822;git-outgoing>); Wed, 17 May 2006 11:39:30 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:30883 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750701AbWEQPja convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 May 2006 11:39:30 -0400
Received: by nf-out-0910.google.com with SMTP id d4so187964nfe
        for <git@vger.kernel.org>; Wed, 17 May 2006 08:39:28 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=mtB2Tg6ZsSbEKyrQUGHzuVkzXix5EsGYSgBikqewKUhp3HCICdYqudTzAu7VLty2lpCCzQ3nXY/dfGNFDiPYrDWm67TtqUANsawvjFzArMqHvv3WnVu00/OjcoMa6xqJo6j86K/PtjzXmvqWcwFqGNuUt/c85QxBGDYRpNiSO4w=
Received: by 10.48.48.16 with SMTP id v16mr8605nfv;
        Wed, 17 May 2006 08:39:26 -0700 (PDT)
Received: by 10.49.5.5 with HTTP; Wed, 17 May 2006 08:39:26 -0700 (PDT)
To: "Junio C Hamano" <junkio@cox.net>
In-Reply-To: <7vves5geng.fsf_-_@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20208>

On 5/17/06, Junio C Hamano <junkio@cox.net> wrote:

> +ifdef NO_H_OPTION_IN_GREP
> +       NO_H_OPTION_IN_GREP=1
> +else
> +       NO_H_OPTION_IN_GREP=0
> +endif

> +       if (NO_H_OPTION_IN_GREP)
> +               push_arg("/dev/null");
> +       else {
> +               push_arg("-H");
> +               push_arg("--");
> +       }

Sorry, maybe a C code beginner question but while you define
NO_H_OPTION_IN_GREP in Makefile, why don't use a build time ``if''
instead of a runtime one ?

Like :

#if NO_H_OPTION_IN_GREP
               push_arg("/dev/null");
#else
               push_arg("-H");
               push_arg("--");
#fi

-- 
Beber
#e.fr@freenode
