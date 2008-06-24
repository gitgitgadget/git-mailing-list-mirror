From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: Windows symlinks
Date: Tue, 24 Jun 2008 19:18:07 -0400
Message-ID: <32541b130806241618p69f6167dycb09cdec1af8ba0@mail.gmail.com>
References: <911589C97062424796D53B625CEC0025E4618F@USCOBRMFA-SE-70.northamerica.cexp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Patrick.Higgins@cexp.com" <Patrick.Higgins@cexp.com>
X-From: git-owner@vger.kernel.org Wed Jun 25 01:19:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBHn0-0006oR-NX
	for gcvg-git-2@gmane.org; Wed, 25 Jun 2008 01:19:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753359AbYFXXSK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2008 19:18:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753327AbYFXXSK
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 19:18:10 -0400
Received: from fk-out-0910.google.com ([209.85.128.184]:52346 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753313AbYFXXSJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2008 19:18:09 -0400
Received: by fk-out-0910.google.com with SMTP id 18so2979792fkq.5
        for <git@vger.kernel.org>; Tue, 24 Jun 2008 16:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=3GobWLlv7BDqTroGwarbUj8ljn/J+vkHVNR8Ug6eoP4=;
        b=VlMbNGFSttmNGSif3PtCYV8KNcQEGlLlah+r/KWhAwFL+eNb1P08dBxxeRS7ExzP/G
         FVdcGkoAeMcebLWTeAnLINraZppa39TE0Bnh/T3W1LEGkVteWcnU6bZKr7BNsD8zzlfn
         IV9u06aHvaU9z+4U+jPBmkqAxX/ejoFX0Vx04=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=LMXyQTQ/bTI5yRkpQDc7LmOBsOxGtU8LmtIvBgRVlRvk6tVNP8k73A7Vk/cFLnw3qU
         5niIxZQ+EyAqH0KcogwyEsQ5Vb2zB4oi0NT7KGMU7gRfi+mtd3qJZUZO51mSLKIDZQKc
         RW+vLYoCQzcEfq+mzfKV2tVUtRimCfW40pT18=
Received: by 10.82.146.10 with SMTP id t10mr607092bud.31.1214349487843;
        Tue, 24 Jun 2008 16:18:07 -0700 (PDT)
Received: by 10.82.100.5 with HTTP; Tue, 24 Jun 2008 16:18:07 -0700 (PDT)
In-Reply-To: <911589C97062424796D53B625CEC0025E4618F@USCOBRMFA-SE-70.northamerica.cexp.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86178>

On 6/24/08, Patrick.Higgins@cexp.com <Patrick.Higgins@cexp.com> wrote:
>  Cygwin's clever symlink trick seems to work pretty well in practice. I'm not exactly sure what
> it's doing, but it seems to create a shortcut that it's own programs understand. Some other
> non-Cygwin programs seem to understand them, too, but Java does not which is a big
> problem for me.

It seems somewhat odd that your developers are relying on an operating
system feature that doesn't even exist.  I might suggest one of:

- add an abstraction layer to your Java applet that understands
cygwin-style symlinks

- actually just check in the file multiple times; git will store it
efficiently anyway

- improve your Makefile to automatically copy the files and/or create
symlinks at build time rather than storing the symlinks in revision
control.

My understanding of Clearcase is that it actually loads a virtual
filesystem driver in Windows and does all kinds of insane magic -
slowly and inefficiently, too - behind the scenes.  Something tells me
git (and every other VCS :)) really doesn't want to go there.

Have fun,

Avery
