From: "Robert Anderson" <rwa000@gmail.com>
Subject: Re: An alternate model for preparing partial commits
Date: Sat, 28 Jun 2008 00:03:54 -0700
Message-ID: <9af502e50806280003p59d00444hd1914a28a3a71d7e@mail.gmail.com>
References: <9af502e50806262350t6e794a92g7751147f1882965@mail.gmail.com>
	 <alpine.DEB.1.00.0806271408290.9925@racer>
	 <7vprq2rbfz.fsf@gitster.siamese.dyndns.org>
	 <20080628050317.GE9451@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Jun 28 09:04:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCUUR-00078K-9A
	for gcvg-git-2@gmane.org; Sat, 28 Jun 2008 09:04:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754338AbYF1HD5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Jun 2008 03:03:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754243AbYF1HD5
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Jun 2008 03:03:57 -0400
Received: from fg-out-1718.google.com ([72.14.220.156]:30560 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753102AbYF1HD4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jun 2008 03:03:56 -0400
Received: by fg-out-1718.google.com with SMTP id 19so404924fgg.17
        for <git@vger.kernel.org>; Sat, 28 Jun 2008 00:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=cvKbvZSE+Eh5fV1dqmEeExEsFs/Vjg7tzF/YdPTv/UM=;
        b=FurWAPvkusDIyHcfxnfHXYHj7CmKbh/nmrMxoF7iedJSSHgHE4DM8Et6j5VK5hT/no
         wYnCtToL53qK1/dW/0GfvzhZ5wDs5o4+5/TSy2OU865qBaskOWlOXjG4Fkac00bTI8YC
         UU2ddN1X5ywBg52Uf2MHwhpNZueDWqB+sjmZU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=Ef84shq9PFdMdHgnMBcrJAuKpzyX+E6RgC/Y10v2Pt6nDjl1dJ1U8Pe/T1H3zzvIZ3
         M/WcENFg5GXIMfe6lbuEoVJiZu1HxiEy6G9LG8OZEbFbcfsXAfv2Uww1ajiGAcGGqs47
         46jYR8LfAYKkVBw96ebzQiFuEMJEFuOfdesCk=
Received: by 10.86.63.19 with SMTP id l19mr3087658fga.77.1214636634791;
        Sat, 28 Jun 2008 00:03:54 -0700 (PDT)
Received: by 10.86.4.6 with HTTP; Sat, 28 Jun 2008 00:03:54 -0700 (PDT)
In-Reply-To: <20080628050317.GE9451@sigill.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86708>

On Fri, Jun 27, 2008 at 10:03 PM, Jeff King <peff@peff.net> wrote:
> So I fundamentally think that all of these contortions are because
> moving things to the stash bucket is not as featureful as moving them to
> the index bucket. And there's no reason for it, since we can use the
> _same_ tools to do both.
>
> Here's a somewhat hackish implementation of "git stash -i" that just relies
> on "add -i":

Are all features for moving changes to stash bi-directional in your
implementation?  Can we move a hunk out of stash, just as easily as we
can move one in?  I think this is an essential property of a good
implementation of this workflow.

As to which way people like to think and work, in terms of re-applying
changes from a fresh state one at a time, or just pushing off changes
they don't want, I think ensuring bi-directionality in the tools for
moving changes back and forth will ensure that all such scenarios will
be equally well supported.

It does seem to me at this point that extending stash functionality is
a reasonable way to approach supporting this type of workflow.

Thanks,
Bob
