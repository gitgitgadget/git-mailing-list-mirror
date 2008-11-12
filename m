From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: [PATCH] git-diff: Add --staged as a synonym for --cached.
Date: Wed, 12 Nov 2008 17:39:05 -0500
Message-ID: <32541b130811121439tbfc54aeq2999dbebf149d5bc@mail.gmail.com>
References: <20081102123519.GA21251@atjola.homenet>
	 <32541b130811102004n54a47331v48ba8d299039897f@mail.gmail.com>
	 <20081112083353.GB3817@coredump.intra.peff.net>
	 <alpine.DEB.1.00.0811121205100.30769@pacific.mpi-cbg.de>
	 <20081112110629.GA20473@coredump.intra.peff.net>
	 <32541b130811120739t95455d8n9b8056a8033491c3@mail.gmail.com>
	 <20081112191512.GA21401@coredump.intra.peff.net>
	 <7vljvooi8w.fsf@gitster.siamese.dyndns.org>
	 <20081112193747.GA21567@coredump.intra.peff.net>
	 <7vbpwkogxq.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Jeff King" <peff@peff.net>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"=?ISO-8859-1?Q?Bj=F6rn_Steinbrink?=" <B.Steinbrink@gmx.de>,
	"David Symonds" <dsymonds@gmail.com>, git@vger.kernel.org,
	"Stephan Beyer" <s-beyer@gmx.net>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 12 23:50:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0OXE-00036Z-2d
	for gcvg-git-2@gmane.org; Wed, 12 Nov 2008 23:50:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752909AbYKLWso (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Nov 2008 17:48:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752856AbYKLWso
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Nov 2008 17:48:44 -0500
Received: from yx-out-2324.google.com ([74.125.44.28]:22455 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752725AbYKLWsn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Nov 2008 17:48:43 -0500
Received: by yx-out-2324.google.com with SMTP id 8so308194yxm.1
        for <git@vger.kernel.org>; Wed, 12 Nov 2008 14:48:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=bl5B1qVOEczgplLa9OlWLW02/CLBPo0IOgHbNEqEtO4=;
        b=og3D/Nb4ySc0hz0rbKfS6WBc95C5nktNjCL2+tO4F5Ba8elMxneU+IAOHySbZo5CXj
         4vIJibvkPJQSftQXjXDqiuF3+2227KiZx4O+3qqAZjnQZRykugFifzTmAFuQxi/ID7lD
         uaFTBN0IjuMYd3AaPCDxZG8jqVu88DuGI8O/o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=iYcyQHBwGYGRE046XHrDnh2XdySgF+vbQSIm+9J6/QWalUAO4vWBLT/QKoRLfbH2eO
         JKtv3FzQAILv9+gr/7kZbR9MsmuWckv9A8lEWazXQbiyHK1OZhJowPM4n/OvqsIcFjqg
         fqwg/HRFrK3n1IgT942P+q58aGLXFuqzjngrA=
Received: by 10.150.156.20 with SMTP id d20mr9466125ybe.135.1226529546029;
        Wed, 12 Nov 2008 14:39:06 -0800 (PST)
Received: by 10.150.98.19 with HTTP; Wed, 12 Nov 2008 14:39:05 -0800 (PST)
In-Reply-To: <7vbpwkogxq.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100828>

On Wed, Nov 12, 2008 at 2:57 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Jeff King <peff@peff.net> writes:
>
>> I'm not sure I agree. They _are_ different things, but in the case of
>> diff, you are really treating each of them like a tree (which makes
>> range operators a little silly, but then that is a silliness already
>> present in "git diff tree1..tree2").
>
> It is not _little_ silly, but quite silly.  It is a historical accident
> and I personally suggest against using it when I teach git to others.

I assume the reason is that "git diff tree1..tree2" works with the
differences between tree1 and tree2, much like "git log tree1..tree2"
does.  On the other hand, "git log tree1 tree2" is something
completely different.

So at least in my mental model, it's "git diff tree1 tree2" that's out
of place, not really the one with the range specifier.

Apparently what's intuitive to one person isn't always intuitive to the next.

Avery
