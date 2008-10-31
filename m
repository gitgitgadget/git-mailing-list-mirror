From: Junio C Hamano <gitster@pobox.com>
Subject: Re: getting list of objects for packing
Date: Fri, 31 Oct 2008 14:30:02 -0700
Message-ID: <7v7i7o8nc5.fsf@gitster.siamese.dyndns.org>
References: <TtAUShKh7lOR5rkf1iyWwpMOWoYpT8Mnw-t3Wemdy3tTCd0XiQHdag@cipher.nrlssc.navy.mil> <alpine.LFD.2.00.0810311625450.13034@xanadu.home> <JhY9the71dfsAJuojZF2S4BG-SEkshM7XxIWGPBeY9M@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>,
	Git Mailing List <git@vger.kernel.org>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Fri Oct 31 22:31:39 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kw1af-0006Da-Jz
	for gcvg-git-2@gmane.org; Fri, 31 Oct 2008 22:31:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752335AbYJaVaU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Oct 2008 17:30:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751451AbYJaVaU
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Oct 2008 17:30:20 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:55654 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751096AbYJaVaT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Oct 2008 17:30:19 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id A9EB17633E;
	Fri, 31 Oct 2008 17:30:17 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id A6B0D7633C; Fri, 31 Oct 2008 17:30:08 -0400 (EDT)
In-Reply-To: <JhY9the71dfsAJuojZF2S4BG-SEkshM7XxIWGPBeY9M@cipher.nrlssc.navy.mil> (Brandon
 Casey's message of "Fri, 31 Oct 2008 15:48:52 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 1CD66CCC-A793-11DD-B2E3-9CEDC82D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99644>

Brandon Casey <casey@nrlssc.navy.mil> writes:

> Nicolas Pitre wrote:
>> On Fri, 31 Oct 2008, Brandon Casey wrote:
>
>>>   -The sed statement is stripping off anything after the sha1. Any way to
>>>    get rev-list to print out just the sha1 so that sed is not necessary?
>> 
>> If you strip the data after the SHA1 when pipping into pack-objects then 
>> you'll have horrible delta compression results.  The path names after 
>> each SHA1 is used to sort objects when trying to find best matches for 
>> delta compression. So you should preserve those and feed it back 
>> especially with those packs that you still want delta compression for.
>
> Ah, I'll have to rethink my script then. Thanks!

Yeah, but wasn't the purpose of your whole exercise to list objects that
do not delta nor compress well with each other, in which case the delta
compression order (aka name hash) would not matter, no?
