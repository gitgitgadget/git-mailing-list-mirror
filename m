From: Andreas Ericsson <ae@op5.se>
Subject: Re: git-describe doesn't show the most recent tag
Date: Sun, 28 Sep 2008 16:51:31 +0200
Message-ID: <48DF99F3.2070503@op5.se>
References: <ce513bcc0809280648s352cda3fj5eb35b6e9cd40af9@mail.gmail.com>	 <20080928135526.GG5302@artemis.corp> <ce513bcc0809280729p47cc3790nb77b3cae8b805221@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Pierre Habouzit <madcoder@debian.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	open-iscsi@googlegroups.com
To: Erez Zilber <erezzi.list@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 28 16:53:03 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kjxdp-0003pX-It
	for gcvg-git-2@gmane.org; Sun, 28 Sep 2008 16:52:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751691AbYI1Ovs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Sep 2008 10:51:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751606AbYI1Ovs
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Sep 2008 10:51:48 -0400
Received: from mail.op5.se ([193.201.96.20]:46204 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751464AbYI1Ovr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Sep 2008 10:51:47 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id DBA6D1B80079;
	Sun, 28 Sep 2008 16:42:50 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.416
X-Spam-Level: 
X-Spam-Status: No, score=-2.416 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, DIET_1=0.083, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ji3JAOMGT1tt; Sun, 28 Sep 2008 16:42:49 +0200 (CEST)
Received: from clix.int.op5.se (unknown [172.27.78.6])
	by mail.op5.se (Postfix) with ESMTP id A34B71B80050;
	Sun, 28 Sep 2008 16:42:48 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
In-Reply-To: <ce513bcc0809280729p47cc3790nb77b3cae8b805221@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96970>

Erez Zilber wrote:
> On Sun, Sep 28, 2008 at 4:55 PM, Pierre Habouzit <madcoder@debian.org> wrote:
>> On Sun, Sep 28, 2008 at 01:48:42PM +0000, Erez Zilber wrote:
>>> Why is this happening?
>>       --tags
>>           Instead of using only the annotated tags, use any tag found in
>>           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>           .git/refs/tags.
>>
> 
> I'm not sure that I understand the difference between tags and annotated tags.
> 

An annotated tag is one created with "git tag -a" or "git tag -s".
Other tags are considered "lightweight". They are supported for
creating immutable quick-and-dirty savepoints for private use,
while published tags are supposed to be annotated to give them
some extra weight.

You can use lightweight tags like normal tags (ie, and publish
them), but then some assumptions in git will not be correct and
you need to tell it so.

Btw, the default update hook prevents lightweight (unannotated)
tags from entering a repository you're pushing to, so this
assumption is not something that's unique to just "describe".

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
