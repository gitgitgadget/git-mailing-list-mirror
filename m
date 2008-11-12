From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: [PATCH] git-diff: Add --staged as a synonym for --cached.
Date: Wed, 12 Nov 2008 10:46:50 -0500
Message-ID: <32541b130811120746m7b0eadd3y1240d1252dbd441d@mail.gmail.com>
References: <1225296936-1357-1-git-send-email-dsymonds@gmail.com>
	 <ee77f5c20810290950k6d7acfcbt90b6280c290bd532@mail.gmail.com>
	 <alpine.DEB.1.00.0810291804400.22125@pacific.mpi-cbg.de.mpi-cbg.de>
	 <20081029171122.GA12167@sigill.intra.peff.net>
	 <20081102123519.GA21251@atjola.homenet>
	 <7vljw2yo93.fsf@gitster.siamese.dyndns.org>
	 <20081103071420.GD10772@coredump.intra.peff.net>
	 <32541b130811102004n54a47331v48ba8d299039897f@mail.gmail.com>
	 <20081112083353.GB3817@coredump.intra.peff.net>
	 <alpine.DEB.1.00.0811121205100.30769@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Jeff King" <peff@peff.net>, "Junio C Hamano" <gitster@pobox.com>,
	"=?ISO-8859-1?Q?Bj=F6rn_Steinbrink?=" <B.Steinbrink@gmx.de>,
	"David Symonds" <dsymonds@gmail.com>, git@vger.kernel.org,
	"Stephan Beyer" <s-beyer@gmx.net>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Nov 12 16:48:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0Hwx-00020g-8g
	for gcvg-git-2@gmane.org; Wed, 12 Nov 2008 16:48:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752722AbYKLPqx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Nov 2008 10:46:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752705AbYKLPqx
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Nov 2008 10:46:53 -0500
Received: from yx-out-2324.google.com ([74.125.44.29]:10591 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752701AbYKLPqw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Nov 2008 10:46:52 -0500
Received: by yx-out-2324.google.com with SMTP id 8so207423yxm.1
        for <git@vger.kernel.org>; Wed, 12 Nov 2008 07:46:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=v3RFt6PeMPH7Kt30Tbs1Qwbozh9nAm65omGp7Us2DWs=;
        b=ewI4MZlOvdup9jN1Uv5KDj1VQib8q7SoZteDpQbFk6vSvJZzibkTUVnQabLXwnNcR2
         NfgD7G6/SpEadvTyhKcgLi6yIEhYd/1tv//ZBm8p7Rcq63cd5fbu7URo+AUCxAJU7+v5
         BWQF3YeUnNQkJZ3TdU8YW9bJtFtFAhQG/xgUk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=L1WiAbYZzTe9F7jvZe6yA8Eg+eTM7RY6qFT/I+YNNsRxHpBw46gHUJy1054bHAKiFn
         JktQwgZSWfluszPM3b/dIGj1/AKhCBHzcrv9nMrqKYaoo41jFrOZT91DeANg495kfzK4
         cQ9abt2YbOqdZ891apCAxGsz4MynbHNyia6QI=
Received: by 10.150.205.20 with SMTP id c20mr6537571ybg.193.1226504811061;
        Wed, 12 Nov 2008 07:46:51 -0800 (PST)
Received: by 10.150.98.19 with HTTP; Wed, 12 Nov 2008 07:46:50 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.0811121205100.30769@pacific.mpi-cbg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100759>

On Wed, Nov 12, 2008 at 6:10 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Just in case anybody thought about creating tree objects on the fly and
> use their SHA-1s: that won't fly, as you can have unmerged entries in the
> index.  So STAGED.. is a _fundamentally_ different thing from HEAD^..

Hmm, I tried it to see, and "git diff --cached branchname" when there
are unmerged entries looks like this (one line):

* Unmerged path /whatever/file

Which is pretty unhelpful anyhow (although I don't know what would be
better).  I can think of several ways to produce the same output,
including using a magic SHA-1 that means "unmerged", or using a
different filemode for unmerged files in the tree object, or actually
including all three versions of the file in the tree object, each with
a different mode.  I admit that sounds pretty gross, though.

> Maybe we could play tricks with a special staged_commit (pretending to be
> a commit with SHA-1 000000... so that git log STAGED.. would do the same
> as plain git log, the rationale being that STAGED is no commit, so ^STAGED
> should be a nop).

I might have imagined STAGED to be a child commit of HEAD (or rather,
its parents should be the same as if you did 'git commit'), but I
don't really know for sure.  In such a case, ^STAGED would definitely
have a meaning.

Have fun,

Avery
