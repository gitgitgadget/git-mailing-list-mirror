From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [PATCH 4/8] rev-parse: teach "git rev-parse --symbolic" to print the full ref name
Date: Sun, 28 Oct 2007 14:49:28 +0100
Message-ID: <A4E7AC63-8EFF-4078-985D-4582BB8D528C@zib.de>
References: <119350380778-git-send-email-prohaska@zib.de> <11935038081211-git-send-email-prohaska@zib.de> <11935038081650-git-send-email-prohaska@zib.de> <1193503808519-git-send-email-prohaska@zib.de> <11935038083369-git-send-email-prohaska@zib.de> <Pine.LNX.4.64.0710271748440.7345@iabervon.org>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Sun Oct 28 14:50:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Im8Wf-0004rr-8N
	for gcvg-git-2@gmane.org; Sun, 28 Oct 2007 14:50:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751588AbXJ1Nts (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Oct 2007 09:49:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751401AbXJ1Ntr
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Oct 2007 09:49:47 -0400
Received: from mailer.zib.de ([130.73.108.11]:49321 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751588AbXJ1Ntr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Oct 2007 09:49:47 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l9SDm2X4001340;
	Sun, 28 Oct 2007 14:49:42 +0100 (CET)
Received: from [192.168.178.21] (brln-4db1072b.pool.einsundeins.de [77.177.7.43])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l9SDm11Y029218
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Sun, 28 Oct 2007 14:48:02 +0100 (MET)
In-Reply-To: <Pine.LNX.4.64.0710271748440.7345@iabervon.org>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62561>


On Oct 27, 2007, at 11:53 PM, Daniel Barkalow wrote:

> On Sat, 27 Oct 2007, Steffen Prohaska wrote:
>
>> "git rev-parse --symbolic" used to return the ref name as it was
>> specified on the command line. This is changed to returning the
>> full matched ref name, i.e. "git rev-parse --symbolic master"
>> now typically returns "refs/heads/master".
>>
>> Note, this changes output of an established command. It might
>> break existing setups. I checked that it does not break scripts
>> in git.git.
>
> I think this makes the --create option to push unnecessary, as  
> interactive
> users could use a suggested explicit value (or whatever they actually
> meant), while scripts could replace $name with $(git rev-parse -- 
> symbolic
> $name) as easily as they could add --create, and by more explicit  
> as to
> what they're doing.

I'll remove 4/8 (git rev-parse --symbolic) from the patch
series. It is not directly related to the push behaviour
and Junio pointed out that the old behavior of git rev-parse
must be maintained as is.  I'm not particularly interested in
modifying git rev-parse. If someone else is, feel free to take
over my patch.

I'll keep the '--create' flag. Its intention is obvious and easy
to explain to users. Much easier than
"git rev-parse --dwim_ref ..." or something similar.

	Steffen
