From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] Add some fancy colors in the test library when terminal
  supports it.
Date: Mon, 22 Oct 2007 13:35:30 +0200
Message-ID: <471C8B02.6080202@viscovery.net>
References: <20071022081341.GC32763@artemis.corp> <471C6510.8010300@viscovery.net> <20071022112401.GE32763@artemis.corp>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Mon Oct 22 13:35:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IjvZR-00019J-3o
	for gcvg-git-2@gmane.org; Mon, 22 Oct 2007 13:35:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751651AbXJVLfe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Oct 2007 07:35:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751856AbXJVLfe
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Oct 2007 07:35:34 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:52452 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751525AbXJVLfd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Oct 2007 07:35:33 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1IjvYx-0006Qb-VF; Mon, 22 Oct 2007 13:35:16 +0200
Received: from [192.168.1.42] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 0146A6B7; Mon, 22 Oct 2007 13:35:30 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <20071022112401.GE32763@artemis.corp>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61992>

Pierre Habouzit schrieb:
> On Mon, Oct 22, 2007 at 08:53:36AM +0000, Johannes Sixt wrote:
>> Pierre Habouzit schrieb:
>>> +say_color () {
>>> +	[ "$nocolor" = 0 ] &&  [ "$1" != '-1' ] && tput setaf "$1"
>>> +	shift
>>> +	echo "* $*"
>>> +	tput op
>>> +}
>> What if tput is not available, like on Windows? How about this (at the 
>> end of the file, so it can obey --no-color):
> 
>   I answered to it already in my first mail: if tput isn't available,
> the command fails, and $? is non 0. and nocolor is set. Or color isn't
> set to 't' for your proposal.

I was too terse, sorry. I wanted to point out that if tput is not available, 
the second invocation will leave "tput: command not found" behind on stderr. 
Therefore, I proposed to make the definition of say_color() different 
depending on whether $color is set or not. Then you don't need to test for 
$color twice inside the function.

-- Hannes
