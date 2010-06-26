From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: git-gui and gitk-git as submodules (Re: [RFC PATCH 0/2] Teach
 	"git status" the "--ignore-submodules" option)
Date: Sat, 26 Jun 2010 13:45:02 +0200
Message-ID: <4C25E83E.4080905@web.de>
References: <4C24C34B.20403@web.de>	<7vlja3j7hu.fsf@alter.siamese.dyndns.org>	<20100625190147.GA17493@burratino> <AANLkTimqXhGw5fAAgZsoDAI9s6kaIzcka9mbFEW8j05v@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Johan Herland <johan@herland.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Andy Parkins <andyparkins@gmail.com>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 26 13:45:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OSTpC-0004l4-Un
	for gcvg-git-2@lo.gmane.org; Sat, 26 Jun 2010 13:45:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752981Ab0FZLpH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jun 2010 07:45:07 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:34824 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752400Ab0FZLpF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jun 2010 07:45:05 -0400
Received: from smtp03.web.de  ( [172.20.0.65])
	by fmmailgate02.web.de (Postfix) with ESMTP id D7D2116923CF6;
	Sat, 26 Jun 2010 13:45:02 +0200 (CEST)
Received: from [80.128.106.233] (helo=[192.168.178.26])
	by smtp03.web.de with asmtp (WEB.DE 4.110 #4)
	id 1OSTok-0007xR-00; Sat, 26 Jun 2010 13:45:02 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.1.9) Gecko/20100317 Thunderbird/3.0.4
In-Reply-To: <AANLkTimqXhGw5fAAgZsoDAI9s6kaIzcka9mbFEW8j05v@mail.gmail.com>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX1/iGuGXCpJyo7j4hwwn9BH6gQsuh6WPjTlMVypA
	zaeBLQLmGxZkdL8+ezwXwB5o0s2Nfn+smz+CP89siFs/FR7p1P
	bCNGkfgxzh17rw1JDZRg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149738>

Am 26.06.2010 06:44, schrieb Tay Ray Chuan:
> On Sat, Jun 26, 2010 at 3:01 AM, Jonathan Nieder <jrnieder@gmail.com> wrote:
>> Given a patch to automatically resolve submodule-ejection/subtree-merge
>> conflicts, do you think a patch series to split off gitk and git-gui
>> as submodules could live in pu eventually?
> 
> +1
> 
> They do sound like they'd fit into the submodule paradigm. Further,
> having git use it would be a good showcase of the submodule feature -
> or bug. :)

Yes, I think having them as a submodule makes lots of sense. But
submodules are not there yet. Unless I overlooked something, the
following issues must be resolved before having these two as a
submodule, otherwise people will complain (and rightfully so!):

1) Switching branches, merging, rebasing and resetting in the
   superproject must result in a checkout of the matching submodule
   work tree (right now you always have to issue a "git submodule
   update" afterwards to get the submodules in sync).

2) On "git clone" the submodules must be cloned and checked out too
   (currently you have to do a "git submodule update --init" after
   cloning the superproject).

3) Switching between commits in the superproject where a directory
   is replaced by a submodule or vice versa doesn't work right now.
   Submodules should handle this situation, otherwise the commit
   putting gitk and git gui into submodules would become a barrier.

I am working on these issues, but that will take some time. But when
they are solved, me too thinks that these two should become submodules.
