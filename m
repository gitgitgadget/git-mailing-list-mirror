From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: [bug] git-add won't add foo/.git/bar
Date: Tue, 25 Mar 2008 00:23:34 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0803250017450.27378@kaos.quantumfyre.co.uk>
References: <fs9f0o$jge$1@ger.gmane.org> <Pine.LNX.4.64.0803242359230.24262@kaos.quantumfyre.co.uk>
 <7v1w5zslv5.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Michael Gebetsroither <gebi@sbox.tugraz.at>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 25 01:24:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jdwxt-0003QR-5X
	for gcvg-git-2@gmane.org; Tue, 25 Mar 2008 01:24:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754037AbYCYAXr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Mar 2008 20:23:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754031AbYCYAXr
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Mar 2008 20:23:47 -0400
Received: from electron.quantumfyre.co.uk ([87.106.55.16]:47826 "EHLO
	electron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753818AbYCYAXq (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 Mar 2008 20:23:46 -0400
Received: from neutron.quantumfyre.co.uk (neutron.datavampyre.co.uk [212.159.54.235])
	by electron.quantumfyre.co.uk (Postfix) with ESMTP id 280B367499
	for <git@vger.kernel.org>; Tue, 25 Mar 2008 00:23:45 +0000 (GMT)
Received: (qmail 11802 invoked by uid 103); 25 Mar 2008 00:23:34 +0000
Received: from 192.168.0.4 by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-1.25st 
 (spamassassin: 3.2.1. perlscan: 1.25st.  
 Clear:RC:1(192.168.0.4):. 
 Processed in 0.029627 secs); 25 Mar 2008 00:23:34 -0000
Received: from elfhelm.quantumfyre.co.uk (HELO kaos.quantumfyre.co.uk) (192.168.0.4)
  by neutron.datavampyre.co.uk with SMTP; 25 Mar 2008 00:23:34 +0000
X-X-Sender: jp3@kaos.quantumfyre.co.uk
In-Reply-To: <7v1w5zslv5.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78134>

On Mon, 24 Mar 2008, Junio C Hamano wrote:

> Julian Phillips <julian@quantumfyre.co.uk> writes:
>
>> On Tue, 25 Mar 2008, Michael Gebetsroither wrote:
>>
>>> hi,
>>>
>>> % git-add -f foo/.git/bar
>>> fatal: unable to add foo/.git/bar to index
>>
>> Well, git won't allow .git as a element anywhere in the path, when we
>> should only care about the _first_ one - and also, if you use
>> --git-dir=banana then we still check for '.git' ... oops.
>
> That's not how git-dir is supposed to used, so there is no oops.

So I can't _ever_ have a directory/file called '.git'?  But I _can_ add 
files inside my repository provided that the repository is not called 
.git?  How is that not an oops, or extremely confusing at the least?

i.e.:

'git add .git/fred' fails
'git --git-dir=.git_repos --work-tree=. add .git/fred' fails
'git --git-dir=.git_repos --work-tree=. add .git_repos/fred' works

> Also it is false that we should only care about the first one.  Think
> submodules.

Ok, true.  I've never used submodules, can you add things inside 
submodules from the parent?  If so, where do they get added - presumably 
to the submodule?

> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

-- 
Julian

  ---
Ya'll hear about the geometer who went to the beach to catch some
rays and became a tangent ?
