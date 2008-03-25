From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: [bug] git-add won't add foo/.git/bar
Date: Tue, 25 Mar 2008 01:42:36 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0803250050320.30488@kaos.quantumfyre.co.uk>
References: <fs9f0o$jge$1@ger.gmane.org> <Pine.LNX.4.64.0803242359230.24262@kaos.quantumfyre.co.uk>
 <7v1w5zslv5.fsf@gitster.siamese.dyndns.org> <fs9i36$qck$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org
To: Michael Gebetsroither <gebi@sbox.tugraz.at>
X-From: git-owner@vger.kernel.org Tue Mar 25 02:44:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JdyCr-0006oO-Iv
	for gcvg-git-2@gmane.org; Tue, 25 Mar 2008 02:44:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754045AbYCYBnY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Mar 2008 21:43:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754022AbYCYBnY
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Mar 2008 21:43:24 -0400
Received: from electron.quantumfyre.co.uk ([87.106.55.16]:50879 "EHLO
	electron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753995AbYCYBnY (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 Mar 2008 21:43:24 -0400
Received: from neutron.quantumfyre.co.uk (neutron.datavampyre.co.uk [212.159.54.235])
	by electron.quantumfyre.co.uk (Postfix) with ESMTP id 1B37BC6090
	for <git@vger.kernel.org>; Tue, 25 Mar 2008 01:43:23 +0000 (GMT)
Received: (qmail 14265 invoked by uid 103); 25 Mar 2008 01:42:36 +0000
Received: from 192.168.0.4 by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-1.25st 
 (spamassassin: 3.2.1. perlscan: 1.25st.  
 Clear:RC:1(192.168.0.4):. 
 Processed in 0.029499 secs); 25 Mar 2008 01:42:36 -0000
Received: from elfhelm.quantumfyre.co.uk (HELO kaos.quantumfyre.co.uk) (192.168.0.4)
  by neutron.datavampyre.co.uk with SMTP; 25 Mar 2008 01:42:36 +0000
X-X-Sender: jp3@kaos.quantumfyre.co.uk
In-Reply-To: <fs9i36$qck$1@ger.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78142>

On Tue, 25 Mar 2008, Michael Gebetsroither wrote:

> * Junio C Hamano <gitster@pobox.com> wrote:
>> Julian Phillips <julian@quantumfyre.co.uk> writes:
>>> On Tue, 25 Mar 2008, Michael Gebetsroither wrote:
>
>>>> % git-add -f foo/.git/bar
>>>> fatal: unable to add foo/.git/bar to index
>
>> Also it is false that we should only care about the first one.  Think
>> submodules.
>
> Would it be possible to allow it with git-add -f or does that break to
> many cases?

It would be possible, but Junio has convinced me that it wouldn't really 
be wise.  Inside the working tree .git is a special name - end of story.

It would be relatively easy to change the check that prevents you from 
doing it - but this wouldn't stop any of the nasty things that could 
ensue.  You might never have a problem with a simple layout, but it could 
cause mayhem for others with more complicated layouts.

(I've never used any of the more complicated layouts either, which is why 
I didn't initially see the problems ... ho hum)

-- 
Julian

  ---
Hlade's Law:
 	If you have a difficult task, give it to a lazy person --
 	they will find an easier way to do it.
