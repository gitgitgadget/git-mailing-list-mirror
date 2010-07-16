From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: Find successor of common ancestor
Date: Fri, 16 Jul 2010 11:44:40 -0400
Message-ID: <AANLkTiloDCX4SuEDe_BNivv3UkY2TrQU1EAZlZGd1HYs@mail.gmail.com>
References: <20100716082937.GA22894@nibiru.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: weigelt@metux.de
X-From: git-owner@vger.kernel.org Fri Jul 16 17:45:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OZn69-00086t-93
	for gcvg-git-2@lo.gmane.org; Fri, 16 Jul 2010 17:45:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965877Ab0GPPpG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Jul 2010 11:45:06 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:60093 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965833Ab0GPPpE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Jul 2010 11:45:04 -0400
Received: by gwj18 with SMTP id 18so1133654gwj.19
        for <git@vger.kernel.org>; Fri, 16 Jul 2010 08:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=WCSJqPCMz4qkunX8xQdfIx+tIAZMtL3hQlj020c7k8Y=;
        b=meA1fxNZwTYN81FWEHHVEVvFTKbsaUojn00snTyDff89DOSyQJZ9KZCUAXgb7o2iLY
         jY7avnz5ss+D8HIyB71JLq9hj0ojPqP9AxfEIKO4vBOeFJMKUNUucekiPk+4TG2c2m6D
         I6pJGdD9Zy/di0gU1bGs3VylZSv1AW2OWwifI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=ZoXzgEmfACeUElk+HYMB9dds6VUHUTSvRCJFBA7VcYn6KznttxC2YQz5o5mR+9AqhU
         /mIM4IePG/4jed73EVU2QIO5MM/KkFNE6KYN3E1hPQk1Nhy/+hsQS+iiEhrUIsGoGN6d
         HI8+SWk354QEL0bTzQmVgXfl/EWMW9Aibqv0M=
Received: by 10.150.173.38 with SMTP id v38mr497303ybe.445.1279295100332; Fri, 
	16 Jul 2010 08:45:00 -0700 (PDT)
Received: by 10.151.85.19 with HTTP; Fri, 16 Jul 2010 08:44:40 -0700 (PDT)
In-Reply-To: <20100716082937.GA22894@nibiru.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151157>

On Fri, Jul 16, 2010 at 4:29 AM, Enrico Weigelt <weigelt@metux.de> wrote:
> I've forked some branch A into B, now A and B have evolved
> independently for quite some time into A' and B'. Now I'd like
> to rebase B' along A' history line step by step - first on A+1,
> then A+3, ... until A' (that's what I'd call zip-rebase).

You haven't *really* explained what you want to do here, but that
doesn't really effect the answer to your actual question...

> For this I need to find out the successor commit A (along the A'
> history line). Does anyone know how to do that ?

git rev-list --first-parent --reverse $(git merge-base A B)..A

Have fun,

Avery
