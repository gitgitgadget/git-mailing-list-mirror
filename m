From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] fast-import: Allow filemodify to set the root
Date: Fri, 08 Oct 2010 08:50:22 +0200
Message-ID: <4CAEBF2E.8020206@viscovery.net>
References: <1286448906-1424-1-git-send-email-david.barr@cordelta.com> <AANLkTikjzQ09XBxYZXXQf6XCme3FiLKtusZ0MLTa--mM@mail.gmail.com> <20101007202847.GA13234@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	David Barr <david.barr@cordelta.com>,
	Git Mailing List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 08 08:50:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P46mk-0008KX-UL
	for gcvg-git-2@lo.gmane.org; Fri, 08 Oct 2010 08:50:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752305Ab0JHGu2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Oct 2010 02:50:28 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:32465 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752228Ab0JHGu1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Oct 2010 02:50:27 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1P46md-0001Ho-3t; Fri, 08 Oct 2010 08:50:23 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id D12D61660F;
	Fri,  8 Oct 2010 08:50:22 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.9) Gecko/20100915 Thunderbird/3.1.4
In-Reply-To: <20101007202847.GA13234@burratino>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158476>

Am 10/7/2010 22:28, schrieb Jonathan Nieder:
> Sverre Rabbelier wrote:
> 
>> This means nothing to me
> 
> Sorry for the lack of clarity.  Probably I should have just said:
> 
> | For a command (like filter-branch --subdirectory-filter) that wants
> | to commit a lot of trees that already exist in the object db, writing
> | undeltified objects as loose files only to repack them later can
> | involve a significant amount[*] of overhead.

1. But when an object already exists in the db, it won't be written again,
will it?

2. Even though fast-import puts all (new) objects into a pack file, the
pack is heavily sub-optimal, and you should repack -f anyway. So what's
the point? Only to avoid a loose object?

(I'm not saying that the patch is unwanted, but only that the
justification is still not sufficiently complete.)

-- Hannes
