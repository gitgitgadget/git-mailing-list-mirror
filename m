From: "David Tweed" <david.tweed@gmail.com>
Subject: Re: current repository hash
Date: Mon, 16 Jun 2008 13:11:46 +0100
Message-ID: <e1dab3980806160511s1a9a5192gbdf6539205ef1865@mail.gmail.com>
References: <556d90580806160451g36daefb6o48b93b92589211bf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Alf Clement" <alf.clement@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 16 14:13:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8Da0-000272-Ey
	for gcvg-git-2@gmane.org; Mon, 16 Jun 2008 14:13:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752692AbYFPMMF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jun 2008 08:12:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752541AbYFPMME
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jun 2008 08:12:04 -0400
Received: from yw-out-2324.google.com ([74.125.46.29]:62994 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752363AbYFPMMC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jun 2008 08:12:02 -0400
Received: by yw-out-2324.google.com with SMTP id 9so3071356ywe.1
        for <git@vger.kernel.org>; Mon, 16 Jun 2008 05:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=lcabJN1ocX9cred+jrJ92Oiorj91NWb7hzLl3ZxFwx8=;
        b=l/auT7vz5UcR2V1ePmnc4SbfMfSQSfPO2/oce/7g2CELlAJFUVW6mkibTptIPs2Mvw
         oRGbPlsjC29CDSpQU95iDJAO73BBnCoHdw62WluWy5v9Cg4g11Cfo3zs2mPWpzlwHd2+
         VJzM1SChM6BaB1NLkUsnCkCTLIjK+lJRtQUPM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=ahLs3gIwQcJAhmo2/oK1eX4+Rmk5XX/zTdzZrHqnZf1tNrbXUFcUHTLY50eekJbn4s
         wPMzIKHNNjx658PQBNrAGNImQIuf8M96/gdtN6E7xFjl84sWb3tOYyLai46svI/R2gWA
         l/nFzPJ0dwvjsYc0FSjxM+wGfzjDB8yic3djo=
Received: by 10.151.45.6 with SMTP id x6mr10622860ybj.163.1213618311132;
        Mon, 16 Jun 2008 05:11:51 -0700 (PDT)
Received: by 10.150.177.21 with HTTP; Mon, 16 Jun 2008 05:11:46 -0700 (PDT)
In-Reply-To: <556d90580806160451g36daefb6o48b93b92589211bf@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85183>

On Mon, Jun 16, 2008 at 12:51 PM, Alf Clement <alf.clement@gmail.com> wrote:
> What would be the best command to get a unique identifier?

Note that git itself does this via the GIT-VERSION-GEN script so you
could look at that for ideas.

> How can I make sure that a shorter hash id will be unique?

Theoretically isn't that going to be tricky, as you don't just want
something that's unique at the time you compile the program but which
won't potentially be rendered non-unique by later commits (after
you've released your binary)? If you just want to be reasonably sure
you can truncate the hash to the length you'd like, eg "addcc13a" for
8 characters and run

git rev-parse addcc13a

and see if it says

addcc13a
fatal: ambiguous argument 'addcc13a': unknown revision or path not in
the working tree.
Use '--' to separate paths from revisions

-- 
cheers, dave tweed__________________________
david.tweed@gmail.com
Rm 124, School of Systems Engineering, University of Reading.
"while having code so boring anyone can maintain it, use Python." --
attempted insult seen on slashdot
