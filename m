From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: PUSH_HEAD, was Re: FETCH_HEAD question
Date: Wed, 18 Feb 2009 01:30:00 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902180122440.10279@pacific.mpi-cbg.de>
References: <76718490902162043k78e615b5g7ba4b7ac95e73b18@mail.gmail.com> <7veixxaale.fsf@gitster.siamese.dyndns.org> <76718490902162221i31e02052j48c9f620a2d47985@mail.gmail.com> <7vr61x8ra4.fsf@gitster.siamese.dyndns.org> <76718490902162341y2f122427i470c77d3915ff554@mail.gmail.com>
 <7vy6w5795h.fsf@gitster.siamese.dyndns.org> <76718490902170914p6258b77ak81318f13757f0dfd@mail.gmail.com> <alpine.DEB.1.00.0902171821190.6185@intel-tinevez-2-302> <76718490902170934u5e2c17ffl7599ddeb5ee59812@mail.gmail.com> <alpine.DEB.1.00.0902172357450.10279@pacific.mpi-cbg.de>
 <7vab8k39ze.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 18 01:30:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZaKp-0001Lb-RM
	for gcvg-git-2@gmane.org; Wed, 18 Feb 2009 01:30:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751844AbZBRA3F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2009 19:29:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752093AbZBRA3E
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Feb 2009 19:29:04 -0500
Received: from mail.gmx.net ([213.165.64.20]:57166 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751454AbZBRA3D (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2009 19:29:03 -0500
Received: (qmail invoked by alias); 18 Feb 2009 00:28:59 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp043) with SMTP; 18 Feb 2009 01:28:59 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/Wxw9H5j7WZ5KTOWeSpcfDwsEwUJKlcz/MEn/TAM
	ga3IBrl+kIahLL
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <7vab8k39ze.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110485>

Hi,

On Tue, 17 Feb 2009, Junio C Hamano wrote:

> FETCH_HEAD is something the user who is sitting in front of the 
> repository controls with "git fetch" into it.  The objects referenced 
> from it is not part of the "reachable" set, and expectation is that 
> anything that requires the objects will happen before that user decides 
> to actively go prune unreachable objects.
> 
> PUSH_HEAD is quite different, and it needs to be handled a lot more 
> carefully.

Well, when I talked about the push equivalent of FETCH_HEAD I really meant 
that it be exactly that.  No additional taking care, that's the user's 
responsibility.

I got carried away with the "2nd push will not need to push the objects 
again", and in the meantime I think that should not be the case.

The main use for it I had in mind was to have some obviously temporary 
"ref" that you could push to.

However, I think that would not bode well, as receive.denyCurrentBranch 
will error out early, and rightfully so.

The way out I _could_ think of right now is to have a REFUSED_PUSH_HEAD 
_just_ for the denyCurrentBranch case, but it's bedtime for lil' Dscho, so 
I cannot think clearly about that today.

Ciao,
Dscho "who will be dreaming of detached, split and pushed heads all night long"
