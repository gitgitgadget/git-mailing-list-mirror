From: PJ Hyett <pjhyett@gmail.com>
Subject: Re: Bad objects error since upgrading GitHub servers to 1.6.1
Date: Tue, 27 Jan 2009 16:34:20 -0800
Message-ID: <bab6a2ab0901271634x7201130bx4a565bd8bea6967b@mail.gmail.com>
References: <bab6a2ab0901271504j73dce7afjf8436c3c7c83b770@mail.gmail.com>
	 <bab6a2ab0901271510y1e3e6912t82ff16e0f912d4b6@mail.gmail.com>
	 <alpine.DEB.1.00.0901280034310.3586@pacific.mpi-cbg.de>
	 <20090127233939.GD1321@spearce.org>
	 <7v1vuo1f6d.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 28 01:35:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRyPI-0006Q7-MC
	for gcvg-git-2@gmane.org; Wed, 28 Jan 2009 01:35:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751971AbZA1AeW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jan 2009 19:34:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751925AbZA1AeW
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jan 2009 19:34:22 -0500
Received: from rv-out-0506.google.com ([209.85.198.239]:5271 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751512AbZA1AeV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jan 2009 19:34:21 -0500
Received: by rv-out-0506.google.com with SMTP id k40so6672200rvb.1
        for <git@vger.kernel.org>; Tue, 27 Jan 2009 16:34:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=CJMRnmREOug95hmbRcXBnWlFeAjRAF2uAOXj84lxqtw=;
        b=rFheLm0BkegIvmHUZctLM97dc/z9vHlrSjyjp3n3+mBIcjqFB7vLAKkNIjbxuuKcWS
         tG32kZGvAY9c7AeMCMb9SNVRJDdzoH4WrBWELaEP8P/QnnjmtJeh95ELyqvtZQem3/F/
         Uetd8M75bGda5dF1Nd45Pyeif4QZQX/KdsCjA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=MzYBJsqX0vPXM+VUTPyrZuttghsedZZzZ+u3fU23610tKX+0gTeD/oi5tzo702dLaN
         cMyFJWPnKB9BEgr8z/MB1oLxD/0OmPXd/89VYxePdgtxZ5hHWB3Rcs77cMkkfefz3iox
         efi8n/sQYmQIGaV8m0mpRPQgflOqdRGbsfWfU=
Received: by 10.140.133.10 with SMTP id g10mr539054rvd.6.1233102860315; Tue, 
	27 Jan 2009 16:34:20 -0800 (PST)
In-Reply-To: <7v1vuo1f6d.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107434>

> As we do not know what version github used to run (or for that matter what
> custom code it adds to 1.6.1), I guessed that the previous one was 1.6.0.6
> and did some comparison.  The client side pack_object() learned to take
> alternates on the server side into account to avoid pushing objects that
> the target repository has through its alternates, so it is not totally
> unexpected the client side changes its behaviour depending on what the
> server does.

The only custom code we've written was a patch to git-daemon to map
pjhyett/github.git to a sharded location (eg.
/repositories/1/1e/df/a0/pjhyett/github.git) instead of the default.

The new alternates code in 1.6.1 sounds like that could be the issue.

-PJ
