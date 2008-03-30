From: Eyvind Bernhardsen <eyvind-git@orakel.ntnu.no>
Subject: Re: git-submodule getting submodules from the parent repository
Date: Sun, 30 Mar 2008 15:32:21 +0200
Message-ID: <D0F821FA-AF53-4F1F-B9CC-58346828FA15@orakel.ntnu.no>
References: <32541b130803291535m317e84e6p321ebccd5dedaab3@mail.gmail.com> <47EECF1F.60908@vilain.net>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Avery Pennarun <apenwarr@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Sun Mar 30 15:33:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jfxen-0002YL-Uz
	for gcvg-git-2@gmane.org; Sun, 30 Mar 2008 15:33:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750991AbYC3NcZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Mar 2008 09:32:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750978AbYC3NcZ
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Mar 2008 09:32:25 -0400
Received: from 97.84-49-228.nextgentel.com ([84.49.228.97]:65436 "EHLO
	eyvind.bernhardsens.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750939AbYC3NcY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Mar 2008 09:32:24 -0400
Received: from vredefort.d.eyvind.bernhardsens.net (vredefort.d.eyvind.bernhardsens.net [172.16.3.223])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by eyvind.bernhardsens.net (Postfix) with ESMTP id E0F88159328;
	Sun, 30 Mar 2008 15:32:22 +0200 (CEST)
In-Reply-To: <47EECF1F.60908@vilain.net>
X-Mailer: Apple Mail (2.919.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78502>

On 30. mars. 2008, at 00.22, Sam Vilain <sam@vilain.net> wrote:

> Avery Pennarun wrote:
>
>> 2. You still check into C, then B, then A, but it doesn't actually
>> matter if you put B and C on a branch first or not, because 'git  
>> push'
>> will work properly, because it auto-pushes B and C revisions based on
>> the fact that A refers to them (ie. implicit branches via the
>> submodule mechanism).
>
> This push failure thing is regrettable; however it's not clear which
> branch name the submodules should get.  A given commit might exist on
> several branches, which one do you choose to name it?

I solved that by adding a "submodule push" that pushes the detached  
head of each submodule to its own ref ("refs/submodule-update/commit- 
$sha1", imaginatively).  I also made "submodule update" try to fetch  
that ref when looking for a sha1.

I ran into trouble trying to avoid pushing every submodule for each  
"submodule push", and then more or less decided not to use submodules,  
so it's not quite fit for public consumption.  I still think it's a  
sound idea in principle, so I'll clean it up and send it to the list  
if there's any interest.
-- 
Eyvind Bernhardsen
