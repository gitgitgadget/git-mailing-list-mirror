From: Pascal Obry <pascal@obry.net>
Subject: Re: Porcelain support for daggy-fixes?
Date: Thu, 10 Jun 2010 16:21:58 +0200
Message-ID: <AANLkTikbe_0GlSkXxiSeIQl0x0tfTYmoI5RuyJPzZioM@mail.gmail.com>
References: <4C10EEBE.5030400@peda.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Mikko Rantalainen <mikko.rantalainen@peda.net>
X-From: git-owner@vger.kernel.org Thu Jun 10 16:22:26 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OMieI-0006T3-4J
	for gcvg-git-2@lo.gmane.org; Thu, 10 Jun 2010 16:22:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759236Ab0FJOWJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jun 2010 10:22:09 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:41584 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759211Ab0FJOWI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jun 2010 10:22:08 -0400
Received: by gwj15 with SMTP id 15so790140gwj.19
        for <git@vger.kernel.org>; Thu, 10 Jun 2010 07:22:07 -0700 (PDT)
Received: by 10.101.4.17 with SMTP id g17mr219680ani.105.1276179725259; Thu, 
	10 Jun 2010 07:22:05 -0700 (PDT)
Received: by 10.101.66.17 with HTTP; Thu, 10 Jun 2010 07:21:58 -0700 (PDT)
In-Reply-To: <4C10EEBE.5030400@peda.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148877>

Mikko,

> I understand that this can already be done with git. The method is
>
> 1) store the current HEAD somewhere
> 2) figure out the proper parent for the bug fix
> 3) checkout the parent
> 4) implement the fix
> 5) commit the fix
> 6) checkout HEAD
> 7) merge with the commit from step 5

I would probably create a topic/fix branch:

1) figure out the proper parent for the bug fix
2) create the fix branch and move to it
    $ git co -b fix-feature-whatever parent
3) implement the fix
4) commit the fix
5) checkout HEAD
6) merge with the commit from step 4

And also merge on release branch if needed.

Pascal.

-- 

--|------------------------------------------------------
--| Pascal Obry                           Team-Ada Member
--| 45, rue Gabriel Peri - 78114 Magny Les Hameaux FRANCE
--|------------------------------------------------------
--|              http://www.obry.net
--| "The best way to travel is by means of imagination"
--|
--| gpg --keyserver wwwkeys.pgp.net --recv-key C1082595
