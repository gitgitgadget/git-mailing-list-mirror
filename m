From: Will Palmer <wmpalmer@gmail.com>
Subject: Re: [PATCH] pretty.c: Make user defined format honor color option
Date: Thu, 17 Mar 2011 12:59:52 +0000
Message-ID: <1300366792.3269.24.camel@wpalmer.simply-domain>
References: <4D81C741.8060108@secunet.com>
	 <1300354791.3269.19.camel@wpalmer.simply-domain>
	 <4D81F860.2070703@secunet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Thomas Egerer <thomas.egerer@secunet.com>
X-From: git-owner@vger.kernel.org Thu Mar 17 14:00:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0Co5-0004mP-Qx
	for gcvg-git-2@lo.gmane.org; Thu, 17 Mar 2011 14:00:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754408Ab1CQM76 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Mar 2011 08:59:58 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:41955 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754132Ab1CQM75 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Mar 2011 08:59:57 -0400
Received: by mail-wy0-f174.google.com with SMTP id 21so2733230wya.19
        for <git@vger.kernel.org>; Thu, 17 Mar 2011 05:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:subject:from:to:cc:in-reply-to:references
         :content-type:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        bh=5lwOG3MPRjpTSZ7A4LkY3cZV+IEH4vAwNfcvgXqmwzw=;
        b=JY6/+8dieOHFRQtggG/WTmDWT9zC7mZpooVdgVkndHRhYm5RQsY1Gbolt1jSyTw/l6
         bL2MapDSYMkZLYwK3AXQAJD56zVD9gpbZ6zjitzeWb9nhC7rROd5LVZSpYejnBfLN7rg
         TyDNsP350plqVMlFDBnDFvjzzi2YkP7XgRtFI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:to:cc:in-reply-to:references:content-type:date
         :message-id:mime-version:x-mailer:content-transfer-encoding;
        b=rIwMwmQpVjmzDmXeHBmguVZg46JYijH3CPh3atdSMH8ZDpxUcQdgOqX6Vo6qHkmhTe
         xHHx/Hitl1zJRBhHEz/VwWJMUeFHQiD1Hda8/yerB9YmvmG8wR3voQhHDkd5cmdU6lNo
         p04Jow/eCV+oW2/2TsgvQnVzPKEUlGhvNU8rg=
Received: by 10.227.178.14 with SMTP id bk14mr1393424wbb.102.1300366796408;
        Thu, 17 Mar 2011 05:59:56 -0700 (PDT)
Received: from [192.168.2.64] (tontine65c.demon.co.uk [80.176.141.31])
        by mx.google.com with ESMTPS id h19sm637220wbc.58.2011.03.17.05.59.54
        (version=SSLv3 cipher=OTHER);
        Thu, 17 Mar 2011 05:59:55 -0700 (PDT)
In-Reply-To: <4D81F860.2070703@secunet.com>
X-Mailer: Evolution 2.28.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169241>

On Thu, 2011-03-17 at 13:02 +0100, Thomas Egerer wrote:
> On 03/17/2011 10:39 AM, Will Palmer schrobtete:
> > On Thu, 2011-03-17 at 09:33 +0100, Thomas Egerer wrote:
> >> This patch fixes that the pretty-formats tformat and format ignore
> >> git's color option.
> > 
> > It is my understanding that this is intentional, the logic being: If you
> > normally don't want color, but have specified it directly on the
> > command-line, you probably want color.
> I'm using the pretty format in the context of an alias. My global setting
> for colors is auto. I would expect git to not disregard this options. I
> usually use the alias to display a git log in a modified way, but I also
> do sometimes pipe it to grep. If there was a way to suppress output
> colorization (let's say by not using global options but the command line
> switch --color=never) that would work for me. But there is no wa and I
> find it inconvinient to have two different aliases doing the same thing
> one with color and one without while there would be a much simpler way.
...snip
> Thomas

Perhaps --color=auto, specified on the command-line, should behave
differently to the various color options specified via config. That
might make both sides happy, as one could always specify --color=auto to
explicitly tell git to only color if it thinks it should.

Can anyone else refresh my memory regarding the use-case where
hand-specified colors really should have an effect even with
--color=never?
