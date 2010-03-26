From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Enumerating all objects in the Git object store
Date: Fri, 26 Mar 2010 16:53:18 +0100
Message-ID: <4BACD86E.4020803@viscovery.net>
References: <a1138db31003260831q34967f69u9fc8de861f7931b1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Paul Richards <paul.richards@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 26 16:54:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NvBqk-0006en-4h
	for gcvg-git-2@lo.gmane.org; Fri, 26 Mar 2010 16:53:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753327Ab0CZPxV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Mar 2010 11:53:21 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:64597 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752342Ab0CZPxV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Mar 2010 11:53:21 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1NvBqY-0005DU-LP; Fri, 26 Mar 2010 16:53:18 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 611B01660F;
	Fri, 26 Mar 2010 16:53:18 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.1.8) Gecko/20100227 Thunderbird/3.0.3
In-Reply-To: <a1138db31003260831q34967f69u9fc8de861f7931b1@mail.gmail.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143254>

Am 3/26/2010 16:31, schrieb Paul Richards:
> Is there a way to enumerate all the objects in the Git
> object store, and for each one figure out its type (commit, tree, or
> blob) and obtain a list of the objects it references?  If not, is
> there a way to do this for a single object at a time?  (I can then
> simply recurse through the whole structure.)

Use 'git rev-list --objects --all' to find all objects connected to all
refs (use something else than --all if you want to). Do *not* look at the
path that the tree and blob objects have attached - it is not authorative
information.

Use 'git cat-file -t' to find the type.

Use 'git cat-file -p' to pretty-print the content of an object. Parse it
depending on the type that you find.

-- Hannes
