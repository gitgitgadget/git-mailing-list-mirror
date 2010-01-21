From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: git locate
Date: Thu, 21 Jan 2010 10:42:19 +0100
Message-ID: <4B58217B.4040205@drmicha.warpmail.net>
References: <43d8ce651001191717l58d10919j691f4e5b056fe9b5@mail.gmail.com> <alpine.DEB.1.00.1001200224270.4985@pacific.mpi-cbg.de> <m3zl49bk0o.fsf@localhost.localdomain> <alpine.DEB.1.00.1001201021060.31129@intel-tinevez-2-302> <4B579BA8.8050000@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>
To: SungHyun Nam <goweol@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 21 10:44:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXtaP-0007mn-GR
	for gcvg-git-2@lo.gmane.org; Thu, 21 Jan 2010 10:44:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754399Ab0AUJoQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jan 2010 04:44:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753669Ab0AUJoQ
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Jan 2010 04:44:16 -0500
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:58836 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753396Ab0AUJoP (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Jan 2010 04:44:15 -0500
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 7786CCDF53;
	Thu, 21 Jan 2010 04:44:14 -0500 (EST)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Thu, 21 Jan 2010 04:44:14 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=1mi+N7J2tZ9Z8DFHoCVHbNBNFXM=; b=sLI8Q3cPQ8i7izbvHi9IHoQzPOBa4kUq2YO8kcG550MThxGfQgpr4qQtq2sf79u8NfZCU9fkScw7v9mj2v5HyQEwEEMzzOhpCsUGGvVZ+HTwapMlI2jtXomXImGMnhGIhsdHtlqICAk5Nuk08iVO3RVA8lbGZbs4jCyTKyAY3BY=
X-Sasl-enc: Ogt+lYDvBtes1AcoN7eoq/6CqcovL68G8AseS3CjfUB9 1264067054
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id D8F214B89AE;
	Thu, 21 Jan 2010 04:44:13 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.7pre) Gecko/20091209 Lightning/1.0b2pre Shredder/3.0.1pre
In-Reply-To: <4B579BA8.8050000@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137646>

SungHyun Nam venit, vidit, dixit 21.01.2010 01:11:
> Hello,
> 
> Johannes Schindelin wrote:
>>
>> On Tue, 19 Jan 2010, Jakub Narebski wrote:
>>
>>> Johannes Schindelin<Johannes.Schindelin@gmx.de>  writes:
>>>
>>>> On Wed, 20 Jan 2010, John Tapsell wrote:
>>>>
>>>>>    Could we add a:  git locate<filename>        or git find<filename>
>>>>
>>>> How about "git ls-files \*<filename>"?
>>>
>>> Or "git ls-files '*filename'...
>>>
>>> ... but how to make an (git) alias for this?
>>
>> Add something like this to your $HOME/.gitconfig:
>>
>> [alias]
>>          locate = !sh -c 'git ls-files "\\*$1"' -
> 
> The alias 'git locate' and the command 'git ls-files' runs
> differently if I run them in a subdirectory.
> Is it expected?
> 
> [master] ~/srcs/git[299]$ git locate urls.txt
> Documentation/urls.txt
> [master] ~/srcs/git[300]$ git ls-files '*urls.txt'
> Documentation/urls.txt
> [master] ~/srcs/git[301]$ cd t
> [master] ~/srcs/git/t[302]$ git locate urls.txt
> Documentation/urls.txt
> [master] ~/srcs/git/t[303]$ git ls-files '*urls.txt'
> [master] ~/srcs/git/t[304]$

Yes, aliases with "!" are executed from the root of the worktree,
ls-files from the current wd.

Michael
