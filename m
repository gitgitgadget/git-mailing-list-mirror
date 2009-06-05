From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCHv1+eps] git-repack.txt: Clarify implications of -a for
 dumb 	protocols
Date: Fri, 05 Jun 2009 10:16:48 +0200
Message-ID: <4A28D470.5030403@drmicha.warpmail.net>
References: <200906031950.56974.lists@informa.tiker.net> <1244115295-28688-1-git-send-email-git@drmicha.warpmail.net> <780e0a6b0906041246k43d42af1xe623168c52ff7e4f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, lists@informa.tiker.net,
	Junio C Hamano <gitster@pobox.com>
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 05 10:23:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MCUhg-0003Rt-JH
	for gcvg-git-2@gmane.org; Fri, 05 Jun 2009 10:23:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757317AbZFEIRH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jun 2009 04:17:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757310AbZFEIRG
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Jun 2009 04:17:06 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:36168 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756867AbZFEIRC (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 Jun 2009 04:17:02 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by out1.messagingengine.com (Postfix) with ESMTP id D258035711D;
	Fri,  5 Jun 2009 04:17:02 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Fri, 05 Jun 2009 04:17:02 -0400
X-Sasl-enc: rpUWr3O/vLTua194hGGk4Hy33JkPZbNP8OxcOaOs0UR1 1244189822
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id C46E21327D;
	Fri,  5 Jun 2009 04:17:01 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1pre) Gecko/20090605 Lightning/1.0pre Shredder/3.0b3pre
In-Reply-To: <780e0a6b0906041246k43d42af1xe623168c52ff7e4f@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120760>

Stephen Boyd venit, vidit, dixit 04.06.2009 21:46:
> On Thu, Jun 4, 2009 at 4:34 AM, Michael J
> Gruber<git@drmicha.warpmail.net> wrote:
>>        pack everything referenced into a single pack.
>>        Especially useful when packing a repository that is used
>>        for private development and there is no need to worry
>> -       about people fetching via dumb protocols from it.  Use
>> +       about people fetching via dumb protocols from it.
>> +       (Over dumb protocols, one would have to fetch the whole new
>> +       pack in order to get any contained object, no matter how
>> +       many other objects in that pack exist locally already.) Use
>>        with '-d'.  This will clean up the objects that `git prune`
>>        leaves behind, but `git fsck --full` shows as
>>        dangling.
> 
> Instead of adding this, why don't we just remove the part about dumb
> protocols? So just say that it's especially useful for private
> development. Then, if we really want to keep this performance note
> just add it after the paragraph in one of those "+" things (What are
> those called?)

...because "repack -a" hurts *badly* on even midsized repos when dumb
protocols are used. On the other hand, using it isn't that much of an
improvement in terms of pack size, unless you repack manually very often
and, thus, produce many small packs. So, "gc --auto" users should be
fine in any case (dumb or not - the protocol, that is...) as long as
they don't use "-a".

Michael
