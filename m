From: John Whitney <jjw@emsoftware.com>
Subject: Re: Bug report
Date: Tue, 09 Oct 2012 14:00:19 -0500
Message-ID: <50747443.8080905@emsoftware.com>
References: <506D122E.2050404@emsoftware.com> <CABURp0rhHTSqQFiXEb12iKLAAjMW3+Jn-ubMy-9jNWc5068toA@mail.gmail.com> <506DB500.4010803@emsoftware.com> <20121006133146.GD11712@sigill.intra.peff.net> <5070E7BF.8040102@emsoftware.com> <20121007235244.GA5536@sigill.intra.peff.net> <50745C32.5050505@emsoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Phil Hord <phil.hord@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Oct 09 21:00:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TLf2i-0003QY-A3
	for gcvg-git-2@plane.gmane.org; Tue, 09 Oct 2012 21:00:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756668Ab2JITAZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Oct 2012 15:00:25 -0400
Received: from mail.emsoftware.com ([76.75.201.49]:64717 "EHLO emsoftware.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756595Ab2JITAY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Oct 2012 15:00:24 -0400
Received: from Johns-MacBook-Pro.local (ppp-70-253-75-224.dsl.austtx.swbell.net [70.253.75.224])
	by emsoftware.com (Postfix) with ESMTP id 658E81AFB0AD;
	Tue,  9 Oct 2012 15:04:13 -0400 (EDT)
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.7; rv:15.0) Gecko/20120907 Thunderbird/15.0.1
In-Reply-To: <50745C32.5050505@emsoftware.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207338>

On 10/9/12 12:17 PM, John Whitney wrote:
> Thank you very much for your detailed explanations. I suspected that 
> efficiency concerns might be preventing a clean solution.
>
> How about this idea... When git stores files, it could include a bit 
> of metadata that tells it whether the file is a binary blob or text. 
> (Perhaps it already does this?) If a binary blob (in the repository) 
> is being compared with a text file (on the filesystem), git could 
> re-process the blob and get the "sha1 of the canonical stripped 
> version". In all other situations, the original SHA1 should be 
> correct, since git already removes CRs from the line endings in files 
> it recognizes as text.
>
> I would think that this solution would have no performance penalty for 
> "fixed" repositories. (It would only have a small performance hit when 
> binary blobs are compared against text files, which is rare even in 
> broken repositories.) Git could even throw a warning like: "File 
> xyz.txt was originally stored as a binary blob."
>
> What do you think?
>
>    ---John
>
I'm going to reply to myself, to save you the trouble of replying. 
(You've been very helpful and I do appreciate it.)

I guess the problem with this idea is that git doesn't have any way to 
distinguish between binary blobs and text files in the repository. I 
think it would be useful information, but I guess that bridge burned a 
long time ago. So any metadata would have to be stored separately. Jeff, 
that's roughly equivalent to your idea of caching, which would take a 
lot of work to implement.

Thank you so much for helping me to understand the reason git behaves 
the way it does. It's a great tool!

    ---John
