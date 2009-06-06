From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH v2 3/8] diff-delta.c: "delta.h" is not a required include
Date: Fri, 05 Jun 2009 21:21:39 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0906052112590.3906@xanadu.home>
References: <67hZHClrEWQHxCRdWosE24FbCSWPktK230jx86LzLj0Aqa5g5XoJb3Iv805pzfx5wCPameuSp6M@cipher.nrlssc.navy.mil>
 <M3MzU6FlQXfVApDnN0vdEf4UcS0v8Dh-XOz1cA15MA7nN8wUHrIif6F7g1-JWcHSJSi5Z6_vOoA@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: gitster@pobox.com, git@vger.kernel.org, peff@peff.net,
	Brandon Casey <drafnel@gmail.com>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Sat Jun 06 03:21:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MCkbZ-0008SW-Fz
	for gcvg-git-2@gmane.org; Sat, 06 Jun 2009 03:21:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752753AbZFFBVo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jun 2009 21:21:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752632AbZFFBVn
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Jun 2009 21:21:43 -0400
Received: from relais.videotron.ca ([24.201.245.36]:54710 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752024AbZFFBVn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jun 2009 21:21:43 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KKS00JCVMG4DPB0@VL-MO-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 05 Jun 2009 21:21:40 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <M3MzU6FlQXfVApDnN0vdEf4UcS0v8Dh-XOz1cA15MA7nN8wUHrIif6F7g1-JWcHSJSi5Z6_vOoA@cipher.nrlssc.navy.mil>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120861>

On Fri, 5 Jun 2009, Brandon Casey wrote:

> From: Brandon Casey <drafnel@gmail.com>
> 
> When compiling diff-delta.c with the SUNWspro C99 compiler, it complains
> 
>     "diff-delta.c", line 314: identifier redeclared: create_delta
> 
> There is nothing in "delta.h" that is required by diff-delta.c, so don't
> include it.
> 
> Signed-off-by: Brandon Casey <drafnel@gmail.com>

NAK.

This is common practice to include the header file declaring function 
prototypes into the file defining the actual function so to make sure 
the declaration matches with the definition.  Deleting that include is 
actively ignoring a problem instead of fixing the cause of it.


Nicolas
