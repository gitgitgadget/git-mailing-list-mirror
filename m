From: Tomas Carnecky <tom@dbservice.com>
Subject: Re: More help with "pull" please
Date: Thu, 2 Apr 2009 17:18:13 +0200
Message-ID: <1E580393-D051-4259-B4DE-CFFC9082C87A@dbservice.com>
References: <450196A1AAAE4B42A00A8B27A59278E70A7D4D9A@EXCHANGE.trad.tradestation.com> <4659A860-4AF5-4E34-B38E-60C926E2BAE1@dbservice.com> <450196A1AAAE4B42A00A8B27A59278E70A7D4E71@EXCHANGE.trad.tradestation.com> <F364AB31-EC5B-4719-834E-58613BDBC433@dbservice.com> <7viqlnokrv.fsf@gitster.siamese.dyndns.org> <450196A1AAAE4B42A00A8B27A59278E70A7D4FF7@EXCHANGE.trad.tradestation.com>
Mime-Version: 1.0 (Apple Message framework v930.4)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, <git@vger.kernel.org>
To: "John Dlugosz" <JDlugosz@TradeStation.com>
X-From: git-owner@vger.kernel.org Thu Apr 02 17:20:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LpOiL-0003kS-TL
	for gcvg-git-2@gmane.org; Thu, 02 Apr 2009 17:20:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760713AbZDBPSr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Apr 2009 11:18:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760195AbZDBPSq
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Apr 2009 11:18:46 -0400
Received: from office.neopsis.com ([78.46.209.98]:54109 "EHLO
	office.neopsis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758345AbZDBPSq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Apr 2009 11:18:46 -0400
Received: from [192.168.0.130] ([62.65.141.13])
	(authenticated user tom@dbservice.com)
	by office.neopsis.com
	(using TLSv1/SSLv3 with cipher AES128-SHA (128 bits));
	Thu, 2 Apr 2009 17:18:39 +0200
In-Reply-To: <450196A1AAAE4B42A00A8B27A59278E70A7D4FF7@EXCHANGE.trad.tradestation.com>
X-Mailer: Apple Mail (2.930.4)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115472>


On Apr 2, 2009, at 4:45 PM, John Dlugosz wrote:

>> If your repository is using .git/remotes/origin to name the "origin"
>
> I don't have a directory under .git called remotes.  A new repository
> made using clone describes origin in the config file.  Is that an old
> way of doing things?

Yep. Earlier git versions used one config file per remote. Newer git  
versions use the .git/config file.

>> remote, they are still honored.  But you are correct to point out  
>> that
>> branch.<name>.remote and with the remote.<name>.* variables in
>> .git/config
>> are used to control these more recent features.  So in that sense the
>> documentation is still correct.
>
> A related question:  is the name "origin" hard-coded as the default,  
> or
> does each repository remember specifically which is the upstream
> repository regardless of what you named it?  From what I see in the
> config file, it would have to be per-branch.  I suppose in other cases
> it's implicit in where the label was found under remotes.

'origin' is the default name for the remote you cloned from. But there  
is nothing special to it other than being a default name used  
throughout git. You can manually add remotes under a different name if  
you like.

$ git clone $url ./xyz

is roughly the same as:

$ mkdir ./xyz && cd ./xyz
$ git init
$ git remote add origin $url
$ git fetch origin
$ git checkout -b master origin/master

tom
